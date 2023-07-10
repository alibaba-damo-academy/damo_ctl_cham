//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: modsubred
// Modify Date: 07/14/2021 14:30
// Description: Parameterized ModSub -> ModReduce module
//
//              Specially designed to deal with the case that
//              the operands and the result
//              are in different modular classes.
//
//              To be more specific,
//              din_0 and din_1 are w.r.t. modulus P,
//              dout is w.r.t. modulus Q0 or Q1 (MOD).
//
//              function: dout = (din_0 - din_1) % MOD
//              delay: 2 cycle(s) = `COMMON_MODSUBRED_DELAY
//////////////////////////////////////////////////

`include "common_defines.vh"

module modsubred #(
    parameter MOD   = 35'h4_0008_0001
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire    i_sub_vld,
    output  wire    o_sub_vldout,

    input   wire    [38:0]  i_sub_din_0,
    input   wire    [38:0]  i_sub_din_1,
    output  reg     [34:0]  o_sub_dout
);

    localparam NSTAGE = `COMMON_MODSUBRED_DELAY;

    reg [NSTAGE:0] vld_mx; // vld minus x
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            vld_mx <= 'b0;
        else
            vld_mx <= {vld_mx[NSTAGE-1:0], i_sub_vld};
    end

    wire [NSTAGE:0] vld;
    assign vld = {vld_mx[NSTAGE-1:0], i_sub_vld};
    assign o_sub_vldout = vld[NSTAGE];


    /* pipeline stage 0 begin */
    wire [38:0] a_minus_b;
    wire [38:0] b_minus_a;
    assign a_minus_b = i_sub_din_0 - i_sub_din_1;
    assign b_minus_a = i_sub_din_1 - i_sub_din_0;

    wire a_geq_b;
    assign a_geq_b = i_sub_din_0 >= i_sub_din_1;

    reg [38:0] diff;
    always @ (posedge clk) begin
        if (vld[0])
            diff <= a_minus_b;
        else
            diff <= 'b0;
    end
    
    reg geq;
    always @ (posedge clk) begin
        if (vld[0])
            geq <= a_geq_b;
        else
            geq <= 'b0;
    end

    wire [38:0] d;
    assign d = a_geq_b ? a_minus_b : b_minus_a;

    // partial product = mask ? (mod << n) : ('b0)
    wire [38:0] pp0;
    wire [38:0] pp1;
    wire [38:0] pp2;
    wire [38:0] pp3;
    wire [38:0] pp4;
    assign pp0 = d[34] ? MOD : 'b0;
    assign pp1 = d[35] ? MOD << 1 : 'b0;
    assign pp2 = d[36] ? MOD << 2 : 'b0;
    assign pp3 = d[37] ? MOD << 3 : 'b0;
    assign pp4 = d[38] ? MOD << 4 : 'b0;

    reg [38:0] d_estim;
    always @ (posedge clk) begin
        if (vld[0])
            d_estim <= pp0 | pp1 | pp2 | pp3 | pp4;
        else
            d_estim <= 'b0;
    end
    /* pipeline stage 0 end */


    /* pipeline stage 1 begin */
    wire [38:0] z;
    assign z = geq ? (diff - d_estim) : (diff + d_estim);

    always @ (posedge clk) begin
        if (vld[1] && z >= MOD)
            o_sub_dout <= z + MOD;
        else if (vld[1] && z < MOD)
            o_sub_dout <= z;
        else
            o_sub_dout <= 'b0;
    end
    /* pipeline stage 1 end */

endmodule
