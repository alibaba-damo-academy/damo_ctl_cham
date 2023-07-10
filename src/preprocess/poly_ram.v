//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: poly_ram
// Modify Date: 07/26/2021 16:10

// Description: wrapper for a polynomial ram
//////////////////////////////////////////////////

`include "common_defines.vh"
module poly_ram#(
    parameter COE_WIDTH          = 39,
    parameter Q_TYPE             = 0,
    parameter ADDR_WIDTH         = 9,         // Depth of ram is 1<<ADDR_WIDTH
    parameter NUM_BASE_BANK      = 8,         // number of banks for one poly
    parameter COMMON_BRAM_DELAY  = `COMMON_BRAM_DELAY
)(
    input                                   clk,
    input   [NUM_BASE_BANK-1:0]             wea,
    input   [ADDR_WIDTH*NUM_BASE_BANK-1:0]  addra,
    input   [COE_WIDTH*NUM_BASE_BANK-1:0]   dina,
    input   [ADDR_WIDTH*NUM_BASE_BANK-1:0]  addrb,
    output  [COE_WIDTH*NUM_BASE_BANK-1:0]   doutb
);

/* generate #NUM_BASE_BANK banks to store a polynomial */
genvar index_bank_ram;
generate
    for(index_bank_ram = 0; index_bank_ram<NUM_BASE_BANK; index_bank_ram = index_bank_ram+1) begin: genblk1
        simple_dual_ram#(
            .COE_WIDTH(COE_WIDTH),
            .Q_TYPE (Q_TYPE),
            .ADDR_WIDTH(ADDR_WIDTH),
            .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
        )
        base_bank(
            .clk(clk),
            .wea(wea[index_bank_ram]),
            .addra(addra[(index_bank_ram+1)*ADDR_WIDTH-1 -: ADDR_WIDTH]),
            .dina(dina[(index_bank_ram+1)*COE_WIDTH-1 -: COE_WIDTH]),
            .addrb(addrb[(index_bank_ram+1)*ADDR_WIDTH-1 -: ADDR_WIDTH]),
            .doutb(doutb[(index_bank_ram+1)*COE_WIDTH-1 -: COE_WIDTH])
        );
    end
endgenerate

endmodule
