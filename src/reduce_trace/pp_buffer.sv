//////////////////////////////////////////////////
//
// File:            pp_buffer.sv
// Project Name:    MVP
// Module Name:     pp_buffer
// Description:     Triple ping-pong buffer for Reduce/Trace module
//
// Author:          Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      06/08/2021
// Modify Date:     24/08/2021
//
//////////////////////////////////////////////////

`include "common_defines.vh"

module pp_buffer #(
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

    input   logic   [COE_WIDTH-1:0]                 i_wdata_a,
    input   logic   [N_BANK-1:0][COE_WIDTH-1:0]     i_wdata_b_wide,
    output  logic   [N_BANK-1:0][COE_WIDTH-1:0]     o_rdata_b_wide,
    output  logic   [COE_WIDTH-1:0]                 o_rdata_c,

    input   logic   [ADDR_WIDTH-1:0]                i_waddr_a_long,
    input   logic   [ADDR_WIDTH_L-1:0]              i_waddr_b,
    input   logic   [ADDR_WIDTH_L-1:0]              i_raddr_b,
    input   logic   [ADDR_WIDTH-1:0]                i_raddr_c_long,

    input   logic                                   i_a_we,
    input   logic                                   i_b_we
);

    logic   [N_BANK-1:0][COE_WIDTH-1:0]             rdata_0;
    logic   [N_BANK-1:0][COE_WIDTH-1:0]             wdata_0;
    logic   [N_BANK-1:0][COE_WIDTH-1:0]             rdata_1;
    logic   [N_BANK-1:0][COE_WIDTH-1:0]             wdata_1;
    logic   [N_BANK-1:0][COE_WIDTH-1:0]             rdata_2;
    logic   [N_BANK-1:0][COE_WIDTH-1:0]             wdata_2;

    logic   [ADDR_WIDTH_L-1:0]                      raddr_0;
    logic   [ADDR_WIDTH_L-1:0]                      waddr_0;
    logic   [ADDR_WIDTH_L-1:0]                      raddr_1;
    logic   [ADDR_WIDTH_L-1:0]                      waddr_1;
    logic   [ADDR_WIDTH_L-1:0]                      raddr_2;
    logic   [ADDR_WIDTH_L-1:0]                      waddr_2;

    logic   [N_BANK-1:0]                            we_0;
    logic   [N_BANK-1:0]                            we_1;
    logic   [N_BANK-1:0]                            we_2;

    logic   [ADDR_WIDTH_H-1:0]                      waddr_a_high;
    logic   [ADDR_WIDTH_L-1:0]                      waddr_a_low;

    logic   [ADDR_WIDTH_H-1:0]                      raddr_c_high_d;
    logic   [ADDR_WIDTH_H-1:0]                      raddr_c_high;
    logic   [ADDR_WIDTH_L-1:0]                      raddr_c_low;

    logic   [N_BANK-1:0]                            a_we_wide;
    logic   [N_BANK-1:0]                            b_we_wide;

    logic   [N_BANK-1:0][COE_WIDTH-1:0]             wdata_a_wide;

    
    assign {waddr_a_high, waddr_a_low} = i_waddr_a_long;
    assign {raddr_c_high, raddr_c_low} = i_raddr_c_long;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) raddr_c_high_d <= {ADDR_WIDTH_H{1'b0}};
        else raddr_c_high_d <= raddr_c_high;
    end

    // capture switch_mode
    logic   switch_mode_d, switch_mode_vld;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) switch_mode_d <= 0;
        else switch_mode_d <= i_switch_mode;
    end
    assign switch_mode_vld = i_switch_mode & ~switch_mode_d;

    // state machine
    enum  logic  [1:0]  {s0, s1, s2} state, next_state;

    // always_ff @(posedge clk or rst_n) begin  // Bug
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= s0;
        else state <= next_state;
    end
    assign next_state = switch_mode_vld && state == s0? s1 :
                        switch_mode_vld && state == s1? s2 :
                        switch_mode_vld && state == s2? s0 : state;

    // adjust a and c to single-ram-grained write
    assign a_we_wide = i_a_we? 1 << waddr_a_high : 0;
    assign b_we_wide = {(N_BANK){i_b_we}};
    
    
    always_comb begin
        wdata_a_wide = 0;
        wdata_a_wide[waddr_a_high] = i_wdata_a;
    end

    // mux
    always_comb begin
        if (state == s0) begin
            //
            we_0 = a_we_wide;
            we_1 = b_we_wide;
            we_2 = 0;
            //
            waddr_0 = waddr_a_low;
            waddr_1 = i_waddr_b;
            waddr_2 = 0;
            //
            wdata_0 = wdata_a_wide;
            wdata_1 = i_wdata_b_wide;
            wdata_2 = 0;
            //
            raddr_0 = 0;
            raddr_1 = i_raddr_b;
            raddr_2 = raddr_c_low;
            //
            o_rdata_b_wide = rdata_1;
            o_rdata_c = rdata_2[raddr_c_high_d];  // Bug: o_rdata_c = rdata_2[raddr_c_high];
        end
        else if (state == s1) begin
            //
            we_0 = b_we_wide;
            we_1 = 0;
            we_2 = a_we_wide;
            //
            waddr_0 = i_waddr_b;
            waddr_1 = 0;
            waddr_2 = waddr_a_low;
            //
            wdata_0 = i_wdata_b_wide;
            wdata_1 = 0;
            wdata_2 = wdata_a_wide;
            //
            raddr_0 = i_raddr_b;
            raddr_1 = raddr_c_low;
            raddr_2 = 0;
            //
            o_rdata_b_wide = rdata_0;
            o_rdata_c = rdata_1[raddr_c_high_d];  // Bug: o_rdata_c = rdata_2[raddr_c_high];
        end
        else begin
            //
            we_0 = 0;
            we_1 = a_we_wide;
            we_2 = b_we_wide;
            //
            waddr_0 = 0;
            waddr_1 = waddr_a_low;
            waddr_2 = i_waddr_b;
            //
            wdata_0 = 0;
            wdata_1 = wdata_a_wide;
            wdata_2 = i_wdata_b_wide;
            //
            raddr_0 = raddr_c_low;
            raddr_1 = 0;
            raddr_2 = i_raddr_b;
            //
            o_rdata_b_wide = rdata_2;
            o_rdata_c = rdata_0[raddr_c_high_d];  // Bug: o_rdata_c = rdata_2[raddr_c_high];
        end
    end

    // three buffers
    poly_ram_x8 #(
            .COE_WIDTH(COE_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH_L),
            .N_BANK(N_BANK),
            .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
        )
        buf0(
            .clk(clk),
            .wea(we_0),
            .addra(waddr_0),
            .dina(wdata_0),
            .addrb(raddr_0),
            .doutb(rdata_0)
        );

    poly_ram_x8 #(
            .COE_WIDTH(COE_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH_L),
            .N_BANK(N_BANK),
            .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
        )
        buf1(
            .clk(clk),
            .wea(we_1),
            .addra(waddr_1),
            .dina(wdata_1),
            .addrb(raddr_1),
            .doutb(rdata_1)
        );

    poly_ram_x8 #(
            .COE_WIDTH(COE_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH_L),
            .N_BANK(N_BANK),
            .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
        )
        buf2(
            .clk(clk),
            .wea(we_2),
            .addra(waddr_2),
            .dina(wdata_2),
            .addrb(raddr_2),
            .doutb(rdata_2)
        );
endmodule