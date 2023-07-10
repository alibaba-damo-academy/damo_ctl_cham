// `include "monox_defines.vh"

/*
    Author: Jianming Tong (jianming.tong@gatech.edu)
    Modified by: Shengrong Liu (srliu1997@pku.edu.cn)
*/

module mux_monox_seq#(
    parameter DATA_WIDTH = 64,              // the bit length of the data.
    parameter MODULUS_WIDTH = 35,           // the bit length of the modulus.
    parameter INDEX_WIDTH = 13,             // the bit length of the inner index
    parameter ADDR_WIDTH = INDEX_WIDTH - 1,
    parameter URAM_READ_LATENCY = 5,        // URAM read latency
    parameter BRAM_READ_LATENCY = 2,
    parameter Q0 = 35'h4_0008_0001,         // Input modulus for yellow group
    parameter Q1 = 35'h4_0800_0001,         // Input modulus for green group
    parameter POWER_WIDTH = 4
)(
    input clk,
    input rst_n,

    // data signals
    input [4*DATA_WIDTH-1:0] i_data_a0,     // input data port group a0
    input [4*DATA_WIDTH-1:0] i_data_a1,     // input data port group a1
    input [4*DATA_WIDTH-1:0] i_data_b0,     // input data port group b0
    input [4*DATA_WIDTH-1:0] i_data_c1,     // input data port group c1
    input i_mode,                           // input mode
    input [POWER_WIDTH-1:0] i_n,            // input power of 2
    input [POWER_WIDTH-1:0] i_n_c1,         // input forward from output addx

    output [POWER_WIDTH-1:0] o_n,           // output power of 2
    output [4*DATA_WIDTH-1:0] o_data_y,     // output data port group o1
    output [4*DATA_WIDTH-1:0] o_data_g,     // output data port group o2
    output [4*ADDR_WIDTH-1:0] o_addr_y,     // output address yellow group
    output [4*ADDR_WIDTH-1:0] o_addr_g,     // output address green group
    output [3:0] o_we_y,                    // output write yellow group
    output [3:0] o_we_g,                    // output write green group

    // BRAM/URAM control signals
    output [ADDR_WIDTH-1:0] o_addr_a0,      // output address port for input group a0
    output [ADDR_WIDTH-1:0] o_addr_a1,      // output address port for input group a1
    output [ADDR_WIDTH-1:0] o_addr_b0,      // output address port for input group b0
    output o_en_bram_a0,                    // output read enable for input group a0
    output o_en_bram_a1,                    // output read enable for input group a1
    output o_en_bram_b0,                    // output read enable for input group b0

    // control signals
    input is_trace,
    input i_en,                             // module enable control
    input i_start,                          // whether to start processing
    output o_done                           // when to finish processing
);


// inner logic
wire [4*DATA_WIDTH-1:0] inner_mux_o_data_o1;
wire [4*DATA_WIDTH-1:0] inner_mux_o_data_o2;
wire inner_valid;
wire [POWER_WIDTH-1:0] inner_n;
reg  [POWER_WIDTH-1:0] inner_o_n;
wire inner_negate;

mux_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .URAM_READ_LATENCY(URAM_READ_LATENCY),
    .BRAM_READ_LATENCY(BRAM_READ_LATENCY)
) pre_mux(
    .clk(clk),
    .rst_n(rst_n),
    .i_data_a0(i_data_a0),             // input data port group a0
    .i_data_a1(i_data_a1),             // input data port group a1
    .i_data_b0(i_data_b0),             // input data port group b0
    .i_data_c1(i_data_c1),             // input data port group c1
    .i_mode(i_mode),                   // input mode
    .i_n(i_n),                         // input power of 2
    .i_n_c1(i_n_c1),                   // input power of 2
    .o_n(inner_n),                     // outut power of 2
    .o_data_o1(inner_mux_o_data_o1),   // output data port group o1
    .o_data_o2(inner_mux_o_data_o2),   // output data port group o2
    .o_addr_a0(o_addr_a0),             // output address port for input group a0
    .o_addr_a1(o_addr_a1),             // output address port for input group a1
    .o_addr_b0(o_addr_b0),             // output address port for input group b0
    .o_en_bram_a0(o_en_bram_a0),       // output write enable for input group a0
    .o_en_bram_a1(o_en_bram_a1),       // output write enable for input group a1
    .o_en_bram_b0(o_en_bram_b0),       // output write enable for input group b0
    .i_en(i_en),
    .i_start(i_start),                 // whether to start processing
    .o_valid(inner_valid),
    .o_negate(inner_negate)
);

monox_aggressive_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .IN_MODULUS(Q0)
) yellow_group(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(inner_mux_o_data_o1),
    .i_n(inner_n),
    .o_data(o_data_y),
    .o_addr(o_addr_y),
    .o_we(o_we_y),
    .i_en(i_en),
    .i_valid(inner_valid),
    .o_done(o_done),
    .i_start(i_start),
    .i_negate(inner_negate),
    .is_trace(is_trace)
);

monox_aggressive_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .IN_MODULUS(Q1)
) green_group(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(inner_mux_o_data_o2),
    .i_n(inner_n),
    .o_data(o_data_g),
    .o_addr(o_addr_g),
    .o_we(o_we_g),
    .i_en(i_en),
    .i_valid(inner_valid),
    .o_done(),
    .i_start(i_start),
    .i_negate(inner_negate),
    .is_trace(is_trace)
);

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        inner_o_n <= 0;
    else if(i_en)
        inner_o_n <= inner_n;
    else
        inner_o_n <= 0;

assign o_n = inner_o_n;

endmodule