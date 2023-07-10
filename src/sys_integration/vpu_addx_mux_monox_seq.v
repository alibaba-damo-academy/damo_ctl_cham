// `include "monox_defines.vh"

/*
    Author: Jianming Tong (jianming.tong@gatech.edu)
    Modified by: Shengrong Liu (srliu1997@pku.edu.cn)
*/

module vpu_addx_mux_monox_seq#(
    parameter DATA_WIDTH = 64,                            // the bit length of the data.
    parameter MODULUS_WIDTH = 35,                         // the bit length of the modulus.
    parameter INDEX_WIDTH = 13,                           // the bit length of the inner index
    parameter ADDR_WIDTH = INDEX_WIDTH - 1,
    parameter URAM_READ_LATENCY = 5,                      // URAM read latency
    parameter BRAM_READ_LATENCY = 2,
    parameter IN_MODULUS = 35'h4_0008_0001,               // Input modulus
    parameter P = 39'h40_0080_0001,
    parameter Q0 = 35'h4_0008_0001,
    parameter Q1 = 35'h4_0800_0001,

    // inverse of modulus (for Barrett reduction)
    parameter IQ0 = 36'd68_717_379_643,
    parameter IQ1 = 36'd68_186_767_610,

    // P inverse mod Q
    parameter PIMQ0 = 35'd8_017_516_954,
    parameter PIMQ1 = 35'd14_972_836_665,

    // modulus width
    parameter MWIDTH = 35,

    parameter POWER_WIDTH = 4
)
(
// timing signals
    input clk,
    input rst_n,               // asynchronous reset

// data signals
    input [2*DATA_WIDTH-1:0] i_data_g1_addx,      // input data
    input [2*DATA_WIDTH-1:0] i_data_g0_addx,      // input data
    input [4*DATA_WIDTH-1:0] i_dina_vpu,
    input [4*DATA_WIDTH-1:0] i_dinb_vpu,
    input [2*DATA_WIDTH-1:0] i_dinc_vpu,
    input [4*DATA_WIDTH-1:0] i_data_a0,
    input [4*DATA_WIDTH-1:0] i_data_a1,
    input [4*DATA_WIDTH-1:0] i_data_b0,
    input [4*DATA_WIDTH-1:0] i_data_c1,

// output to the following module
    output [POWER_WIDTH-1:0] o_n,                  // output power of 2
    output [4*DATA_WIDTH-1:0] o_data_y,            // output data port group o1
    output [4*DATA_WIDTH-1:0] o_data_g,            // output data port group o2

// vpu BRAM control signals
    output o_rdena_vpu,
    output o_rdenb_vpu,
    output o_rdenc_vpu,
    output o_wren_vpu,
    output [ADDR_WIDTH-1:0] o_rdaddra_vpu,
    output [ADDR_WIDTH-1:0] o_rdaddrb_vpu,
    output [ADDR_WIDTH-1:0] o_rdaddrc_vpu,
    output [ADDR_WIDTH-1:0] o_wrdaddr_vpu,

// addx BRAM control signals
    input [POWER_WIDTH-1:0] i_n_addx,            // input power of 2
    output [ADDR_WIDTH-1:0] o_addr_g0_addx,      // output write address for input to addx -- group g0
    output [ADDR_WIDTH-1:0] o_addr_g1_addx,      // output write address for input to addx -- group g1
    output o_en_bram_g0_addx,   // output bram enable signal for input to addx -- group 0
    output o_en_bram_g1_addx,   // output bram enable signal for input to addx -- group 1

// monox BRAM/URAM control signals
    input [POWER_WIDTH-1:0] i_n_monox,             // input power of 2
    output [4*ADDR_WIDTH-1:0] o_addr_y,            // output address yellow group
    output [4*ADDR_WIDTH-1:0] o_addr_g,            // output address green group
    output [3:0] o_we_y,              // output write yellow group
    output [3:0] o_we_g,              // output write green group

// mux BRAM/URAM control signals
    input i_mode,
    output [ADDR_WIDTH-1:0] o_addr_a0,           // output address port for input group a0
    output [ADDR_WIDTH-1:0] o_addr_a1,           // output address port for input group a1
    output [ADDR_WIDTH-1:0] o_addr_b0,           // output address port for input group b0
    output o_en_bram_a0,        // output read enable for input group a0
    output o_en_bram_a1,        // output read enable for input group a1
    output o_en_bram_b0,        // output read enable for input group b0

// data and control for writing reduce buffer
    input i_s7_mode,                             // input mode to control the destination of output data.
    output [4*DATA_WIDTH-1:0] o_data_rb,         // output data for reduce buffer
    output [ADDR_WIDTH-1:0] o_addr_rb,           // output write address for reduce buffer
    output o_we_rb,                              // output write enable for writing reduce buffer

// hyper-block pipeline control signals
    input is_trace,
    input i_en,                // whether to enable processing
    input i_start_addx,        // whether to start processing in addx
    input i_start_monox,       // whether to start processing in monox
    output o_done_addx,             // Bug: new output
    output o_done_monox              // indicate the end of valid
);


// inner logic
wire [POWER_WIDTH-1:0] inner_n_addx;
wire [4*DATA_WIDTH-1:0] inner_o_data_addx;
wire inner_valid;

vpu_addx_seq#(
    .P(P),
    .Q0(Q0),
    .Q1(Q1),
    // inverse of modulus (for Barrett reduction)
    .IQ0(IQ0),
    .IQ1(IQ1),
    // P inverse mod Q
    .PIMQ0(PIMQ0),
    .PIMQ1(PIMQ1),
    .BRAM_DELAY(BRAM_READ_LATENCY),
    // modulus width
    .MWIDTH(MWIDTH),
    .DATA_WIDTH(DATA_WIDTH),                     // the bit length of the data.
    .MODULUS_WIDTH(MODULUS_WIDTH)                // the bit length of the modulus.
) vpu_addx (
// timing signals
    .clk(clk),
    .rst_n(rst_n),                           // asynchronous reset
// data signals
    .i_data_g1_addx(i_data_g1_addx),         // input data
    .i_data_g0_addx(i_data_g0_addx),         // input data
    .i_dina_vpu(i_dina_vpu),
    .i_dinb_vpu(i_dinb_vpu),
    .i_dinc_vpu(i_dinc_vpu),
    .o_rdena_vpu(o_rdena_vpu),
    .o_rdenb_vpu(o_rdenb_vpu),
    .o_rdenc_vpu(o_rdenc_vpu),
    .o_wren_vpu(o_wren_vpu),
    .o_rdaddra_vpu(o_rdaddra_vpu),
    .o_rdaddrb_vpu(o_rdaddrb_vpu),
    .o_rdaddrc_vpu(o_rdaddrc_vpu),
    .o_wrdaddr_vpu(o_wrdaddr_vpu),
// control signals
    .i_n(i_n_addx),                          // input power of 2
    .o_addr_g0_addx(o_addr_g0_addx),         // output write address for input to addx -- group
    .o_addr_g1_addx(o_addr_g1_addx),         // output write address for input to addx -- group g1
    .o_en_bram_g0_addx(o_en_bram_g0_addx),   // output bram enable signal for input to addx -- group 0
    .o_en_bram_g1_addx(o_en_bram_g1_addx),   // output bram enable signal for input to addx -- group 1
// output to the following module
    .o_data(inner_o_data_addx),              // output data
    .o_n_addx(inner_n_addx),                 // output power of 2
// hyper-block pipeline control signals
    .i_en(i_en),                             // whether to enable processing
    .i_start(i_start_addx),                  // whether to start processing
    .o_done(o_done_addx),  // Bug: new
    .o_valid(inner_valid),                   // indicate the end of valid
    .i_s7_mode(i_s7_mode),
    .o_data_rb(o_data_rb),
    .o_addr_rb(o_addr_rb),
    .o_we_rb(o_we_rb)
);


mux_monox_seq #(
    .DATA_WIDTH(DATA_WIDTH),
    .MODULUS_WIDTH(MODULUS_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .URAM_READ_LATENCY(URAM_READ_LATENCY),
    .BRAM_READ_LATENCY(BRAM_READ_LATENCY),
    .Q0(Q0),
    .Q1(Q1)
) mux_monox(
    .clk(clk),
    .rst_n(rst_n),
    .i_data_a0(i_data_a0),            // input data port group a0
    .i_data_a1(i_data_a1),            // input data port group a1
    .i_data_b0(i_data_b0),            // input data port group b0
    .i_data_c1(inner_o_data_addx),    // input data port group c1
    .i_mode(i_mode),                  // input mode
    .i_n(i_n_monox),                  // input power of 2
    .i_n_c1(inner_n_addx),            // input power of 2
    .o_n(o_n),                        // outut power of 2
    .o_data_y(o_data_y),              // output data port group o1
    .o_data_g(o_data_g),              // output data port group o2
    .o_addr_y(o_addr_y),              // output address yellow group
    .o_addr_g(o_addr_g),              // output address green group
    .o_we_y(o_we_y),                  // output write yellow group
    .o_we_g(o_we_g),                  // output write green group
    .o_addr_a0(o_addr_a0),            // output address port for input group a0
    .o_addr_a1(o_addr_a1),            // output address port for input group a1
    .o_addr_b0(o_addr_b0),            // output address port for input group b0
    .o_en_bram_a0(o_en_bram_a0),      // output write enable for input group a0
    .o_en_bram_a1(o_en_bram_a1),      // output write enable for input group a1
    .o_en_bram_b0(o_en_bram_b0),      // output write enable for input group b0
    .i_en(i_en),
    .i_start(i_start_monox),          // whether to start processing
    .o_done(o_done_monox),
    .is_trace(is_trace)
);

endmodule