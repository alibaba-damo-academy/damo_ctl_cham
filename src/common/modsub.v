//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: modsub
// Modify Date: 07/13/2021 11:00
// Description: Parameterized ModSub module
//              function: dout = (din_0 - din_1) % MOD
//              delay: 1 cycle(s) = `COMMON_MODSUB_DELAY
//////////////////////////////////////////////////

`include "common_defines.vh"

module modsub #(
    parameter MOD   = 39'h40_0080_0001,
    parameter MWIDTH= 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire    i_sub_vld,
    output  reg     o_sub_vldout,

    input   wire    [MWIDTH-1:0]  i_sub_din_0,
    input   wire    [MWIDTH-1:0]  i_sub_din_1,
    output  reg     [MWIDTH-1:0]  o_sub_dout
);

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            o_sub_vldout <= 1'b0;
        else
            o_sub_vldout <= i_sub_vld;
    end

    wire [MWIDTH-1:0] diff;
    assign diff = i_sub_din_0 - i_sub_din_1;

    always @ (posedge clk) begin
        if (i_sub_vld && i_sub_din_0 < i_sub_din_1)
            o_sub_dout <= diff + MOD;
        else if (i_sub_vld && i_sub_din_0 >= i_sub_din_1)
            o_sub_dout <= diff;
        else
            o_sub_dout <= 'b0;
    end

endmodule
