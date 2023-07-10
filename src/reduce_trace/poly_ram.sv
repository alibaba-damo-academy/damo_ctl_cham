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

`include "common_defines.vh"

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
// BRAM (thru = x8)
// ----------------------------------------------------------
// TODO: rename this module
module poly_ram_x8 #(
    parameter COE_WIDTH = 39,
    parameter ADDR_WIDTH = 9,
    parameter N_BANK = 8,
    parameter COMMON_BRAM_DELAY = 1
)(
    input                                           clk,
    input   logic   [N_BANK-1:0]                    wea,
    input   logic   [ADDR_WIDTH-1:0]                addra,
    input   logic   [N_BANK-1:0][COE_WIDTH-1:0]     dina,
    input   logic   [ADDR_WIDTH-1:0]                addrb,
    output  logic   [N_BANK-1:0][COE_WIDTH-1:0]     doutb
);

    localparam ADDR_WIDTH_H = $clog2(N_BANK);
    localparam ADDR_WIDTH_L = ADDR_WIDTH;
    localparam ADDR_WIDTH_FULL = ADDR_WIDTH_H + ADDR_WIDTH_L;
    localparam POLY_SIZE = 1 << ADDR_WIDTH_FULL;
    localparam MEM_DEPTH = 1 << ADDR_WIDTH_L;

    // localparam N_DEBUG = 1;
    localparam N_DEBUG = MEM_DEPTH;

    logic  [COE_WIDTH-1:0]      temp_mem [0:POLY_SIZE-1];
    logic  [COE_WIDTH-1:0]      gold_mem [0:POLY_SIZE-1];
    bit                         init, check;

    /* generate #N_BANK banks to store a polynomial */
    generate
        for(genvar i = 0; i < N_BANK; i = i+1) begin : banks
            dual_ram #(
                .COE_WIDTH(COE_WIDTH),
                .ADDR_WIDTH(ADDR_WIDTH),
                .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
            )
            base_bank (
                .clk(clk),
                .wea(wea[i]),
                .addra(addra),
                .dina(dina[i]),
                .addrb(addrb),
                .doutb(doutb[i])
            );
        end
    endgenerate

`ifdef SIMULATION
    // initialize poly mem
    always @(posedge init) begin
        // wait(init);
        force banks[0].base_bank.mem_bank = temp_mem[0 +: MEM_DEPTH];
        force banks[1].base_bank.mem_bank = temp_mem[MEM_DEPTH +: MEM_DEPTH];
        force banks[2].base_bank.mem_bank = temp_mem[MEM_DEPTH*2 +: MEM_DEPTH];
        force banks[3].base_bank.mem_bank = temp_mem[MEM_DEPTH*3 +: MEM_DEPTH];
        force banks[4].base_bank.mem_bank = temp_mem[MEM_DEPTH*4 +: MEM_DEPTH];
        force banks[5].base_bank.mem_bank = temp_mem[MEM_DEPTH*5 +: MEM_DEPTH];
        force banks[6].base_bank.mem_bank = temp_mem[MEM_DEPTH*6 +: MEM_DEPTH];
        force banks[7].base_bank.mem_bank = temp_mem[MEM_DEPTH*7 +: MEM_DEPTH];
        #1;
        release banks[0].base_bank.mem_bank;
        release banks[1].base_bank.mem_bank;
        release banks[2].base_bank.mem_bank;
        release banks[3].base_bank.mem_bank;
        release banks[4].base_bank.mem_bank;
        release banks[5].base_bank.mem_bank;
        release banks[6].base_bank.mem_bank;
        release banks[7].base_bank.mem_bank;
    end

    // check result
    always @(posedge check) begin
        // wait(check);
        for (int i = 0; i < N_DEBUG; i++) begin
            assert (banks[0].base_bank.mem_bank[i] == gold_mem[i])
                else $display("ram=0, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[0].base_bank.mem_bank[i], gold_mem[i]);
            assert (banks[1].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH + i])
                else $display("ram=1, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[1].base_bank.mem_bank[i], gold_mem[MEM_DEPTH + i]);
            assert (banks[2].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*2 + i])
                else $display("ram=2, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[2].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*2 + i]);
            assert (banks[3].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*3 + i])
                else $display("ram=3, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[3].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*3 + i]);
            assert (banks[4].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*4 + i])
                else $display("ram=4, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[4].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*4 + i]);
            assert (banks[5].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*5 + i])
                else $display("ram=5, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[5].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*5 + i]);
            assert (banks[6].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*6 + i])
                else $display("ram=6, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[6].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*6 + i]);
            assert (banks[7].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*7 + i])
                else $display("ram=7, addr=%h, data=%10h, expected=%10h\n",
                            i, banks[7].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*7 + i]);
        end
    end
`endif
endmodule

// ----------------------------------------------------------
// BRAM (thru = x1)
// ----------------------------------------------------------
module poly_ram_x1 #(
    parameter COE_WIDTH = 39,
    parameter ADDR_WIDTH = 12,
    parameter N_BANK = 8,
    parameter COMMON_BRAM_DELAY = 1
)(
    input                                           clk,
    input   logic                                   wea,
    input   logic   [ADDR_WIDTH-1:0]                addra,
    input   logic   [COE_WIDTH-1:0]                 dina,
    input   logic   [ADDR_WIDTH-1:0]                addrb,
    output  logic   [COE_WIDTH-1:0]                 doutb
);  

    localparam ADDR_WIDTH_H = $clog2(N_BANK);
    localparam ADDR_WIDTH_L = ADDR_WIDTH;
    localparam ADDR_WIDTH_FULL = ADDR_WIDTH_H + ADDR_WIDTH_L;
    localparam POLY_SIZE = 1 << ADDR_WIDTH;
    localparam MEM_DEPTH = 1 << ADDR_WIDTH;

    // localparam N_DEBUG = 1;
    localparam N_DEBUG = POLY_SIZE;

    logic  [COE_WIDTH-1:0]      temp_mem [0:POLY_SIZE-1];
    logic  [COE_WIDTH-1:0]      gold_mem [0:POLY_SIZE-1];
    bit                         init, check;

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

`ifdef SIMULATION
    // initialize poly mem
    always @(posedge init) begin
        // wait(init);
        force base_bank.mem_bank = temp_mem;
        #1 release base_bank.mem_bank;
    end

    // check result
    always @(posedge check) begin
        // wait(check);
        for (int i = 0; i < N_DEBUG; i++) begin
            assert (base_bank.mem_bank[i] == gold_mem[i])
                else $display("addr=%h, data=%10h, expected=%10h\n",
                            i, base_bank.mem_bank[i], gold_mem[i]);
        end
    end
`endif
endmodule

// ----------------------------------------------------------
// URAM (ksk buffer)
// ----------------------------------------------------------
module poly_ram_x12 #(
    parameter COE_WIDTH = 39,
    parameter ADDR_WIDTH = 12,
    parameter N_BANK = 12,
    parameter COMMON_BRAM_DELAY = 1
)(
    input                                           clk,
    input   logic   [N_BANK-1:0]                    wea,
    input   logic   [ADDR_WIDTH-1:0]                addra,
    input   logic   [N_BANK-1:0][COE_WIDTH-1:0]     dina,
    input   logic   [ADDR_WIDTH-1:0]                addrb,
    output  logic   [N_BANK-1:0][COE_WIDTH-1:0]     doutb
);

    localparam ADDR_WIDTH_H = $clog2(N_BANK);
    localparam ADDR_WIDTH_L = ADDR_WIDTH;
    localparam ADDR_WIDTH_FULL = ADDR_WIDTH_H + ADDR_WIDTH_L;
    localparam POLY_SIZE = 1 << ADDR_WIDTH_FULL;
    localparam MEM_DEPTH = 1 << ADDR_WIDTH_L;

    logic  [COE_WIDTH-1:0]      temp_mem [0:POLY_SIZE-1];
    // logic  [COE_WIDTH-1:0]      gold_mem [0:POLY_SIZE-1];
    bit                         check;

    /* generate #N_BANK banks to store a polynomial */
    generate
        for(genvar i = 0; i < N_BANK; i = i+1) begin : banks
            dual_ram #(
                .COE_WIDTH(COE_WIDTH),
                .ADDR_WIDTH(ADDR_WIDTH),
                .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
            )
            base_bank (
                .clk(clk),
                .wea(wea[i]),
                .addra(addra),
                .dina(dina[i]),
                .addrb(addrb),
                .doutb(doutb[i])
            );
        end
    endgenerate

`ifdef SIMULATION
    // initialize poly mem
    initial begin
        #1;
        force banks[0].base_bank.mem_bank = temp_mem[0 +: MEM_DEPTH];
        force banks[4].base_bank.mem_bank = temp_mem[MEM_DEPTH +: MEM_DEPTH];
        force banks[8].base_bank.mem_bank = temp_mem[MEM_DEPTH*2 +: MEM_DEPTH];
        force banks[1].base_bank.mem_bank = temp_mem[MEM_DEPTH*3 +: MEM_DEPTH];
        force banks[5].base_bank.mem_bank = temp_mem[MEM_DEPTH*4 +: MEM_DEPTH];
        force banks[9].base_bank.mem_bank = temp_mem[MEM_DEPTH*5 +: MEM_DEPTH];
        force banks[2].base_bank.mem_bank = temp_mem[MEM_DEPTH*6 +: MEM_DEPTH];
        force banks[6].base_bank.mem_bank = temp_mem[MEM_DEPTH*7 +: MEM_DEPTH];
        force banks[10].base_bank.mem_bank = temp_mem[MEM_DEPTH*8 +: MEM_DEPTH];
        force banks[3].base_bank.mem_bank = temp_mem[MEM_DEPTH*9 +: MEM_DEPTH];
        force banks[7].base_bank.mem_bank = temp_mem[MEM_DEPTH*10 +: MEM_DEPTH];
        force banks[11].base_bank.mem_bank = temp_mem[MEM_DEPTH*11 +: MEM_DEPTH];

        #2;
        release banks[0].base_bank.mem_bank;
        release banks[1].base_bank.mem_bank;
        release banks[2].base_bank.mem_bank;
        release banks[3].base_bank.mem_bank;
        release banks[4].base_bank.mem_bank;
        release banks[5].base_bank.mem_bank;
        release banks[6].base_bank.mem_bank;
        release banks[7].base_bank.mem_bank;
        release banks[8].base_bank.mem_bank;
        release banks[9].base_bank.mem_bank;
        release banks[10].base_bank.mem_bank;
        release banks[11].base_bank.mem_bank;
    end

    // // check result
    // initial begin
    //     wait(check);
    //     for (int i = 0; i < MEM_DEPTH; i++) begin
    //         assert (banks[0].base_bank.mem_bank[i] == gold_mem[i])
    //             else $display("ram=0, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[0].base_bank.mem_bank[i], gold_mem[i]);
    //         assert (banks[1].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH + i])
    //             else $display("ram=1, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[1].base_bank.mem_bank[i], gold_mem[MEM_DEPTH + i]);
    //         assert (banks[2].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*2 + i])
    //             else $display("ram=2, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[2].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*2 + i]);
    //         assert (banks[3].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*3 + i])
    //             else $display("ram=3, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[3].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*3 + i]);
    //         assert (banks[4].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*4 + i])
    //             else $display("ram=4, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[4].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*4 + i]);
    //         assert (banks[5].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*5 + i])
    //             else $display("ram=5, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[5].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*5 + i]);
    //         assert (banks[6].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*6 + i])
    //             else $display("ram=6, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[6].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*6 + i]);
    //         assert (banks[7].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*7 + i])
    //             else $display("ram=7, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[7].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*7 + i]);
    //         assert (banks[8].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*8 + i])
    //             else $display("ram=8, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[8].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*8 + i]);
    //         assert (banks[9].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*9 + i])
    //             else $display("ram=9, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[9].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*9 + i]);
    //         assert (banks[10].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*10 + i])
    //             else $display("ram=10, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[10].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*10 + i]);
    //         assert (banks[11].base_bank.mem_bank[i] == gold_mem[MEM_DEPTH*11 + i])
    //             else $display("ram=11, addr=%h, data=%10h, expected=%10h",
    //                         i, banks[11].base_bank.mem_bank[i], gold_mem[MEM_DEPTH*11 + i]);
    //     end
    // end
`endif
endmodule

module ksk_ram #(
    parameter DATA_PATH = "../../../cmod/data/",
    parameter DATA_WIDTH = 39,
    parameter ADDR_WIDTH = 12,
    parameter ADDR_WIDTH_PRE = 4,
    parameter N_BANK = 12,
    parameter N_KSK = 12,
    parameter COMMON_URAM_DELAY = 5
)(
    input                                               clk,
    input   logic   [N_BANK-1:0]                        wea,
    input   logic   [ADDR_WIDTH+ADDR_WIDTH_PRE-1:0]     addra,
    input   logic   [N_BANK-1:0][DATA_WIDTH-1:0]        dina,
    input   logic   [ADDR_WIDTH+ADDR_WIDTH_PRE-1:0]     addrb,
    output  logic   [N_BANK-1:0][DATA_WIDTH-1:0]        doutb
);

    localparam  COMMON_BRAM_DELAY = COMMON_URAM_DELAY;

    // logic   [N_KSK-1:0][N_BANK-1:0]                     wea_wide;
    // logic   [N_KSK-1:0][ADDR_WIDTH-1:0]                 addra_wide;
    // logic   [N_KSK-1:0][N_BANK-1:0][DATA_WIDTH-1:0]     dina_wide;
    // logic   [N_KSK-1:0][ADDR_WIDTH-1:0]                 addrb_wide;
    logic   [N_KSK-1:0][N_BANK-1:0][DATA_WIDTH-1:0]         doutb_wide;
    logic   [COMMON_BRAM_DELAY-1:0][ADDR_WIDTH_PRE-1:0]     ram_rd_idx;

    // rdata
    always_ff @(posedge clk) begin
        ram_rd_idx[0] <= addrb[ADDR_WIDTH+ADDR_WIDTH_PRE-1:ADDR_WIDTH];
    end

    generate
        for(genvar i = 1; i < COMMON_BRAM_DELAY; i++) begin
            always_ff @(posedge clk) begin
                ram_rd_idx[i] <= ram_rd_idx[i-1];
            end
        end
    endgenerate

    always_comb begin
        if (ram_rd_idx[COMMON_BRAM_DELAY-1] < N_KSK) begin
            doutb = doutb_wide[ram_rd_idx[COMMON_BRAM_DELAY-1]];
        end
        else begin
            doutb = doutb_wide[0];
        end
    end

    generate
        for (genvar i = 0; i < N_KSK; i++) begin : rams
            poly_ram_x12 #(
                    .COE_WIDTH(DATA_WIDTH),
                    .ADDR_WIDTH(ADDR_WIDTH),
                    .N_BANK(N_BANK),
                    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
                )
                base_buf (
                    .clk(clk),
                    .wea({N_BANK{1'b0}}),  // TODO: unused and incorrect
                    .addra(addra[ADDR_WIDTH-1:0]),  // TODO: unused and incorrect
                    .dina(dina),  // TODO: unused and incorrect
                    .addrb(addrb[ADDR_WIDTH-1:0]),
                    .doutb(doutb_wide[i])
                );
        end
    endgenerate

    /*
    initial begin
        $readmemh({DATA_PATH, "ksk/k1.txt"}, rams[0].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k2.txt"}, rams[1].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k3.txt"}, rams[2].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k4.txt"}, rams[3].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k5.txt"}, rams[4].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k6.txt"}, rams[5].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k7.txt"}, rams[6].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k8.txt"}, rams[7].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k9.txt"}, rams[8].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k10.txt"}, rams[9].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k11.txt"}, rams[10].base_buf.temp_mem);
        $readmemh({DATA_PATH, "ksk/k12.txt"}, rams[11].base_buf.temp_mem);
    end
    */
endmodule
