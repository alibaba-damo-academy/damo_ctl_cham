`include "addx_defines.vh"
/* 
    Top Module:  cross_aggressive_last_seq.v
    Data:        Unsign format, 64 bit (most significant (64-35) bits are 0)
    Role:        read the corresponding address from BRAM and execute negate or bypass
    Warm-up:     Not input & output valid, start process when detecting high i_en.
                 the first data comes out "3" cycles after i_en set high.   
                 initial interval (II = 1)
    Timing:      Sequential Logic, 2-cycle latency
                  first cycle: normal subtraction & add
                  second cycle: sub&add's result correction to modulus sub & modulus add
                                output selection & zero extension (for A+B & C+D)
    Dummy Data:  {DATA_WIDTH{1'b0}}
    Function:                           
                                                                     
                                             ||                                                   
                                             ||                                                   
                 first clock cycle           ||                second clock cycle                   
                                             ||                                                   
                                             ||                                                   
                                                                     
                                                            inner_o_select_ctrl[0]                                                           
                                                        >=modulus  _______                                                                            
                                                           |-------|_reg_|--------------------------                                                                    
                             _________                     |                                       |                                         
                             |       |                     |     __________                        |                                                   
             A      -------> |       |  res_uncorrected    |    |          |    res_corrected    |\v                                                    
             C      -------> |       | [MODULUS_WIDTH:0]   |    |  normal  |    [0*IRW+:IRW]     | \                                                   
                             |normal |------------------------->|   sub    |-------------------->|1 \         _______________                                  
     [MODULUS_WIDTH-1:0]     |  ADD  |         Q0   ----------->|in-modulus|                     |   |----->  |zero extension|  ---> o_data_bus[DATA_WIDTH-1:0]
                             |       |                          |__________|                     |   |        |______________|                                               
                             |_______|                                        ------------------>|0 /                                         
                                                                              res_uncorrected    | /                                                                    
                                                                                 [0*MW+:MW]      |/                                                                     
                                                          
                                                                      
                                                            inner_o_select_ctrl[1]    
                                                        >=modulus  _______                                                                   
                             ________                      |-------|_reg_|--------------------------                                         
                             |       |                     |                                       |                                                                                      
             B      -------> |       |                     |     __________                        |                                                                                      
             D      -------> |       |  res_uncorrected    |    |          |    res_corrected    |\v                                                                                      
                             |normal |  [1*IRW+:IRW]       |    |  normal  |     [1*IRW+:IRW]    | \                                                                                   
     [MODULUS_WIDTH-1:0]     |  ADD  |------------------------->|   sub    |-------------------->|1 \         ________________                                                                            
                             |       |         Q1   ----------->|in-modulus|                     |   |----->  |zero extension|  ---> o_data_bus[1*DATA_WIDTH+:DATA_WIDTH]                                                
                             |_______|                          |__________|                     |   |        |______________|                                                            
                                                                              ------------------>|0 /                                     
                                                                              res_uncorrected    | /                                                                    
                                                                                 [1*MW+:MW]      |/                                                                     

    Abbreviate:
        IRW = INNER_RES_WIDTH = MODULUS_WIDTH + 1
        MW  = MODULUS_WIDTH
   
    Data layout:
        i_data_y layout                                                        
        MSB                     LSB     
        [ DATA_WIDTH | DATA_WIDTH ]      
                C             A

        i_data_g layout                                                        
        MSB                     LSB     
        [ DATA_WIDTH | DATA_WIDTH ]      
                D             B    
                        
        res_uncorrected 
        MSB                       LSB
        [ DATA_WIDTH+1 | DATA_WIDTH+1]
              B+D           A+C
        
        o_data layout 
        MSB                   LSB
        [ DATA_WIDTH | DATA_WIDTH]   
             B+D         A+C
    Note:
        In this design, we assume the bit length of the modulus is smaller than the bit length of the data.
    
    Control: 
        When i_s7_mode =
            1'b1: mean data forwarded to the direct output port.
            1'b0: mean data forwarded to the reduce buffer.

    Author:      Jianming Tong (jianming.tong@gatech.edu)
*/

module cross_aggressive_last_seq#(
    parameter DATA_WIDTH = 64,                            // the bit length of the data.
    parameter ADDR_WIDTH = 12,
    parameter MODULUS_WIDTH = 35,                         // the bit length of the modulus.
    parameter COMMON_BRAM_LATENCY = 1,
    parameter Q0 = 35'h4_0800_0001,
    parameter Q1 = 35'h4_0008_0001
)(
    // timing signals
        clk,   
        rst_n,          // asynchronous reset

    // data signals
        i_data_vpu,       // input data
        i_data_pp,       // input data
        i_addr_vpu,      // new signal, from vpu3
        i_done_vpu,
        i_we_vpu,      // new signal, from vpu3

        o_data,         // output data for mux

    // data and control for writing reduce buffer
        i_s7_mode,      // input mode to control the destination of output data. 
        o_data_rb,      // output data for reduce buffer 
        o_addr_rb,      // output write address for reduce buffer 
        o_we_rb,        // output write enable for writing reduce buffer 

    // control read signals
        i_n,            // input power of 2
        o_addr_g0,      // output write address for input group g0
        o_en_bram_g0,   // output bram enable signal
        o_n_c1,         // output power of 2

    // control signals
        i_en,           // whether to enable processing
        i_start,        // whether to start processing
        o_done,  // Bug: new signal
        o_valid         // indicate the end of valid
);

    localparam   N_POLY = 2;
    localparam   LEVEL_WIDTH = 4;

    // interface
    input  wire                                 clk;
    input  wire                                 rst_n;
    input  wire    [LEVEL_WIDTH-1:0]            i_n;

    input  wire    [N_POLY * DATA_WIDTH-1:0]    i_data_vpu;
    input  wire    [N_POLY * DATA_WIDTH-1:0]    i_data_pp;
    input  wire    [ADDR_WIDTH-1:0]             i_addr_vpu;
    input  wire                                 i_done_vpu;
    input  wire                                 i_we_vpu;

    output wire    [N_POLY * DATA_WIDTH-1:0]    o_data;
    output wire    [ADDR_WIDTH-1:0]             o_addr_g0;
    output wire                                 o_en_bram_g0;

    input  wire                                 i_s7_mode;
    output wire    [N_POLY * DATA_WIDTH-1:0]    o_data_rb;
    output wire    [ADDR_WIDTH-1:0]             o_addr_rb;
    output wire                                 o_we_rb;

    output wire    [LEVEL_WIDTH-1:0]            o_n_c1;

    input  wire                                 i_en;
    input  wire                                 i_start;
    output wire                                 o_valid;
    output wire                                 o_done;


    reg   [N_POLY * DATA_WIDTH-1:0]             data_r;
    reg   [N_POLY * DATA_WIDTH-1:0]             data_vpu_d;

    wire  [N_POLY * DATA_WIDTH-1:0]             data_comb, raw_sum;
    wire  [N_POLY-1:0]                          modsub;
    reg                                         we_vpu_d1, we_vpu_d2;
    reg                                         done_vpu_d1, done_vpu_d2;
    reg   [ADDR_WIDTH-1:0]                      addr_vpu_d1, addr_vpu_d2;


    // done
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            done_vpu_d1 <= 1'b1;
            done_vpu_d2 <= 1'b1;
        end
        else begin
            done_vpu_d1 <= i_done_vpu;
            done_vpu_d2 <= done_vpu_d1;
        end
    end
    assign o_done = i_done_vpu & done_vpu_d2;


    // cross add
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            data_vpu_d <= {(N_POLY*DATA_WIDTH){1'b0}};
        end
        else begin
            data_vpu_d <= i_data_vpu;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            data_r <= {(N_POLY*DATA_WIDTH){1'b0}};
        else
            data_r <= data_comb;
    end
    assign data_comb[DATA_WIDTH-1:0]            = raw_sum[DATA_WIDTH-1:0] >= {4'b0, Q0} ?
                                                  raw_sum[DATA_WIDTH-1:0] - {4'b0, Q0} : raw_sum[DATA_WIDTH-1:0];
    assign data_comb[DATA_WIDTH*2-1:DATA_WIDTH] = raw_sum[DATA_WIDTH*2-1:DATA_WIDTH] >= {4'b0, Q1} ? 
                                                  raw_sum[DATA_WIDTH*2-1:DATA_WIDTH] - {4'b0, Q1} : raw_sum[DATA_WIDTH*2-1:DATA_WIDTH];

    assign raw_sum[DATA_WIDTH-1:0] = data_vpu_d[DATA_WIDTH-1:0] + i_data_pp[DATA_WIDTH-1:0];
    assign raw_sum[DATA_WIDTH*2-1:DATA_WIDTH] = data_vpu_d[DATA_WIDTH*2-1:DATA_WIDTH] + i_data_pp[DATA_WIDTH*2-1:DATA_WIDTH];


    // to upper pp
    assign o_addr_g0 = i_addr_vpu;
    assign o_en_bram_g0 = i_we_vpu;


    // to s3
    assign o_data = data_r;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            we_vpu_d1 <= 1'b0;
            we_vpu_d2 <= 1'b0;
        end
        else begin
            we_vpu_d1 <= i_we_vpu;
            we_vpu_d2 <= we_vpu_d1;
        end
    end
    assign o_valid = we_vpu_d2;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            addr_vpu_d1 <= 1'b0;
            addr_vpu_d2 <= 1'b0;
        end
        else begin
            addr_vpu_d1 <= i_addr_vpu;
            addr_vpu_d2 <= addr_vpu_d1;
        end
    end
    assign o_addr_rb = addr_vpu_d2;


    // to reduce buffer
    assign o_data_rb = data_r;
    assign o_we_rb = i_s7_mode? 1'b0 : we_vpu_d2;


    // level
    assign o_n_c1 = i_n;

endmodule
