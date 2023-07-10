//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: polyvec_ram
// Modify Date: 07/27/2021 16:10

// Description: wrapper for a set (typically 4,6,8) polynomials
//              as xilinx IP, port a is a write port, port b is a read port,
//////////////////////////////////////////////////

`include "common_defines.vh"
module polyvec_ram#(
    parameter COE_WIDTH          = 39,
    parameter Q_TYPE             = 0,
    parameter ADDR_WIDTH         = 9,        // Depth of ram is 1<<ADDR_WIDTH
    parameter NUM_POLY           = 8,        // number of polys in one polyvec
    parameter NUM_BASE_BANK      = 8,        // number of banks for one poly
    parameter COMMON_BRAM_DELAY  = `COMMON_BRAM_DELAY
)(
    input                                            clk,
    input   [NUM_BASE_BANK*NUM_POLY-1:0]             wea,
    input   [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addra,
    input   [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   dina,
    input   [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addrb,
    output  [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   doutb
);

/* generate #NUM_POLY_BANK banks to store a polynomial */
genvar index_poly;
generate
    for(index_poly = 0; index_poly<NUM_POLY; index_poly = index_poly+1) begin: genblk1
        poly_ram#(
            .COE_WIDTH(COE_WIDTH),
            .Q_TYPE (Q_TYPE),
            .NUM_BASE_BANK(NUM_BASE_BANK),
            .ADDR_WIDTH(ADDR_WIDTH),
            .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
        )
        polynomial(
            .clk(clk),
            .wea(wea[(index_poly+1)*NUM_BASE_BANK-1 -: NUM_BASE_BANK]),
            .addra(addra[(index_poly+1)*ADDR_WIDTH*NUM_BASE_BANK-1 -: ADDR_WIDTH*NUM_BASE_BANK]),
            .dina(dina[(index_poly+1)*COE_WIDTH*NUM_BASE_BANK-1 -: COE_WIDTH*NUM_BASE_BANK]),
            .addrb(addrb[(index_poly+1)*ADDR_WIDTH*NUM_BASE_BANK-1 -: ADDR_WIDTH*NUM_BASE_BANK]),
            .doutb(doutb[(index_poly+1)*COE_WIDTH*NUM_BASE_BANK-1 -: COE_WIDTH*NUM_BASE_BANK])
        );
    end
endgenerate

endmodule
