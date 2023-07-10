//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: modadd
// Modify Date: 07/13/2021 11:00
// Description: Parameterized ModAdd module
//              function: dout = (din_0 + din_1) % MOD
//              delay: 1 cycle(s) = `COMMON_MODADD_DELAY
//////////////////////////////////////////////////

`include "common_defines.vh"

module modadd #(
    parameter MOD   = 39'h40_0080_0001,
    parameter MWIDTH= 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire    i_add_vld,
    output  reg     o_add_vldout,

    input   wire    [MWIDTH-1:0]  i_add_din_0,
    input   wire    [MWIDTH-1:0]  i_add_din_1,
    output  reg     [MWIDTH-1:0]  o_add_dout
);

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            o_add_vldout <= 1'b0;
        else
            o_add_vldout <= i_add_vld;
    end

    wire [MWIDTH:0] sum;
    assign sum = i_add_din_0 + i_add_din_1;

    always @ (posedge clk) begin
        if (i_add_vld && sum >= MOD)
            o_add_dout <= sum - MOD;
        else if (i_add_vld && sum < MOD)
            o_add_dout <= sum[MWIDTH-1:0];
        else
            o_add_dout <= 'b0;
    end

endmodule
