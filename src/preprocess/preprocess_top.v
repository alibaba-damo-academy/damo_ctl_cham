module preprocess_top #(
    parameter DATA_WIDTH    = 39,
    parameter ADDR_WIDTH    = 12
) (
    input   wire                        clock,
    input   wire                        reset,

    input   wire                        io_i_intt_start,
    output  wire                        io_o_intt_done,
    input   wire                        io_i_vpu4_start,
    output  wire                        io_o_vpu4_done,
    input   wire                        io_i_pre_switch,
    input   wire                        io_i_mux_done,

    input   wire    [11:0]              io_i_coeff_index,

    input   wire                        io_i_dp1_wren,
    input   wire    [ADDR_WIDTH-1:0]    io_i_dp1_wraddr,
    input   wire    [6*DATA_WIDTH-1:0]  io_i_dp1_wrdata,
    input   wire    [ADDR_WIDTH-1:0]    io_i_dp1_rdaddr,
    output  wire    [6*DATA_WIDTH-1:0]  io_o_dp1_rddata,
    input   wire    [ADDR_WIDTH-1:0]    io_i_mux_rdaddr,
    output  wire    [4*DATA_WIDTH-1:0]  io_o_mux_rddata
);

    preprocess_top_chisel u_dp2_top (
        .clock              ( clock             ),
        .reset              ( reset             ),
        .io_i_intt_start    ( io_i_intt_start   ),
        .io_o_intt_done     ( io_o_intt_done    ),
        .io_i_vpu4_start    ( io_i_vpu4_start   ),
        .io_o_vpu4_done     ( io_o_vpu4_done    ),
        .io_i_pre_switch    ( io_i_pre_switch   ),
        .io_i_mux_done      ( io_i_mux_done     ),
        .io_i_coeff_index   ( io_i_coeff_index  ),
        .io_dp1_wr_5_en     ( io_i_dp1_wren     ),
        .io_dp1_wr_5_addr   ( io_i_dp1_wraddr   ),
        .io_dp1_wr_5_data   ( io_i_dp1_wrdata[5*DATA_WIDTH+39-1 : 5*DATA_WIDTH] ),
        .io_dp1_wr_4_en     ( io_i_dp1_wren     ),
        .io_dp1_wr_4_addr   ( io_i_dp1_wraddr   ),
        .io_dp1_wr_4_data   ( io_i_dp1_wrdata[4*DATA_WIDTH+39-1 : 4*DATA_WIDTH] ),
        .io_dp1_wr_3_en     ( io_i_dp1_wren     ),
        .io_dp1_wr_3_addr   ( io_i_dp1_wraddr   ),
        .io_dp1_wr_3_data   ( io_i_dp1_wrdata[3*DATA_WIDTH+35-1 : 3*DATA_WIDTH] ),
        .io_dp1_wr_2_en     ( io_i_dp1_wren     ),
        .io_dp1_wr_2_addr   ( io_i_dp1_wraddr   ),
        .io_dp1_wr_2_data   ( io_i_dp1_wrdata[2*DATA_WIDTH+35-1 : 2*DATA_WIDTH] ),
        .io_dp1_wr_1_en     ( io_i_dp1_wren     ),
        .io_dp1_wr_1_addr   ( io_i_dp1_wraddr   ),
        .io_dp1_wr_1_data   ( io_i_dp1_wrdata[1*DATA_WIDTH+35-1 : 1*DATA_WIDTH] ),
        .io_dp1_wr_0_en     ( io_i_dp1_wren     ),
        .io_dp1_wr_0_addr   ( io_i_dp1_wraddr   ),
        .io_dp1_wr_0_data   ( io_i_dp1_wrdata[0*DATA_WIDTH+35-1 : 0*DATA_WIDTH] ),
        .io_dp1_rd_5_addr   ( io_i_dp1_rdaddr   ),
        .io_dp1_rd_5_data   ( io_o_dp1_rddata[5*DATA_WIDTH+39-1 : 5*DATA_WIDTH] ),
        .io_dp1_rd_4_addr   ( io_i_dp1_rdaddr   ),
        .io_dp1_rd_4_data   ( io_o_dp1_rddata[4*DATA_WIDTH+39-1 : 4*DATA_WIDTH] ),
        .io_dp1_rd_3_addr   ( io_i_dp1_rdaddr   ),
        .io_dp1_rd_3_data   ( io_o_dp1_rddata[3*DATA_WIDTH+35-1 : 3*DATA_WIDTH] ),
        .io_dp1_rd_2_addr   ( io_i_dp1_rdaddr   ),
        .io_dp1_rd_2_data   ( io_o_dp1_rddata[2*DATA_WIDTH+35-1 : 2*DATA_WIDTH] ),
        .io_dp1_rd_1_addr   ( io_i_dp1_rdaddr   ),
        .io_dp1_rd_1_data   ( io_o_dp1_rddata[1*DATA_WIDTH+35-1 : 1*DATA_WIDTH] ),
        .io_dp1_rd_0_addr   ( io_i_dp1_rdaddr   ),
        .io_dp1_rd_0_data   ( io_o_dp1_rddata[0*DATA_WIDTH+35-1 : 0*DATA_WIDTH] ),
        .io_mux_rd_3_addr   ( io_i_mux_rdaddr   ),
        .io_mux_rd_3_data   ( io_o_mux_rddata[3*DATA_WIDTH+35-1 : 3*DATA_WIDTH] ),
        .io_mux_rd_2_addr   ( io_i_mux_rdaddr   ),
        .io_mux_rd_2_data   ( io_o_mux_rddata[2*DATA_WIDTH+35-1 : 2*DATA_WIDTH] ),
        .io_mux_rd_1_addr   ( io_i_mux_rdaddr   ),
        .io_mux_rd_1_data   ( io_o_mux_rddata[1*DATA_WIDTH+35-1 : 1*DATA_WIDTH] ),
        .io_mux_rd_0_addr   ( io_i_mux_rdaddr   ),
        .io_mux_rd_0_data   ( io_o_mux_rddata[0*DATA_WIDTH+35-1 : 0*DATA_WIDTH] )
    );

    genvar i;
    generate
        if (DATA_WIDTH > 35) begin
            for (i = 0; i < 4; i = i + 1) begin : gen_zero_35
                assign io_o_dp1_rddata[(i+1)*DATA_WIDTH-1 : i*DATA_WIDTH+35] = 'b0;
                assign io_o_mux_rddata[(i+1)*DATA_WIDTH-1 : i*DATA_WIDTH+35] = 'b0;
            end
        end
        if (DATA_WIDTH > 39) begin
            for (i = 4; i < 6; i = i + 1) begin : gen_zero_39
                assign io_o_dp1_rddata[(i+1)*DATA_WIDTH-1 : i*DATA_WIDTH+39] = 'b0;
            end
        end
    endgenerate

endmodule
