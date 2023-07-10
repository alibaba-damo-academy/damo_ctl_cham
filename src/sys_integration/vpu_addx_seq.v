`include "monox_defines.vh"
/*
    Top Module:  vpu_addx_seq.v
    Data:        Unsign format, 64 bit (most significant (64-35) bits are 0)
    Role:        read the corresponding address from BRAM and execute negate or bypass
    Warm-up:     Not input & output valid, start process when detecting high i_en.
                 the first data comes out "6" cycles after i_en set high.   
                 initial interval (II = 1)
    Timing:      Sequential Logic, 5/6-cycle latency
                  first part: register the input or shift&negate the input. (1-cycle latency)
                  second part: cross operation, (3-cycle latency)
                  third part: shuffle (2-cycle latency); zero-extension (1-cycle latency)
    Dummy Data:  {DATA_WIDTH{1'b0}}

    system datapath diagram: 
        --- mode 0
                                                || 
                              vpu_top           ||     cross 
                      warm-up latency 10 cycle  ||    2 cycle     
                                                   ____________   
                                                  |            |
                                                  |A        A+C|  
                                       [0*DW+:DW] |B  cross    |  
                           ___________     |----->|C           |                                           
                          |           |----| |--->|D        B+D|                                    
                          |           |------|    |____________|                    
          i_dina_vpu----> |           | [2*DW+:DW]         
          i_dinb_vpu----> |  vpu_top  |      
          i_dinc_vpu----> |           | [1*DW+:DW]    
                          |           |------|     ____________                               
                          |___________|----| |    |            |                             
                                           | |    |A        A+C|                                                                          
                                           | |    |B  cross    |                                                                          
                                           | |--->|C           |                                                                 
                                           |----->|D        B+D|
                                        [3*DW+:DW]|____________|            
                                                                                         
     Data layout:
            i_data_g0_addx layout                                                        
           MSB                           LSB     
            [  DATA_WIDTH  |  DATA_WIDTH]      
                 B               A
   
            i_data_g1_addx layout                                                        
           MSB                           LSB     
            [  DATA_WIDTH  |  DATA_WIDTH]      
                 B               A
      
            i_dina_vpu layout                                                        
           MSB                                                           LSB
            [  DATA_WIDTH  |   DATA_WIDTH  |   DATA_WIDTH  |  DATA_WIDTH  ]
                dina_0           dina_1          dina_2         dina_3      
      
            i_dinb_vpu layout                                                        
           MSB                                                           LSB
            [  DATA_WIDTH  |   DATA_WIDTH  |   DATA_WIDTH  |  DATA_WIDTH  ]
                dinb_0           dinb_1          dinb_2         dinb_3        
      
            i_dinc_vpu layout                                                        
           MSB                                                           LSB
            [  DATA_WIDTH  |   DATA_WIDTH  |   DATA_WIDTH  |  DATA_WIDTH  ]
                dinc_0           dinc_1          dinc_2         dinc_3       

            o_data layout 
           MSB           group 1         |||           group 0         LSB
            [  DATA_WIDTH  |  DATA_WIDTH  |  DATA_WIDTH  |  DATA_WIDTH  ]
                  B+D             A+C            B+D             A+C  

    Author:      Jianming Tong (jianming.tong@gatech.edu)
*/


module vpu_addx_seq#(
    parameter P     = 39'h40_0080_0001,
    parameter Q0    = 35'h4_0008_0001,
    parameter Q1    = 35'h4_0800_0001,
    
    // inverse of modulus (for Barrett reduction)
    parameter IQ0   = 36'd68_717_379_643,
    parameter IQ1   = 36'd68_186_767_610,

    // P inverse mod Q
    parameter PIMQ0 = 35'd8_017_516_954,
    parameter PIMQ1 = 35'd14_972_836_665,

    parameter BRAM_DELAY = 1,
    
    // modulus width
    parameter MWIDTH= 35,
    parameter DATA_WIDTH = 64,                            // the bit length of the data.
    parameter MODULUS_WIDTH = 39                          // the bit length of the modulus. 
)(
    // timing signals
        clk,   
        rst_n,               // asynchronous reset

    // data signals
        i_data_g1_addx,      // input data
        i_data_g0_addx,      // input data

        i_dina_vpu,
        i_dinb_vpu,
        i_dinc_vpu,

        o_rdena_vpu,
        o_rdenb_vpu,
        o_rdenc_vpu,
        o_wren_vpu,
        o_rdaddra_vpu,
        o_rdaddrb_vpu,
        o_rdaddrc_vpu,
        o_wrdaddr_vpu,

    // control signals
        i_n,                 // input power of 2
        o_addr_g0_addx,      // output write address for input to addx -- group g0
        o_addr_g1_addx,      // output write address for input to addx -- group g1
        o_en_bram_g0_addx,   // output bram enable signal for input to addx -- group 0
        o_en_bram_g1_addx,   // output bram enable signal for input to addx -- group 1

    // data and control for writing reduce buffer
        i_s7_mode,           // input mode to control the destination of output data. 
        o_data_rb,           // output data for reduce buffer 
        o_addr_rb,           // output write address for reduce buffer 
        o_we_rb,             // output write enable for writing reduce buffer 

    // output to the following module
        o_data,              // output data for the following module
        o_n_addx,            // output power of 2

    // hyper-block pipeline control signals
        i_en,                // whether to enable processing
        i_start,             // whether to start processing
        o_done,  // Bug: new signal
        o_valid              // indicate the end of valid
);

    // parameter
    localparam   NUM_INPUT_DATA = 4;
    localparam   NUM_OUTPUT_DATA = 2;
    
    localparam   INNER_RES_WIDTH = DATA_WIDTH + 1; // extra 1 bit per data is used to detect whether need to correction.
    localparam   ZERO_EXTEND_LENGTH = INNER_RES_WIDTH - MODULUS_WIDTH;
    localparam   WIDTH_INNER_RES = NUM_OUTPUT_DATA * INNER_RES_WIDTH;
    
    localparam   WIDTH_INPUT_DATA = NUM_INPUT_DATA * DATA_WIDTH;
    localparam   WIDTH_INPUT_HALF_DATA = (NUM_INPUT_DATA >> 1) * DATA_WIDTH;
    localparam   ADDR_WIDTH = 12;

    localparam   POWER_WIDTH = 4;

    // interface
    input                                             clk;
    input                                             rst_n;
    input              [POWER_WIDTH-1:0]              i_n;

    input              [WIDTH_INPUT_HALF_DATA-1:0]    i_data_g0_addx;
    input              [WIDTH_INPUT_HALF_DATA-1:0]    i_data_g1_addx;

    output             [WIDTH_INPUT_DATA-1:0]         o_data;
    output             [ADDR_WIDTH-1:0]               o_addr_g0_addx;
    output             [ADDR_WIDTH-1:0]               o_addr_g1_addx;
    output                                            o_en_bram_g0_addx;
    output                                            o_en_bram_g1_addx;

    output             [POWER_WIDTH-1:0]              o_n_addx;

    input                                             i_en;
    input                                             i_start;
    output                                            o_done;  // Bug: new signal
    output                                            o_valid;

    input              [WIDTH_INPUT_DATA-1:0]         i_dina_vpu;
    input              [WIDTH_INPUT_DATA-1:0]         i_dinb_vpu;
    input              [WIDTH_INPUT_HALF_DATA-1:0]    i_dinc_vpu;

    output                                            o_rdena_vpu;
    output                                            o_rdenb_vpu;
    output                                            o_rdenc_vpu;
    output                                            o_wren_vpu;
    output             [ADDR_WIDTH-1:0]               o_rdaddra_vpu;
    output             [ADDR_WIDTH-1:0]               o_rdaddrb_vpu;
    output             [ADDR_WIDTH-1:0]               o_rdaddrc_vpu;
    output             [ADDR_WIDTH-1:0]               o_wrdaddr_vpu;

    input                                             i_s7_mode;   
    output             [WIDTH_INPUT_DATA-1:0]         o_data_rb;
    output             [ADDR_WIDTH-1:0]               o_addr_rb;
    output                                            o_we_rb;

    wire               [WIDTH_INPUT_DATA-1:0]         inner_data_vpu_addx;
    wire                                              done_vpu;

    vpu3_top #(
        .P(P),    
        .Q0(Q0),
        .Q1(Q1),
        .IQ0(IQ0),
        .IQ1(IQ1),
        .PIMQ0(PIMQ0),
        .PIMQ1(PIMQ1),
        .BRAM_DELAY(BRAM_DELAY),
        .DATA_WIDTH(DATA_WIDTH)
    ) vpu3(
        .clk(clk),
        .rst_n(rst_n),
        .i_vpu3_start(i_start),
        .o_vpu3_done(done_vpu),     // Bug: this had been missed
        .i_vpu3_level(i_n),
        .i_vpu3_dina(i_dina_vpu),
        .i_vpu3_dinb(i_dinb_vpu[WIDTH_INPUT_HALF_DATA-1:0]),
        .i_vpu3_dinc(i_dinc_vpu),
        .o_vpu3_dout(inner_data_vpu_addx),
        .o_vpu3_rdena(o_rdena_vpu),
        .o_vpu3_rdenb(o_rdenb_vpu),
        .o_vpu3_rdenc(o_rdenc_vpu),
        .o_vpu3_wren(o_wren_vpu),
        .o_vpu3_wben(),
        .o_vpu3_rdaddra(o_rdaddra_vpu),
        .o_vpu3_rdaddrb(o_rdaddrb_vpu),
        .o_vpu3_rdaddrc(o_rdaddrc_vpu),
        .o_vpu3_wraddr(o_wrdaddr_vpu)
    );

    cross_aggressive_last_seq #(
        .DATA_WIDTH(DATA_WIDTH),
        .MODULUS_WIDTH(MODULUS_WIDTH),
        .Q0(Q0),
        .Q1(Q1)
    ) addx_g0(
        .clk(clk),
        .rst_n(rst_n),
        .i_data_vpu({inner_data_vpu_addx[3*DATA_WIDTH-1-:DATA_WIDTH], inner_data_vpu_addx[1*DATA_WIDTH-1-:DATA_WIDTH]}),
        .i_data_pp({i_data_g0_addx[2*DATA_WIDTH-1-:DATA_WIDTH], i_data_g0_addx[1*DATA_WIDTH-1-:DATA_WIDTH]}),
        .i_addr_vpu(o_wrdaddr_vpu),  // Bug: new signal, from vpu3
        .i_we_vpu(o_wren_vpu),  // Bug: new signal, from vpu3
        .i_n(i_n),
        .i_done_vpu(done_vpu),  // Bug: new signal, from vpu3
        .o_data(o_data[2*DATA_WIDTH-1-:2*DATA_WIDTH]),
        .o_addr_g0(o_addr_g0_addx),
        .o_en_bram_g0(o_en_bram_g0_addx),
        .o_n_c1(),
        .i_start(i_start),
        .i_en(i_en),
        .o_valid(),
        .o_done(o_done),
        .i_s7_mode(i_s7_mode),
        .o_data_rb(o_data_rb[2*DATA_WIDTH-1-:2*DATA_WIDTH]),
        .o_addr_rb(o_addr_rb),
        .o_we_rb(o_we_rb)
    );

    cross_aggressive_last_seq #(
        .DATA_WIDTH(DATA_WIDTH),
        .MODULUS_WIDTH(MODULUS_WIDTH),
        .Q0(Q0),
        .Q1(Q1)
    ) addx_g1(
        .clk(clk),
        .rst_n(rst_n),
        .i_data_vpu({inner_data_vpu_addx[4*DATA_WIDTH-1-:DATA_WIDTH], inner_data_vpu_addx[2*DATA_WIDTH-1-:DATA_WIDTH]}),
        .i_data_pp({i_data_g1_addx[2*DATA_WIDTH-1-:DATA_WIDTH], i_data_g1_addx[1*DATA_WIDTH-1-:DATA_WIDTH]}),
        .i_addr_vpu(o_wrdaddr_vpu),  // Bug: new signal, from vpu3
        .i_we_vpu(o_wren_vpu),  // Bug: new signal, from vpu3
        .i_n(i_n),
        .i_done_vpu(done_vpu),  // Bug: new signal, from vpu3
        .o_data(o_data[4*DATA_WIDTH-1-:2*DATA_WIDTH]),
        .o_addr_g0(o_addr_g1_addx),
        .o_en_bram_g0(o_en_bram_g1_addx),
        .o_n_c1(o_n_addx),
        .i_start(i_start),
        .i_en(i_en),
        .o_valid(o_valid),
        .o_done(),
        .i_s7_mode(i_s7_mode),
        .o_data_rb(o_data_rb[4*DATA_WIDTH-1-:2*DATA_WIDTH]),
        .o_addr_rb(),
        .o_we_rb()
    );

endmodule
