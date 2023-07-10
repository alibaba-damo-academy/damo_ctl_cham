//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: vpu3_top 
// Modify Date: 07/15/2021 15:00
//
// Description: VPU3 (MS) top module
//              Calculate (A - C) * P^-1 mod Q.
//              Detail see specification.
//////////////////////////////////////////////////

// `include "vpu3_defines.vh"
`include "common_defines.vh"

module vpu3_top #(
    // modulus
    parameter P     = 39'h40_0080_0001,
    parameter Q0    = 35'h4_0800_0001,
    parameter Q1    = 35'h4_0008_0001,
    // inverse of modulus (for Barrett reduction)
    parameter IQ0   = 36'd68_186_767_610,
    parameter IQ1   = 36'd68_717_379_643,
    // P inverse mod Q
    parameter PIMQ0 = 35'd14_972_836_665,
    parameter PIMQ1 = 35'd8_017_516_954,
    // RAM delay
    parameter BRAM_DELAY = 1,
    // data width
    parameter DATA_WIDTH    = 39
)
(
    input   wire    clk,
    input   wire    rst_n,
    
    input   wire                        i_vpu3_start,
    output  wire                        o_vpu3_done,

    input   wire    [3:0]               i_vpu3_level,

    input   wire    [4*DATA_WIDTH-1:0]  i_vpu3_dina,
    input   wire    [2*DATA_WIDTH-1:0]  i_vpu3_dinb,
    input   wire    [2*DATA_WIDTH-1:0]  i_vpu3_dinc,
    output  wire    [4*DATA_WIDTH-1:0]  o_vpu3_dout,

    output  wire                        o_vpu3_rdena,
    output  wire                        o_vpu3_rdenb,
    output  wire                        o_vpu3_rdenc,
    output  wire                        o_vpu3_wren,
    output  wire    [7:0]               o_vpu3_wben,
    output  wire    [11:0]              o_vpu3_rdaddra,
    output  wire    [11:0]              o_vpu3_rdaddrb,
    output  wire    [11:0]              o_vpu3_rdaddrc,
    output  wire    [11:0]              o_vpu3_wraddr
);

    localparam VPU3_DELAY = BRAM_DELAY + `COMMON_MODADD_DELAY + `COMMON_MODSUBRED_DELAY + `COMMON_MODSUB_DELAY + `COMMON_MODMUL_DELAY + `COMMON_MODADD_DELAY;

    localparam VPU3_RD_BEGIN = 0;
    localparam VPU3_RDA_BEGIN = VPU3_RD_BEGIN + `COMMON_MODADD_DELAY + `COMMON_MODSUBRED_DELAY;
    localparam VPU3_RDB_BEGIN = VPU3_RD_BEGIN + `COMMON_MODADD_DELAY + `COMMON_MODSUBRED_DELAY + `COMMON_MODSUB_DELAY + `COMMON_MODMUL_DELAY;
    localparam VPU3_RDC_BEGIN = VPU3_RD_BEGIN + 0;
    localparam VPU3_WR_BEGIN = VPU3_RD_BEGIN + VPU3_DELAY;

    localparam VPU3_RD_END = VPU3_RD_BEGIN + `COMMON_DATA_LENGTH;
    localparam VPU3_RDA_END = VPU3_RDA_BEGIN + `COMMON_DATA_LENGTH;
    localparam VPU3_RDB_END = VPU3_RDB_BEGIN + `COMMON_DATA_LENGTH;
    localparam VPU3_RDC_END = VPU3_RDC_BEGIN + `COMMON_DATA_LENGTH;
    localparam VPU3_WR_END = VPU3_WR_BEGIN + `COMMON_DATA_LENGTH;

    localparam VPU3_BUSY_END = VPU3_WR_END;   // when state BUSY -> IDLE

    localparam C_RDA_BEGIN = VPU3_RDA_BEGIN;
    localparam C_RDB_BEGIN = VPU3_RDB_BEGIN;
    localparam C_RDC_BEGIN = VPU3_RDC_BEGIN;
    localparam C_WR_BEGIN = VPU3_WR_BEGIN;

    localparam C_RDA_END = VPU3_RDA_END;
    localparam C_RDB_END = VPU3_RDB_END;
    localparam C_RDC_END = VPU3_RDC_END;
    localparam C_WR_END = VPU3_WR_END;

    localparam C_BUSY_END = VPU3_BUSY_END;

    localparam S_IDLE = 1'b0;
    localparam S_BUSY = 1'b1;

    // localparam BRAM_DELAY = `COMMON_BRAM_DELAY;
    localparam ADD_DELAY = `COMMON_MODADD_DELAY;
    localparam ADD_VLD_SHIFT = BRAM_DELAY;
    localparam DP_VLD_SHIFT = BRAM_DELAY + ADD_DELAY;
    localparam VLD_WIDTH = BRAM_DELAY + ADD_DELAY + 1;
    

    reg state;
    reg state_nxt;
    reg [12:0] count;

    assign o_vpu3_done = (state == S_IDLE);


    /* FSM begin */
    always @ (*) begin
        state_nxt = state;
        case (state)
            S_IDLE: begin
                if (i_vpu3_start)
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

    
    /* BRAM interface begin */
    // modify rdaddr w.r.t. i_vpu3_level
    reg [12:0] read_offset;
    always @ (*) begin
        read_offset = 0;
        case (i_vpu3_level)
            4'd0: read_offset = 4096 - (4096 >> 0);
            4'd1: read_offset = 4096 - (4096 >> 1);
            4'd2: read_offset = 4096 - (4096 >> 2);
            4'd3: read_offset = 4096 - (4096 >> 3);
            4'd4: read_offset = 4096 - (4096 >> 4);
            4'd5: read_offset = 4096 - (4096 >> 5);
            4'd6: read_offset = 4096 - (4096 >> 6);
            4'd7: read_offset = 4096 - (4096 >> 7);
            4'd8: read_offset = 4096 - (4096 >> 8);
            4'd9: read_offset = 4096 - (4096 >> 9);
            4'd10: read_offset = 4096 - (4096 >> 10);
            4'd11: read_offset = 4096 - (4096 >> 11);
            4'd12: read_offset = 4096 - (4096 >> 12);
        endcase
    end

    assign o_vpu3_rdaddra = count - C_RDA_BEGIN + read_offset;
    assign o_vpu3_rdaddrb = count - C_RDB_BEGIN + read_offset;
    assign o_vpu3_rdaddrc = count - C_RDC_BEGIN + read_offset;
    assign o_vpu3_wraddr = count - C_WR_BEGIN + read_offset;

    assign o_vpu3_rdena = (state == S_BUSY &&
                           count >= C_RDA_BEGIN &&
                           count < C_RDA_END);
    assign o_vpu3_rdenb = (state == S_BUSY &&
                           count >= C_RDB_BEGIN &&
                           count < C_RDB_END);
    assign o_vpu3_rdenc = (state == S_BUSY &&
                           count >= C_RDC_BEGIN &&
                           count < C_RDC_END);
    assign o_vpu3_wren = (state == S_BUSY &&
                          count >= C_WR_BEGIN &&
                          count < C_WR_END);
    assign o_vpu3_wben = {8{o_vpu3_wren}};
    /* BRAM interface end */
    

    /* split data bus begin */
    wire [DATA_WIDTH-1:0] dina_0;
    wire [DATA_WIDTH-1:0] dina_1;
    wire [DATA_WIDTH-1:0] dina_2;
    wire [DATA_WIDTH-1:0] dina_3;
    assign {dina_3, dina_2, dina_1, dina_0} = i_vpu3_dina;

    wire [DATA_WIDTH-1:0] dinb_0;
    wire [DATA_WIDTH-1:0] dinb_1;
    assign {dinb_1, dinb_0} = i_vpu3_dinb;

    wire [DATA_WIDTH-1:0] dinc_0;
    wire [DATA_WIDTH-1:0] dinc_1;
    assign {dinc_1, dinc_0} = i_vpu3_dinc;

    wire [DATA_WIDTH-1:0] dout_0;
    wire [DATA_WIDTH-1:0] dout_1;
    wire [DATA_WIDTH-1:0] dout_2;
    wire [DATA_WIDTH-1:0] dout_3;
    assign o_vpu3_dout = {dout_3, dout_2, dout_1, dout_0};
    /* split data bus end */
    

    /* generate control signals begin */
    reg [VLD_WIDTH-1:0] vld_mx;
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            vld_mx <= 'b0;
        else
            vld_mx <= {vld_mx[VLD_WIDTH-2:0], o_vpu3_rdenc};
    end

    wire [VLD_WIDTH-1:0] vld;
    assign vld = {vld_mx[VLD_WIDTH-2:0], o_vpu3_rdenc};

    wire add_vld, dp_vld;
    assign add_vld = vld[ADD_VLD_SHIFT];
    assign dp_vld = vld[DP_VLD_SHIFT];
    /* generate control signals end */


    /* instantiate begin */
    wire [DATA_WIDTH-1:0] add_dp_c_0;
    wire [DATA_WIDTH-1:0] add_dp_c_1;

    modadd #(
        .MOD    ( P             ),
        .MWIDTH ( DATA_WIDTH    )
    ) i_add_0 (
        .clk            ( clk           ),
        .rst_n          ( rst_n         ),
        .i_add_vld      ( add_vld       ),
        .o_add_vldout   (               ),
        .i_add_din_0    ( dinc_0        ),
        .i_add_din_1    ( P >> 1        ),
        .o_add_dout     ( add_dp_c_0    )
    );

    modadd #(
        .MOD    ( P             ),
        .MWIDTH ( DATA_WIDTH    )
    ) i_add_1 (
        .clk            ( clk           ),
        .rst_n          ( rst_n         ),
        .i_add_vld      ( add_vld       ),
        .o_add_vldout   (               ),
        .i_add_din_0    ( dinc_1        ),
        .i_add_din_1    ( P >> 1        ),
        .o_add_dout     ( add_dp_c_1    )
    );

    vpu3_datapath #(
        .P      ( P             ),
        .MOD    ( Q0            ),
        .IMOD   ( IQ0           ),
        .PIMQ   ( PIMQ0         ),
        .DWIDTH ( DATA_WIDTH    )
    ) i_dp_0 (
        .clk            ( clk           ),
        .rst_n          ( rst_n         ),
        .i_dp_vld       ( dp_vld        ),
        .o_dp_vldout    (               ),
        .i_dp_dina      ( dina_0        ),
        .i_dp_dinb      ( dinb_0        ),
        .i_dp_dinc      ( add_dp_c_0    ),
        .o_dp_dout      ( dout_0        )
    );

    vpu3_datapath #(
        .P      ( P             ),
        .MOD    ( Q1            ),
        .IMOD   ( IQ1           ),
        .PIMQ   ( PIMQ1         ),
        .DWIDTH ( DATA_WIDTH    )
    ) i_dp_1 (
        .clk            ( clk           ),
        .rst_n          ( rst_n         ),
        .i_dp_vld       ( dp_vld        ),
        .o_dp_vldout    (               ),
        .i_dp_dina      ( dina_2        ),
        .i_dp_dinb      ( dinb_1        ),
        .i_dp_dinc      ( add_dp_c_0    ),
        .o_dp_dout      ( dout_2        )
    );

    vpu3_datapath #(
        .P      ( P             ),
        .MOD    ( Q0            ),
        .IMOD   ( IQ0           ),
        .PIMQ   ( PIMQ0         ),
        .DWIDTH ( DATA_WIDTH    )
    ) i_dp_2 (
        .clk            ( clk           ),
        .rst_n          ( rst_n         ),
        .i_dp_vld       ( dp_vld        ),
        .o_dp_vldout    (               ),
        .i_dp_dina      ( dina_1        ),
        .i_dp_dinb      ( {DATA_WIDTH{1'b0}} ),
        .i_dp_dinc      ( add_dp_c_1    ),
        .o_dp_dout      ( dout_1        )
    );

    vpu3_datapath #(
        .P      ( P             ),
        .MOD    ( Q1            ),
        .IMOD   ( IQ1           ),
        .PIMQ   ( PIMQ1         ),
        .DWIDTH ( DATA_WIDTH    )
    ) i_dp_3 (
        .clk            ( clk           ),
        .rst_n          ( rst_n         ),
        .i_dp_vld       ( dp_vld        ),
        .o_dp_vldout    (               ),
        .i_dp_dina      ( dina_3        ),
        .i_dp_dinb      ( {DATA_WIDTH{1'b0}} ),
        .i_dp_dinc      ( add_dp_c_1    ),
        .o_dp_dout      ( dout_3        )
    );
    /* instantiate end */

endmodule
