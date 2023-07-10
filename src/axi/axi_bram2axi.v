module axi_bram2axi #(
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
    input   wire                                i_b2a_start,
    output  wire                                o_b2a_done,
    input   wire    [AXI_ADDR_WIDTH-1:0]        i_b2a_data_addr,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   i_b2a_data_size_bytes,

    // AXI4 Interface (wr)
    output  wire                                m_axi_awvalid,
    input   wire                                m_axi_awready,
    output  wire    [AXI_ADDR_WIDTH-1:0]        m_axi_awaddr,
    output  wire    [7:0]                       m_axi_awlen,

    output  wire                                m_axi_wvalid,
    input   wire                                m_axi_wready,
    output  wire    [AXI_DATA_WIDTH-1:0]        m_axi_wdata,
    output  wire    [AXI_DATA_WIDTH/8-1:0]      m_axi_wstrb,
    output  wire                                m_axi_wlast,

    input   wire                                m_axi_bvalid,
    output  wire                                m_axi_bready,

    // BRAM Interface (rd)
    output  wire    [BRAM_ADDR_WIDTH-1:0]       o_b2a_rdaddr,
    input   wire    [BRAM_DATA_WIDTH-1:0]       i_b2a_rddata
);

    wire [AXI_XFER_SIZE_WIDTH-1:0] data_size_bytes;
    assign data_size_bytes = i_b2a_data_size_bytes;

    wire wr_tvalid, wr_tready;
    wire [AXI_DATA_WIDTH-1:0] wr_tdata;
    
    axi_bram2axis #(
        .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH            ),
        .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH            ),
        .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_SIZE_WIDTH       ),
        .BRAM_ADDR_WIDTH        ( BRAM_ADDR_WIDTH           ),
        .BRAM_DATA_WIDTH        ( BRAM_DATA_WIDTH           ),
        .BRAM_DELAY             ( BRAM_DELAY                )
    )
    i_bram2axis(
        .clk                    ( clk                       ),
        .rst_n                  ( rst_n                     ),
        .i_b2as_start           ( i_b2a_start               ),
        .o_b2as_done            (                           ),
        .i_b2as_data_size_bytes ( data_size_bytes           ),
        .m_axis_tvalid          ( wr_tvalid                 ),
        .m_axis_tready          ( wr_tready                 ),
        .m_axis_tdata           ( wr_tdata                  ),
        .m_axis_tlast           (                           ),
        .o_b2as_rdaddr          ( o_b2a_rdaddr              ),
        .i_b2as_rddata          ( i_b2a_rddata              )
    );
    
    axi_write_master #(
        .C_M_AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH            ),
        .C_M_AXI_DATA_WIDTH     ( AXI_DATA_WIDTH            ),
        .C_XFER_SIZE_WIDTH      ( AXI_XFER_SIZE_WIDTH       ),
        .C_INCLUDE_DATA_FIFO    ( INCLUDE_DATA_FIFO         )
    )
    i_axi_write_master (
        .aclk                   ( clk                       ),
        .areset                 ( ~rst_n                    ),
        .ctrl_start             ( i_b2a_start               ),
        .ctrl_done              ( o_b2a_done                ),
        .ctrl_addr_offset       ( i_b2a_data_addr           ),
        .ctrl_xfer_size_in_bytes( data_size_bytes           ),
        .m_axi_awvalid          ( m_axi_awvalid             ),
        .m_axi_awready          ( m_axi_awready             ),
        .m_axi_awaddr           ( m_axi_awaddr              ),
        .m_axi_awlen            ( m_axi_awlen               ),
        .m_axi_wvalid           ( m_axi_wvalid              ),
        .m_axi_wready           ( m_axi_wready              ),
        .m_axi_wdata            ( m_axi_wdata               ),
        .m_axi_wstrb            ( m_axi_wstrb               ),
        .m_axi_wlast            ( m_axi_wlast               ),
        .m_axi_bvalid           ( m_axi_bvalid              ),
        .m_axi_bready           ( m_axi_bready              ),
        // .s_axis_aclk            (                           ),
        // .s_axis_areset          (                           ),
        .s_axis_tvalid          ( wr_tvalid                 ),
        .s_axis_tready          ( wr_tready                 ),
        .s_axis_tdata           ( wr_tdata                  )
    );

endmodule
