//////////////////////////////////////////////////
//
// File:            tb_top.sv
// Project Name:    MVP v1.2 top testbench
// Module Name:     tb_top
// Description:     MVP v1.2 top testbench
//
// Author:          Heng Liu(taotao), Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      13/08/2021
// Modify Date:     03/04/2022
//
//////////////////////////////////////////////////

`include "common_defines.vh"
`define PERIOD  4

module tb_top;

    parameter C_DATA_AXI_ADDR_WIDTH = 64;
    parameter C_DATA_AXI_DATA_WIDTH = 512;
    parameter C_S_AXI_CONTROL_ADDR_WIDTH = 12;
    parameter C_S_AXI_CONTROL_DATA_WIDTH = 32;

    parameter N_STAGE = 11;
    parameter ADDR_WIDTH = 12;
    parameter LEVEL_WIDTH = 4;
    parameter COE_WIDTH = 39;
    parameter P = 39'h40_0080_0001;
    parameter Q0 = 35'h4_0800_0001;
    parameter Q1 = 35'h4_0008_0001;

    parameter LEVEL = 8;
    parameter COL_SIZE = 1024;
    parameter N_SPLIT = 1;
    parameter N_INDEX = 1;
    parameter MAT_LEN = (1 << LEVEL) * N_SPLIT / N_INDEX;

    localparam  N_RSLT_POLY        = 4;
    localparam  N_KSK_POLY         = 144;

    localparam  TB_DDR_DATA_SIZE   = (N_SPLIT * 6 + MAT_LEN * 3 + N_KSK_POLY + N_RSLT_POLY) << 15;
    localparam  TB_DDR_ADDR_WIDTH  = $clog2(TB_DDR_DATA_SIZE);
    localparam  DDR_MEM_DEPTH      = (2 ** TB_DDR_ADDR_WIDTH) >> 6;

    localparam  DDR_MEM_VEC_DEPTH  = (N_SPLIT * 6) << 9;
    localparam  DDR_MEM_MAT_DEPTH  = (MAT_LEN * 3) << 9;
    localparam  DDR_MEM_KSK_DEPTH  = N_KSK_POLY << 9;
    localparam  DDR_MEM_RSLT_DEPTH = N_RSLT_POLY << 9;

    localparam  VEC_START_LINE     = 0;
    localparam  MAT_START_LINE     = VEC_START_LINE + DDR_MEM_VEC_DEPTH;
    localparam  KSK_START_LINE     = MAT_START_LINE + DDR_MEM_MAT_DEPTH;
    localparam  RSLT_START_LINE    = KSK_START_LINE + DDR_MEM_KSK_DEPTH;

    localparam  VEC_START_ADDR     = VEC_START_LINE << 6;
    localparam  MAT_START_ADDR     = MAT_START_LINE << 6;
    localparam  KSK_START_ADDR     = KSK_START_LINE << 6;
    localparam  RSLT_START_ADDR    = RSLT_START_LINE << 6;

    localparam  PARTIAL_START_LINE      = 0;
    localparam  DDR_MEM_PARTIAL_DEPTH   = 6 << 9;

    localparam  POLY_SIZE = 1 << ADDR_WIDTH;

    `define REG_BASE_ADDR       12'h0
    `define AXI_RD              u_dut_top.u_axi_data_rd_top
    `define AXI_WR              u_dut_top.u_axi_data_wr_top
    `define DP                  u_dut_top.u_dp_top
    `define PP0                 u_dut_top.u_preprocess_top0.u_dp2_top
    `define PP1                 u_dut_top.u_preprocess_top1.u_dp2_top
    `define RT                  u_dut_top.u_reduce_trace
    `define CNTL                u_dut_top.u_control
    `define KSK_RAM             u_dut_top.u_axi_data_rd_top.i_ksk_buffer
    `define RB                  u_dut_top.u_reduce_buffer

    `ifdef PARTIAL_TEST
        localparam PARTIAL_TEST       = 1; 
    `else
        localparam PARTIAL_TEST       = 0;
    `endif

    `ifdef DEBUG_SINGLE_STAGE
        localparam DEBUG_SINGLE_STAGE = 1;
    `else
        localparam DEBUG_SINGLE_STAGE = 0;
    `endif
    
    localparam RUN_DIR          = "./../../sim/";


    `ifdef INIT_KSK
        defparam `KSK_RAM.gen_ksk_uram[0].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[0].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k0.mem";
        defparam `KSK_RAM.gen_ksk_uram[1].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[1].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k1.mem";
        defparam `KSK_RAM.gen_ksk_uram[2].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[2].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k2.mem";
        defparam `KSK_RAM.gen_ksk_uram[3].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[3].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k3.mem";
        defparam `KSK_RAM.gen_ksk_uram[4].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[4].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k4.mem";
        defparam `KSK_RAM.gen_ksk_uram[5].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[5].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k5.mem";
        defparam `KSK_RAM.gen_ksk_uram[6].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[6].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k6.mem";
        defparam `KSK_RAM.gen_ksk_uram[7].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[7].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k7.mem";
        defparam `KSK_RAM.gen_ksk_uram[8].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[8].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k8.mem";
        defparam `KSK_RAM.gen_ksk_uram[9].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[9].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k9.mem";
        defparam `KSK_RAM.gen_ksk_uram[10].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[10].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k10.mem";
        defparam `KSK_RAM.gen_ksk_uram[11].i_ksk_uram_spdram.MEMORY_PRIMITIVE="block";
        defparam `KSK_RAM.gen_ksk_uram[11].i_ksk_uram_spdram.MEMORY_INIT_FILE="uram_k11.mem";
    `endif

    int                                     fd, rt, i, ii;

    bit                                     clk, rst_n;
    bit                                     start, interrupt;
    bit [C_DATA_AXI_DATA_WIDTH/8-1:0]       tmp[7:0];
    bit [511:0]                             gold_mem;
    bit [COE_WIDTH*8-1:0]                   ksk_mem;
    bit [511:0]                             temp_mem [0:DDR_MEM_DEPTH-1];
    bit                                     stage0_mode;
    bit                                     init;
    bit                                     switch_mode;
    bit [N_STAGE-1:0]                       stage_status_partial_test;
    bit [N_STAGE-1:0]                       stage_status_single_stage;
    bit [N_STAGE-1:0]                       stage_status;
    bit [N_STAGE-1:0]                       stage_start_partial_test;
    bit [N_STAGE-1:0]                       stage_start_d1;
    bit [N_STAGE-1:0]                       stage_start_d2;
    bit [N_STAGE-1:0]                       stage_start_d3;
    bit [N_STAGE-1:0]                       stage_start_d4;
    bit [N_STAGE-1:0]                       stage_start_d5;
    bit [N_STAGE-1:0]                       stage_start_d6;
    bit [N_STAGE-1:0]                       stage_start_d7;
    bit [N_STAGE-1:0]                       stage_start_partial_test_pre;
    bit [N_STAGE-1:0]                       stage_done;
    bit                                     stage_10_done_delay;
    bit                                     stage_10_done_pulse;
    wire                                    in_a_row_done;
    reg                                     done_delay, done_pulse_d1, done_pulse_d2, done_pulse_d3, done_pulse_d4, done_pulse_d5;
    wire                                    done_pulse;
    bit [LEVEL_WIDTH-1:0]                   level_partial_test;
    bit [LEVEL_WIDTH-1:0]                   level_minus_one_partial_test;
    bit [LEVEL_WIDTH*5-1:0]                 level_partial_test_x5;
    bit [ADDR_WIDTH-1:0]                    index_partial_test;
    bit [LEVEL_WIDTH-1:0]                   rt_buffer_wr_index;
    string                                  testname;
    int                                     ts_single_stage;
    int                                     ts_full;
    int                                     ts_row;
    int                                     ts;
    int                                     is_stall;
    int                                     is_trace;
    string                                  ts_str, timeslot;
    string                                  test_data_dir;
    string                                  cmod_data_dir;
    string                                  test_size;

    // AXI4 master interface
    wire                                    data_axi_awvalid;
    wire                                    data_axi_awready;
    wire    [C_DATA_AXI_ADDR_WIDTH-1:0]     data_axi_awaddr;
    wire    [7:0]                           data_axi_awlen;
    wire                                    data_axi_wvalid;
    wire                                    data_axi_wready;
    wire    [C_DATA_AXI_DATA_WIDTH-1:0]     data_axi_wdata;
    wire    [C_DATA_AXI_DATA_WIDTH/8-1:0]   data_axi_wstrb;
    wire                                    data_axi_wlast;
    wire                                    data_axi_bvalid;
    wire                                    data_axi_bready;
    wire                                    data_axi_arvalid;
    wire                                    data_axi_arready;
    wire    [C_DATA_AXI_ADDR_WIDTH-1:0]     data_axi_araddr;
    wire    [7:0]                           data_axi_arlen;
    wire                                    data_axi_rvalid;
    wire                                    data_axi_rready;
    wire    [C_DATA_AXI_DATA_WIDTH-1:0]     data_axi_rdata;
    wire                                    data_axi_rlast;

    // AXI4-Lite slave interface
    // reg                                     s_axi_control_awvalid;
    // wire                                    s_axi_control_awready;
    // reg  [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_awaddr ;
    // reg                                     s_axi_control_wvalid ;
    // wire                                    s_axi_control_wready ;
    // reg  [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_wdata  ;
    // reg  [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_wstrb  ;
    // reg                                     s_axi_control_arvalid;
    // wire                                    s_axi_control_arready;
    // reg  [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_araddr ;
    // wire                                    s_axi_control_rvalid ;
    // reg                                     s_axi_control_rready ;
    // wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_rdata  ;
    // wire [2-1:0]                            s_axi_control_rresp  ;
    // wire                                    s_axi_control_bvalid ;
    // reg                                     s_axi_control_bready ;
    // wire [2-1:0]                            s_axi_control_bresp  ;


    /******************************************************************************/
    /**************************** Clock Value Generation **************************/
    /******************************************************************************/
    initial begin
        clk = 1'b1;
    end

    always #(`PERIOD/2) clk = ~clk;


    /*******************************************************************************/
    /*************** AXI-Lite interface init value Generation **********************/
    /*******************************************************************************/
    // initial begin
    //     s_axi_control_awvalid = 1'b0;
    //     s_axi_control_awaddr  = {(C_S_AXI_CONTROL_ADDR_WIDTH){1'b0}};
    //     s_axi_control_wvalid  = 1'b0;
    //     s_axi_control_wdata   = {(C_S_AXI_CONTROL_DATA_WIDTH){1'b0}};
    //     s_axi_control_wstrb   = {(C_S_AXI_CONTROL_DATA_WIDTH/8){1'b0}};
    //     s_axi_control_arvalid = 1'b0;
    //     s_axi_control_araddr  = {(C_S_AXI_CONTROL_ADDR_WIDTH){1'b0}};
    //     s_axi_control_rready  = 1'b1;
    //     s_axi_control_bready  = 1'b1;
    // end


    /*******************************************************************************/
    /******************* Module Instantiation in Testbench *************************/
    /*******************************************************************************/

    // BRAM with AXI interface to mimic memory with AXI interface in Vitis Shell
    tb_axi_bram #(
    .C_S_AXI_DATA_WIDTH (C_DATA_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH (TB_DDR_ADDR_WIDTH)
    ) i_ddr_mem (
        .s_axi_aclk   (clk),
        .s_axi_aresetn(rst_n),
        .s_axi_awid   (4'd0),
        .s_axi_awaddr (data_axi_awaddr[TB_DDR_ADDR_WIDTH-1:0]),
        .s_axi_awlen  (data_axi_awlen),
        .s_axi_awsize (3'd6),
        .s_axi_awburst(2'd1),
        .s_axi_awlock (1'd0),
        .s_axi_awcache(4'd3),
        .s_axi_awprot (3'd0),
        .s_axi_awvalid(data_axi_awvalid),
        .s_axi_awready(data_axi_awready),
        .s_axi_wdata  (data_axi_wdata),
        .s_axi_wstrb  (data_axi_wstrb),
        .s_axi_wlast  (data_axi_wlast),
        .s_axi_wvalid (data_axi_wvalid),
        .s_axi_wready (data_axi_wready),
        .s_axi_bid    (),
        .s_axi_bresp  (),
        .s_axi_bvalid (data_axi_bvalid),
        .s_axi_bready (data_axi_bready),
        .s_axi_arid   (4'd0),
        .s_axi_araddr (data_axi_araddr),
        .s_axi_arlen  (data_axi_arlen),
        .s_axi_arsize (3'd6),
        .s_axi_arburst(2'd1),
        .s_axi_arlock (1'd0),
        .s_axi_arcache(4'd3),
        .s_axi_arprot (3'd0),
        .s_axi_arvalid(data_axi_arvalid),
        .s_axi_arready(data_axi_arready),
        .s_axi_rid    (),
        .s_axi_rdata  (data_axi_rdata),
        .s_axi_rresp  (),
        .s_axi_rlast  (data_axi_rlast),
        .s_axi_rvalid (data_axi_rvalid),
        .s_axi_rready (data_axi_rready) 
    );

    // MVP Top-level Design Instantiation
    bit [31:0]                          csr_test1    ;  // out
    bit                                 csr_ap_start ;  // TODO
    bit [31:0]                          csr_ap_done  ;  // out
    bit                                 csr_ap_idle  ;  // out
    bit                                 csr_ap_ready ;  // out
    bit [31:0]                          csr_command  ;  // TODO
    bit [31:0]                          csr_level    ;
    bit [31:0]                          csr_col_size ;
    bit [31:0]                          csr_split    ;
    bit [31:0]                          csr_index    ;
    bit [31:0]                          csr_mat_len  ;
    bit [C_DATA_AXI_ADDR_WIDTH-1:0]     csr_ksk_ptr  ;  // TODO
    bit [C_DATA_AXI_ADDR_WIDTH-1:0]     csr_mat_ptr  ;  // TODO
    bit [C_DATA_AXI_ADDR_WIDTH-1:0]     csr_vec_ptr  ;  // TODO
    bit [C_DATA_AXI_ADDR_WIDTH-1:0]     csr_rslt_ptr ;  // TODO

    mvp_top # (
        .AXI_ADDR_WIDTH     ( C_DATA_AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH     ( C_DATA_AXI_DATA_WIDTH )
    ) u_dut_top (
        .clk    ( clk   ),
        .rst_n  ( rst_n ),

        // AXI Interface
        .data_axi_awvalid   ( data_axi_awvalid  ),
        .data_axi_awready   ( data_axi_awready  ),
        .data_axi_awaddr    ( data_axi_awaddr   ),
        .data_axi_awlen     ( data_axi_awlen    ),
        .data_axi_wvalid    ( data_axi_wvalid   ),
        .data_axi_wready    ( data_axi_wready   ),
        .data_axi_wdata     ( data_axi_wdata    ),
        .data_axi_wstrb     ( data_axi_wstrb    ),
        .data_axi_wlast     ( data_axi_wlast    ),
        .data_axi_bvalid    ( data_axi_bvalid   ),
        .data_axi_bready    ( data_axi_bready   ),
        .data_axi_arvalid   ( data_axi_arvalid  ),
        .data_axi_arready   ( data_axi_arready  ),
        .data_axi_araddr    ( data_axi_araddr   ),
        .data_axi_arlen     ( data_axi_arlen    ),
        .data_axi_rvalid    ( data_axi_rvalid   ),
        .data_axi_rready    ( data_axi_rready   ),
        .data_axi_rdata     ( data_axi_rdata    ),
        .data_axi_rlast     ( data_axi_rlast    ),

        // Control
        .test1      ( csr_test1     ),  // out
        .ap_start   ( csr_ap_start  ),
        .ap_done    ( csr_ap_done   ),  // out
        .ap_idle    ( csr_ap_idle   ),  // out
        .ap_ready   ( csr_ap_ready  ),  // out
        .command    ( csr_command   ),
        .level      ( csr_level     ),
        .col_size   ( csr_col_size  ),
        .split      ( csr_split     ),
        .index      ( csr_index     ),
        .mat_len    ( csr_mat_len   ),
        .ksk_ptr    ( csr_ksk_ptr   ),
        .mat_ptr    ( csr_mat_ptr   ),
        .vec_ptr    ( csr_vec_ptr   ),
        .data_ptr   ( csr_rslt_ptr  )
    );

    assign interrupt = csr_ap_done[0];  // TODO

    // KSK URAM module for stg_0_0 ksk write result check 
    wire                    wea   [0:11];
    wire [12:0]             addra [0:11];
    wire [8*COE_WIDTH-1:0]  dina  [0:11];

    genvar kk;
    generate 
        for (kk = 0; kk < 12; kk = kk + 1) begin : gen_ksk_model

            assign wea[kk]   = `KSK_RAM.gen_ksk_uram[kk].wren;
            assign addra[kk] = `KSK_RAM.gen_ksk_uram[kk].wraddr;
            assign dina[kk]  = `KSK_RAM.gen_ksk_uram[kk].wrdata;

            ram_model #(
                .COE_WIDTH         (8*COE_WIDTH),        
                .ADDR_WIDTH        (13),        
                .N_BANK            (1) 
            )
            i_ksk_uram_model (
                .clk(clk),      
                .doutb(),   
                .addra(addra[kk]),
                .addrb(),
                .dina(dina[kk]),               
                .wea(wea[kk]) 
            );
        end
    endgenerate

    wire                    rslt_wea  ;
    wire [10:0]             rslt_addra;
    wire [511:0]            rslt_dina ;

    assign rslt_wea   = i_ddr_mem.i_ddr_mem_bank_512b.base_bank.wea;
    assign rslt_addra = i_ddr_mem.i_ddr_mem_bank_512b.base_bank.addra[10:0] - (RSLT_START_LINE & {11{1'b1}});
    assign rslt_dina  = i_ddr_mem.i_ddr_mem_bank_512b.base_bank.dina;

    ram_model #(
        .COE_WIDTH         (512),
        .ADDR_WIDTH        (11),
        .N_BANK            (1) 
    )
    i_rslt_mem_model (
        .clk(clk),
        .doutb(),
        .addra(rslt_addra),
        .addrb(),
        .dina(rslt_dina),
        .wea(rslt_wea) 
    );

    assign stage_done = {
        `AXI_WR.o_axiwr_done,   // stg10
        `RT.o_done_x5,          // stg5-9
        `PP0.io_o_vpu4_done,    // stg4
        `PP0.io_o_intt_done,    // stg3
        `DP.o_madd_done,        // stg2
        `DP.o_ntt_done,         // stg1
        `AXI_RD.o_axird_done    // stg0
    };
    assign stage_status = (PARTIAL_TEST == 1) ? ((DEBUG_SINGLE_STAGE == 1) ? stage_status_single_stage : stage_status_partial_test) : `CNTL.mvp_status_r;
    assign level_minus_one_partial_test = level_partial_test - 1'b1;

    always @ (posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            stage_10_done_delay <= 1'b0;
        else 
            stage_10_done_delay <= stage_done[N_STAGE-1];
    end
    assign stage_10_done_pulse = stage_done[N_STAGE-1] && (!stage_10_done_delay);

    if(PARTIAL_TEST) begin
        initial begin
            force `AXI_RD.i_axird_initstart = stage_start_partial_test[0];
            force `AXI_RD.i_axird_start     = stage_start_partial_test[0];
            force `AXI_WR.i_axiwr_start     = stage_start_partial_test[10];
            force `DP.i_ntt_start           = stage_start_partial_test[1];
            force `DP.i_madd_start          = stage_start_partial_test[2];
            force `PP0.io_i_intt_start      = stage_start_partial_test[3];
            force `PP0.io_i_vpu4_start      = stage_start_partial_test[4];
            force `RT.i_start_x5            = stage_start_partial_test[9:5];
            force `DP.i_mode                = 2'b10;
            force `PP0.io_i_coeff_index     = index_partial_test;
            force `RT.i_level_x5            = level_partial_test_x5;
            force `RT.i_switch_mode         = switch_mode;
            force `RT.i_stall               = 1'b0;
            force `RT.i_is_trace            = 1'b0;
            force `KSK_RAM.i_ksk_rd_stage   = level_minus_one_partial_test;
            assert(`PP0.io_i_intt_start == `PP1.io_i_intt_start);
            assert(`PP0.io_i_vpu4_start == `PP1.io_i_vpu4_start);
            assert(`PP0.io_i_coeff_index == `PP1.io_i_coeff_index);
        end

        assign rt_buffer_wr_index = 0;
        assign is_stall = 0;
        assign is_trace = 0;

        always@(posedge clk or negedge rst_n)
        begin
            if(!rst_n) begin
                stage_start_d1 <= 'b0;
                stage_start_d2 <= 'b0;
                stage_start_d3 <= 'b0;
                stage_start_d4 <= 'b0;
                stage_start_d5 <= 'b0;
                stage_start_d6 <= 'b0;
                stage_start_d7 <= 'b0;
            end
            else begin
                stage_start_d1 <= stage_start_partial_test;
                stage_start_d2 <= stage_start_d1;
                stage_start_d3 <= stage_start_d2;
                stage_start_d4 <= stage_start_d3;
                stage_start_d5 <= stage_start_d4;
                stage_start_d6 <= stage_start_d5;
                stage_start_d7 <= stage_start_d6;
            end
        end

        assign test_data_dir = {RUN_DIR, "../tv/basic/"};

        if (DEBUG_SINGLE_STAGE) begin
            assign level_partial_test_x5 = {5{level_partial_test}};
            always_ff @ (posedge clk or negedge rst_n) begin
                if(!rst_n)
                    stage_start_partial_test <= 1'b0;
                else
                    stage_start_partial_test <= stage_start_partial_test_pre;
            end
        end

        else begin
            assign stage_status_partial_test = ctrl.status_r;

            control_tb #(
                .LEVEL_WIDTH(LEVEL_WIDTH),
                .N_STAGE(N_STAGE)
            ) ctrl (
                .clk(clk),
                .rst_n(rst_n),
                .i_init(init),
                .o_start(stage_start_partial_test),
                .i_done(stage_done),
                .o_switch_mode(switch_mode),
                .i_level(level_partial_test),
                .o_level_x5(level_partial_test_x5),
                .*
            );

            assign in_a_row_done = stage_status_partial_test[N_STAGE-1] & stage_done[N_STAGE-1];
        end

    end
    else begin

        assign is_stall           = `CNTL.stall_r;
        assign is_trace           = `CNTL.reduce_trace_r;
        assign rt_buffer_wr_index = `CNTL.o_uram_index;

        always@(posedge clk or negedge rst_n)
        begin
            if(!rst_n) begin
                stage_start_d1 <= 'b0;
                stage_start_d2 <= 'b0;
                stage_start_d3 <= 'b0;
                stage_start_d4 <= 'b0;
                stage_start_d5 <= 'b0;
                stage_start_d6 <= 'b0;
                stage_start_d7 <= 'b0;
            end
            else begin

                stage_start_d1 <= {`AXI_WR.i_axiwr_start, `RT.i_start_x5, `PP0.io_i_vpu4_start, 
                    `PP0.io_i_intt_start, `DP.i_madd_start, `DP.i_ntt_start, `AXI_RD.i_axird_initstart};
                stage_start_d2 <= stage_start_d1;
                stage_start_d3 <= stage_start_d2;
                stage_start_d4 <= stage_start_d3;
                stage_start_d5 <= stage_start_d4;
                stage_start_d6 <= stage_start_d5;
                stage_start_d7 <= stage_start_d6;
            end
        end

        assign done_pulse = (&stage_done[N_STAGE-1:0]) && (!done_delay) && stage0_mode;

        always_ff@(posedge clk or negedge rst_n) begin
            if(~rst_n)
            begin
                done_delay    <= 0;
                done_pulse_d1 <= 0;
                done_pulse_d2 <= 0;
                done_pulse_d3 <= 0;
                done_pulse_d4 <= 0;
                done_pulse_d5 <= 0;
            end
            else
            begin
                done_delay    <= &stage_done[N_STAGE-1:0];
                done_pulse_d1 <= done_pulse;
                done_pulse_d2 <= done_pulse_d1;
                done_pulse_d3 <= done_pulse_d2;
                done_pulse_d4 <= done_pulse_d3;
                done_pulse_d5 <= done_pulse_d4;
            end
        end
        
        always_ff@(posedge clk or negedge rst_n) begin
            if(~rst_n)
                ts_full <= 0;
            else if(done_pulse_d5)
                ts_full <= ts_full + 1;
        end

        always_comb begin
            ts_str.itoa(ts_full - 1);
            timeslot = {{(4-ts_str.len()){"0"}}, ts_str};
        end

        assign ts            = ts_full - 1;
        assign test_size     = "16x1024";
        assign cmod_data_dir = {RUN_DIR, "../tv/", test_size, "/"};
        assign test_data_dir = {cmod_data_dir, "t", timeslot, "/"};
    end


    /*******************************************************************************/
    /******************************* Test Flow Generation **************************/
    /*******************************************************************************/
    initial begin

        if($value$plusargs("TESTNAME=%s", testname)) begin
            $display("Running test {%0s}......\n", testname);
        end
        else begin
            $display("ERROR! Test {%0s} does not exist!\n", testname);
            $finish;
        end

        stage0_mode = 1;

        rst_n = 1'b1;
        wait_some_cycles();
        rst_n = 1'b0;
        wait_some_cycles();
        rst_n = 1'b1;
        wait_some_cycles();
        wait_some_cycles();

        `include "testcase.sv"

        wait_some_cycles();

        $display("Simulation Done!");
        $finish;
    end

    initial begin
        #(`PERIOD*1000000) $display("Simulation Timeout!");
        $finish;
    end


    /*******************************************************************************/
    /************************ Waveform Setup in Testbench **************************/
    /*******************************************************************************/
    initial begin
        $fsdbAutoSwitchDumpfile(1000, "waveform.fsdb", 50);
        $fsdbDumpvars(0,tb_top,"+mda");
    end

    /*******************************************************************************/
    /************************ Monitors for RAM init and check **********************/
    /*******************************************************************************/
    `include "monitor.sv"

    /*******************************************************************************/
    /********************** Task Definition in Testbench ***************************/
    /*******************************************************************************/
    task wait_some_cycles();
        #(`PERIOD*4);
    endtask

    task wait_one_cycle();
        #(`PERIOD);
    endtask

    task wait_half_cycle();
        #(`PERIOD/2);
    endtask

    task wait_quarter_cycle();
        #(`PERIOD/4);
    endtask

    task read_level(string filename);
        wait_one_cycle();
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        rt = $fscanf(fd, "%h", level_partial_test);
        $fclose(fd);
        wait_one_cycle();
    endtask

    task read_index(string filename);
        wait_one_cycle();
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end
        rt = $fscanf(fd, "%h", index_partial_test);
        $fclose(fd);
        wait_one_cycle();
    endtask

    task initialize_ddr_vec(string file);
        fd = $fopen(file, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", file);
            // $finish;
        end
        else begin
            //initialize input memory matrix
            for (i = 0; i < DDR_MEM_VEC_DEPTH; i++) begin
                rt = $fscanf(fd, "%h", tmp[0]);
                rt = $fscanf(fd, "%h", tmp[1]);
                rt = $fscanf(fd, "%h", tmp[2]);
                rt = $fscanf(fd, "%h", tmp[3]);
                rt = $fscanf(fd, "%h", tmp[4]);
                rt = $fscanf(fd, "%h", tmp[5]);
                rt = $fscanf(fd, "%h", tmp[6]);
                rt = $fscanf(fd, "%h", tmp[7]);
                temp_mem[VEC_START_LINE + i] = {tmp[7], tmp[6], tmp[5], tmp[4], tmp[3], tmp[2], tmp[1], tmp[0]};
            end
            $fclose(fd);
        end
    endtask

    task initialize_ddr_partial(string file);
        fd = $fopen(file, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", file);
            // $finish;
        end
        else begin
            //initialize input memory matrix
            for (i = 0; i < DDR_MEM_PARTIAL_DEPTH; i++) begin
                rt = $fscanf(fd, "%h", tmp[0]);
                rt = $fscanf(fd, "%h", tmp[1]);
                rt = $fscanf(fd, "%h", tmp[2]);
                rt = $fscanf(fd, "%h", tmp[3]);
                rt = $fscanf(fd, "%h", tmp[4]);
                rt = $fscanf(fd, "%h", tmp[5]);
                rt = $fscanf(fd, "%h", tmp[6]);
                rt = $fscanf(fd, "%h", tmp[7]);
                temp_mem[PARTIAL_START_LINE + i] = {tmp[7], tmp[6], tmp[5], tmp[4], tmp[3], tmp[2], tmp[1], tmp[0]};
            end
            $fclose(fd);
        end
    endtask

    task initialize_ddr_mat(string file);
        fd = $fopen(file, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", file);
            // $finish;
        end
        else begin
            //initialize input memory matrix
            for (i = 0; i < DDR_MEM_MAT_DEPTH; i++) begin
                rt = $fscanf(fd, "%h", tmp[0]);
                rt = $fscanf(fd, "%h", tmp[1]);
                rt = $fscanf(fd, "%h", tmp[2]);
                rt = $fscanf(fd, "%h", tmp[3]);
                rt = $fscanf(fd, "%h", tmp[4]);
                rt = $fscanf(fd, "%h", tmp[5]);
                rt = $fscanf(fd, "%h", tmp[6]);
                rt = $fscanf(fd, "%h", tmp[7]);
                temp_mem[MAT_START_LINE + i] = {tmp[7], tmp[6], tmp[5], tmp[4], tmp[3], tmp[2], tmp[1], tmp[0]};
            end
            $fclose(fd);
        end
    endtask

    task initialize_ddr_ksk(string file);
        fd = $fopen(file, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", file);
            // $finish;
        end
        else begin
            //initialize input ksk ram 
            for (i = 0; i < DDR_MEM_KSK_DEPTH; i++) begin
                rt = $fscanf(fd, "%h", tmp[0]);
                rt = $fscanf(fd, "%h", tmp[1]);
                rt = $fscanf(fd, "%h", tmp[2]);
                rt = $fscanf(fd, "%h", tmp[3]);
                rt = $fscanf(fd, "%h", tmp[4]);
                rt = $fscanf(fd, "%h", tmp[5]);
                rt = $fscanf(fd, "%h", tmp[6]);
                rt = $fscanf(fd, "%h", tmp[7]);
                temp_mem[KSK_START_LINE + i] = {tmp[7], tmp[6], tmp[5], tmp[4], tmp[3], tmp[2], tmp[1], tmp[0]};
            end
            $fclose(fd);
        end
    endtask

    task initialize_ddr_mem(string file_vec, string file_mat, string file_ksk);
        initialize_ddr_vec(file_vec);
        initialize_ddr_mat(file_mat);
        initialize_ddr_ksk(file_ksk);
        force i_ddr_mem.i_ddr_mem_bank_512b.base_bank.mem_bank = temp_mem; 
        wait_one_cycle();
    endtask

    task initialize_ddr_mem_partial(string file_in, string file_ksk);
        initialize_ddr_partial(file_in);
        initialize_ddr_ksk(file_ksk);
        force i_ddr_mem.i_ddr_mem_bank_512b.base_bank.mem_bank = temp_mem; 
        wait_one_cycle();
    endtask

    task check_ddr_mem(string filename);  
        fd = $fopen(filename, "r");
        if(fd == 0) begin
            $display("ERROR!!! Cannot find file %s \n", filename);
            $finish;
        end

        for (i = 0; i < DDR_MEM_RSLT_DEPTH; i++) begin
            rt = $fscanf(fd, "%h", tmp[0]);
            rt = $fscanf(fd, "%h", tmp[1]);
            rt = $fscanf(fd, "%h", tmp[2]);
            rt = $fscanf(fd, "%h", tmp[3]);
            rt = $fscanf(fd, "%h", tmp[4]);
            rt = $fscanf(fd, "%h", tmp[5]);
            rt = $fscanf(fd, "%h", tmp[6]);
            rt = $fscanf(fd, "%h", tmp[7]);
            gold_mem = {tmp[7], tmp[6], tmp[5], tmp[4], tmp[3], tmp[2], tmp[1], tmp[0]};
            if(i_rslt_mem_model.base_bank.mem_bank[i] == gold_mem) begin end
            else begin
                $display("i_rslt_mem_model.base_bank.mem_bank[%d] out value %d wrong!!! Correct value should be %d !!!\n", i, i_rslt_mem_model.base_bank.mem_bank[i], gold_mem);
                $display("i_rslt_mem_model.base_bank.mem_bank[%d] out value %h wrong!!! Correct value should be %h !!!\n", i, i_rslt_mem_model.base_bank.mem_bank[i], gold_mem);
                $finish;
            end
        end
        $fclose(fd);

    endtask

    task config_kernel_init(); // mvp config for ksk uram init process
        csr_command     = 32'h0             ;
        csr_ksk_ptr     = KSK_START_ADDR    ;
    endtask

    task config_kernel_run(); //mvp config for a complete run except ksk uram init
        csr_command     =  32'h1            ;
        csr_level       =  LEVEL            ;
        csr_col_size    =  COL_SIZE         ;
        csr_index       =  N_INDEX          ;
        csr_split       =  N_SPLIT          ;
        csr_mat_len     =  MAT_LEN          ;
        csr_vec_ptr     =  VEC_START_ADDR   ;
        csr_mat_ptr     =  MAT_START_ADDR   ;
        csr_rslt_ptr    =  RSLT_START_ADDR  ;
    endtask

    task mvp_start();
        wait_half_cycle();
        csr_ap_start    =  1'b1             ;
        wait_some_cycles();
        csr_ap_start    =  1'b0             ;
        wait_one_cycle();
    endtask

    task single_test(int index);
        stage_status_single_stage[index] = 1'b1;
        wait_some_cycles();

        wait_half_cycle();
        stage_start_partial_test_pre[index] = 1'b1;
        wait_one_cycle();
        stage_start_partial_test_pre[index] = 1'b0;
        wait_some_cycles();

        wait(stage_done[index]);
        wait_some_cycles();
        stage_status_single_stage[index] = 1'b0;
    endtask

    task basic_test();
        initialize_ddr_mem_partial({test_data_dir, "ddr_in_partial.txt"}, {test_data_dir, "ddr_in_ksk.txt"});
        initialize_dp_ctxt_uram("uram_vec.mem", 1);
        config_kernel_run();
        read_index({test_data_dir, "stg4_coeff_index.txt"});
        read_level({test_data_dir, "stg5_level.txt"});

        init = 1'b1;
        wait_one_cycle();
        init = 1'b0;

        wait(in_a_row_done == 1'b1);
        wait_some_cycles();
    endtask

    task full_test_no_uram();
        stage0_mode = 1;
        initialize_ddr_mem({test_data_dir, "ddr_in_vec.txt"}, 
            {test_data_dir, "ddr_in_mat.txt"}, {test_data_dir, "ddr_in_ksk.txt"});
        config_kernel_run();
        mvp_start();
        wait(interrupt);
        wait_some_cycles();
    endtask

    task full_test();
        stage0_mode = 0;
        initialize_ddr_mem({test_data_dir, "ddr_in_vec.txt"}, 
            {test_data_dir, "ddr_in_mat.txt"}, {test_data_dir, "ddr_in_ksk.txt"});
        config_kernel_init();
        mvp_start();
        wait(interrupt);
        wait_some_cycles();
        stage0_mode = 1;
        config_kernel_run();
        mvp_start();
        wait(interrupt);
        wait_some_cycles();
    endtask

    `include "task.sv"

endmodule
