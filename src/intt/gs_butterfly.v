//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: gs_butterfly
// Modify Date: 07/14/2021 16:10

// Description: gs_butterfly contains mulred,addred.subred and halfred
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module gs_butterfly#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0,
    parameter MULRED_PIP_LEVEL = 5
)(
    input                    clk,
    input  [COE_WIDTH-1:0]   i_u, 
    input  [COE_WIDTH-1:0]   i_v, 
    input  [COE_WIDTH-1:0]   i_omega,
    output [COE_WIDTH-1:0]   o_u, 
    output [COE_WIDTH-1:0]   o_v
    );
    
    reg [COE_WIDTH-1:0]  o_addred_reg [0:MULRED_PIP_LEVEL-1];
    wire [COE_WIDTH-1:0] o_addred;
    wire [COE_WIDTH-1:0] o_subred;
    wire [COE_WIDTH-1:0] mulred_result;
    
    always@(posedge clk) begin
        o_addred_reg[0] <= o_addred;
    end
    
    generate
        genvar i;
        for(i=0;i<MULRED_PIP_LEVEL-1;i=i+1)      // MULRED_PIP_LEVEL-1 loop
            begin
                always@(posedge clk) begin
                    o_addred_reg[i+1] <= o_addred_reg[i];
                end
            end
    endgenerate
    
    mulred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    . MULRED_PIP_LEVEL(MULRED_PIP_LEVEL))
    MR (
    .clk(clk),
    .i_a(o_subred),
    .i_b(i_omega),
    .o_mulred(mulred_result)
    );
    
    addred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE))
    AR (
    .i_a(i_u),
    .i_b(i_v),
    .o_addred(o_addred)
    );
    
    subred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE))
    SR (
    .i_a(i_u),
    .i_b(i_v),
    .o_subred(o_subred)
    );
    
    halfred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE))
    HR_u (
    .clk(clk),
    .i_a(o_addred_reg[MULRED_PIP_LEVEL-1]),
    .o_halfred(o_u)
    );
    
    halfred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE))
    HR_v (
    .clk(clk),
    .i_a(mulred_result),
    .o_halfred(o_v)
    );
    
endmodule
