// `include "monox_defines.vh"

/*
    Author: Jianming Tong (jianming.tong@gatech.edu)
    Modified by: Shengrong Liu (srliu1997@pku.edu.cn)
*/

module monox_aggressive_seq#(
    parameter DATA_WIDTH = 64,                      // Data bus width.
    parameter MODULUS_WIDTH = 35,                   // Modulus width (useful width).
    parameter INDEX_WIDTH = 13,                     // Index width (Address width + 1).
    parameter ADDR_WIDTH = INDEX_WIDTH - 1,
    parameter IN_MODULUS = 35'h4_0800_0001          // Modulus value.
)(
    // timing signals
    input clk,
    input rst_n,

    // data signals
    input [4*DATA_WIDTH-1:0] i_data,   // Input data.
    input i_valid,                     // Input data valid.
    input [3:0] i_n,                   // input power of 2, e.g. 2^8 then input 8
    input i_negate,                    // whether input data need to be negated. 1'b1 -> go through negate

    output [4*DATA_WIDTH-1:0] o_data,         // output data -- for writing BRAM
    output [4*ADDR_WIDTH-1:0] o_addr,         // output addr -- for writing BRAM
    output [3:0] o_we,                        // output write enable -- for writing BRAM

    // control signals
    input is_trace,
    input i_en,           // Enable.
    input i_start,        // when to start a new processing
    output reg o_done     // Processing done.
);


wire [INDEX_WIDTH-1:0] i_galois_elt;

assign i_galois_elt = (1'b1 << i_n) + 1'b1;


// Valid shift register.
reg [3:0] valid_shift;

always @(posedge clk or negedge rst_n)
    if (!rst_n)
        valid_shift <= 4'b0;
    else if (!i_en)
        valid_shift <= 4'b0;
    else
        valid_shift <= {valid_shift[2:0], i_valid};


// o_done generation
always @(posedge clk or negedge rst_n)
    if (!rst_n)
        o_done <= 1'b1;
        // o_done <= 1'b0;  // Bug
    else if (!i_en)
        o_done <= 1'b1;
        // o_done <= 1'b0;  // Bug
    else begin
        if (i_start)
            o_done <= 1'b0;
        else
            o_done <= valid_shift[3] & ~valid_shift[2] ? 1'b1 : o_done;
    end

/*
    first part:
        shift&negate - 1 cycle
*/
wire [MODULUS_WIDTH-1:0] A, B, C, D;
assign A = i_data[0*DATA_WIDTH+:MODULUS_WIDTH];
assign B = i_data[2*DATA_WIDTH+:MODULUS_WIDTH];  // Notice: Different from top diagram.
assign C = i_data[1*DATA_WIDTH+:MODULUS_WIDTH];  // Notice: Different from top diagram.
assign D = i_data[3*DATA_WIDTH+:MODULUS_WIDTH];

// Trace shift.
reg [4*DATA_WIDTH-1:0] trace1, trace2, trace3;
always @(posedge clk)
    if (i_valid && is_trace)
        // trace1 <= i_data;
    begin
        trace1[0*DATA_WIDTH+:DATA_WIDTH] <= i_data[1*DATA_WIDTH+:DATA_WIDTH];
        trace1[1*DATA_WIDTH+:DATA_WIDTH] <= i_data[3*DATA_WIDTH+:DATA_WIDTH];  // Bug: Exchange postion of B and C.
        trace1[2*DATA_WIDTH+:DATA_WIDTH] <= i_data[1*DATA_WIDTH+:DATA_WIDTH];  // Bug: Exchange positon of B and C.
        trace1[3*DATA_WIDTH+:DATA_WIDTH] <= i_data[3*DATA_WIDTH+:DATA_WIDTH];
    end
always @(posedge clk)
    // if (valid_shift[1] && is_trace)
    if (valid_shift[0] && is_trace)  // Bug: Trace data 1 cycle delay.
        trace2 <= trace1;
always @(posedge clk)
    // if (valid_shift[2] && is_trace)
    if (valid_shift[1] && is_trace)  // Bug: Trace data 1 cycle delay.
        trace3 <= trace2;

reg [MODULUS_WIDTH-1:0] A_q, B_q, C_sn, D_sn;

always @(posedge clk)
    if(i_en && i_valid)
        A_q <= A;

always @(posedge clk)
    if(i_en && i_valid)
        B_q <= B;

// C -- shift & negate
always @(posedge clk)
    if(i_en && i_valid) begin
        if (i_negate && (C > 0))
            C_sn <= IN_MODULUS - C;
        else
            C_sn <= C;
    end

// D -- shift & negate
always @(posedge clk)
    if(i_en && i_valid) begin
        if (i_negate && (D > 0))
            D_sn <= IN_MODULUS - D;
        else
            D_sn <= D;
    end

/*
    second part:
        cross - 2 cycle
*/
wire [MODULUS_WIDTH-1:0] AC_sub, BD_sub;
wire [DATA_WIDTH-1:0] cross_out_ac, cross_out_bd;

cross_aggressive_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .IN_MODULUS(IN_MODULUS)
) u_cross (
    .clk(clk),
    .A(A_q),
    .B(B_q),
    .C(C_sn),
    .D(D_sn),
    .AC_sum(cross_out_ac),
    .BD_sum(cross_out_bd),
    .AC_sub(AC_sub),
    .BD_sub(BD_sub)
);

assign o_data[0*DATA_WIDTH+:DATA_WIDTH] = is_trace ? trace3[0*DATA_WIDTH+:DATA_WIDTH] : cross_out_ac;
assign o_data[1*DATA_WIDTH+:DATA_WIDTH] = is_trace ? trace3[1*DATA_WIDTH+:DATA_WIDTH] : cross_out_bd;

reg [ADDR_WIDTH-1:0] bram_addr;

always @(posedge clk)
    if(valid_shift[2])
        bram_addr <= bram_addr + 1'b1;
    else
        bram_addr <= 0;

assign o_addr[0*ADDR_WIDTH+:ADDR_WIDTH] = bram_addr;
assign o_addr[1*ADDR_WIDTH+:ADDR_WIDTH] = bram_addr;

assign o_we[1:0] = {2{valid_shift[2]}};

/*
    third part
*/

wire [MODULUS_WIDTH-1:0] shuffle_in_ac, shuffle_in_bd;
assign shuffle_in_ac = is_trace ? trace3[2*DATA_WIDTH+:MODULUS_WIDTH] : AC_sub;
assign shuffle_in_bd = is_trace ? trace3[3*DATA_WIDTH+:MODULUS_WIDTH] : BD_sub;


// A-C -- Shuffle
shuffle_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .IN_MODULUS(IN_MODULUS)
) a_sub_c(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(shuffle_in_ac),
    .i_galois_elt(i_galois_elt),
    .o_data(o_data[2*DATA_WIDTH+:DATA_WIDTH]),
    .o_addr(o_addr[2*ADDR_WIDTH+:ADDR_WIDTH]),
    .o_we(o_we[2]),
    .i_valid(valid_shift[2])
);

// B-D -- Shuffle
shuffle_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .IN_MODULUS(IN_MODULUS)
) b_sub_d(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(shuffle_in_bd),
    .i_galois_elt(i_galois_elt),
    .o_data(o_data[3*DATA_WIDTH+:DATA_WIDTH]),
    .o_addr(o_addr[3*ADDR_WIDTH+:ADDR_WIDTH]),
    .o_we(o_we[3]),
    .i_valid(valid_shift[2])
);

endmodule

/*
    Top Module: monox_aggressive_seq.v
    Data:       Unsign format, 64 bit (most significant (64-35) bits are 0)
    Role:       read the corresponding address from BRAM and execute negate or bypass
    Warm-up:    Not input & output valid, start process when detecting high i_en.
                the first data comes out "6" cycles after i_en set high.
                initial interval (II = 1)
    Timing:     Sequential Logic, 5/6-cycle latency
                    first part: register the input or shift&negate the input. (1-cycle latency)
                    second part: cross operation, (3-cycle latency)
                    third part: shuffle (2-cycle latency); zero-extension (1-cycle latency)
    Dummy Data:  {DATA_WIDTH{1'b0}}
    Function:
                                                            ||                                                 ||
                                        first part          ||               second part                       ||       third part
                                        Shift&Negate        ||               cross                             ||       shuffle
                                                            ||                                                 ||
                                            cycle 1                          cycle 2 & 3                                cycle 4 & 5
                                                                            _______________
                                    ______                                 |              |
            i_data (A) ------------>_|_|_| ------------------------------> | A        A+B | ----->    o_data
    [0*MODULUS_WIDTH+:MODULUS_WIDTH]                       connection_data |              |   [0*DATA_WIDTH+:DATA_WIDTH]
                                                [0*DATA_WIDTH+:DATA_WIDTH] |              |
                                    ____________________                   |              |
            i_data (B) ------------>|    modulus sub    | ---------------> | B        C+D | ----->   o_data
    [1*MODULUS_WIDTH+:MODULUS_WIDTH]|___________________|  connection_data |              |   [1*DATA_WIDTH+:DATA_WIDTH]
                                                [1*DATA_WIDTH+:DATA_WIDTH] |    Cross     |
                                    ______                                 |              |                     _______________________________
            i_data (C) ------------>_|_|_| ------------------------------> | C        A-B | ------------------> |           shuffle           |   -->        o_data
    [2*MODULUS_WIDTH+:MODULUS_WIDTH]                       connection_data |              |   cross_res_wire    |_____________________________|    [2*DATA_WIDTH+:DATA_WIDTH]
                                                [2*DATA_WIDTH+:DATA_WIDTH] |              | [0*MODULUS_WIDTH+:MODULUS_WIDTH]
                                    _____________________                  |              |                     ______________________________
            i_data (D) ------------>|    modulus sub    | ---------------> | D        C-D | ------------------> |           shuffle           |   -->        o_data
    [3*MODULUS_WIDTH+:MODULUS_WIDTH]|___________________|  connection_data |              |   cross_res_wire    |_____________________________|    [3*DATA_WIDTH+:DATA_WIDTH]
                                                [3*DATA_WIDTH+:DATA_WIDTH] |______________| [1*MODULUS_WIDTH+:MODULUS_WIDTH]

    Output Control:
        ________________________
        |        shuffle         | --> o_addr
        |________________________| --> o_we


    Data layout:
            i_data layout
            MSB                                                          LSB
            [  DATA_WIDTH  |  DATA_WIDTH  |  DATA_WIDTH  |  DATA_WIDTH  ]
                   D              C              B              A

            o_data layout
            MSB                                                          LSB
            [  DATA_WIDTH  |  DATA_WIDTH  |  DATA_WIDTH  |  DATA_WIDTH  ]
                  C-D            A-B            C+D            A+B
*/
