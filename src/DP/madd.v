//////////////////////////////////////////////////
// Engineer: Gu Zhen(jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP
// Module Name: madd
// Modify Date: 03/14/2021 16:10

// Description: include 6 modmuladd
//////////////////////////////////////////////////

`include "dp_defines.vh"
module madd#(
    parameter NUM_POLY           = 6,        // number of polys in one polyvec
    parameter DP_MADD_PIP_DELAY  = 5,
    parameter COE_WIDTH          = 39
)(
    input                                           clk,
    input                                           rst_n,
    // axi control and input ports
    input   [1:0]                                   i_idx_split,
    input   [COE_WIDTH*NUM_POLY-1:0]                i_dina,
    input   [COE_WIDTH*NUM_POLY-1:0]                i_dinb,
    input   [COE_WIDTH*NUM_POLY-1:0]                i_psum,
    output  [COE_WIDTH*NUM_POLY-1:0]                o_dout
);
wire [NUM_POLY-1:0]             modadd_done;
wire [NUM_POLY-1:0]             modmul_done;
wire [COE_WIDTH*NUM_POLY-1:0]   prod; 
//dout_0
genvar madd_index;
generate 
    for(madd_index = 0; madd_index < NUM_POLY; madd_index = madd_index +1) begin
        localparam MWIDTH = (madd_index<2? `COE_WIDTH_0 : (madd_index<4? `COE_WIDTH_1 : `COE_WIDTH_2));
        modmuladd #(
            .MWIDTH(MWIDTH),
            .Q_TYPE((madd_index<2? 0 : (madd_index<4? 1:2))),
            .MODMULADD_PIP_LEVEL(DP_MADD_PIP_DELAY)
        ) mma (
            .clk(clk),
            .i_a(i_dina[MWIDTH+COE_WIDTH*madd_index-1 : COE_WIDTH*madd_index]),
            .i_b(i_dinb[MWIDTH+COE_WIDTH*madd_index-1 : COE_WIDTH*madd_index]),
            .i_c(i_psum[MWIDTH+COE_WIDTH*madd_index-1 : COE_WIDTH*madd_index]),
            .ma_en(i_idx_split==0? 1'b0: 1'b1),
            .o_modmuladd(o_dout[MWIDTH+COE_WIDTH*madd_index-1 : COE_WIDTH*madd_index])
        );
        if(MWIDTH<COE_WIDTH) begin
            assign o_dout[COE_WIDTH*(madd_index+1)-1 : MWIDTH+COE_WIDTH*madd_index] ='b0;
        end
    end
endgenerate
endmodule
