//================================================
//
//  mvp
//  mvp_top for FPGA
//  Author: Yanheng Lu(yanheng.lyh@ablibaba-inc.com)
//  Date: 20211228
//
//================================================

module mvp(
     input  wire            s_axil_test_aclk    ,  
     input  wire            s_axil_test_aresetn ,
                                  
     input  wire [15 : 0]   s_axil_test_awaddr  ,
     input  wire [2 : 0]    s_axil_test_awprot  ,
     input  wire            s_axil_test_awvalid ,
     output wire            s_axil_test_awready ,
                                  
     input  wire [31 : 0]   s_axil_test_wdata   ,
     input  wire [3 : 0]    s_axil_test_wstrb   ,
     input  wire            s_axil_test_wvalid  ,
     output wire            s_axil_test_wready  ,
                                  
     output wire            s_axil_test_bvalid  ,
     output wire [1 : 0]    s_axil_test_bresp   ,
     input  wire            s_axil_test_bready  ,
                                  
     input  wire [15 : 0]   s_axil_test_araddr  ,
     input  wire [2 : 0]    s_axil_test_arprot  ,
     input  wire            s_axil_test_arvalid ,
     output wire            s_axil_test_arready ,
                                  
     output wire [31 : 0]   s_axil_test_rdata   ,
     output wire [1 : 0]    s_axil_test_rresp   ,
     output wire            s_axil_test_rvalid  ,
     input  wire            s_axil_test_rready  ,
 
     //DDR4//
     input  wire            test_resetn              ,
     input  wire            test_clk                 ,       
     output  wire[11 : 0]   test_axi_c0_awid         ,      
     output  wire[63 : 0]   test_axi_c0_awaddr       ,
     output  wire[7 : 0]    test_axi_c0_awlen        ,
     output  wire[2 : 0]    test_axi_c0_awsize       ,
     output  wire[1 : 0]    test_axi_c0_awburst      ,
     output  wire           test_axi_c0_awlock       ,
     output  wire[3 : 0]    test_axi_c0_awcache      ,
     output  wire[2 : 0]    test_axi_c0_awprot       ,
     output  wire           test_axi_c0_awvalid      ,
     input  wire            test_axi_c0_awready      ,
     output  wire[511 : 0]  test_axi_c0_wdata        ,
     output  wire[63 : 0]   test_axi_c0_wstrb        ,
     output  wire           test_axi_c0_wlast        ,
     output  wire           test_axi_c0_wvalid       ,
     input   wire           test_axi_c0_wready       ,
     input   wire[11 : 0]   test_axi_c0_bid          ,
     input   wire[1 : 0]    test_axi_c0_bresp        ,
     input   wire           test_axi_c0_bvalid       ,
     output  wire           test_axi_c0_bready       ,
     output  wire[11 : 0]   test_axi_c0_arid         ,
     output  wire[63 : 0]   test_axi_c0_araddr       ,
     output  wire[7 : 0]    test_axi_c0_arlen        ,
     output  wire[2 : 0]    test_axi_c0_arsize       ,
     output  wire[1 : 0]    test_axi_c0_arburst      ,
     output  wire           test_axi_c0_arlock       ,
     output  wire[3 : 0]    test_axi_c0_arcache      ,
     output  wire[2 : 0]    test_axi_c0_arprot       ,
     output  wire           test_axi_c0_arvalid      ,
     input   wire           test_axi_c0_arready      ,
     input   wire[11 : 0]   test_axi_c0_rid          ,
     input   wire[511 : 0]  test_axi_c0_rdata        ,
     input   wire[1 : 0]    test_axi_c0_rresp        ,
     input   wire           test_axi_c0_rlast        ,
     input   wire           test_axi_c0_rvalid       ,
     output  wire           test_axi_c0_rready
 ); 
 
 
wire [32-1:0]                       command                       ;
wire [32-1:0]                       split                         ;
wire [32-1:0]                       level                         ;
wire [32-1:0]                       col_size                      ;
wire [32-1:0]                       index                         ;
wire [32-1:0]                       mat_len                       ;
wire [64-1:0]                       ksk_ptr                       ;
wire [64-1:0]                       mat_ptr                       ;
wire [64-1:0]                       vec_ptr                       ;
wire [64-1:0]                       output_ptr                    ;
wire                                ap_start                      ;
wire [32-1:0]                       ap_done                       ;
wire [32-1:0]                       test1                         ;

 
 ////DDR4////
  assign test_axi_c0_awaddr[63:33]=31'h0;
  assign test_axi_c0_araddr[63:33]=31'h0; 
  
 wire    [63:0]              tmp_awaddr         ;
 wire    [63:0]              tmp_araddr         ;
 assign test_axi_c0_awid = 'd0;
 assign test_axi_c0_awsize = 'd6;
 assign test_axi_c0_awburst = 'd1;
 assign test_axi_c0_awcache = 'd3;
 assign test_axi_c0_awlock = 'd0;
 assign test_axi_c0_awprot = 'd0;
 assign test_axi_c0_arid = 'd0;
 assign test_axi_c0_arsize = 'd6;
 assign test_axi_c0_arburst = 'd1;
 assign test_axi_c0_arcache = 'd3;
 assign test_axi_c0_arlock = 'd0;
 assign test_axi_c0_arprot = 'd0;
 assign test_axi_c0_awaddr[32 : 0] = tmp_awaddr[32 : 0];
 assign test_axi_c0_araddr[32 : 0] = tmp_araddr[33 - 1 : 0];

parameter C_MVP_AXI_ADDR_WIDTH = 'd64;
parameter C_MVP_AXI_DATA_WIDTH = 'd512;

mvp_top #(
    .AXI_ADDR_WIDTH         ( C_MVP_AXI_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH         ( C_MVP_AXI_DATA_WIDTH  )
)
u_mvp_top (
    .clk                    ( test_clk                  ),
    .rst_n                  ( test_resetn               ),
    .data_axi_awvalid       ( test_axi_c0_awvalid       ),
    .data_axi_awready       ( test_axi_c0_awready       ),
    .data_axi_awaddr        ( tmp_awaddr                ),
    .data_axi_awlen         ( test_axi_c0_awlen         ),
    .data_axi_wvalid        ( test_axi_c0_wvalid        ),
    .data_axi_wready        ( test_axi_c0_wready        ),
    .data_axi_wdata         ( test_axi_c0_wdata         ),
    .data_axi_wstrb         ( test_axi_c0_wstrb         ),
    .data_axi_wlast         ( test_axi_c0_wlast         ),
    .data_axi_bvalid        ( test_axi_c0_bvalid        ),
    .data_axi_bready        ( test_axi_c0_bready        ),
    .data_axi_arvalid       ( test_axi_c0_arvalid       ),
    .data_axi_arready       ( test_axi_c0_arready       ),
    .data_axi_araddr        ( tmp_araddr                ),
    .data_axi_arlen         ( test_axi_c0_arlen         ),
    .data_axi_rvalid        ( test_axi_c0_rvalid        ),
    .data_axi_rready        ( test_axi_c0_rready        ),
    .data_axi_rdata         ( test_axi_c0_rdata         ),
    .data_axi_rlast         ( test_axi_c0_rlast         ),
    .ap_start               ( ap_start              ),
    .ap_done                ( ap_done               ),
    .ap_idle                (                       ),
    .ap_ready               (                       ),
    .test1                  ( test1                 ),
    .command                ( command               ),
    .level                  ( level                 ),
    .col_size               ( col_size              ),
    .split                  ( split                 ),
    .index                  ( index                 ),
    .mat_len                ( mat_len               ),
    .ksk_ptr                ( ksk_ptr               ),
    .mat_ptr                ( mat_ptr               ),
    .vec_ptr                ( vec_ptr               ),
    .data_ptr               ( output_ptr            )
);

mvp_axil #(
  .C_S_AXI_ADDR_WIDTH ( 16 ),
  .C_S_AXI_DATA_WIDTH ( 32 )
)
u_mvp_axil (
  .ACLK       ( s_axil_test_aclk      ),
  .ARESET     ( ~s_axil_test_aresetn  ),
  .ACLK_EN    ( 1'b1                  ),
  .AWVALID    ( s_axil_test_awvalid   ),
  .AWREADY    ( s_axil_test_awready   ),
  .AWADDR     ( s_axil_test_awaddr    ),
  .WVALID     ( s_axil_test_wvalid    ),
  .WREADY     ( s_axil_test_wready    ),
  .WDATA      ( s_axil_test_wdata     ),
  .WSTRB      ( s_axil_test_wstrb     ),
  .ARVALID    ( s_axil_test_arvalid   ),
  .ARREADY    ( s_axil_test_arready   ),
  .ARADDR     ( s_axil_test_araddr    ),
  .RVALID     ( s_axil_test_rvalid    ),
  .RREADY     ( s_axil_test_rready    ),
  .RDATA      ( s_axil_test_rdata     ),
  .RRESP      ( s_axil_test_rresp     ),
  .BVALID     ( s_axil_test_bvalid    ),
  .BREADY     ( s_axil_test_bready    ),
  .BRESP      ( s_axil_test_bresp     ),
  .ap_start   ( ap_start              ),
  .ap_done    ( ap_done               ),
  .test1      ( test1                 ),
  .command    ( command               ),
  .level      ( level                 ),
  .col_size   ( col_size              ),
  .split      ( split                 ),
  .index      ( index                 ),
  .mat_len    ( mat_len               ),
  .ksk_ptr    ( ksk_ptr               ),
  .mat_ptr    ( mat_ptr               ),
  .vec_ptr    ( vec_ptr               ),
  .output_ptr ( output_ptr            )
);

endmodule                
