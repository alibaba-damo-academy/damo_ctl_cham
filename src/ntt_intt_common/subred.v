//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: subred
// Modify Date: 07/14/2021 16:10

// Description: sub then reduction
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module subred#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0
)
(
    input  [COE_WIDTH-1:0] i_a,
    input  [COE_WIDTH-1:0] i_b,
    output [COE_WIDTH-1:0] o_subred
);

wire [COE_WIDTH-1:0] HE_Q;

if (Q_TYPE == 2)
    assign HE_Q = 39'd`Q2;
else if  (Q_TYPE == 0)
    assign HE_Q = 35'd`Q0;
else
    assign HE_Q = 35'd`Q1;

assign o_subred = (i_a >= i_b) ? (i_a - i_b) : (HE_Q + i_a - i_b);


endmodule
