//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: vpu2_top 
// Modify Date: 07/09/2021 18:50
//
// Description: VPU2 (MulAcc) top module
//
//              Responsible for state control
//              and rd/wr address generation.
//
//              Contains three similar datapaths
//              which differ only in modulus.
//////////////////////////////////////////////////

// `include "vpu2_defines.vh"
`include "common_defines.vh"

module vpu2_top #(
    // modulus
    parameter P     = 39'h40_0080_0001, // aka modulus for bottom datapath
    parameter Q0    = 35'h4_0800_0001,  // aka modulus for top datapath
    parameter Q1    = 35'h4_0008_0001,  // aka modulus for mid datapath
    // inverse of modulus (for Barrett reduction)
    parameter IP    = 40'd1099478074363,
    parameter IQ0   = 36'd68186767610,
    parameter IQ1   = 36'd68717379643,
    // RAM delay
    parameter BRAM_DELAY = 1,
    parameter URAM_DELAY = 4,
    // data width
    parameter DATA_WIDTH    = 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire                        i_vpu2_start,
    output  wire                        o_vpu2_done,

    input   wire    [6*DATA_WIDTH-1:0]  i_vpu2_din,
    input   wire    [12*DATA_WIDTH-1:0] i_vpu2_extdin,
    output  wire    [6*DATA_WIDTH-1:0]  o_vpu2_dout,

    output  wire                        o_vpu2_rden,
    output  wire                        o_vpu2_wren,
    output  wire    [11:0]              o_vpu2_rdaddr,
    output  wire    [11:0]              o_vpu2_wraddr
);

    localparam VPU2_DELAY = URAM_DELAY + `COMMON_MODMUL_DELAY + `COMMON_MODADD_DELAY;

    localparam VPU2_RD_BEGIN = 0;
    localparam VPU2_WR_BEGIN = VPU2_RD_BEGIN + VPU2_DELAY;

    localparam VPU2_RD_END = VPU2_RD_BEGIN + `COMMON_DATA_LENGTH;
    localparam VPU2_WR_END = VPU2_WR_BEGIN + `COMMON_DATA_LENGTH;

    localparam VPU2_BUSY_END = VPU2_WR_END;   // when state BUSY -> IDLE

    localparam C_RD_BEGIN = VPU2_RD_BEGIN;
    localparam C_WR_BEGIN = VPU2_WR_BEGIN;
    localparam C_RD_END = VPU2_RD_END;
    localparam C_WR_END = VPU2_WR_END;
    localparam C_BUSY_END = VPU2_BUSY_END;

    localparam S_IDLE = 1'b0;
    localparam S_BUSY = 1'b1;

    // localparam BRAM_DELAY = `COMMON_BRAM_DELAY;  // Bug
    // localparam URAM_DELAY = `COMMON_URAM_DELAY;  // Bug
    localparam DP_VLD_SHIFT = URAM_DELAY;
    localparam VLD_WIDTH = URAM_DELAY + 1;


    reg state;
    reg state_nxt;
    reg [12:0] count;

    assign o_vpu2_done = (state == S_IDLE);
    assign o_vpu2_rdaddr = count - C_RD_BEGIN;
    assign o_vpu2_wraddr = count - C_WR_BEGIN;
    assign o_vpu2_rden = (state == S_BUSY &&
                          count >= C_RD_BEGIN &&
                          count < C_RD_END);
    assign o_vpu2_wren = (state == S_BUSY &&
                          count >= C_WR_BEGIN &&
                          count < C_WR_END);


    /* FSM begin */
    always @ (*) begin
        state_nxt = state;
        case (state)
            S_IDLE: begin
                if (i_vpu2_start)
                    state_nxt = S_BUSY;
            end
            S_BUSY: begin
                if (count == C_BUSY_END)
                    state_nxt = S_IDLE;
            end
        endcase
    end

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            state <= S_IDLE;
        else
            state <= state_nxt;
    end

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            count <= 13'd0;
        else if (state == S_BUSY)
            count <= count + 1;
        else
            count <= 13'd0;
    end
    /* FSM end */


    /* split data bus begin */
    localparam DIN_MX_WIDTH = (URAM_DELAY-BRAM_DELAY) * 6 * DATA_WIDTH;
    localparam DIN_MX_SHIFT = (URAM_DELAY-BRAM_DELAY-1) * 6 * DATA_WIDTH;
    reg [DIN_MX_WIDTH-1:0] din_mx;
    always @ (posedge clk) begin
        din_mx <= {i_vpu2_din, din_mx[DIN_MX_WIDTH-1 -: DIN_MX_SHIFT]};
    end

    wire [DATA_WIDTH-1:0] din_0;
    wire [DATA_WIDTH-1:0] din_1;
    wire [DATA_WIDTH-1:0] din_2;
    wire [DATA_WIDTH-1:0] din_3;
    wire [DATA_WIDTH-1:0] din_4;
    wire [DATA_WIDTH-1:0] din_5;
    assign {din_5, din_4, din_3, din_2, din_1, din_0} =
           din_mx[0 +: 6*DATA_WIDTH];

    wire [DATA_WIDTH-1:0] extdin_0;
    wire [DATA_WIDTH-1:0] extdin_1;
    wire [DATA_WIDTH-1:0] extdin_2;
    wire [DATA_WIDTH-1:0] extdin_3;
    wire [DATA_WIDTH-1:0] extdin_4;
    wire [DATA_WIDTH-1:0] extdin_5;
    wire [DATA_WIDTH-1:0] extdin_6;
    wire [DATA_WIDTH-1:0] extdin_7;
    wire [DATA_WIDTH-1:0] extdin_8;
    wire [DATA_WIDTH-1:0] extdin_9;
    wire [DATA_WIDTH-1:0] extdin_10;
    wire [DATA_WIDTH-1:0] extdin_11;
    assign {extdin_11, extdin_10, extdin_9, 
            extdin_8, extdin_7, extdin_6,
            extdin_5, extdin_4, extdin_3,
            extdin_2, extdin_1, extdin_0} = i_vpu2_extdin;

    wire [DATA_WIDTH-1:0] dout_0;
    wire [DATA_WIDTH-1:0] dout_1;
    wire [DATA_WIDTH-1:0] dout_2;
    wire [DATA_WIDTH-1:0] dout_3;
    wire [DATA_WIDTH-1:0] dout_4;
    wire [DATA_WIDTH-1:0] dout_5;
    assign o_vpu2_dout = {dout_5, dout_4, dout_3, dout_2, dout_1, dout_0};
    /* split data bus end */


    /* generate control signals begin */
    reg [VLD_WIDTH-1:0] vld_mx;
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            vld_mx <= 'b0;
        else
            vld_mx <= {vld_mx[VLD_WIDTH-2:0], o_vpu2_rden};
    end

    wire [VLD_WIDTH-1:0] vld;
    assign vld = {vld_mx[VLD_WIDTH-2:0], o_vpu2_rden};

    wire dp_vld;
    assign dp_vld = vld[DP_VLD_SHIFT];
    /* generate control signals end */


    /* instantiate datapath begin */
    vpu2_datapath #(
        .MOD            ( Q0            ),
        .IMOD           ( IQ0           ),
        .DWIDTH         ( DATA_WIDTH    )
    ) i_dp_top (
        .clk            ( clk                                       ),
        .rst_n          ( rst_n                                     ),
        .i_dp_vld       ( dp_vld                                    ),
        .i_dp_din       ( {din_1, din_0}                            ),
        .i_dp_extdin    ( {extdin_3, extdin_2, extdin_1, extdin_0}  ),
        .o_dp_dout      ( {dout_1, dout_0}                          )
    );

    vpu2_datapath #(
        .MOD            ( Q1            ),
        .IMOD           ( IQ1           ),
        .DWIDTH         ( DATA_WIDTH    )
    ) i_dp_mid (
        .clk            ( clk                                       ),
        .rst_n          ( rst_n                                     ),
        .i_dp_vld       ( dp_vld                                    ),
        .i_dp_din       ( {din_3, din_2}                            ),
        .i_dp_extdin    ( {extdin_7, extdin_6, extdin_5, extdin_4}  ),
        .o_dp_dout      ( {dout_3, dout_2}                          )
    );

    vpu2_datapath #(
        .MOD            ( P             ),
        .IMOD           ( IP            ),
        .DWIDTH         ( DATA_WIDTH    )
    ) i_dp_bot (
        .clk            ( clk                                       ),
        .rst_n          ( rst_n                                     ),
        .i_dp_vld       ( dp_vld                                    ),
        .i_dp_din       ( {din_5, din_4}                            ),
        .i_dp_extdin    ( {extdin_11, extdin_10, extdin_9, extdin_8}),
        .o_dp_dout      ( {dout_5, dout_4}                          )
    );
    /* instantiate datapath end */

endmodule
