//////////////////////////////////////////////////
//
// File:            pp_buffer_x4.sv
// Project Name:    MVP
// Module Name:     pp_buffer_x4
// Description:     Five ping-pong buffer for Reduce/Trace module
//
// Author:          Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      06/08/2021
// Modify Date:     24/08/2021
//
//////////////////////////////////////////////////

`include "common_defines.vh"

module pp_buffer_x4 #(
    parameter COE_WIDTH = 39,
    parameter ADDR_WIDTH = 12,
    parameter ADDR_WIDTH_H = 3,
    parameter ADDR_WIDTH_L = 9,
    parameter N_BANK = 8,
    parameter COMMON_BRAM_DELAY = 1
)
(
    input   logic                                   clk,
    input   logic                                   rst_n,

    input   logic                                   i_switch_mode,

    input   logic   [COE_WIDTH-1:0]                 i_wdata,
    output  logic   [COE_WIDTH-1:0]                 o_rdata,

    input   logic   [ADDR_WIDTH-1:0]                i_waddr,
    input   logic   [ADDR_WIDTH-1:0]                i_raddr,

    input   logic                                   i_we
);

    localparam  N_BUF = 5;

    logic   [N_BUF-1:0]                         we_x5;
    logic   [N_BUF-1:0][COE_WIDTH-1:0]          rdata_x5;

    logic                                       switch_mode_d, switch_mode_vld;
    enum  logic  [2:0]  {s0, s1, s2, s3, s4}    state, next_state;
    
    // capture switch_mode
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) switch_mode_d <= 0;
        else switch_mode_d <= i_switch_mode;
    end
    assign switch_mode_vld = i_switch_mode & ~switch_mode_d;

    // state machine
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= s0;
        else state <= next_state;
    end
    assign next_state = switch_mode_vld && state == s0? s1 :
                        switch_mode_vld && state == s1? s2 :
                        switch_mode_vld && state == s2? s3 :
                        switch_mode_vld && state == s3? s4 :
                        switch_mode_vld && state == s4? s0 : state;

    // mux
    always_comb begin
        if (state == s0) begin
            we_x5 = 5'b10000 & {5{i_we}};  // Bug: we_x5 = 4'b1000;
            o_rdata = rdata_x5[0];
        end
        else if (state == s1) begin
            we_x5 = 5'b00001 & {5{i_we}};  // Bug: we_x5 = 4'b0001;
            o_rdata = rdata_x5[1];
        end
        else if (state == s2) begin
            we_x5 = 5'b00010 & {5{i_we}};  // Bug: we_x5 = 4'b0010;
            o_rdata = rdata_x5[2];
        end
        else if (state == s3) begin
            we_x5 = 5'b00100 & {5{i_we}};  // Bug: we_x5 = 4'b0100;
            o_rdata = rdata_x5[3];
        end
        else begin
            we_x5 = 5'b01000 & {5{i_we}};  // Bug: we_x5 = 4'b0100;
            o_rdata = rdata_x5[4];
        end
    end

    // five buffers
    poly_ram_x1 #(
        .COE_WIDTH(COE_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .N_BANK(N_BANK),
        .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
    )
    buf0(
        .clk(clk),
        .wea(we_x5[0]),
        .addra(i_waddr),
        .dina(i_wdata),
        .addrb(i_raddr),
        .doutb(rdata_x5[0])
    );

    poly_ram_x1 #(
        .COE_WIDTH(COE_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .N_BANK(N_BANK),
        .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
    )
    buf1(
        .clk(clk),
        .wea(we_x5[1]),
        .addra(i_waddr),
        .dina(i_wdata),
        .addrb(i_raddr),
        .doutb(rdata_x5[1])
    );

    poly_ram_x1 #(
        .COE_WIDTH(COE_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .N_BANK(N_BANK),
        .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
    )
    buf2(
        .clk(clk),
        .wea(we_x5[2]),
        .addra(i_waddr),
        .dina(i_wdata),
        .addrb(i_raddr),
        .doutb(rdata_x5[2])
    );

    poly_ram_x1 #(
        .COE_WIDTH(COE_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .N_BANK(N_BANK),
        .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
    )
    buf3(
        .clk(clk),
        .wea(we_x5[3]),
        .addra(i_waddr),
        .dina(i_wdata),
        .addrb(i_raddr),
        .doutb(rdata_x5[3])
    );

    poly_ram_x1 #(
        .COE_WIDTH(COE_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .N_BANK(N_BANK),
        .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
    )
    buf4(
        .clk(clk),
        .wea(we_x5[4]),
        .addra(i_waddr),
        .dina(i_wdata),
        .addrb(i_raddr),
        .doutb(rdata_x5[4])
    );
endmodule