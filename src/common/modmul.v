//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: modmul 
// Modify Date: 07/13/2021 11:00
// Description: Parameterized ModMul module
//
//              Adopts Barrett reduction algorithm.
//              din_0 * din_1       ---> prod
//              prod >> (MWIDTH-1)  ---> prod_shift
//              prod_shift * IMOD   ---> mid
//              mid >> (MWIDTH-1)   ---> mid_shift
//              mid_shift * MOD     ---> estim
//              prod - estim        ---> diff
//              diff - MOD*(0/1/2)  ---> dout
//
//              funct: dout = (din_0 * din_1) % MOD
//              delay: 4 cycle(s) = `COMMON_MODMUL_DELAY
//////////////////////////////////////////////////

`include "common_defines.vh"

module modmul #(
    parameter MOD   = 39'h40_0080_0001,
    parameter IMOD  = 40'd1099478074363, 
    parameter MWIDTH= 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire    i_mul_vld,
    output  wire    o_mul_vldout,

    input   wire    [MWIDTH-1:0]  i_mul_din_0,
    input   wire    [MWIDTH-1:0]  i_mul_din_1,
    output  reg     [MWIDTH-1:0]  o_mul_dout
);

    localparam NSTAGE = `COMMON_MODMUL_DELAY;

    reg [NSTAGE:0] vld_mx; // vld minus x
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            vld_mx <= 'b0;
        else
            vld_mx <= {vld_mx[NSTAGE-1:0], i_mul_vld};
    end

    wire [NSTAGE:0] vld;
    assign vld = {vld_mx[NSTAGE-1:0], i_mul_vld};
    assign o_mul_vldout = vld[NSTAGE];


    /* pipeline stage 0 begin */
    reg [2*MWIDTH-1:0] prod;
    always @ (posedge clk) begin
        if (vld[0])
            prod <= i_mul_din_0 * i_mul_din_1;
        else
            prod <= 'b0;
    end
    /* pipeline stage 0 end */


    /* pipeline stage 1 begin */
    wire [MWIDTH:0] prod_shift;
    assign prod_shift = prod >> (MWIDTH - 1);

    reg [2*MWIDTH+1:0] mid;
    always @ (posedge clk) begin
        if (vld[1])
            mid <= prod_shift * IMOD;
        else
            mid <= 'b0;
    end
    
    reg [2*MWIDTH-1:0] prod_m1;
    always @ (posedge clk) begin
        prod_m1 <= prod;
    end
    /* pipeline stage 1 end */

    
    /* pipeline stage 2 begin */
    wire [MWIDTH:0] mid_shift;
    assign mid_shift = mid >> (MWIDTH + 1);

    reg [2*MWIDTH:0] estim;
    always @ (posedge clk) begin
        if (vld[2])
            estim <= mid_shift * MOD;
        else
            estim <= 'b0;
    end
    
    reg [2*MWIDTH-1:0] prod_m2;
    always @ (posedge clk) begin
        prod_m2 <= prod_m1;
    end
    /* pipeline stage 2 end */


    /* pipeline stage 3 begin */
    wire [2*MWIDTH-1:0] diff;
    assign diff = prod_m2 - estim;
    
    always @ (posedge clk) begin
        if (vld[3] && diff < MOD)
            o_mul_dout <= diff;
        else if (vld[3] && diff < MOD * 2)
            o_mul_dout <= diff - MOD;
        else if (vld[3] && diff >= MOD * 2)
            o_mul_dout <= diff - MOD * 2;
        else
            o_mul_dout <= 'b0;
    end
    /* pipeline stage 3 end */

endmodule
