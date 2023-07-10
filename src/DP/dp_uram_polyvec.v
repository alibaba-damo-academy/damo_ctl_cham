//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: uram_polyvec
// Modify Date: 08/15/2021 16:10

// Description: a polyvec stored in uram
//              an uram can store 2 4096*35 polynomials
//////////////////////////////////////////////////

`include "dp_defines.vh"
module dp_uram_polyvec #(
    parameter COE_WIDTH         = 35,
    parameter ADDR_WIDTH        = 12,
    parameter NUM_POLY          = 3,
    parameter COMMON_URAM_DELAY = 1    // Number of pipeline Registers
)(
    input                   clk,
    input                   mem_en,
    input                   we,
    input  [ADDR_WIDTH-1:0] addr,
    input  [NUM_POLY*COE_WIDTH-1:0]  din,
    output [NUM_POLY*COE_WIDTH-1:0]  dout
);

genvar index_mod;
generate
    for(index_mod = 0; index_mod < NUM_POLY; index_mod = index_mod + 1) begin
    localparam DWIDTH = COE_WIDTH;
        sp_uram # (
            .AWIDTH(ADDR_WIDTH),
            .DWIDTH(DWIDTH),
            .NBPIPE(COMMON_URAM_DELAY)
        )
        uram_inst (
            .clk(clk),
            .mem_en(mem_en), 
            .we(we),    
            .addr(addr),
            .din(din[index_mod*COE_WIDTH+DWIDTH-1 : index_mod*COE_WIDTH]), 
            .dout(dout[index_mod*COE_WIDTH+DWIDTH-1 : index_mod*COE_WIDTH])
        );
    end
endgenerate
endmodule
