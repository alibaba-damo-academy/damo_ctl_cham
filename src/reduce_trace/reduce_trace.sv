//////////////////////////////////////////////////
//
// File:            reduce_trace.sv
// Project Name:    MVP
// Module Name:     reduce_trace
// Description:     Reduce/Trace module
//
// Author:          Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      06/08/2021
// Modify Date:     24/08/2021
//
//////////////////////////////////////////////////

`include "common_defines.vh"

module reduce_trace #(
    parameter COE_WIDTH = 39,
    parameter Q_WIDTH = 35,

    parameter ADDR_WIDTH = 12,
    parameter ADDR_WIDTH_H = 3,
    parameter ADDR_WIDTH_L = 9,

    parameter LEVEL_WIDTH = 4,
    parameter N_POLY_CT = 4,

    parameter COMMON_BRAM_DELAY = 1,
    parameter COMMON_MULRED_DELAY = 5,
    parameter COMMON_SWAP_DELAY = 2,
    parameter COMMON_NTT_PIP_DELAY = COMMON_BRAM_DELAY + COMMON_MULRED_DELAY + COMMON_SWAP_DELAY,
    parameter COMMON_URAM_DELAY = 1,

    parameter P = 39'h40_0080_0001,
    parameter Q0 = 35'h4_0800_0001,
    parameter Q1 = 35'h4_0008_0001,

    parameter IP = 40'd1099478074363,
    parameter IQ0 = 36'd68186767610,
    parameter IQ1 = 36'd68717379643,

    parameter PIMQ0 = 35'd14_972_836_665,
    parameter PIMQ1 = 35'd8_017_516_954,

    parameter N_STAGE = 5,
    parameter POLY_SIZE = 1 << ADDR_WIDTH,
    parameter N_BANK = 1 << ADDR_WIDTH_H,
    parameter MEM_DEPTH = 1 << ADDR_WIDTH_L,

    parameter N_POLY = 6,
    parameter N_POLY_SUB = N_POLY - N_POLY_CT
)
(
    input   logic                                   clk,
    input   logic                                   rst_n,

    // control
    input   logic  [N_STAGE-1:0]                    i_start_x5,
    input   logic                                   i_switch_mode,
    input   logic                                   i_stall,
    input   logic                                   i_last_write,
    input   logic                                   i_is_trace,
    output  logic  [N_STAGE-1:0]                    o_done_x5,

    input   logic  [N_STAGE-1:0][LEVEL_WIDTH-1:0]   i_level_x5,

    // redbuf
    output  logic                                   o_redbuf_we,
    output  logic  [ADDR_WIDTH-1:0]                 o_redbuf_waddr,
    output  logic  [N_POLY_CT-1:0][Q_WIDTH-1:0]     o_redbuf_wdata,  // SHORT

    input   logic  [N_POLY_CT-1:0][Q_WIDTH-1:0]     i_redbuf_rdata,  // SHORT
    output  logic  [ADDR_WIDTH-1:0]                 o_redbuf_raddr,

    // preprocess
    input   logic  [N_POLY_CT-1:0][Q_WIDTH-1:0]     i_prep_rdata_a0,  // SHORT
    input   logic  [N_POLY_CT-1:0][Q_WIDTH-1:0]     i_prep_rdata_a1,  // SHORT

    output  logic  [ADDR_WIDTH-1:0]                 o_prep_raddr_a0,
    output  logic  [ADDR_WIDTH-1:0]                 o_prep_raddr_a1,

    // ksk
    input   logic  [N_POLY-1:0][COE_WIDTH*2-1:0]    i_ksk_rdata,
    output  logic  [ADDR_WIDTH-1:0]                 o_ksk_raddr
);

    localparam DIFF_WIDTH = COE_WIDTH - Q_WIDTH;

    // ---------------------------------------------------------------------
    // I/O
    // ---------------------------------------------------------------------

    logic                                           s7_mode;
    logic                                           s7_to_redbuf_we_1b_x1;
    logic  [ADDR_WIDTH-1:0]                         s7_to_redbuf_waddr_12b_x1;
    logic  [N_POLY_CT-1:0][COE_WIDTH-1:0]           s7_to_redbuf_wdata_x1_x4;

    logic  [N_POLY_CT-1:0][COE_WIDTH-1:0]           prep_to_s3_rdata_a0_x1_x4;
    logic  [N_POLY_CT-1:0][COE_WIDTH-1:0]           prep_to_s3_rdata_a1_x1_x4;
    logic  [N_POLY_CT-1:0][COE_WIDTH-1:0]           redbuf_to_s3_rdata_x1_x4;

    logic  [ADDR_WIDTH-1:0]                         s3_to_prep_raddr_a0_12b_x1;
    logic  [ADDR_WIDTH-1:0]                         s3_to_prep_raddr_a1_12b_x1;
    logic  [ADDR_WIDTH-1:0]                         s3_to_redbuf_raddr_12b_x1;

    logic  [N_POLY-1:0][COE_WIDTH*2-1:0]            ksk_rdata_x2_x6;
    logic  [ADDR_WIDTH-1:0]                         s5_to_pp1ksk_raddr_12b_x1;

    // done
    logic  [N_POLY-1:0]                             s4_done;
    logic  [N_POLY-1:0]                             s6_done;

    assign o_redbuf_we = s7_to_redbuf_we_1b_x1;
    assign o_redbuf_waddr = s7_to_redbuf_waddr_12b_x1;
    assign s7_mode = i_stall & (!i_last_write);
    // assign o_redbuf_wdata = s7_to_redbuf_wdata_x1_x4[Q_WIDTH-1:0];  // Bug

    always_comb begin
        for (int i = 0; i < N_POLY_CT; i++) begin
            prep_to_s3_rdata_a0_x1_x4[i] = {{DIFF_WIDTH{1'b0}}, i_prep_rdata_a0[i]};
            prep_to_s3_rdata_a1_x1_x4[i] = {{DIFF_WIDTH{1'b0}}, i_prep_rdata_a1[i]};
            redbuf_to_s3_rdata_x1_x4[i] = {{DIFF_WIDTH{1'b0}}, i_redbuf_rdata[i]};
            o_redbuf_wdata[i] = s7_to_redbuf_wdata_x1_x4[i][Q_WIDTH-1:0];
        end
    end
    // assign prep_to_s3_rdata_a0_x1_x4 = {{DIFF_WIDTH{1'b0}}, i_prep_rdata_a0};  // Bug
    // assign prep_to_s3_rdata_a1_x1_x4 = {{DIFF_WIDTH{1'b0}}, i_prep_rdata_a1};  // Bug
    // assign redbuf_to_s3_rdata_x1_x4 = {{DIFF_WIDTH{1'b0}}, i_redbuf_rdata};  // Bug

    assign o_prep_raddr_a0 = s3_to_prep_raddr_a0_12b_x1;
    assign o_prep_raddr_a1 = s3_to_prep_raddr_a1_12b_x1;
    assign o_redbuf_raddr = s3_to_redbuf_raddr_12b_x1;

    assign ksk_rdata_x2_x6 = i_ksk_rdata;
    assign o_ksk_raddr = s5_to_pp1ksk_raddr_12b_x1;

    assign o_done_x5[1] = &s4_done;
    assign o_done_x5[3] = &s6_done;

    // ---------------------------------------------------------------------
    // Upper buffer
    // ---------------------------------------------------------------------

    logic  [N_POLY-1:0]                             s3_to_upper_we_1b_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH-1:0]             s3_to_upper_waddr_12b_x6;
    logic  [N_POLY-1:0][COE_WIDTH-1:0]              s3_to_upper_wdata_x1_x6;
    logic  [N_POLY-1:0][Q_WIDTH-1:0]                s3_to_upper_wdata_x1_x6_q;  // SHORT

    logic  [N_POLY-1:0][ADDR_WIDTH-1:0]             s7_to_upper_raddr_12b_x6;
    logic  [N_POLY-1:0][COE_WIDTH-1:0]              upper_to_s7_rdata_x1_x6;
    logic  [N_POLY-1:0][Q_WIDTH-1:0]                upper_to_s7_rdata_x1_x6_q;  // SHORT

    assign s7_to_upper_raddr_12b_x6[1] = s7_to_upper_raddr_12b_x6[0];
    assign s7_to_upper_raddr_12b_x6[3] = s7_to_upper_raddr_12b_x6[2];
    assign s7_to_upper_raddr_12b_x6[5] = s7_to_upper_raddr_12b_x6[4];

    always_comb begin
        for (int i = 0; i < N_POLY; i++) begin
            upper_to_s7_rdata_x1_x6[i] = {{DIFF_WIDTH{1'b0}}, upper_to_s7_rdata_x1_x6_q[i]};
            s3_to_upper_wdata_x1_x6_q[i] = s3_to_upper_wdata_x1_x6[i][Q_WIDTH-1:0];
        end
    end

    generate
        for (genvar i = 0; i < N_POLY; i++) begin : g3
            pp_buffer_x4 #(
                    .COE_WIDTH(Q_WIDTH),  // SHORT
                    .ADDR_WIDTH(ADDR_WIDTH),
                    .ADDR_WIDTH_H(ADDR_WIDTH_H),
                    .ADDR_WIDTH_L(ADDR_WIDTH_L),
                    .N_BANK(N_BANK),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
                )
                pp (
                    .i_switch_mode(i_switch_mode),

                    .i_we(s3_to_upper_we_1b_x6[i]),  // from s3 (1b)
                    .i_waddr(s3_to_upper_waddr_12b_x6[i]),  // from s3 (12b)
                    .i_wdata(s3_to_upper_wdata_x1_x6_q[i]),  // from s3 (x1)

                    .i_raddr(s7_to_upper_raddr_12b_x6[i]),  // from s7 (12b)
                    .o_rdata(upper_to_s7_rdata_x1_x6_q[i]),  // to s7 (x1)
                    .*
                );
        end
    endgenerate

    // ---------------------------------------------------------------------
    // s3, s7, mux
    // ---------------------------------------------------------------------

    // s3 -> pp1/sub
    logic  [N_POLY_CT-1:0][COE_WIDTH-1:0]           s3_wdata_y_x1_x4;  // SHORT
    logic  [N_POLY_CT-1:0][COE_WIDTH-1:0]           s3_wdata_g_x1_x4;  // SHORT

    logic  [N_POLY_CT-1:0][ADDR_WIDTH-1:0]          s3_waddr_y_12b_x4;
    logic  [N_POLY_CT-1:0][ADDR_WIDTH-1:0]          s3_waddr_g_12b_x4;

    logic  [N_POLY_CT-1:0]                          s3_we_y_1b_x4;
    logic  [N_POLY_CT-1:0]                          s3_we_g_1b_x4;

    logic  [N_POLY-1:0]                             sub_to_pp1_we_1b_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH-1:0]             sub_to_pp1_waddr_12b_x6;
    logic  [N_POLY-1:0][COE_WIDTH-1:0]              sub_to_pp1_wdata_x1_x6;  // SHORT

    logic  [N_POLY_SUB-1:0]                         monox_to_sub_we_1b_x2;
    logic  [N_POLY_SUB-1:0][ADDR_WIDTH-1:0]         monox_to_sub_waddr_12b_x2;
    logic  [N_POLY_SUB-1:0][COE_WIDTH-1:0]          monox_to_sub_wdata_x1_x2;  // SHORT

    // pp2 -> s7
    logic  [N_POLY-1:0][COE_WIDTH-1:0]              pp2_to_s7_rdata_x1_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH-1:0]             s7_to_pp2_raddr_12b_x6;

    assign s7_to_pp2_raddr_12b_x6[1] = s7_to_pp2_raddr_12b_x6[0];
    assign s7_to_pp2_raddr_12b_x6[2] = s7_to_pp2_raddr_12b_x6[0];
    assign s7_to_pp2_raddr_12b_x6[3] = s7_to_pp2_raddr_12b_x6[0];
    assign s7_to_pp2_raddr_12b_x6[5] = s7_to_pp2_raddr_12b_x6[4];

    assign s3_to_upper_we_1b_x6[0] = s3_we_y_1b_x4[0];
    assign s3_to_upper_we_1b_x6[1] = s3_we_g_1b_x4[0];
    assign s3_to_upper_we_1b_x6[2] = s3_we_y_1b_x4[1];
    assign s3_to_upper_we_1b_x6[3] = s3_we_g_1b_x4[1];
    assign s3_to_upper_we_1b_x6[4] = s3_we_y_1b_x4[2];
    assign s3_to_upper_we_1b_x6[5] = s3_we_g_1b_x4[2];
    assign monox_to_sub_we_1b_x2[0] = s3_we_y_1b_x4[3];
    assign monox_to_sub_we_1b_x2[1] = s3_we_g_1b_x4[3];

    assign s3_to_upper_waddr_12b_x6[0] = s3_waddr_y_12b_x4[0];
    assign s3_to_upper_waddr_12b_x6[1] = s3_waddr_g_12b_x4[0];
    assign s3_to_upper_waddr_12b_x6[2] = s3_waddr_y_12b_x4[1];
    assign s3_to_upper_waddr_12b_x6[3] = s3_waddr_g_12b_x4[1];
    assign s3_to_upper_waddr_12b_x6[4] = s3_waddr_y_12b_x4[2];
    assign s3_to_upper_waddr_12b_x6[5] = s3_waddr_g_12b_x4[2];
    assign monox_to_sub_waddr_12b_x2[0] = s3_waddr_y_12b_x4[3];
    assign monox_to_sub_waddr_12b_x2[1] = s3_waddr_g_12b_x4[3];

    assign s3_to_upper_wdata_x1_x6[0] = s3_wdata_y_x1_x4[0];
    assign s3_to_upper_wdata_x1_x6[1] = s3_wdata_g_x1_x4[0];
    assign s3_to_upper_wdata_x1_x6[2] = s3_wdata_y_x1_x4[1];
    assign s3_to_upper_wdata_x1_x6[3] = s3_wdata_g_x1_x4[1];
    assign s3_to_upper_wdata_x1_x6[4] = s3_wdata_y_x1_x4[2];
    assign s3_to_upper_wdata_x1_x6[5] = s3_wdata_g_x1_x4[2];
    assign monox_to_sub_wdata_x1_x2[0] = s3_wdata_y_x1_x4[3];
    assign monox_to_sub_wdata_x1_x2[1] = s3_wdata_g_x1_x4[3];

    vpu_addx_mux_monox_seq #(
            .DATA_WIDTH(COE_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .POWER_WIDTH(LEVEL_WIDTH),
            .BRAM_READ_LATENCY(COMMON_BRAM_DELAY),
            .URAM_READ_LATENCY(COMMON_URAM_DELAY),
            .MODULUS_WIDTH(Q_WIDTH),
            .INDEX_WIDTH(ADDR_WIDTH+1),

            .P(P),
            .Q0(Q0),
            .Q1(Q1),

            .IQ0(IQ0),
            .IQ1(IQ1),

            .PIMQ0(PIMQ0),
            .PIMQ1(PIMQ1),

            .MWIDTH(Q_WIDTH)
        )
        s3_s7_mux (
            // s7
            .i_data_g0_addx(upper_to_s7_rdata_x1_x6[1:0]),  // from upper (x1 x2)
            .i_data_g1_addx(upper_to_s7_rdata_x1_x6[3:2]),  // from upper (x1 x2)
            .i_dina_vpu(pp2_to_s7_rdata_x1_x6[3:0]),  // from pp2 (x1 x4)
            .i_dinb_vpu({{(COE_WIDTH*2){1'b0}}, upper_to_s7_rdata_x1_x6[5:4]}),  // from upper (x1 x2)
            .i_dinc_vpu(pp2_to_s7_rdata_x1_x6[5:4]),  // from pp2 (x1 x2)

            .o_rdena_vpu(),  // ignore, to pp2 (1b)
            .o_rdenb_vpu(),  // ignore, to upper (1b)
            .o_rdenc_vpu(),  // ignore, to pp2 (1b)
            .o_wren_vpu(),  // ignore, output (1b)
            .o_rdaddra_vpu(s7_to_pp2_raddr_12b_x6[0]),  // to pp2 (12b)
            .o_rdaddrb_vpu(s7_to_upper_raddr_12b_x6[4]),  // to upper (12b)
            .o_rdaddrc_vpu(s7_to_pp2_raddr_12b_x6[4]),  // to pp2 (12b)
            .o_wrdaddr_vpu(),  // ignore, output (12b)

            .i_n_addx(i_level_x5[4]),  // Bug: i_level_x5[4]
            .o_addr_g0_addx(s7_to_upper_raddr_12b_x6[0]),  // to upper (12b)
            .o_addr_g1_addx(s7_to_upper_raddr_12b_x6[2]),  // to upper (12b)
            .o_en_bram_g0_addx(),  // ignore
            .o_en_bram_g1_addx(),  // ignore

            .i_s7_mode(s7_mode),  // input mode to control the destination of output data
            .o_data_rb(s7_to_redbuf_wdata_x1_x4),  // output
            .o_addr_rb(s7_to_redbuf_waddr_12b_x1),  // output
            .o_we_rb(s7_to_redbuf_we_1b_x1),  // output

            .i_en(1'b1),
            .is_trace(i_is_trace),
            .i_start_monox(i_start_x5[0]),
            .i_start_addx(i_start_x5[4]),
            .o_done_addx(o_done_x5[4]),  // Bug: new output
            .o_done_monox(o_done_x5[0]),

            // s3
            .i_data_a0(prep_to_s3_rdata_a0_x1_x4),  // input, from preprocess (x1 x4)
            .i_data_a1(prep_to_s3_rdata_a1_x1_x4),  // input, from preprocess (x1 x4)
            .i_data_b0(redbuf_to_s3_rdata_x1_x4),  // input, from reduce_buf (x1 x4)
            .i_data_c1(),  // ignore, from s7 (x1 x4)

            .o_n(),  // ignore
            .o_data_y(s3_wdata_y_x1_x4),  // to pp1/sub (x1 x4)
            .o_data_g(s3_wdata_g_x1_x4),  // to pp1/sub (x1 x4)

            .i_n_monox(i_level_x5[0]),
            .o_addr_y(s3_waddr_y_12b_x4),  // to pp1/sub (12b x4)
            .o_addr_g(s3_waddr_g_12b_x4),  // to pp1/sub (12b x4)
            .o_we_y(s3_we_y_1b_x4),  // to pp1/sub (1b x4)
            .o_we_g(s3_we_g_1b_x4),  // to pp1/sub (1b x4)

            .i_mode(i_stall),
            .o_addr_a0(s3_to_prep_raddr_a0_12b_x1),  // output, to preprocess (12b)
            .o_addr_a1(s3_to_prep_raddr_a1_12b_x1),  // output, to preprocess (12b)
            .o_addr_b0(s3_to_redbuf_raddr_12b_x1),  // output, to reduce_buf (12b)
            .o_en_bram_a0(),  // ignore
            .o_en_bram_a1(),  // ignore
            .o_en_bram_b0(),  // ignore
            .*
        );

    stg3_sub #(
            .DATA_WIDTH(COE_WIDTH),  // SHORT
            .ADDR_WIDTH(ADDR_WIDTH),
            .Q0(Q0),
            .Q1(Q1),
            .N_POLY(N_POLY),
            .N_POLY_SUB(N_POLY_SUB)
        )
        s3_sub (
            .i_we(monox_to_sub_we_1b_x2),  // from monox (1b x2)
            .i_addr(monox_to_sub_waddr_12b_x2),  // from monox (12b x2)
            .i_data(monox_to_sub_wdata_x1_x2),  // from monox (x1 x2)
            .o_we(sub_to_pp1_we_1b_x6),  // to pp1 (1b x6)
            .o_addr(sub_to_pp1_waddr_12b_x6),  // to pp1 (12b x6)
            .o_data(sub_to_pp1_wdata_x1_x6),  // to pp1 (x1 x6)
            .*
        );

    // ---------------------------------------------------------------------
    // Group 1 (s4, s5)
    // ---------------------------------------------------------------------
    // pp1 <-> s4 <-> local_buf
    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s4_to_pp1_raddr_9b_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s4_to_pp1_waddr_9b_x6;
    logic  [N_POLY-1:0][N_BANK-1:0][COE_WIDTH-1:0]  pp1_to_s4_rdata_x8_x6;

    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s4_to_buf_raddr_9b_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s4_to_buf_waddr_9b_x6;
    logic  [N_POLY-1:0][N_BANK-1:0][COE_WIDTH-1:0]  buf_to_s4_rdata_x8_x6;

    logic  [N_POLY-1:0][N_BANK-1:0][COE_WIDTH-1:0]  s4_to_pp1buf_wdata_x8_x6;
    logic  [N_POLY-1:0]                             s4_to_pp1_we_1b_x6;
    logic  [N_POLY-1:0]                             s4_to_buf_we_1b_x6;

    // pp1 -> s5 -> pp2
    logic  [N_POLY-1:0][COE_WIDTH-1:0]              pp1_to_s5_rdata_x1_x6;
    logic  [N_POLY-1:0][COE_WIDTH-1:0]              s5_to_pp2_wdata_x1_x6;
    logic                                           s5_to_pp2_we_1b_x1;
    // logic  [ADDR_WIDTH-1:0]                         s5_to_pp1ksk_raddr_12b_x1;
    logic  [ADDR_WIDTH-1:0]                         s5_to_pp2_waddr_12b_x1;

    generate
        for (genvar i = 0; i < N_POLY; i++) begin : g1
            // pp1
            pp_buffer #(
                    .COE_WIDTH(COE_WIDTH),
                    .ADDR_WIDTH(ADDR_WIDTH),
                    .ADDR_WIDTH_H(ADDR_WIDTH_H),
                    .ADDR_WIDTH_L(ADDR_WIDTH_L),
                    .N_BANK(N_BANK),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
                )
                pp (
                    .i_switch_mode(i_switch_mode),

                    .i_wdata_a(sub_to_pp1_wdata_x1_x6[i]),  // from s3/sub (x1)
                    .i_wdata_b_wide(s4_to_pp1buf_wdata_x8_x6[i]),  // from s4 (x8)
                    .o_rdata_b_wide(pp1_to_s4_rdata_x8_x6[i]),  // to s4 (x8)
                    .o_rdata_c(pp1_to_s5_rdata_x1_x6[i]),  // to s5 (x1)

                    .i_waddr_a_long(sub_to_pp1_waddr_12b_x6[i]),  // from s3 (12b)
                    .i_waddr_b(s4_to_pp1_waddr_9b_x6[i]),  // from s4 (9b)
                    .i_raddr_b(s4_to_pp1_raddr_9b_x6[i]),  // from s4 (9b)
                    .i_raddr_c_long(s5_to_pp1ksk_raddr_12b_x1),  // from s5 (12b)

                    .i_a_we(sub_to_pp1_we_1b_x6[i]),  // from s3 (1b)
                    .i_b_we(s4_to_pp1_we_1b_x6[i]),  // from s4 (1b)
                    .*
                );

            // s4
            ntt_core #(
                    .COE_WIDTH(COE_WIDTH),
                    .Q_TYPE (i>>1),
                    .COMMON_MULRED_DELAY(COMMON_MULRED_DELAY),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
                    .COMMON_NTT_PIP_DELAY(COMMON_NTT_PIP_DELAY)
                )
                s4_ntt (
                    .ntt_start(i_start_x5[1]),
                    .i_data_b_l(pp1_to_s4_rdata_x8_x6[i]),  // from pp1 (x8)
                    .i_data_b_r(buf_to_s4_rdata_x8_x6[i]),  // from from buf (x8)
                    .o_we_a_l(s4_to_pp1_we_1b_x6[i]),  // to pp1 (1b)
                    .o_we_a_r(s4_to_buf_we_1b_x6[i]),  // to buf (1b)
                    .o_data_a(s4_to_pp1buf_wdata_x8_x6[i]),  // to pp1/buf (x8)
                    .o_addr_a_l(s4_to_pp1_waddr_9b_x6[i]),  // to pp1 (9b)
                    .o_addr_a_r(s4_to_buf_waddr_9b_x6[i]),  // to buf (9b)
                    .o_addr_b_l(s4_to_pp1_raddr_9b_x6[i]),  // to pp1 (9b)
                    .o_addr_b_r(s4_to_buf_raddr_9b_x6[i]),  // to buf (9b)
                    .ntt_done(s4_done[i]),
                    .*
                );

            // ntt local buffer
            poly_ram_x8 #(
                    .COE_WIDTH(COE_WIDTH),
                    .ADDR_WIDTH(ADDR_WIDTH_L),
                    .N_BANK(N_BANK),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
                )
                local_buf (
                    .wea({N_BANK{s4_to_buf_we_1b_x6[i]}}),  // from s4 (1b)
                    .addra(s4_to_buf_waddr_9b_x6[i]),  // from s4 (9b)
                    .dina(s4_to_pp1buf_wdata_x8_x6[i]),  // from s4 (x8)
                    .addrb(s4_to_buf_raddr_9b_x6[i]),  // from s4 (9b)
                    .doutb(buf_to_s4_rdata_x8_x6[i]),  // to s4 (x8)
                    .*
                );
        end
    endgenerate

    // s5
    vpu2_top #(
            .P(P),
            .Q0(Q0),
            .Q1(Q1),

            .IP(IP),
            .IQ0(IQ0),
            .IQ1(IQ1),

            .BRAM_DELAY(COMMON_BRAM_DELAY),
            .URAM_DELAY(COMMON_URAM_DELAY),

            .DATA_WIDTH(COE_WIDTH)
        )
        s5_vpu2 (
            .i_vpu2_start(i_start_x5[2]),
            .o_vpu2_done(o_done_x5[2]),
            .i_vpu2_din(pp1_to_s5_rdata_x1_x6),  // from pp1 (x1 x6) TODO: to modify data width; order
            .i_vpu2_extdin(ksk_rdata_x2_x6),  // input
            .o_vpu2_dout(s5_to_pp2_wdata_x1_x6),  // to pp2 (x1 x6) TODO: order
            .o_vpu2_rden(),  // ignore
            .o_vpu2_wren(s5_to_pp2_we_1b_x1),  // to pp2 (1b)
            .o_vpu2_rdaddr(s5_to_pp1ksk_raddr_12b_x1),  // to pp1 (12b)
            .o_vpu2_wraddr(s5_to_pp2_waddr_12b_x1),  // to pp2 (12b)
            .*
        );

    // ---------------------------------------------------------------------
    // Group 2 (s6)
    // ---------------------------------------------------------------------
    // pp2 <-> s6 <-> local_buf
    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s6_to_pp2_raddr_9b_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s6_to_pp2_waddr_9b_x6;
    logic  [N_POLY-1:0][N_BANK-1:0][COE_WIDTH-1:0]  pp2_to_s6_rdata_x8_x6;

    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s6_to_buf_raddr_9b_x6;
    logic  [N_POLY-1:0][ADDR_WIDTH_L-1:0]           s6_to_buf_waddr_9b_x6;
    logic  [N_POLY-1:0][N_BANK-1:0][COE_WIDTH-1:0]  buf_to_s6_rdata_x8_x6;

    logic  [N_POLY-1:0][N_BANK-1:0][COE_WIDTH-1:0]  s6_to_pp2buf_wdata_x8_x6;
    logic  [N_POLY-1:0]                             s6_to_pp2_we_1b_x6;
    logic  [N_POLY-1:0]                             s6_to_buf_we_1b_x6;

    generate
        for (genvar i = 0; i < N_POLY; i++) begin : g2
            // pp2
            pp_buffer #(
                    .COE_WIDTH(COE_WIDTH),
                    .ADDR_WIDTH(ADDR_WIDTH),
                    .ADDR_WIDTH_H(ADDR_WIDTH_H),
                    .ADDR_WIDTH_L(ADDR_WIDTH_L),
                    .N_BANK(N_BANK),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
                )
                pp (
                    .i_switch_mode(i_switch_mode),

                    .i_wdata_a(s5_to_pp2_wdata_x1_x6[i]),  // from s5 (x1)
                    .i_wdata_b_wide(s6_to_pp2buf_wdata_x8_x6[i]),  // from s6 (x8)
                    .o_rdata_b_wide(pp2_to_s6_rdata_x8_x6[i]),  // to s6 (x8)
                    .o_rdata_c(pp2_to_s7_rdata_x1_x6[i]),  // to s7 (x1)

                    .i_waddr_a_long(s5_to_pp2_waddr_12b_x1),  // from s5 (12b)
                    .i_waddr_b(s6_to_pp2_waddr_9b_x6[i]),  // from s6 (9b)
                    .i_raddr_b(s6_to_pp2_raddr_9b_x6[i]),  // from s6 (9b)
                    .i_raddr_c_long(s7_to_pp2_raddr_12b_x6[i]),  // from s7 (12b)

                    .i_a_we(s5_to_pp2_we_1b_x1),  // from s5 (1b)
                    .i_b_we(s6_to_pp2_we_1b_x6[i]),  // from s6 (1b)
                    .*
                );

            // s6
            intt_core #(
                    .COE_WIDTH(COE_WIDTH),
                    .Q_TYPE (i>>1),
                    .COMMON_MULRED_DELAY(COMMON_MULRED_DELAY),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
                    .COMMON_NTT_PIP_DELAY(COMMON_NTT_PIP_DELAY)
                )
                s6_intt (
                    .ntt_start(i_start_x5[3]),
                    .i_data_b_l(pp2_to_s6_rdata_x8_x6[i]),  // from pp2 (x8)
                    .i_data_b_r(buf_to_s6_rdata_x8_x6[i]),  // from from buf (x8)
                    .o_we_a_l(s6_to_pp2_we_1b_x6[i]),  // to pp2 (1b)
                    .o_we_a_r(s6_to_buf_we_1b_x6[i]),  // to buf (1b)
                    .o_data_a(s6_to_pp2buf_wdata_x8_x6[i]),  // to pp2/buf (x8)
                    .o_addr_a_l(s6_to_pp2_waddr_9b_x6[i]),  // to pp2 (9b)
                    .o_addr_a_r(s6_to_buf_waddr_9b_x6[i]),  // to buf (9b)
                    .o_addr_b_l(s6_to_pp2_raddr_9b_x6[i]),  // to pp2 (9b)
                    .o_addr_b_r(s6_to_buf_raddr_9b_x6[i]),  // to buf (9b)
                    .ntt_done(s6_done[i]),
                    .*
                );

            // intt local buffer
            poly_ram_x8 #(
                    .COE_WIDTH(COE_WIDTH),
                    .ADDR_WIDTH(ADDR_WIDTH_L),
                    .N_BANK(N_BANK),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
                )
                local_buf (
                    .wea({N_BANK{s6_to_buf_we_1b_x6[i]}}),  // from s6 (1b)
                    .addra(s6_to_buf_waddr_9b_x6[i]),  // from s6 (9b)
                    .dina(s6_to_pp2buf_wdata_x8_x6[i]),  // from s6 (x8)
                    .addrb(s6_to_buf_raddr_9b_x6[i]),  // from s6 (9b)
                    .doutb(buf_to_s6_rdata_x8_x6[i]),  // to s6 (x8)
                    .*
                );
        end
    endgenerate
endmodule
