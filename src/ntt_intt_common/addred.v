//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: addred
// Modify Date: 07/14/2021 16:10

// Description: add then reduction
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module addred#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0
)
(
    input  [COE_WIDTH-1:0] i_a,
    input  [COE_WIDTH-1:0] i_b,
    output [COE_WIDTH-1:0] o_addred
);

wire [COE_WIDTH-1:0] HE_Q;
wire [COE_WIDTH:0] sum;

if (Q_TYPE == 2)
    assign HE_Q = 39'd`Q2;
else if  (Q_TYPE == 0)
    assign HE_Q = 35'd`Q0;
else
    assign HE_Q = 35'd`Q1;

assign sum = i_a + i_b;
assign o_addred = (sum >= HE_Q) ? (sum - HE_Q) : sum;


endmodule