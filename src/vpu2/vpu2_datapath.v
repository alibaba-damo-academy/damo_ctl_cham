//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: vpu2_datapath 
// Modify Date: 07/09/2021 18:50
//
// Description: VPU2 (MulAcc) datapath
//
//              din0 * extdin0 ---[ModMul]---> m0
//              din0 * extdin1 ---[ModMul]---> m1
//              din1 * extdin2 ---[ModMul]---> m2
//              din1 * extdin3 ---[ModMul]---> m3
//              m0 + m2 ---[ModAdd]---> dout0
//              m1 + m3 ---[ModAdd]---> dout1
//////////////////////////////////////////////////

`include "vpu2_defines.vh"
`include "common_defines.vh"

module vpu2_datapath #(
    parameter MOD       = 39'h40_0080_0001,
    parameter IMOD      = 40'd1099478074363, 
    parameter DWIDTH    = 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire                    i_dp_vld,

    input   wire    [2*DWIDTH-1:0]  i_dp_din,
    input   wire    [4*DWIDTH-1:0]  i_dp_extdin,
    output  wire    [2*DWIDTH-1:0]  o_dp_dout
);

    localparam MWIDTH = $clog2(MOD);

    localparam MUL_DELAY = `COMMON_MODMUL_DELAY;
    localparam MUL_VLD_SHIFT = 0;
    localparam ADD_VLD_SHIFT = MUL_DELAY;
    localparam VLD_WIDTH = MUL_DELAY + 1;


    /* split data bus begin */
    wire [DWIDTH-1:0] din_0;
    wire [DWIDTH-1:0] din_1;
    assign din_0 = i_dp_din[0*DWIDTH +: DWIDTH];
    assign din_1 = i_dp_din[1*DWIDTH +: DWIDTH];

    wire [DWIDTH-1:0] extdin_0;
    wire [DWIDTH-1:0] extdin_1;
    wire [DWIDTH-1:0] extdin_2;
    wire [DWIDTH-1:0] extdin_3;
    assign extdin_0 = i_dp_extdin[0*DWIDTH +: DWIDTH];
    assign extdin_1 = i_dp_extdin[1*DWIDTH +: DWIDTH];
    assign extdin_2 = i_dp_extdin[2*DWIDTH +: DWIDTH];
    assign extdin_3 = i_dp_extdin[3*DWIDTH +: DWIDTH];

    wire [DWIDTH-1:0] dout_0;
    wire [DWIDTH-1:0] dout_1;
    assign o_dp_dout[0*DWIDTH +: DWIDTH] = dout_0;
    assign o_dp_dout[1*DWIDTH +: DWIDTH] = dout_1;
    /* split data bus end */


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

    wire mul_vld, add_vld;
    assign mul_vld = vld[MUL_VLD_SHIFT];
    assign add_vld = vld[ADD_VLD_SHIFT];
    /* generate control signals end */


    /* instantiate modmul & modadd begin */
    wire [MWIDTH-1:0] mul_add_data_0;
    wire [MWIDTH-1:0] mul_add_data_1;
    wire [MWIDTH-1:0] mul_add_data_2;
    wire [MWIDTH-1:0] mul_add_data_3;

    modmul #(
        .MOD    ( MOD       ),
        .IMOD   ( IMOD      ),
        .MWIDTH ( MWIDTH    )
    ) i_modmul_0 (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_mul_vld      ( mul_vld           ),
        .o_mul_vldout   (                   ),
        .i_mul_din_0    ( din_0             ),
        .i_mul_din_1    ( extdin_0          ),
        .o_mul_dout     ( mul_add_data_0    )
    );

    modmul #(
        .MOD    ( MOD       ),
        .IMOD   ( IMOD      ),
        .MWIDTH ( MWIDTH    )
    ) i_modmul_1 (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_mul_vld      ( mul_vld           ),
        .o_mul_vldout   (                   ),
        .i_mul_din_0    ( din_0             ),
        .i_mul_din_1    ( extdin_1          ),
        .o_mul_dout     ( mul_add_data_1    )
    );

    modmul #(
        .MOD    ( MOD       ),
        .IMOD   ( IMOD      ),
        .MWIDTH ( MWIDTH    )
    ) i_modmul_2 (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_mul_vld      ( mul_vld           ),
        .o_mul_vldout   (                   ),
        .i_mul_din_0    ( din_1             ),
        .i_mul_din_1    ( extdin_2          ),
        .o_mul_dout     ( mul_add_data_2    )
    );

    modmul #(
        .MOD    ( MOD       ),
        .IMOD   ( IMOD      ),
        .MWIDTH ( MWIDTH    )
    ) i_modmul_3 (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_mul_vld      ( mul_vld           ),
        .o_mul_vldout   (                   ),
        .i_mul_din_0    ( din_1             ),
        .i_mul_din_1    ( extdin_3          ),
        .o_mul_dout     ( mul_add_data_3    )
    );

    modadd #(
        .MOD    ( MOD       ),
        .MWIDTH ( MWIDTH    )
    ) i_modadd_0 (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_add_vld      ( add_vld           ),
        .o_add_vldout   (                   ),
        .i_add_din_0    ( mul_add_data_0    ),
        .i_add_din_1    ( mul_add_data_2    ),
        .o_add_dout     ( dout_0            )
    );

    modadd #(
        .MOD    ( MOD       ),
        .MWIDTH ( MWIDTH    )
    ) i_modadd_1 (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_add_vld      ( add_vld           ),
        .o_add_vldout   (                   ),
        .i_add_din_0    ( mul_add_data_1    ),
        .i_add_din_1    ( mul_add_data_3    ),
        .o_add_dout     ( dout_1            )
    );
    
    generate
        if (DWIDTH > MWIDTH) begin
            assign dout_0[DWIDTH-1:MWIDTH] = 'b0;
            assign dout_1[DWIDTH-1:MWIDTH] = 'b0;
        end
    endgenerate
    /* instantiate modadd & modmul end */

endmodule
