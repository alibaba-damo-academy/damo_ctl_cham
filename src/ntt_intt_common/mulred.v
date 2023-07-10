//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: mulred
// Modify Date: 07/14/2021 16:10

// Description: multiply reduction with 5dsp and barrett reduction
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module mulred#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0,
    parameter MULRED_PIP_LEVEL = 4
)
(
    input                   clk,
    input  [COE_WIDTH-1:0]  i_a,
    input  [COE_WIDTH-1:0]  i_b,
    output [COE_WIDTH-1:0]  o_mulred
);

//(* use_dsp = "yes" *) reg [2*COE_WIDTH-1:0] product;

//always@(posedge clk) begin
//    (* use_dsp48 = "yes" *) product <= i_a * i_b;
//end

wire [2*COE_WIDTH-1:0] mult_result;
wire [COE_WIDTH-1:0] HE_Q;

if (Q_TYPE == 2)
    assign HE_Q = 39'd`Q2;
else if  (Q_TYPE == 0)
    assign HE_Q = 35'd`Q0;
else
    assign HE_Q = 35'd`Q1;

mult #(
.COE_WIDTH (COE_WIDTH),
.Q_TYPE(Q_TYPE),
.MULT_PIP_LEVEL(MULRED_PIP_LEVEL - 4))
mult0(
.clk(clk),
.i_a(i_a),
.i_b(i_b),
.o_mult(mult_result)
);

barrett#(
.COE_WIDTH (COE_WIDTH),
.Q_TYPE(Q_TYPE))
reduce(
.clk(clk),
.i_a(mult_result),
.o_red(o_mulred)
);

endmodule