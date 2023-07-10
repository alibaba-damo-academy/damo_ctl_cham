// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module mvp_axil
#(parameter
    C_S_AXI_ADDR_WIDTH = 7,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          ap_start,
    input  wire [31:0]                   ap_done,
    input  wire [31:0]                   test1,
    output wire [31:0]                   command,
    output wire [31:0]                   level,
    output wire [31:0]                   col_size,
    output wire [31:0]                   split,
    output wire [31:0]                   index,
    output wire [31:0]                   mat_len,
    output wire [63:0]                   ksk_ptr,
    output wire [63:0]                   mat_ptr,
    output wire [63:0]                   vec_ptr,
    output wire [63:0]                   output_ptr
);

//------------------------Parameter----------------------
localparam
    ADDR_START             = 16'h0000,
    ADDR_COMMAND_DATA_0    = 16'h0004,
    ADDR_LEVEL_DATA_0      = 16'h0008,
    ADDR_COL_SIZE_DATA_0   = 16'h000c,
    ADDR_SPLIT_DATA_0      = 16'h0010,
    ADDR_INDEX_NUM_DATA_0  = 16'h0014,
    ADDR_MAT_LEN_DATA_0    = 16'h0018,
    ADDR_KSK_PTR_DATA_0    = 16'h001c,
    ADDR_KSK_PTR_DATA_1    = 16'h0020,
    ADDR_MAT_PTR_DATA_0    = 16'h0024,
    ADDR_MAT_PTR_DATA_1    = 16'h0028,
    ADDR_VEC_PTR_DATA_0    = 16'h002c,
    ADDR_VEC_PTR_DATA_1    = 16'h0030,
    ADDR_OUTPUT_PTR_DATA_0 = 16'h0034,
    ADDR_OUTPUT_PTR_DATA_1 = 16'h0038,
    ADDR_DONE              = 16'h003c,
    ADDR_TEST              = 16'h0040,
    WRIDLE                 = 2'd0,
    WRDATA                 = 2'd1,
    WRRESP                 = 2'd2,
    WRRESET                = 2'd3,
    RDIDLE                 = 2'd0,
    RDDATA                 = 2'd1,
    RDRESET                = 2'd2,
    ADDR_BITS              = 16;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [31:0]                   wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [31:0]                   rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_start = 1'b0;
    reg  [31:0]                   int_command = 'b0;
    reg  [31:0]                   int_level = 'b0;
    reg  [31:0]                   int_col_size = 'b0;
    reg  [31:0]                   int_split = 'b0;
    reg  [31:0]                   int_index = 'b0;
    reg  [31:0]                   int_index0 = 'b0;
    reg  [31:0]                   int_index1 = 'b0;
    reg  [31:0]                   int_index2 = 'b0;
    reg  [31:0]                   int_index3 = 'b0;
    reg  [31:0]                   int_mat_len = 'b0;
    reg  [63:0]                   int_ksk_ptr = 'b0;
    reg  [63:0]                   int_mat_ptr = 'b0;
    reg  [63:0]                   int_vec_ptr = 'b0;
    reg  [63:0]                   int_output_ptr = 'b0;

//------------------------Instantiation------------------

//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 1'b0;
            case (raddr)
                ADDR_START: begin
                    rdata <= {31'b0, ap_start};
                end
                ADDR_COMMAND_DATA_0: begin
                    rdata <= int_command[31:0];
                end
                ADDR_LEVEL_DATA_0: begin
                    rdata <= int_level[31:0];
                end
                ADDR_COL_SIZE_DATA_0: begin
                    rdata <= int_col_size[31:0];
                end
                ADDR_SPLIT_DATA_0: begin
                    rdata <= int_split[31:0];
                end
                ADDR_INDEX_NUM_DATA_0: begin
                    rdata <= int_index[31:0];
                end
                ADDR_MAT_LEN_DATA_0: begin
                    rdata <= int_mat_len[31:0];
                end
                ADDR_KSK_PTR_DATA_0: begin
                    rdata <= int_ksk_ptr[31:0];
                end
                ADDR_KSK_PTR_DATA_1: begin
                    rdata <= int_ksk_ptr[63:32];
                end
                ADDR_MAT_PTR_DATA_0: begin
                    rdata <= int_mat_ptr[31:0];
                end
                ADDR_MAT_PTR_DATA_1: begin
                    rdata <= int_mat_ptr[63:32];
                end
                ADDR_VEC_PTR_DATA_0: begin
                    rdata <= int_vec_ptr[31:0];
                end
                ADDR_VEC_PTR_DATA_1: begin
                    rdata <= int_vec_ptr[63:32];
                end
                ADDR_OUTPUT_PTR_DATA_0: begin
                    rdata <= int_output_ptr[31:0];
                end
                ADDR_OUTPUT_PTR_DATA_1: begin
                    rdata <= int_output_ptr[63:32];
                end
                ADDR_DONE: begin
                    rdata <= ap_done;
                end
                ADDR_TEST: begin
                    rdata <= test1;
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign ap_start   = int_ap_start;
assign command    = int_command;
assign level      = int_level;
assign col_size   = int_col_size;
assign split      = int_split;
assign index      = int_index;
assign mat_len    = int_mat_len;
assign ksk_ptr    = int_ksk_ptr;
assign mat_ptr    = int_mat_ptr;
assign vec_ptr    = int_vec_ptr;
assign output_ptr = int_output_ptr;

// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_START)
            int_ap_start <= WDATA;
    end
end

// int_command[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_command[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_COMMAND_DATA_0)
            int_command[31:0] <= (WDATA[31:0] & wmask) | (int_command[31:0] & ~wmask);
    end
end

// int_level[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_level[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_LEVEL_DATA_0)
            int_level[31:0] <= (WDATA[31:0] & wmask) | (int_level[31:0] & ~wmask);
    end
end

// int_col_size[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_col_size[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_COL_SIZE_DATA_0)
            int_col_size[31:0] <= (WDATA[31:0] & wmask) | (int_col_size[31:0] & ~wmask);
    end
end

// int_split[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_split[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_SPLIT_DATA_0)
            int_split[31:0] <= (WDATA[31:0] & wmask) | (int_split[31:0] & ~wmask);
    end
end

// int_index[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_index[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_INDEX_NUM_DATA_0)
            int_index[31:0] <= (WDATA[31:0] & wmask) | (int_index[31:0] & ~wmask);
    end
end

// int_mat_len[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_mat_len[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_MAT_LEN_DATA_0)
            int_mat_len[31:0] <= (WDATA[31:0] & wmask) | (int_mat_len[31:0] & ~wmask);
    end
end

// int_ksk_ptr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ksk_ptr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_KSK_PTR_DATA_0)
            int_ksk_ptr[31:0] <= (WDATA[31:0] & wmask) | (int_ksk_ptr[31:0] & ~wmask);
    end
end

// int_ksk_ptr[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_ksk_ptr[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_KSK_PTR_DATA_1)
            int_ksk_ptr[63:32] <= (WDATA[31:0] & wmask) | (int_ksk_ptr[63:32] & ~wmask);
    end
end

// int_mat_ptr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_mat_ptr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_MAT_PTR_DATA_0)
            int_mat_ptr[31:0] <= (WDATA[31:0] & wmask) | (int_mat_ptr[31:0] & ~wmask);
    end
end

// int_mat_ptr[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_mat_ptr[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_MAT_PTR_DATA_1)
            int_mat_ptr[63:32] <= (WDATA[31:0] & wmask) | (int_mat_ptr[63:32] & ~wmask);
    end
end

// int_vec_ptr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_vec_ptr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_VEC_PTR_DATA_0)
            int_vec_ptr[31:0] <= (WDATA[31:0] & wmask) | (int_vec_ptr[31:0] & ~wmask);
    end
end

// int_vec_ptr[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_vec_ptr[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_VEC_PTR_DATA_1)
            int_vec_ptr[63:32] <= (WDATA[31:0] & wmask) | (int_vec_ptr[63:32] & ~wmask);
    end
end

// int_output_ptr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_output_ptr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_OUTPUT_PTR_DATA_0)
            int_output_ptr[31:0] <= (WDATA[31:0] & wmask) | (int_output_ptr[31:0] & ~wmask);
    end
end

// int_output_ptr[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_output_ptr[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_OUTPUT_PTR_DATA_1)
            int_output_ptr[63:32] <= (WDATA[31:0] & wmask) | (int_output_ptr[63:32] & ~wmask);
    end
end

endmodule
