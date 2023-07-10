//////////////////////////////////////////////////
//
// File:            mvp_top.v
// Project Name:    MVP
// Module Name:     mvp_top
// Description:     MVP IP top module
//
// Author:          Yanheng Lu(yanheng)
// Email:           yanheng.lyh@alibaba-inc.com
// Backup:          Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      13/08/2021
// Modify Date:     03/04/2022
//
//////////////////////////////////////////////////

`include "common_defines.vh"

module mvp_top #(
    parameter integer AXI_ADDR_WIDTH      = 64 ,
    parameter integer AXI_DATA_WIDTH      = 512
)
(
    input  wire                             clk                  ,
    input  wire                             rst_n                ,
    // AXI MM
    output wire                             data_axi_awvalid     ,
    input  wire                             data_axi_awready     ,
    output wire [AXI_ADDR_WIDTH-1:0]        data_axi_awaddr      ,
    output wire [8-1:0]                     data_axi_awlen       ,
    output wire                             data_axi_wvalid      ,
    input  wire                             data_axi_wready      ,
    output wire [AXI_DATA_WIDTH-1:0]        data_axi_wdata       ,
    output wire [AXI_DATA_WIDTH/8-1:0]      data_axi_wstrb       ,
    output wire                             data_axi_wlast       ,
    input  wire                             data_axi_bvalid      ,
    output wire                             data_axi_bready      ,
    output wire                             data_axi_arvalid     ,
    input  wire                             data_axi_arready     ,
    output wire [AXI_ADDR_WIDTH-1:0]        data_axi_araddr      ,
    output wire [8-1:0]                     data_axi_arlen       ,
    input  wire                             data_axi_rvalid      ,
    output wire                             data_axi_rready      ,
    input  wire [AXI_DATA_WIDTH-1:0]        data_axi_rdata       ,
    input  wire                             data_axi_rlast       ,
    // control
    output wire [31:0]                      test1                ,
    output wire [31:0]                      test2                ,
    input  wire                             ap_start             ,
    output wire [31:0]                      ap_done              ,
    output wire                             ap_idle              ,
    output wire                             ap_ready             ,
    input  wire [31:0]                      command              ,
    input  wire [31:0]                      level                ,
    input  wire [31:0]                      col_size             ,
    input  wire [31:0]                      split                ,
    input  wire [31:0]                      index                ,
    input  wire [31:0]                      mat_len              ,
    input  wire [AXI_ADDR_WIDTH-1:0]        ksk_ptr              ,
    input  wire [AXI_ADDR_WIDTH-1:0]        mat_ptr              ,
    input  wire [AXI_ADDR_WIDTH-1:0]        vec_ptr              ,
    input  wire [AXI_ADDR_WIDTH-1:0]        data_ptr
);

    parameter LEVEL_WIDTH       = 4;
    parameter NUM_POLY          = 4;
    parameter MVP_STATUS_WIDTH  = 10;
    parameter REDUCE_BUF_DEPTH  = 12;
    parameter COE_WIDTH_L       = 39;
    parameter COE_WIDTH_S       = 35;
    parameter NUM_BASE_BANK     = 8;
    parameter ADDR_WIDTH        = 12;
    parameter ADDR_WIDTH_H      = 3;
    parameter ADDR_WIDTH_L      = 9;
    parameter COMMON_BRAM_DELAY = 1;
    parameter COMMON_URAM_DELAY = 4;
    parameter P                 = 39'h40_0080_0001;
    parameter Q0                = 35'h4_0800_0001;
    parameter Q1                = 35'h4_0008_0001;
    parameter IP                = 40'd1099478074363;
    parameter IQ0               = 36'd68186767610;
    parameter IQ1               = 36'd68717379643;
    parameter PIMQ0             = 35'd14972836665;
    parameter PIMQ1             = 35'd8017516954;
    parameter P_WIDTH           = 39;
    parameter Q0_WIDTH          = 35;
    parameter Q1_WIDTH          = 35;
    parameter N_STAGE           = 5;
    parameter N_POLY            = 6;
    parameter INCLUDE_DATA_FIFO = 0;
    parameter AXI_XFER_WIDTH    = 32;

    // control
    wire    [MVP_STATUS_WIDTH-1:0]  start_w;
    wire    [MVP_STATUS_WIDTH-1:0]  done_w;
    wire                            wruram_start_w;
    wire                            wruram_done_w;
    wire                            is_trace_w;
    wire                            rt_switch_mode_w;
    wire                            stall_w; //actually stall|is_trace
    wire                            pre_tpp_switch_w; //actually stall|is_trace
    wire                            last_write_w;
    wire                            mvp_start_pulse;
    wire                            mvp_start_w;
    wire                            mvp_done_w;
    wire                            mvp_idle_w;
    wire    [15 : 0]                stage_cnt_w;
    wire    [LEVEL_WIDTH-1:0]       reduce_level_w;
    wire    [LEVEL_WIDTH-1:0]       level_s5_w;
    wire    [LEVEL_WIDTH-1:0]       level_s7_w;
    wire    [LEVEL_WIDTH-1:0]       level_s9_w;
    wire    [LEVEL_WIDTH*5-1:0]     level_reduce_w;
    wire    [LEVEL_WIDTH-1:0]       uram_index_w;
    wire    [LEVEL_WIDTH-1:0]       uram_wr_index_w;
    wire                            axi_alldone_w;
    wire                            axi_run_command_w;
    wire    [2 : 0]                 idx_split_w;
    wire    [1 : 0]                 dp_mode_w;
    wire    [11 : 0]                coeff_index_w;
    // axi => dp
    wire    [N_POLY * NUM_BASE_BANK-1:0]        axi_dp_we_w;
    wire    [N_POLY * NUM_BASE_BANK-1:0]        axi_dp_we_2_w;
    wire    [NUM_BASE_BANK * ADDR_WIDTH_L-1:0]  axi_dp_waddr_w; 
    wire    [2 * N_POLY * COE_WIDTH_S-1:0]      axi_dp_wdata_w; 
    // dp1 => preprocess
    wire    [2 * N_POLY * NUM_BASE_BANK-1:0]    dp1_pre_we_w; //bit_width ?
    wire    [NUM_BASE_BANK * ADDR_WIDTH_L-1:0]  dp1_pre_waddr_w; 
    wire    [2 * N_POLY * COE_WIDTH_L-1:0]      dp1_pre_wdata_w; 
    wire    [2 * N_POLY * COE_WIDTH_L-1:0]      dp1_pre_wdata_w0; 
    wire    [2 * N_POLY * COE_WIDTH_L-1:0]      dp1_pre_wdata_w1; 
    wire    [NUM_BASE_BANK * ADDR_WIDTH_L-1:0]  dp1_pre_raddr_w; 
    wire    [2 * N_POLY * COE_WIDTH_L-1:0]      dp1_pre_rdata_w; 
    wire    [N_POLY * COE_WIDTH_L-1:0]          dp1_pre_rdata_w0; 
    wire    [N_POLY * COE_WIDTH_L-1:0]          dp1_pre_rdata_w1; 
    // preprocess => mux
    wire    [ADDR_WIDTH-1:0]        mux_raddr_a0_w;
    wire    [ADDR_WIDTH-1:0]        mux_raddr_a1_w;
    wire    [NUM_POLY * COE_WIDTH_L-1:0]        mux_pre_rdata_a0_w;
    wire    [NUM_POLY * COE_WIDTH_L-1:0]        mux_pre_rdata_a1_w;
    wire    [NUM_POLY * COE_WIDTH_S-1:0]        mux_rdata_a0_w;
    wire    [NUM_POLY * COE_WIDTH_S-1:0]        mux_rdata_a1_w;
    // redbuf
    wire                            redbuf_we_w;
    wire    [ADDR_WIDTH-1:0]        redbuf_addr_w;
    wire    [ADDR_WIDTH-1:0]        redbuf_waddr_w;
    wire    [ADDR_WIDTH-1:0]        redbuf_raddr_w;
    wire    [ADDR_WIDTH-1:0]        axi_rd_raddr_w;
    wire    [ADDR_WIDTH-1:0]        rt_rd_raddr_w;
    wire    [NUM_POLY * COE_WIDTH_S-1:0]        redbuf_wdata_w;
    wire    [NUM_POLY * COE_WIDTH_S-1:0]        redbuf_rdata_w;
    // ksk
    wire    [ADDR_WIDTH-1:0]        ksk_raddr_w;
    wire    [12 * COE_WIDTH_L-1:0]  ksk_rdata_w;
    wire    [12 * COE_WIDTH_L-1:0]  ksk_rdata_w_sf;
    //size
    reg     [AXI_XFER_WIDTH-1:0]    mat_size_bytes_r;
    wire    [AXI_XFER_WIDTH-1:0]    mat_size_bytes_w;
    reg     [AXI_XFER_WIDTH-1:0]    vec_size_bytes_r;
    wire    [AXI_XFER_WIDTH-1:0]    vec_size_bytes_w;
    wire    [AXI_XFER_WIDTH-1:0]    ksk_size_bytes;
    wire    [AXI_XFER_WIDTH-1:0]    data_size_bytes;
    wire    [            15-1:0]    data_size_batches;
    //ap
    reg                             ap_idle_r;
    reg                             ap_start_r;
    
    
    wire axird_done;
    reg  axird_done_r1;
    wire axiwr_done;
    reg  axiwr_done_r1;
    wire pre_s3_done0;
    wire pre_s3_done1;
    wire pre_s4_done0;
    wire pre_s4_done1;
    reg  [31:0] cycle_cnt;
    wire ap_done_w;
    reg ap_done_r;
    reg mvp_start_r;
    reg [4:0] config_error; //0: level 1: col_size 2: n_split 3: n_index 4: h_mat_len

    wire [12:0]  row_size;
    assign row_size = 1 << level[3:0];
    //level
    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            config_error[0] <= 1'b0;
        else if(mvp_start_pulse & command[0] & ((level == 0) | (level > 12)))
            config_error[0] <= 1'b1;
        else if(mvp_start_pulse)
            config_error[0] <= 1'b0;

    //col_size
    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            config_error[1] <= 1'b0;
        else if(mvp_start_pulse & command[0] & ((col_size == 0) | (col_size > 16384) | (row_size * col_size[14:0] < 8192)))
            config_error[1] <= 1'b1;
        else if(mvp_start_pulse)
            config_error[1] <= 1'b0;

    //split
    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            config_error[2] <= 1'b0;
        else if(mvp_start_pulse & command[0] & ((split == 0) | (split > 4)))
            config_error[2] <= 1'b1;
        else if(mvp_start_pulse)
            config_error[2] <= 1'b0;

    //index
    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            config_error[3] <= 1'b0;
        else if(mvp_start_pulse & command[0] & ((index[31:13] != 0) |
                (index[12] + index[11] + index[10] + index[9] + index[8] +
                 index[7] + index[6] + index[5] + index[4] + index[3] + 
                 index[2] + index[1] + index[0] != 1)))
            config_error[3] <= 1'b1;
        else if(mvp_start_pulse)
            config_error[3] <= 1'b0;

    //h_mat_len
    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            config_error[4] <= 1'b0;
        else if(mvp_start_pulse & command[0] & ((mat_len[31:15] != 0) |
                (mat_len[14:0] * index[12:0] != split[2:0] * row_size)))
            config_error[4] <= 1'b1;
        else if(mvp_start_pulse)
            config_error[4] <= 1'b0;

    always @ (posedge clk or negedge rst_n)
        if(!rst_n)
            cycle_cnt <= 'd0;
        else if(!ap_idle_r)
            cycle_cnt <= cycle_cnt + 1'b1;
    
    always @ (posedge clk) begin
        axird_done_r1 <= axird_done;
        axiwr_done_r1 <= axiwr_done;
    end
   
    reg [11:0] arvalid_count;
    always@(posedge clk)
        if(mvp_start_w)
            arvalid_count <= 'b0;
        else if(data_axi_arvalid)
            arvalid_count <= arvalid_count + 1'b1;

    reg [17:0] rvalid_count;
    always@(posedge clk)
        if(mvp_start_w)
            rvalid_count <= 'b0;
        else if(data_axi_rvalid)
            rvalid_count <= rvalid_count + 1'b1;

    always@(posedge clk)
        mvp_start_r <= mvp_start_pulse;

    /*assign test1[31] = ap_start;
    assign test1[30] = ap_done[0];
    assign test1[29] = command[0];
    assign test1[28] = is_trace_w;
    assign test1[27] = ap_start_r;
    assign test1[26] = ap_idle_r;
    assign test1[25] = axird_done;
    assign test1[24] = axiwr_done;
    assign test1[23:20] = reduce_level_w;
    assign ap_done[31:20] = arvalid_count;
    assign ap_done[19:2] = rvalid_count;
    assign ap_done[1] = mvp_start_r;
    assign ap_done[0] = ap_done_r;*/
    assign test1 = {stage_cnt_w, 7'b0,mvp_idle_w, 8'h7};
    assign test2 = cycle_cnt;
    assign ap_done = {19'b0, config_error, 7'b0, ap_done_r};
    assign ap_done_w = (command[0] ? ((~axiwr_done_r1 & axiwr_done) | (config_error > 0)) : (~axird_done_r1 & axird_done));
    assign done_w[0] = command[0] ? axird_done : 1'b0;

    assign reduce_level_w = level[LEVEL_WIDTH-1:0];
    assign level_reduce_w = {level_s9_w, 4'b0, level_s7_w, 4'b0, level_s5_w};
    assign axi_run_command_w = command[0];
    assign mat_size_bytes_w = mat_size_bytes_r; //for 200M; break the critical path
    assign vec_size_bytes_w = vec_size_bytes_r; //for 250M; break the critical path
    assign ksk_size_bytes = 32'h00480000;
    assign data_size_bytes = 32'h00020000;
    assign data_size_batches = mat_len[14:1] + split[2:0];
    assign mvp_start_pulse = ap_start & !ap_start_r;
    assign mvp_start_w = mvp_start_r & ((config_error == 0) | !command[0]);
    assign ap_ready = ap_done[0];
    assign ap_idle = ap_idle_r;
    assign axi_dp_we_2_w = 
           {axi_dp_we_w[47],axi_dp_we_w[41],axi_dp_we_w[35],axi_dp_we_w[29],axi_dp_we_w[23],axi_dp_we_w[17],axi_dp_we_w[11],axi_dp_we_w[05],
            axi_dp_we_w[46],axi_dp_we_w[40],axi_dp_we_w[34],axi_dp_we_w[28],axi_dp_we_w[22],axi_dp_we_w[16],axi_dp_we_w[10],axi_dp_we_w[04],
            axi_dp_we_w[45],axi_dp_we_w[39],axi_dp_we_w[33],axi_dp_we_w[27],axi_dp_we_w[21],axi_dp_we_w[15],axi_dp_we_w[09],axi_dp_we_w[03],
            axi_dp_we_w[44],axi_dp_we_w[38],axi_dp_we_w[32],axi_dp_we_w[26],axi_dp_we_w[20],axi_dp_we_w[14],axi_dp_we_w[08],axi_dp_we_w[02],
            axi_dp_we_w[43],axi_dp_we_w[37],axi_dp_we_w[31],axi_dp_we_w[25],axi_dp_we_w[19],axi_dp_we_w[13],axi_dp_we_w[07],axi_dp_we_w[01],
            axi_dp_we_w[42],axi_dp_we_w[36],axi_dp_we_w[30],axi_dp_we_w[24],axi_dp_we_w[18],axi_dp_we_w[12],axi_dp_we_w[06],axi_dp_we_w[00]};
    /*assign axi_dp_we_2_w = 
           {axi_dp_we_w[47],axi_dp_we_w[39],axi_dp_we_w[31],axi_dp_we_w[23],axi_dp_we_w[15],axi_dp_we_w[07],
            axi_dp_we_w[46],axi_dp_we_w[38],axi_dp_we_w[30],axi_dp_we_w[22],axi_dp_we_w[14],axi_dp_we_w[06],
            axi_dp_we_w[45],axi_dp_we_w[37],axi_dp_we_w[29],axi_dp_we_w[21],axi_dp_we_w[13],axi_dp_we_w[05],
            axi_dp_we_w[44],axi_dp_we_w[36],axi_dp_we_w[28],axi_dp_we_w[20],axi_dp_we_w[12],axi_dp_we_w[04],
            axi_dp_we_w[43],axi_dp_we_w[35],axi_dp_we_w[27],axi_dp_we_w[19],axi_dp_we_w[11],axi_dp_we_w[03],
            axi_dp_we_w[42],axi_dp_we_w[34],axi_dp_we_w[26],axi_dp_we_w[18],axi_dp_we_w[10],axi_dp_we_w[02],
            axi_dp_we_w[41],axi_dp_we_w[33],axi_dp_we_w[25],axi_dp_we_w[17],axi_dp_we_w[09],axi_dp_we_w[01],
            axi_dp_we_w[40],axi_dp_we_w[32],axi_dp_we_w[24],axi_dp_we_w[16],axi_dp_we_w[08],axi_dp_we_w[00]};*/

    assign ksk_rdata_w_sf[COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[5*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[2*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[9*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[3*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[2*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[4*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[6*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[5*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[10*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[6*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[3*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[7*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[7*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[8*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[11*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[9*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[4*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[10*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[8*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[11*COE_WIDTH_L-1 -: COE_WIDTH_L];
    assign ksk_rdata_w_sf[12*COE_WIDTH_L-1 -: COE_WIDTH_L] = ksk_rdata_w[12*COE_WIDTH_L-1 -: COE_WIDTH_L];

    always@(posedge clk)
        ap_start_r <= ap_start;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            ap_done_r <= 1'b0;
        else if(mvp_start_w)
            ap_done_r <= 1'b0;
        else if(ap_done_w)
            ap_done_r <= 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            ap_idle_r <= 1'b1;
        else if(mvp_start_w)
            ap_idle_r <= 1'b0;
        else if(ap_done_w)
            ap_idle_r <= 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            mat_size_bytes_r <= 'b0;
        else
            mat_size_bytes_r <= 20'h18000 * mat_len;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            vec_size_bytes_r <= 'b0;
        else
            vec_size_bytes_r <= 20'h30000 * split[2:0];

axi_data_rd_top #(
    .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH    ),
    .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_WIDTH    ),
    .INCLUDE_DATA_FIFO      ( INCLUDE_DATA_FIFO ),
    .KSK_DATA_WIDTH         ( COE_WIDTH_L       ),
    .PRE_DATA_WIDTH         ( COE_WIDTH_L       ),
    .RAM_DELAY              ( COMMON_URAM_DELAY )
)
u_axi_data_rd_top(
    .clk                    ( clk               ),
    .rst_n                  ( rst_n             ),
    // AXI read
    .mvp_axi_arvalid        ( data_axi_arvalid  ),
    .mvp_axi_arready        ( data_axi_arready  ),
    .mvp_axi_araddr         ( data_axi_araddr   ),
    .mvp_axi_arlen          ( data_axi_arlen    ),
    .mvp_axi_rvalid         ( data_axi_rvalid   ),
    .mvp_axi_rready         ( data_axi_rready   ),
    .mvp_axi_rdata          ( data_axi_rdata    ),
    .mvp_axi_rlast          ( data_axi_rlast    ),
    // control
    .i_axird_command        ( command           ),
    .i_axird_initstart      ( mvp_start_w       ),
    .i_axird_start          ( start_w[0]        ),
    .o_axird_done           ( axird_done        ),
    .o_axird_alldone        ( axi_alldone_w     ),
    .ksk_ptr                ( ksk_ptr           ),
    .mat_ptr                ( mat_ptr           ),
    .vec_ptr                ( vec_ptr           ),
    .mat_size_bytes         ( mat_size_bytes_w  ),
    .vec_size_bytes         ( vec_size_bytes_w  ),
    .ksk_size_bytes         ( ksk_size_bytes    ),
    .data_size_batches      ( data_size_batches ),
    // KSK
    .i_axird_ksk_stage      ( level_s7_w        ),
    .i_axird_ksk_rdaddr     ( ksk_raddr_w       ),
    .o_axird_ksk_rddata     ( ksk_rdata_w       ),
    // Preprocess
    .o_axird_pre_wren       ( axi_dp_we_w       ),
    .o_axird_pre_wraddr     ( axi_dp_waddr_w    ),
    .o_axird_pre_wrdata     ( axi_dp_wdata_w    )
);

axi_data_wr_top #(
    .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH    ),
    .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_WIDTH    ),
    .INCLUDE_DATA_FIFO      ( INCLUDE_DATA_FIFO ),
    .DATA_WIDTH             ( COE_WIDTH_S       ),
    .RAM_DELAY              ( COMMON_URAM_DELAY )
)
u_axi_data_wr_top(
    .clk                    ( clk               ),
    .rst_n                  ( rst_n             ),
    // AXI write
    .mvp_axi_awvalid        ( data_axi_awvalid  ),
    .mvp_axi_awready        ( data_axi_awready  ),
    .mvp_axi_awaddr         ( data_axi_awaddr   ),
    .mvp_axi_awlen          ( data_axi_awlen    ),
    .mvp_axi_wvalid         ( data_axi_wvalid   ),
    .mvp_axi_wready         ( data_axi_wready   ),
    .mvp_axi_wdata          ( data_axi_wdata    ),
    .mvp_axi_wstrb          ( data_axi_wstrb    ),
    .mvp_axi_wlast          ( data_axi_wlast    ),
    .mvp_axi_bvalid         ( data_axi_bvalid   ),
    .mvp_axi_bready         ( data_axi_bready   ),
    // control
    .i_axiwr_start          ( mvp_done_w        ),
    .o_axiwr_done           ( axiwr_done        ),
    .data_ptr               ( data_ptr          ),
    .data_size_bytes        ( data_size_bytes   ),
    // reduce buffer
    .o_axiwr_rdaddr         ( axi_rd_raddr_w    ),
    .i_axiwr_rddata         ( redbuf_rdata_w    )
);

dp_top #(
    .COE_WIDTH              ( COE_WIDTH_L       ),
    .ADDR_WIDTH             ( ADDR_WIDTH_L      ),
    .URAM_ADDR_WIDTH        ( ADDR_WIDTH        ),
    .NUM_SPLIT              ( 4                 ),
    .LOG_NUM_BANK           ( ADDR_WIDTH_H      ),
    .NUM_POLY               ( N_POLY/2          ),
    .NUM_BASE_BANK          ( NUM_BASE_BANK     ),
    .COMMON_BRAM_DELAY      ( COMMON_BRAM_DELAY ),
    .DP_MADD_PIP_DELAY      ( 5                 )
)
u_dp_top(
    .clk                    ( clk               ),
    .rst_n                  ( rst_n             ),
    .i_idx_split            ( idx_split_w[1:0]  ), //3 bits
    .i_mode                 ( dp_mode_w         ), //01 for ciphertext vec, 10 for plaintext mat
    .i_axi_done             ( done_w[0]         ),
    .i_axi_we               ( axi_dp_we_2_w     ),
    .i_axi_wraddr           ( axi_dp_waddr_w    ),
    .i_axi_data             ( axi_dp_wdata_w    ),
    .i_ntt_start            ( start_w[1]        ),
    .o_ntt_done             ( done_w[1]         ),
    .i_wruram_start         ( wruram_start_w    ),
    .o_wruram_done          ( wruram_done_w     ),
    .i_madd_start           ( start_w[2]        ),
    .o_madd_done            ( done_w[2]         ),
    .o_madd_we              ( dp1_pre_we_w      ),
    .o_madd_wraddr          ( dp1_pre_waddr_w   ), //output [ADDR_WIDTH+LOG_NUM_BANK-1:0]                o_madd_wraddr,
    .o_madd_data            ( dp1_pre_wdata_w   ), //output [COE_WIDTH*NUM_POLY*4-1:0]                   o_madd_data,
    .o_madd_rdaddr          ( dp1_pre_raddr_w   ), //output [ADDR_WIDTH+LOG_NUM_BANK-1:0]                o_madd_rdaddr,
    .i_madd_data            ( dp1_pre_rdata_w   )  //input  [COE_WIDTH*NUM_POLY*4-1:0]                   i_madd_data
);

wire pre_mux_done_w;
assign pre_mux_done_w = done_w[5] | stall_w; //Risky
assign dp1_pre_rdata_w = {dp1_pre_rdata_w1, dp1_pre_rdata_w0};
assign dp1_pre_wdata_w1 = dp1_pre_wdata_w[COE_WIDTH_L*ADDR_WIDTH_H*4-1 : COE_WIDTH_L*ADDR_WIDTH_H*2]; 
assign dp1_pre_wdata_w0 = dp1_pre_wdata_w[COE_WIDTH_L*ADDR_WIDTH_H*2-1 : 0];

preprocess_top #(
    .DATA_WIDTH             ( COE_WIDTH_L       ),
    .ADDR_WIDTH             ( ADDR_WIDTH        )
)
u_preprocess_top1(
    .clock                  ( clk               ),
    .reset                  ( ~rst_n            ),
    .io_i_pre_switch        ( pre_tpp_switch_w  ),
    //.io_i_dp1_done          ( done_w[2]         ),
    .io_i_mux_done          ( pre_mux_done_w    ),
    .io_i_intt_start        ( start_w[3]        ),
    .io_o_intt_done         ( pre_s3_done1      ),
    .io_i_vpu4_start        ( start_w[4]        ),
    .io_o_vpu4_done         ( pre_s4_done1      ),

    .io_i_coeff_index       ( coeff_index_w     ),
    .io_i_dp1_wren          ( dp1_pre_we_w      ),
    .io_i_dp1_wraddr        ( dp1_pre_waddr_w   ),
    .io_i_dp1_wrdata        ( dp1_pre_wdata_w1  ),
    .io_i_dp1_rdaddr        ( dp1_pre_raddr_w   ),
    .io_o_dp1_rddata        ( dp1_pre_rdata_w1  ),
    .io_i_mux_rdaddr        ( mux_raddr_a1_w    ),
    .io_o_mux_rddata        ( mux_pre_rdata_a1_w)
);

preprocess_top #(
    .DATA_WIDTH             ( COE_WIDTH_L       ),
    .ADDR_WIDTH             ( ADDR_WIDTH        )
)
u_preprocess_top0(
    .clock                  ( clk               ),
    .reset                  ( ~rst_n            ),
    .io_i_pre_switch        ( pre_tpp_switch_w  ),
    .io_i_mux_done          ( pre_mux_done_w    ),
    .io_i_intt_start        ( start_w[3]        ),
    .io_o_intt_done         ( pre_s3_done0      ),
    .io_i_vpu4_start        ( start_w[4]        ),
    .io_o_vpu4_done         ( pre_s4_done0      ),

    .io_i_coeff_index       ( coeff_index_w     ),
    .io_i_dp1_wren          ( dp1_pre_we_w      ),
    .io_i_dp1_wraddr        ( dp1_pre_waddr_w   ),
    .io_i_dp1_wrdata        ( dp1_pre_wdata_w0  ),
    .io_i_dp1_rdaddr        ( dp1_pre_raddr_w   ),
    .io_o_dp1_rddata        ( dp1_pre_rdata_w0  ),
    .io_i_mux_rdaddr        ( mux_raddr_a0_w    ),
    .io_o_mux_rddata        ( mux_pre_rdata_a0_w)
);

genvar _i_tmp;
generate
    for (_i_tmp = 0; _i_tmp < NUM_POLY; _i_tmp = _i_tmp + 1) begin
        assign mux_rdata_a0_w[_i_tmp * COE_WIDTH_S +: COE_WIDTH_S] 
            = mux_pre_rdata_a0_w[_i_tmp * COE_WIDTH_L +: COE_WIDTH_S];
        assign mux_rdata_a1_w[_i_tmp * COE_WIDTH_S +: COE_WIDTH_S] 
            = mux_pre_rdata_a1_w[_i_tmp * COE_WIDTH_L +: COE_WIDTH_S];
    end
endgenerate

assign done_w[3] = pre_s3_done0 & pre_s3_done1;
assign done_w[4] = pre_s4_done0 & pre_s4_done1;

reduce_trace #(
    .COE_WIDTH              ( COE_WIDTH_L       ),
    .Q_WIDTH                ( COE_WIDTH_S       ),
    .ADDR_WIDTH             ( ADDR_WIDTH        ),
    .ADDR_WIDTH_H           ( ADDR_WIDTH_H      ),
    .ADDR_WIDTH_L           ( ADDR_WIDTH_L      ),
    .N_POLY_CT              ( NUM_POLY          ),
    .LEVEL_WIDTH            ( LEVEL_WIDTH       ),
    .COMMON_BRAM_DELAY      ( COMMON_BRAM_DELAY ),
    .COMMON_URAM_DELAY      ( COMMON_URAM_DELAY ),
    .P                      ( P                 ),
    .Q0                     ( Q0                ),
    .Q1                     ( Q1                ),
    .IP                     ( IP                ),
    .IQ0                    ( IQ0               ),
    .IQ1                    ( IQ1               ),
    .PIMQ0                  ( PIMQ0             ),
    .PIMQ1                  ( PIMQ1             ),
    .N_STAGE                ( N_STAGE           ),
    .N_POLY                 ( N_POLY            )
)
u_reduce_trace(
    .clk                    ( clk               ),
    .rst_n                  ( rst_n             ),
    //control
    .i_is_trace             ( is_trace_w        ),
    .i_start_x5             ( start_w[9:5]      ),
    .i_switch_mode          ( rt_switch_mode_w  ),
    .i_stall                ( stall_w           ),
    .i_last_write           ( last_write_w      ),
    .o_done_x5              ( done_w[9:5]       ),
    .i_level_x5             ( level_reduce_w    ),
    //redbuf
    .o_redbuf_we            ( redbuf_we_w       ),
    .o_redbuf_waddr         ( redbuf_waddr_w    ),
    .o_redbuf_wdata         ( redbuf_wdata_w    ),
    .i_redbuf_rdata         ( redbuf_rdata_w    ),
    .o_redbuf_raddr         ( rt_rd_raddr_w     ),
    //preprocess
    .i_prep_rdata_a0        ( mux_rdata_a0_w    ),
    .i_prep_rdata_a1        ( mux_rdata_a1_w    ),
    .o_prep_raddr_a0        ( mux_raddr_a0_w    ),
    .o_prep_raddr_a1        ( mux_raddr_a1_w    ),
    //ksk
    .i_ksk_rdata            ( ksk_rdata_w_sf    ),
    .o_ksk_raddr            ( ksk_raddr_w       )
);

control #(
    .LEVEL_WIDTH            ( LEVEL_WIDTH       ),
    .MVP_STATUS_WIDTH       ( MVP_STATUS_WIDTH  ),
    .REDUCE_BUFFER_WIDTH    ( REDUCE_BUF_DEPTH  )
)
u_control(
    .clk                    ( clk               ),
    .rst_n                  ( rst_n             ),
    //start&done
    .i_mvp_start            ( mvp_start_w       ),
    .o_mvp_done             ( mvp_done_w        ),
    .o_mvp_idle             ( mvp_idle_w        ),
    .o_stage_cnt            ( stage_cnt_w       ), //for debug
//    .status                 (                   ),
    .i_wruram_done          ( wruram_done_w     ),
    .o_wruram_start         ( wruram_start_w    ),
    .i_axi_s0_done          ( done_w[0]         ),
    .i_axi_s0_alldone       ( axi_alldone_w     ),
    .i_dp_ntt_s1_done       ( done_w[1]         ),
    .i_dp_muladd_s2_done    ( done_w[2]         ),
    .i_intt_s3_done         ( done_w[3]         ),
    .i_mext_s4_done         ( done_w[4]         ),
    .i_mux_monox_s5_done    ( done_w[5]         ),
    .i_ntt_s6_done          ( done_w[6]         ),
    .i_mulacc_s7_done       ( done_w[7]         ),
    .i_intt_s8_done         ( done_w[8]         ),
    .i_ms_addx_s9_done      ( done_w[9]         ),
    .o_axi_s0_start         ( start_w[0]        ),
    .o_dp_ntt_s1_start      ( start_w[1]        ),
    .o_dp_muladd_s2_start   ( start_w[2]        ),
    .o_intt_s3_start        ( start_w[3]        ),
    .o_mext_s4_start        ( start_w[4]        ),
    .o_mux_monox_s5_start   ( start_w[5]        ),
    .o_ntt_s6_start         ( start_w[6]        ),
    .o_mulacc_s7_start      ( start_w[7]        ),
    .o_intt_s8_start        ( start_w[8]        ),
    .o_ms_addx_s9_start     ( start_w[9]        ),
    //control
    .i_command              ( command           ),
    .i_reduce_level         ( reduce_level_w    ), //level from reduce to trace
    .i_col_size             ( col_size          ), //to generate coeff_index
    .i_split                ( split             ), //split
    .i_index                ( index             ), //compress
    .o_dp_mode              ( dp_mode_w         ),
    .o_idx_split            ( idx_split_w       ), //3 bits
    .o_switch_mode          ( rt_switch_mode_w  ),
    .o_reduce_trace         ( is_trace_w        ),
    .o_mux_s5_mode          ( stall_w           ),
    .o_pre_tpp_switch       ( pre_tpp_switch_w  ),
    .o_last_write           ( last_write_w      ),
    .o_mux_monox_s5_n       ( level_s5_w        ),
    .o_mulacc_s7_n          ( level_s7_w        ),
    .o_ms_addx_s9_n         ( level_s9_w        ),
    .o_coeff_index          ( coeff_index_w     ),
    .o_uram_index           ( uram_index_w      )
);

assign redbuf_raddr_w = mvp_idle_w ? axi_rd_raddr_w : rt_rd_raddr_w;
assign redbuf_addr_w = redbuf_we_w ? redbuf_waddr_w : redbuf_raddr_w;

reduce_buffer #(
    .COE_WIDTH              ( COE_WIDTH_S       ),
    .ADDR_WIDTH             ( ADDR_WIDTH        ),
    .BUFFER_DEPTH           ( REDUCE_BUF_DEPTH  ),
    .NUM_POLY               ( NUM_POLY          ),
    .COMMON_URAM_DELAY      ( COMMON_URAM_DELAY )
)
u_reduce_buffer (
    .clk                    ( clk               ),
    .i_we                   ( redbuf_we_w       ),
    .i_addr                 ( redbuf_addr_w     ),
    .i_data                 ( redbuf_wdata_w    ),
    .i_uram_index           ( uram_index_w      ),
    .o_data                 ( redbuf_rdata_w    )
);

endmodule
