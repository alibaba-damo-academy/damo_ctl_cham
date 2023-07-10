//////////////////////////////////////////////////
//
// File:            poly_ram.sv
// Project Name:    MVP
// Module Name:     dual_ram / poly_ram_x8 / poly_ram_x1 / poly_ram_x12 / ksk_ram
// Description:     RAM models for Reduce/Trace module
//
// Author:          Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      10/08/2021
// Modify Date:     24/08/2021
//
//////////////////////////////////////////////////

// ----------------------------------------------------------
// Dual-port RAM
// ----------------------------------------------------------
module dual_ram #(
    parameter COE_WIDTH = 39,
    parameter ADDR_WIDTH = 9,
    parameter COMMON_BRAM_DELAY = 1
)
(
    input   logic                               clk,
    input   logic                               wea,
    input   logic   [ADDR_WIDTH-1:0]            addra,
    input   logic   [COE_WIDTH-1:0]             dina,
    input   logic   [ADDR_WIDTH-1:0]            addrb,
    output  logic   [COE_WIDTH-1:0]             doutb
);

    localparam MEM_DEPTH = 1 << ADDR_WIDTH;

    logic [COE_WIDTH-1:0] mem_bank [0:MEM_DEPTH-1];
    logic [COE_WIDTH-1:0] doutb_reg [0:COMMON_BRAM_DELAY-1];

    // synchronous write
    always_ff @(posedge clk) begin
        if (wea) begin
            mem_bank[addra] <= dina;
        end
    end

    // synchronous read
    always_ff @(posedge clk) begin
        doutb_reg[0] <= mem_bank[addrb];
    end

    genvar i;
    generate
        for(i = 1; i < COMMON_BRAM_DELAY; i = i+1) begin
            always_ff @(posedge clk) begin
                doutb_reg[i] <= doutb_reg[i-1];
            end
        end
    endgenerate
    assign doutb = doutb_reg[COMMON_BRAM_DELAY-1];
endmodule

// ----------------------------------------------------------
// BRAM (thru = x1)
// ----------------------------------------------------------
module ram_model #(
    parameter COE_WIDTH = 512,
    parameter ADDR_WIDTH = 20,
    parameter N_BANK = 1,
    parameter COMMON_BRAM_DELAY = 1
)(
    input                                           clk,
    input   logic                                   wea,
    input   logic   [ADDR_WIDTH-1:0]                addra,
    input   logic   [COE_WIDTH-1:0]                 dina,
    input   logic   [ADDR_WIDTH-1:0]                addrb,
    output  logic   [COE_WIDTH-1:0]                 doutb
);  

    localparam ADDR_WIDTH_L = ADDR_WIDTH;
    localparam ADDR_WIDTH_FULL = ADDR_WIDTH_L;
    localparam POLY_SIZE = 1 << ADDR_WIDTH;
    localparam MEM_DEPTH = 1 << ADDR_WIDTH;

    localparam N_DEBUG = 1;
    // localparam N_DEBUG = POLY_SIZE;

    //logic  [COE_WIDTH-1:0]      temp_mem [0:POLY_SIZE-1];
    //logic  [COE_WIDTH-1:0]      gold_mem [0:POLY_SIZE-1];
    //bit                         init, check;

    /* generate #N_BANK banks to store a polynomial */
    dual_ram #(
        .COE_WIDTH(COE_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
    )
    base_bank (
        .clk(clk),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .addrb(addrb),
        .doutb(doutb)
    );

    //// initialize poly mem
    //always @(posedge init) begin
    //    // wait(init);
    //    force base_bank.mem_bank = temp_mem;
    //    #1 release base_bank.mem_bank;
    //end

    //// check result
    //always @(posedge check) begin
    //    // wait(check);
    //    for (int i = 0; i < N_DEBUG; i++) begin
    //        assert (base_bank.mem_bank[i] == gold_mem[i])
    //            else $display("addr=%h, data=%10h, expected=%10h\n",
    //                        i, base_bank.mem_bank[i], gold_mem[i]);
    //    end
    //end
endmodule
