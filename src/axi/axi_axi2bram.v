module axi_axi2bram #(
    parameter AXI_ADDR_WIDTH        = 64,
    parameter AXI_DATA_WIDTH        = 512,
    parameter AXI_XFER_SIZE_WIDTH   = 32,
    parameter BRAM_ADDR_WIDTH       = 32,
    parameter BRAM_DATA_WIDTH       = 512,
    parameter BRAM_DELAY            = 2,
    parameter INCLUDE_DATA_FIFO     = 0
)
(
    input   wire    clk,
    input   wire    rst_n,

    // Control Signals
    input   wire                                i_a2b_start,
    output  wire                                o_a2b_done,
    input   wire                                i_a2b_ready,
    input   wire    [AXI_ADDR_WIDTH-1:0]        i_a2b_data_addr,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   i_a2b_data_size_bytes,

    // AXI4 Interface (rd)
    output  wire                                m_axi_arvalid,
    input   wire                                m_axi_arready,
    output  wire    [AXI_ADDR_WIDTH-1:0]        m_axi_araddr,
    output  wire    [7:0]                       m_axi_arlen,

    input   wire                                m_axi_rvalid,
    output  wire                                m_axi_rready,
    input   wire    [AXI_DATA_WIDTH-1:0]        m_axi_rdata,
    input   wire                                m_axi_rlast,

    // BRAM Interface (wr)
    output  wire                                o_a2b_wren,
    output  wire    [BRAM_ADDR_WIDTH-1:0]       o_a2b_wraddr,
    output  wire    [BRAM_DATA_WIDTH-1:0]       o_a2b_wrdata
);

    wire [AXI_XFER_SIZE_WIDTH-1:0] data_size_bytes;
    assign data_size_bytes = i_a2b_data_size_bytes;

    wire rd_tvalid, rd_tready, rd_tlast;
    wire [AXI_DATA_WIDTH-1:0] rd_tdata;
    
    axi_read_master #(
        .C_M_AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH            ),
        .C_M_AXI_DATA_WIDTH     ( AXI_DATA_WIDTH            ),
        .C_XFER_SIZE_WIDTH      ( AXI_XFER_SIZE_WIDTH       ),
        .C_INCLUDE_DATA_FIFO    ( INCLUDE_DATA_FIFO         )
    )
    i_axi_read_master (
        .aclk                   ( clk                       ),
        .areset                 ( ~rst_n                    ),
        .ctrl_start             ( i_a2b_start               ),
        .ctrl_done              (                           ),
        .ctrl_addr_offset       ( i_a2b_data_addr           ),
        .ctrl_xfer_size_in_bytes( data_size_bytes           ),
        .m_axi_arvalid          ( m_axi_arvalid             ),
        .m_axi_arready          ( m_axi_arready             ),
        .m_axi_araddr           ( m_axi_araddr              ),
        .m_axi_arlen            ( m_axi_arlen               ),
        .m_axi_rvalid           ( m_axi_rvalid              ),
        .m_axi_rready           ( m_axi_rready              ),
        .m_axi_rdata            ( m_axi_rdata               ),
        .m_axi_rlast            ( m_axi_rlast               ),
        .m_axis_tvalid          ( rd_tvalid                 ),
        .m_axis_tready          ( rd_tready                 ),
        .m_axis_tlast           ( rd_tlast                  ),
        .m_axis_tdata           ( rd_tdata                  )
    );

    axi_axis2bram #(
        .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH            ),
        .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH            ),
        .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_SIZE_WIDTH       ),
        .BRAM_ADDR_WIDTH        ( BRAM_ADDR_WIDTH           ),
        .BRAM_DATA_WIDTH        ( BRAM_DATA_WIDTH           ),
        .BRAM_DELAY             ( BRAM_DELAY                )
    )
    i_axis2bram(
        .clk                    ( clk                       ),
        .rst_n                  ( rst_n                     ),
        .i_as2b_start           ( i_a2b_start               ),
        .o_as2b_done            ( o_a2b_done                ),
        .i_as2b_ready           ( i_a2b_ready               ),
        .i_as2b_data_size_bytes ( data_size_bytes           ),
        .s_axis_tvalid          ( rd_tvalid                 ),
        .s_axis_tready          ( rd_tready                 ),
        .s_axis_tdata           ( rd_tdata                  ),
        .s_axis_tlast           ( rd_tlast                  ),
        .o_as2b_wren            ( o_a2b_wren                ),
        .o_as2b_wraddr          ( o_a2b_wraddr              ),
        .o_as2b_wrdata          ( o_a2b_wrdata              )
    );

endmodule
