//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: simple_dual_ram
// Modify Date: 07/26/2021 16:10

// Description: inferance a simple dual-port ram
//////////////////////////////////////////////////

`include "common_defines.vh"
module simple_dual_ram#(
    parameter COE_WIDTH          = 39,
    parameter Q_TYPE             = 0,
    parameter ADDR_WIDTH         = 9,
    parameter COMMON_BRAM_DELAY  = `COMMON_BRAM_DELAY
)
(
    input                     clk,
    input                     wea,
    input   [ADDR_WIDTH-1:0]  addra,
    input   [COE_WIDTH-1:0]   dina,
    input   [ADDR_WIDTH-1:0]  addrb,
    output  [COE_WIDTH-1:0]   doutb
);

reg [COE_WIDTH-1:0] mem_bank [0:(1<<ADDR_WIDTH)-1];
reg [COE_WIDTH-1:0] doutb_reg [0:COMMON_BRAM_DELAY-1];

//initial begin
//      $readmemh ("/rshome/zhaohui.chen/mvp/src/ntt_rom_39q/tf0.mem", mem_bank);
//end

/* write */
always@(posedge clk) begin
    if(wea) begin
        mem_bank[addra] <= dina;
    end    
end

/* read */
always@(posedge clk) begin
    doutb_reg[0] <= mem_bank[addrb];
end

genvar index_dout;
generate
    for(index_dout = 1; index_dout<COMMON_BRAM_DELAY; index_dout = index_dout+1) begin
        always@(posedge clk) begin
            doutb_reg[index_dout] <= doutb_reg[index_dout-1];
        end
    end
endgenerate
assign doutb = doutb_reg[COMMON_BRAM_DELAY-1];

endmodule
