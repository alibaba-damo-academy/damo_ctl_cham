//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: halfred
// Modify Date: 07/14/2021 16:10

// Description: i_a multiply by 1/2 with modulo Q
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module halfred#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0
)
(
    input                      clk,
    input      [COE_WIDTH-1:0] i_a,
    output reg [COE_WIDTH-1:0] o_halfred
);

wire [COE_WIDTH-1:0] HE_Q;
wire [COE_WIDTH-1:0] o_mux;

if (Q_TYPE == 2)
    assign HE_Q = 39'd`Q2;
else if  (Q_TYPE == 0)
    assign HE_Q = 35'd`Q0;
else
    assign HE_Q = 35'd`Q1;

assign o_mux = i_a[0]? (HE_Q + 1)>>1 : 'b0; // add (HE_Q + 1)/2 if i_a is odd

always@(*) begin
    o_halfred = o_mux + i_a[COE_WIDTH-1:1];
end

endmodule
