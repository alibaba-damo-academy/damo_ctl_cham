// `include "mux_defines.vh"

/*
    Author: Jianming Tong (jianming.tong@gatech.edu)
    Modified by: Shengrong Liu (srliu1997@pku.edu.cn)
*/

module mux_seq#(
    parameter DATA_WIDTH = 64,
    parameter MODULUS_WIDTH = 35,
    parameter INDEX_WIDTH = 13,
    parameter ADDR_WIDTH = INDEX_WIDTH - 1,
    parameter URAM_READ_LATENCY = 5,
    parameter BRAM_READ_LATENCY = 2
)(
    input clk,
    input rst_n,

    input [4*DATA_WIDTH-1:0] i_data_a0,
    input [4*DATA_WIDTH-1:0] i_data_a1,
    input [4*DATA_WIDTH-1:0] i_data_b0,
    input [4*DATA_WIDTH-1:0] i_data_c1,
    input i_mode,               // mode
    input [3:0] i_n,            // input power of 2
    input [3:0] i_n_c1,         // input forward from output addx

    output reg [3:0] o_n,                         // output power of 2
    output reg [4*DATA_WIDTH-1:0] o_data_o1,      // output data port group o1
    output reg [4*DATA_WIDTH-1:0] o_data_o2,      // output data port group o2

    // BRAM/URAM control signals
    output reg [ADDR_WIDTH-1:0] o_addr_a0,      // output address port for input group a0
    output reg [ADDR_WIDTH-1:0] o_addr_a1,      // output address port for input group a1
    output reg [ADDR_WIDTH-1:0] o_addr_b0,      // output address port for input group b0
    output reg o_en_bram_a0,   // output read enable for input group a0
    output reg o_en_bram_a1,   // output read enable for input group a1
    output reg o_en_bram_b0,   // output read enable for input group b0

    // control signals
    input i_en,           // module enable control
    input i_start,        // whether to start processing
    output o_valid,       // when to finish processing
    output o_negate
);

// parameter

localparam [ADDR_WIDTH-1:0] ADDRESS_START_A0 = 0;
localparam [ADDR_WIDTH-1:0] ADDRESS_START_A1 = 2048;
localparam [ADDR_WIDTH-1:0] ADDRESS_END_A0 = 4095 - 2;
//vpu3 latency = 9 + BRAM; addx latency = 2; C1 latency = 1 + URAM_READ_LATENCY
localparam C1_LATENCY = 10 + BRAM_READ_LATENCY - URAM_READ_LATENCY;  // Yanheng: risky bug: C1 data 8 cycles later than B0 data, not 7.

wire [ADDR_WIDTH-1:0] o_addr_b0_start;

reg processing;
reg [URAM_READ_LATENCY:0] valid_shift;
reg mode0_finish;
reg mode1_finish;


reg [3:0] c1_cnt;
always @(posedge clk or negedge rst_n)
    if (!rst_n)
        c1_cnt <= 0;
    else if (i_start)
        c1_cnt <= 0;
    else if (processing)
        c1_cnt <= c1_cnt == C1_LATENCY ? c1_cnt : c1_cnt + 1;

// i_start triggers processing
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        processing <= 1'b0;
    else if(i_en & i_start)
        processing <= 1'b1;
    else if(i_en & (mode0_finish | mode1_finish))
        processing <= 1'b0;
    else if(i_en)
        processing <= processing;
    else
        processing <= 1'b0;


// o_valid -- valid_shift generation
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        valid_shift <= 0;
    else if(i_en & (~i_mode))
        valid_shift <= {valid_shift[URAM_READ_LATENCY-1:0], o_en_bram_a0};
    else if(i_en & i_mode)
        valid_shift <= {valid_shift[URAM_READ_LATENCY-1:0], o_en_bram_b0};
    else
        valid_shift <= 0;

/*
    mode 1 related control
*/

// mode1 finish control
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        mode1_finish <= 1'b0;
    else if(i_en & processing & i_mode)
        //mode1_finish <= o_addr_b0 == (o_addr_b0_start - 1'b1) - 2;
        mode1_finish <= o_addr_b0 == 12'hffd;  // Bug: Syntax error.
    else
        mode1_finish <= 1'b0;

assign o_addr_b0_start = 0; //'d4096 - ('d4096 >> i_n);

// output address for group b0
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        o_addr_b0 <= 0;
    // else if(i_en & processing & i_mode)
    else if(i_en & processing & i_mode & (c1_cnt == C1_LATENCY))  // Bug: Delay data_b0 to make it align with data_c1.
        o_addr_b0 <= o_addr_b0 + 1;
    else
        o_addr_b0 <= o_addr_b0_start - 1'b1;

// output write enable for group b0
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        o_en_bram_b0 <= 1'b0;
    // else if(i_en & processing & i_mode)
    else if(i_en & processing & i_mode & (c1_cnt == C1_LATENCY))  // Bug: Delay data_b0 to make it align with data_c1.
        o_en_bram_b0 <= 1'b1;
    else
        o_en_bram_b0 <= 1'b0;

/*
    mode 0 related control
*/

// mode0 finish control
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        mode0_finish <= 1'b0;
    else if(i_en & processing & (~i_mode))
        mode0_finish <= o_addr_a0 == ADDRESS_END_A0;
    else
        mode0_finish <= 1'b0;

// output address for group a0
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        o_addr_a0 <= 0;
    else if(i_en & processing & (~i_mode))
        o_addr_a0 <= o_addr_a0 + 1;
    else
        o_addr_a0 <= ADDRESS_START_A0 - 1;

// output address for group a1
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        o_addr_a1 <= 0;
    else if(i_en & processing & (~i_mode))
        o_addr_a1 <= o_addr_a1 + 1;
    else
        o_addr_a1 <= ADDRESS_START_A1 - 1;

// output write enable for group a0 & a1
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        {o_en_bram_a1, o_en_bram_a0} <= 2'b0;
    else if(i_en & processing & (~i_mode))
        {o_en_bram_a1, o_en_bram_a0} <= 2'b11;
    else
        {o_en_bram_a1, o_en_bram_a0} <= 2'b0;


always @(posedge clk or negedge rst_n)
    if (!rst_n)
        o_n <= 4'b0;
    else if (i_en)
        // o_n <= i_mode ? i_n_c1 : i_n;
        o_n <= i_n;  // Bug: Don't need i_n_c1.


assign o_valid = i_mode ? valid_shift[URAM_READ_LATENCY] : valid_shift[BRAM_READ_LATENCY];

wire [ADDR_WIDTH-1:0] negate_addr;
assign negate_addr = 4096 >> o_n;
assign o_negate = o_valid & ((i_mode ? (o_addr_b0 - URAM_READ_LATENCY) : (o_addr_a0 - BRAM_READ_LATENCY)) <= negate_addr);

/*
    data transmission
*/

// output port group o1.
always @(posedge clk)
    if(i_en)
        if(~i_mode) begin
            o_data_o1[0*DATA_WIDTH+:DATA_WIDTH] <= i_data_a0[0*DATA_WIDTH+:DATA_WIDTH];
            o_data_o1[1*DATA_WIDTH+:DATA_WIDTH] <= i_data_a1[0*DATA_WIDTH+:DATA_WIDTH];
            o_data_o1[2*DATA_WIDTH+:DATA_WIDTH] <= i_data_a0[2*DATA_WIDTH+:DATA_WIDTH];
            o_data_o1[3*DATA_WIDTH+:DATA_WIDTH] <= i_data_a1[2*DATA_WIDTH+:DATA_WIDTH];
        end
        else begin
            o_data_o1[0*DATA_WIDTH+:DATA_WIDTH] <= i_data_b0[0*DATA_WIDTH+:DATA_WIDTH];
            o_data_o1[1*DATA_WIDTH+:DATA_WIDTH] <= i_data_c1[0*DATA_WIDTH+:DATA_WIDTH];
            o_data_o1[2*DATA_WIDTH+:DATA_WIDTH] <= i_data_b0[2*DATA_WIDTH+:DATA_WIDTH];
            o_data_o1[3*DATA_WIDTH+:DATA_WIDTH] <= i_data_c1[2*DATA_WIDTH+:DATA_WIDTH];
        end

// output port group o2.
always @(posedge clk)
    if(i_en)
        if(~i_mode) begin
            o_data_o2[0*DATA_WIDTH+:DATA_WIDTH] <= i_data_a0[1*DATA_WIDTH+:DATA_WIDTH];
            o_data_o2[1*DATA_WIDTH+:DATA_WIDTH] <= i_data_a1[1*DATA_WIDTH+:DATA_WIDTH];
            o_data_o2[2*DATA_WIDTH+:DATA_WIDTH] <= i_data_a0[3*DATA_WIDTH+:DATA_WIDTH];
            o_data_o2[3*DATA_WIDTH+:DATA_WIDTH] <= i_data_a1[3*DATA_WIDTH+:DATA_WIDTH];
        end
        else begin
            o_data_o2[0*DATA_WIDTH+:DATA_WIDTH] <= i_data_b0[1*DATA_WIDTH+:DATA_WIDTH];
            o_data_o2[1*DATA_WIDTH+:DATA_WIDTH] <= i_data_c1[1*DATA_WIDTH+:DATA_WIDTH];
            o_data_o2[2*DATA_WIDTH+:DATA_WIDTH] <= i_data_b0[3*DATA_WIDTH+:DATA_WIDTH];
            o_data_o2[3*DATA_WIDTH+:DATA_WIDTH] <= i_data_c1[3*DATA_WIDTH+:DATA_WIDTH];
        end

endmodule
