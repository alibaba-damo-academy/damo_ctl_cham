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

`include "common_defines.vh"
module uram_polyvec #(
    parameter COE_WIDTH         = 35,
    parameter ADDR_WIDTH        = 12,
    parameter NUM_POLY          = 4,
    parameter COMMON_URAM_DELAY = 1    // Number of pipeline Registers
)(
    input                   clk,
    input                   mem_en,
    input                   we,
    input  [ADDR_WIDTH-1:0] addr,
    input  [NUM_POLY-1:0][COE_WIDTH-1:0]  din,
    output [NUM_POLY-1:0][COE_WIDTH-1:0]  dout
);

sp_uram # (
    .AWIDTH(ADDR_WIDTH),
    .DWIDTH(2*COE_WIDTH),
    .NBPIPE(COMMON_URAM_DELAY)
)
uram_inst0 (
    .clk(clk),
    .mem_en(mem_en), 
    .we(we),    
    .addr(addr),
    .din({din[1],din[0]}), 
    .dout({dout[1],dout[0]})
);

sp_uram # (
    .AWIDTH(ADDR_WIDTH),
    .DWIDTH(2*COE_WIDTH),
    .NBPIPE(COMMON_URAM_DELAY)
)
uram_inst1 (
    .clk(clk),   
    .mem_en(mem_en), 
    .we(we),    
    .addr(addr),
    .din({din[3],din[2]}), 
    .dout({dout[3],dout[2]})
);
endmodule
