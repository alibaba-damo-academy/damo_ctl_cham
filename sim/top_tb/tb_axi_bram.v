// *                                                                           *
// * T-Head Confidential                                           *
// * -------------------------------                                           *
// * This file and all its contents are properties of C-Sky Microsystems. The  *
// * information contained herein is confidential and proprietary and is not   *
// * to be disclosed outside of C-Sky Microsystems except under a              *
// * Non-Disclosure Agreement (NDA).                                           *
// *                                                                           *
// *****************************************************************************
// FILE NAME       : tb_axi_bram.v
// AUTHOR          : Heng Liu
// ORIGINAL TIME   : 2020.8.17
// FUNCTION        : A wrapper of BRAM controller and BRAM, support AXI interface
//                   The BRAM controller support AXI4 interface and support 
//                   awsize/arsize = 3'b110 and 3'b111 (only 64B 128B transfer)
//                   burst type = INCR only
// RESET           : Async reset
// DFT             :
// DFP             :
// VERIFICATION    :
// RELEASE HISTORY :
// $Id:
// *****************************************************************************

`timescale 1 ns / 1 ps

module tb_axi_bram #
(
    // BRAM read latency
    parameter integer BRAM_LATENCY       = 1,
    // Width of ID for for write address, write data, read address and read data
    parameter integer C_S_AXI_ID_WIDTH   = 4,
    // Width of S_AXI data bus
    parameter integer C_S_AXI_DATA_WIDTH = 512,
    // Width of S_AXI address bus
    parameter integer C_S_AXI_ADDR_WIDTH = 26 // 64MB
)
(
    s_axi_aclk,
    s_axi_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready
);

  input s_axi_aclk;
  input s_axi_aresetn;

  input [C_S_AXI_ID_WIDTH-1:0]s_axi_awid;
  input [C_S_AXI_ADDR_WIDTH-1:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input s_axi_awvalid;
  output s_axi_awready;
  input [C_S_AXI_DATA_WIDTH-1:0]s_axi_wdata;
  input [C_S_AXI_DATA_WIDTH/8-1:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [C_S_AXI_ID_WIDTH-1:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [C_S_AXI_ID_WIDTH-1:0]s_axi_arid;
  input [C_S_AXI_ADDR_WIDTH-1:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input s_axi_arvalid;
  output s_axi_arready;
  output [C_S_AXI_ID_WIDTH-1:0]s_axi_rid;
  output [C_S_AXI_DATA_WIDTH-1:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;

  localparam ENTRY_OFFSET_WIDTH=$clog2(C_S_AXI_DATA_WIDTH/8);
  localparam URAM_SIZE_IN_BIT=(2**C_S_AXI_ADDR_WIDTH)*8;

  wire ena;
  wire enb;
  wire [C_S_AXI_DATA_WIDTH/8-1:0] wea;
  wire [C_S_AXI_ADDR_WIDTH-1:0] addra;
  wire [C_S_AXI_ADDR_WIDTH-1:0] addrb;
  wire [C_S_AXI_DATA_WIDTH-1:0] dina;
  wire [C_S_AXI_DATA_WIDTH-1:0] doutb;

  reg [C_S_AXI_ADDR_WIDTH-1:0] waddr_reg;
  reg [C_S_AXI_DATA_WIDTH-1:0] wdata_reg;
  reg [C_S_AXI_DATA_WIDTH/8-1:0] wstrb_reg;
  reg [C_S_AXI_ID_WIDTH-1:0] wid_reg;
  reg [7:0] wcnt_reg;
  reg [2:0] wsize_reg;

  reg wr_bip; //burst in process
  reg wr_bts; //beat to send, means in the register stage there are write beat to send to uram
  reg wr_data_in_register_stage; // this signal is high means ther are data in register stage to send to uram
  reg bresp_stuck;

  reg rd_bip; //burst in process
  reg [C_S_AXI_ADDR_WIDTH-1:0] raddr_reg;
  reg [C_S_AXI_ID_WIDTH-1:0] rid_reg;
  reg [2:0] rsize_reg;
  reg [7:0] rcnt_reg;
  
  reg [BRAM_LATENCY-1:0] stage_valid;
  reg [C_S_AXI_ID_WIDTH-1:0] stage_rid[0:BRAM_LATENCY-1];
  reg stage_rlast[0:BRAM_LATENCY-1];
  
  wire last_beat_sent_out;
  //wire data_exist_in_buffer;
  
  genvar i;

  assign s_axi_rid = 0;
  assign s_axi_bid = 0;

  //write channel interface signals
  wire        wr_cmd_rd;
  wire        wr_cmd_full;
  wire        wr_cmd_full_n;
  wire        wr_cmd_empty;
  wire        wr_cmd_empty_n;
  wire [43:0] wr_cmd_in;
  wire [43:0] wr_cmd_out;

  wire                          wr_data_rd;
  wire [C_S_AXI_DATA_WIDTH+C_S_AXI_DATA_WIDTH/8-1:0] wr_data_out;
  wire                          wr_data_full;
  wire                          wr_data_full_n;
  wire                          wr_data_empty;
  wire                          wr_data_empty_n;

  wire [31:0] awaddr_awid_pad;
  assign awaddr_awid_pad  = {{(32-C_S_AXI_ID_WIDTH-C_S_AXI_ADDR_WIDTH){1'b0}}, s_axi_awid, s_axi_awaddr};
  assign wr_cmd_in = {1'b0, s_axi_awsize, s_axi_awlen, awaddr_awid_pad}; //TODO need to be modified when parameter change
  assign s_axi_awready = !wr_cmd_full;
  assign s_axi_wready = !wr_data_full;
  assign wr_cmd_rd = !wr_cmd_empty && !wr_data_empty && (wcnt_reg == 0) && (!wr_bip || s_axi_bready);
  assign wr_data_rd = wr_cmd_rd || (wr_bts && !wr_data_empty && (wcnt_reg != 0));
  assign wr_cmd_full = !wr_cmd_full_n;
  assign wr_cmd_empty = !wr_cmd_empty_n;
  assign wr_data_full = !wr_data_full_n;
  assign wr_data_empty = !wr_data_empty_n;

  fifo_fwft #(
      .DATA_WIDTH (44)
  ) u_wr_cmd_fifo
  (
      .clk          (s_axi_aclk),
      .reset        (!s_axi_aresetn),
      .if_write_ce  (1'b1),
      .if_write     (s_axi_awvalid && s_axi_awready),
      .if_din       (wr_cmd_in),
      .if_full_n    (wr_cmd_full_n),
      .if_read_ce   (1'b1),
      .if_read      (wr_cmd_rd),
      .if_dout      (wr_cmd_out),
      .if_empty_n   (wr_cmd_empty_n)
  );
 
  fifo_fwft #(
      .DATA_WIDTH (576)
  ) u_wr_data_fifo(
      .clk          (s_axi_aclk),
      .reset        (!s_axi_aresetn),
      .if_write_ce  (1'b1),
      .if_write     (s_axi_wvalid && s_axi_wready),
      .if_din       ({s_axi_wstrb, s_axi_wdata}),
      .if_full_n    (wr_data_full_n),
      .if_read_ce   (1'b1),
      .if_read      (wr_data_rd),
      .if_dout      (wr_data_out),
      .if_empty_n   (wr_data_empty_n)
  );
 
//write response channel interface signals
assign s_axi_bvalid = wr_bip && (((wcnt_reg == 0) && (wr_data_in_register_stage)) || bresp_stuck);
assign s_axi_bid = wid_reg;
assign s_axi_bresp = 2'b00;

//buffer write address channel signals
always@(posedge s_axi_aclk)
begin
    if(wr_cmd_rd)
    begin
        wid_reg <= wr_cmd_out[C_S_AXI_ADDR_WIDTH+C_S_AXI_ID_WIDTH-1:C_S_AXI_ADDR_WIDTH];
        wsize_reg <= wr_cmd_out[42:40];
    end
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wcnt_reg <= 0;
    else if(wr_cmd_rd)
        wcnt_reg <= wr_cmd_out[39:32];
    else if(wr_bts && (wcnt_reg != 0) && !wr_data_empty)
        wcnt_reg <= wcnt_reg - 1'b1;
end

always@(posedge s_axi_aclk)
begin
    if(wr_cmd_rd)
        waddr_reg <= wr_cmd_out[C_S_AXI_ADDR_WIDTH-1:0];
    else if(wr_bts && (wcnt_reg != 0) && (wr_data_in_register_stage))
        waddr_reg <= wsize_reg[0] ? (waddr_reg + 8'b10000000) : (waddr_reg + 7'b1000000);
end

always@(posedge s_axi_aclk)
begin
    if(wr_data_rd)
        wdata_reg <= wr_data_out[C_S_AXI_DATA_WIDTH-1:0];
        wstrb_reg <= wr_data_out[C_S_AXI_DATA_WIDTH+C_S_AXI_DATA_WIDTH/8-1:C_S_AXI_DATA_WIDTH];
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wr_bip <= 1'b0;
    else if(wr_cmd_rd)
        wr_bip <= 1'b1;
    else if((((wcnt_reg == 0) && (wr_data_in_register_stage)) || bresp_stuck) && s_axi_bready)
        wr_bip <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        bresp_stuck <= 1'b0;
    else if(s_axi_bvalid && (!s_axi_bready))
        bresp_stuck <= 1'b1;
    else if(s_axi_bready)
        bresp_stuck <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wr_bts <= 1'b0;
    else if(wr_cmd_rd)
        wr_bts <= 1'b1;
    else if((wcnt_reg == 0)  && (wr_data_in_register_stage))
        wr_bts <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        wr_data_in_register_stage <= 1'b0;
    else 
        wr_data_in_register_stage <= wr_cmd_rd || wr_data_rd;
end

//control signals for bram porta
assign addra = waddr_reg;
assign ena = wr_bts && wr_data_in_register_stage;
assign dina = wdata_reg;
//assign wea = {(C_S_AXI_DATA_WIDTH/8){1'b1}}; //TODO:need to be modified if wstrb have 0 bits
assign wea = (wsize_reg[0] || (C_S_AXI_DATA_WIDTH == 512))  ? wstrb_reg : (waddr_reg[6] ? {wstrb_reg[C_S_AXI_DATA_WIDTH/8-1:C_S_AXI_DATA_WIDTH/16], {(C_S_AXI_DATA_WIDTH/16){1'b0}}} : {{(C_S_AXI_DATA_WIDTH/16){1'b0}}, wstrb_reg[C_S_AXI_DATA_WIDTH/16-1:0]}); 


//read channel interface signals
assign s_axi_arready = !rd_bip || last_beat_sent_out;
assign last_beat_sent_out = (rcnt_reg == 8'b0) && enb;

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        rd_bip <= 1'b0;
    else if(s_axi_arvalid && s_axi_arready)
        rd_bip <= 1'b1;
    else if(last_beat_sent_out)
        rd_bip <= 1'b0;
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        rcnt_reg <= 8'b0;
    else if(s_axi_arvalid && s_axi_arready)
        rcnt_reg <= s_axi_arlen;
    else if(enb && (rcnt_reg != 0))
        rcnt_reg <= rcnt_reg - 1'b1;
end

always@(posedge s_axi_aclk)
begin
    if(s_axi_arvalid && s_axi_arready)
    begin
        rid_reg   <= s_axi_arid;
        rsize_reg <= s_axi_arsize;
    end
end

always@(posedge s_axi_aclk)
begin
    if(s_axi_arvalid && s_axi_arready)
        raddr_reg <= s_axi_araddr;
    else if(enb && (rcnt_reg != 0))
        raddr_reg <= rsize_reg[0] ? (raddr_reg + 8'b10000000) : (raddr_reg + 7'b1000000); 
end

always@(posedge s_axi_aclk or negedge s_axi_aresetn)
begin
    if(~s_axi_aresetn)
        stage_valid[0] <= 1'b0;
    else
        stage_valid[0] <= enb;
end

always@(posedge s_axi_aclk)
begin
    stage_rlast[0] <= last_beat_sent_out;
    stage_rid[0] <= rid_reg;
end

generate 
    for(i=1;i<BRAM_LATENCY;i=i+1)
    begin: gen_stage_record

        always@(posedge s_axi_aclk or negedge s_axi_aresetn)
        begin
            if(~s_axi_aresetn)
                stage_valid[i] <= 1'b0;
            else
                stage_valid[i] <= stage_valid[i-1];
        end

        always@(posedge s_axi_aclk)
        begin
            stage_rid[i] <= stage_rid[i-1];
            stage_rlast[i] <= stage_rlast[i-1];
        end

    end
endgenerate

wire rd_info_wr;
wire rd_data_wr;
wire rd_info_rd;
wire rd_data_rd;
wire [8:0] rd_info_in;
wire [8:0] rd_info_out;
wire [C_S_AXI_DATA_WIDTH-1:0] rd_data_in;
wire [C_S_AXI_DATA_WIDTH-1:0] rd_data_out;
wire rd_info_almost_full;
wire rd_info_almost_full_n;
wire rd_data_almost_full;
wire rd_data_almost_full_n;
wire rd_info_empty;
wire rd_info_empty_n;
wire rd_data_empty;
wire rd_data_empty_n;

assign rd_info_almost_full = !rd_info_almost_full_n;
assign rd_data_almost_full = !rd_data_almost_full_n;
assign rd_info_empty = !rd_info_empty_n;
assign rd_data_empty = !rd_data_empty_n;

fifo_fwft #(
      .DATA_WIDTH (9)
) u_rd_info_fifo(
    .clk           (s_axi_aclk),
    .reset         (!s_axi_aresetn),
    .if_write_ce   (1'b1),
    .if_write      (rd_info_wr),
    .if_din        (rd_info_in),
    .if_afull_n    (rd_info_almost_full_n),
    .if_read_ce    (1'b1),
    .if_read       (rd_info_rd),
    .if_dout       (rd_info_out),
    .if_empty_n    (rd_info_empty_n)
);

fifo_fwft #(
      .DATA_WIDTH (C_S_AXI_DATA_WIDTH)
) u_rd_data_fifo(
    .clk           (s_axi_aclk),
    .reset         (!s_axi_aresetn),
    .if_write_ce   (1'b1),
    .if_write      (rd_data_wr),
    .if_din        (rd_data_in),
    .if_afull_n    (rd_data_almost_full_n), //TODO: almost full means rdata_fifo only have 2 unused entry,its threshold must > parameter BRAM_LATENCY
    .if_read_ce    (1'b1),
    .if_read       (rd_data_rd),
    .if_dout       (rd_data_out),
    .if_empty_n    (rd_data_empty_n)
);

wire [7:0] rid;

assign rid = {4'b0, stage_rid[BRAM_LATENCY-1]};
assign rd_info_wr = stage_valid[BRAM_LATENCY-1]; 
assign rd_data_wr = stage_valid[BRAM_LATENCY-1];
assign rd_info_in = {stage_rlast[BRAM_LATENCY-1], rid}; //TODO: need to be modified when id width change
assign rd_data_in = doutb;
assign rd_info_rd = !rd_info_empty && s_axi_rready;
assign rd_data_rd = !rd_data_empty && s_axi_rready;

assign s_axi_rresp = 2'b00;
assign s_axi_rvalid = !rd_data_empty;
assign s_axi_rdata = rd_data_out;
assign s_axi_rid = rd_info_out[C_S_AXI_ID_WIDTH-1:0]; 
assign s_axi_rlast = rd_info_out[8]; 

assign addrb = raddr_reg; 
assign enb   = rd_bip && !rd_data_almost_full;

ram_model #(
      .COE_WIDTH         (C_S_AXI_DATA_WIDTH),        
      .ADDR_WIDTH        (C_S_AXI_ADDR_WIDTH-6),        
      .N_BANK            (1),        
      .COMMON_BRAM_DELAY (BRAM_LATENCY) 
   )
   i_ddr_mem_bank_512b (
      .clk(s_axi_aclk),      
      .doutb(doutb),   
      .addra(addra[C_S_AXI_ADDR_WIDTH-1:ENTRY_OFFSET_WIDTH]),
      .addrb(addrb[C_S_AXI_ADDR_WIDTH-1:ENTRY_OFFSET_WIDTH]),
      .dina(dina),               
      .wea(ena) 
   );
    // User logic ends


endmodule
