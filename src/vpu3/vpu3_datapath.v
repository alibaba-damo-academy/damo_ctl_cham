//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: vpu3_datapath
// Modify Date: 07/14/2021 15:30
// 
// Description: VPU3 (MS) datapath
//              Function see specification.
//////////////////////////////////////////////////

`include "vpu3_defines.vh"
`include "common_defines.vh"

module vpu3_datapath #(
    parameter P         = 39'h40_0080_0001,

    parameter MOD       = 35'h4_0008_0001,
    parameter IMOD      = 36'd68_717_379_643,
    parameter PIMQ      = 35'd8_017_516_954,

    parameter DWIDTH    = 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire                    i_dp_vld,
    output  wire                    o_dp_vldout,

    input   wire    [DWIDTH-1:0]    i_dp_dina,
    input   wire    [DWIDTH-1:0]    i_dp_dinb,
    input   wire    [DWIDTH-1:0]    i_dp_dinc,
    output  wire    [DWIDTH-1:0]    o_dp_dout
);

    localparam MWIDTH = $clog2(MOD);

    localparam SUBRED_DELAY = `COMMON_MODSUBRED_DELAY;
    localparam SUB_DELAY = `COMMON_MODSUB_DELAY;
    localparam MUL_DELAY = `COMMON_MODMUL_DELAY;
    localparam ADD_DELAY = `COMMON_MODADD_DELAY;

    localparam SUBRED_VLD_SHIFT = 0;
    localparam SUB_VLD_SHIFT = SUBRED_DELAY;
    localparam MUL_VLD_SHIFT = SUBRED_DELAY + SUB_DELAY;
    localparam ADD_VLD_SHIFT = SUBRED_DELAY + SUB_DELAY + MUL_DELAY;

    localparam VLD_WIDTH = SUBRED_DELAY + SUB_DELAY + MUL_DELAY+ 1;


    /* generate control signals begin */
    reg [VLD_WIDTH-1:0] vld_mx;
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            vld_mx <= 'b0;
        else
            vld_mx <= {vld_mx[VLD_WIDTH-2:0], i_dp_vld};
    end

    wire [VLD_WIDTH-1:0] vld;
    assign vld = {vld_mx[VLD_WIDTH-2:0], i_dp_vld};

    wire subred_vld, sub_vld, mul_vld, add_vld;
    assign subred_vld = vld[SUBRED_VLD_SHIFT];
    assign sub_vld = vld[SUB_VLD_SHIFT];
    assign mul_vld = vld[MUL_VLD_SHIFT];
    assign add_vld = vld[ADD_VLD_SHIFT];
    /* generate control signals end */


    /* instantiate SubRed + Sub + Mul + Add begin */
    wire [MWIDTH-1:0] subred_sub_data;
    wire [MWIDTH-1:0] sub_mul_data;
    wire [MWIDTH-1:0] mul_add_data;

    modsubred #(
        .MOD    ( MOD       )
    ) i_modsubred (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_sub_vld      ( subred_vld        ),
        .o_sub_vldout   (                   ),
        .i_sub_din_0    ( i_dp_dinc         ),
        .i_sub_din_1    ( P >> 1            ),
        .o_sub_dout     ( subred_sub_data   )
    );

    modsub #(
        .MOD    ( MOD       ),
        .MWIDTH ( MWIDTH    )
    ) i_modsub (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_sub_vld      ( sub_vld           ),
        .o_sub_vldout   (                   ),
        .i_sub_din_0    ( i_dp_dina         ),
        .i_sub_din_1    ( subred_sub_data   ),
        .o_sub_dout     ( sub_mul_data      )
    );
    
    modmul #(
        .MOD    ( MOD       ),
        .IMOD   ( IMOD      ), 
        .MWIDTH ( MWIDTH    )
    ) i_modmul (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_mul_vld      ( mul_vld           ),
        .o_mul_vldout   (                   ),
        .i_mul_din_0    ( sub_mul_data      ),
        .i_mul_din_1    ( PIMQ              ),
        .o_mul_dout     ( mul_add_data      )
    );

    modadd #(
        .MOD    ( MOD       ),
        .MWIDTH ( MWIDTH    )
    ) i_modadd (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_add_vld      ( add_vld           ),
        .o_add_vldout   (                   ),
        .i_add_din_0    ( mul_add_data      ),
        .i_add_din_1    ( i_dp_dinb         ),
        .o_add_dout     ( o_dp_dout         )
    );

    generate
        if (DWIDTH > MWIDTH) begin
            assign o_dp_dout[DWIDTH-1:MWIDTH] = 'b0;
        end
    endgenerate
    /* instantiate SubRed + Sub + Mul + Add end */

endmodule
