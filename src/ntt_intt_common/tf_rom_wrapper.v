//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: tf_rom_wrapper
// Modify Date: 07/14/2021 16:10

// Description: wrapper of the twiddle factor rom
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module tf_rom_wrapper#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0,
    parameter NTT_INTT_CASE = 0,        // 0 for NTT, 1 for INTT
    parameter COMMON_BRAM_DELAY = 1
)(
    input                  clk,
    input  [10:0]          addr_tfsr,
    output [COE_WIDTH-1:0] tf_rom0,
    output [COE_WIDTH-1:0] tf_rom1,
    output [COE_WIDTH-1:0] tf_rom2,
    output [COE_WIDTH-1:0] tf_rom3
);

wire [10:0] addr_tfsr_rom0;             // address line for rom0
wire [9:0] addr_tfsr_rom1;
wire [8:0] addr_tfsr_rom2;
wire [8:0] addr_tfsr_rom3;

assign addr_tfsr_rom0 = addr_tfsr;
assign addr_tfsr_rom1 = addr_tfsr[9:0];
assign addr_tfsr_rom2 = addr_tfsr[8:0];
assign addr_tfsr_rom3 = addr_tfsr[8:0];

single_port_rom#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(11),
    .NTT_INTT_CASE(NTT_INTT_CASE),        // 0 for NTT, 1 for INTT
    .PATH(0),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
) rom0(
    .clka(clk),
    .addra(addr_tfsr_rom0),
    .douta(tf_rom0)
);

single_port_rom#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(10),
    .NTT_INTT_CASE(NTT_INTT_CASE),        // 0 for NTT, 1 for INTT
    .PATH(1),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
) rom1(
    .clka(clk),
    .addra(addr_tfsr_rom1),
    .douta(tf_rom1)
);

single_port_rom#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(9),
    .NTT_INTT_CASE(NTT_INTT_CASE),        // 0 for NTT, 1 for INTT
    .PATH(2),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
) rom2(
    .clka(clk),
    .addra(addr_tfsr_rom2),
    .douta(tf_rom2)
);

single_port_rom#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(9),
    .NTT_INTT_CASE(NTT_INTT_CASE),        // 0 for NTT, 1 for INTT
    .PATH(3),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
) rom3(
    .clka(clk),
    .addra(addr_tfsr_rom3),
    .douta(tf_rom3)
);

//invtfsr_rom0 rom0(
//    .clka(clk),
//    .addra(addr_invtfsr_rom0),
//    .douta(tf_rom0)
//);

//invtfsr_rom1 rom1(
//    .clka(clk),
//    .addra(addr_invtfsr_rom1),
//    .douta(tf_rom1)
//);

//invtfsr_rom2 rom2(
//    .clka(clk),
//    .addra(addr_invtfsr_rom2),
//    .douta(tf_rom2)
//);

//invtfsr_rom3 rom3(
//    .clka(clk),
//    .addra(addr_invtfsr_rom3),
//    .douta(tf_rom3)
//);
endmodule