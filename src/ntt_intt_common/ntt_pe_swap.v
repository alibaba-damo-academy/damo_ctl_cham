//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: ntt_pe_swap
// Modify Date: 07/14/2021 16:10

// Description: swap the order of coefficients
//              Please see the specification3 for details.
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module ntt_pe_swap#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0
)(
    input                     clk,
    input                     mux_sel,
    input  [COE_WIDTH-1 : 0]  i_coe_a,
    input  [COE_WIDTH-1 : 0]  i_coe_b,
    output [COE_WIDTH-1 : 0]  o_coe_a,
    output [COE_WIDTH-1 : 0]  o_coe_b
);

reg mux_sel_reg;
reg [COE_WIDTH-1 : 0] coe_a_l;
reg [COE_WIDTH-1 : 0] coe_b_l;
reg [COE_WIDTH-1 : 0] coe_a_r;
reg [COE_WIDTH-1 : 0] coe_b_r;

wire [COE_WIDTH-1 : 0] mux_a;
wire [COE_WIDTH-1 : 0] mux_b;

assign mux_a = (mux_sel == 1)? coe_b_r : coe_a_l;
assign mux_b = (mux_sel_reg == 1)? coe_b_r : coe_a_l;
assign o_coe_a = coe_a_r;
assign o_coe_b = mux_b;

always@(posedge clk) begin
    mux_sel_reg <= mux_sel;
    coe_a_l <= i_coe_a;
    coe_b_l <= i_coe_b;
    coe_a_r <= mux_a;
    coe_b_r <= coe_b_l;
end

endmodule
