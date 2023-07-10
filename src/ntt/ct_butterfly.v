//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: ct_butterfly
// Modify Date: 07/14/2021 16:10

// Description: ct_butterfly contains mulred,addred and subred
//////////////////////////////////////////////////


module ct_butterfly#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0,
    parameter MULRED_PIP_LEVEL = 5
)(
    input clk,
    input [COE_WIDTH-1:0] i_u, 
    input [COE_WIDTH-1:0] i_v, 
    input [COE_WIDTH-1:0] i_omega,
    output [COE_WIDTH-1:0] o_u, o_v
    );
    
    reg [COE_WIDTH-1:0] i_u_reg [0:MULRED_PIP_LEVEL-1];
    wire [COE_WIDTH-1:0] mulred_result;
    
    always@(posedge clk) begin
        i_u_reg[0] <= i_u;
    end
    
    generate
        genvar i;
        for(i=0;i<MULRED_PIP_LEVEL-1;i=i+1)      // MULRED_PIP_LEVEL-1 loop
            begin
                always@(posedge clk) begin
                    i_u_reg[i+1] <= i_u_reg[i];
                end
            end
    endgenerate
    
    mulred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    . MULRED_PIP_LEVEL(MULRED_PIP_LEVEL))
    MR (
    .clk(clk),
    .i_a(i_v),
    .i_b(i_omega),
    .o_mulred(mulred_result)
    );
    
    addred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE))
    AR (
    .i_a(i_u_reg [MULRED_PIP_LEVEL-1]),
    .i_b(mulred_result),
    .o_addred(o_u)
    );
    
    subred#(
    .COE_WIDTH (COE_WIDTH),
    .Q_TYPE(Q_TYPE))
    SR (
    .i_a(i_u_reg [MULRED_PIP_LEVEL-1]),
    .i_b(mulred_result),
    .o_subred(o_v)
    );
    
endmodule