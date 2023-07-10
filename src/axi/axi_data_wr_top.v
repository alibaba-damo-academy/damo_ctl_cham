module axi_data_wr_top #(
    parameter AXI_ADDR_WIDTH        = 64,
    parameter AXI_DATA_WIDTH        = 512,
    parameter AXI_XFER_SIZE_WIDTH   = 32,
    parameter INCLUDE_DATA_FIFO     = 0,
    parameter DATA_WIDTH            = 39,
    parameter RAM_DELAY             = 3
)
(
    // System Signals
    input   wire    clk,
    input   wire    rst_n,

    // AXI4 Interfaces for Output Data
    output  wire                                mvp_axi_awvalid,
    input   wire                                mvp_axi_awready,
    output  wire    [AXI_ADDR_WIDTH-1:0]        mvp_axi_awaddr,
    output  wire    [7:0]                       mvp_axi_awlen,

    output  wire                                mvp_axi_wvalid,
    input   wire                                mvp_axi_wready,
    output  wire    [AXI_DATA_WIDTH-1:0]        mvp_axi_wdata,
    output  wire    [AXI_DATA_WIDTH/8-1:0]      mvp_axi_wstrb,
    output  wire                                mvp_axi_wlast,

    input   wire                                mvp_axi_bvalid,
    output  wire                                mvp_axi_bready,

    // Control Signals 
    input   wire                                i_axiwr_start,
    output  wire                                o_axiwr_done,

    input   wire    [AXI_ADDR_WIDTH-1:0]        data_ptr,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   data_size_bytes,

    // Output Data
    output  wire    [11:0]                      o_axiwr_rdaddr,
    input   wire    [4*DATA_WIDTH-1:0]          i_axiwr_rddata
);

    localparam S_IDLE = 2'd0;
    localparam S_BUF = 2'd1;
    localparam S_XFER = 2'd2;

    /* FSM begin */
    reg [1:0] state;
    reg [1:0] state_nxt;

    wire obuf_start, obuf_done;
    wire b2a_start, b2a_done;

    always @ (*) begin
        state_nxt = state;
        case (state)
            S_IDLE: begin
                if (i_axiwr_start)
                    state_nxt = S_BUF;
            end
            S_BUF: begin
                if (obuf_done)
                    state_nxt = S_XFER;
            end
            S_XFER: begin
                if (b2a_done)
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

    assign o_axiwr_done = (state == S_IDLE);
    assign obuf_start = (state_nxt == S_BUF && state == S_IDLE);
    assign b2a_start = (state_nxt == S_XFER && state == S_BUF);
    /* FSM end */
    
    wire [10:0] b2a_obuf_addr;
    wire [8*DATA_WIDTH-1:0] obuf_b2a_data;
    wire [AXI_DATA_WIDTH-1:0] data_trimmed;

    out_output_transposer #(
        .DATA_WIDTH     ( DATA_WIDTH        ),
        .URAM_DELAY     ( RAM_DELAY         )
    )
    i_output_transposer (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_obuf_reset   ( 1'b0              ),
        .i_obuf_start   ( obuf_start        ),
        .o_obuf_done    ( obuf_done         ),
        .o_obuf_addr    ( o_axiwr_rdaddr    ),
        .i_obuf_data    ( i_axiwr_rddata    ),
        .i_obuf_addr    ( b2a_obuf_addr     ),
        .o_obuf_data    ( obuf_b2a_data     )
    );

    data_trimmer #(
        .IN_WIDTH       ( DATA_WIDTH        ),
        .OUT_WIDTH      ( 64                ),
        .DATA_COUNT     ( 8                 )
    )
    i_output_trimmer (
        .trim_in        ( obuf_b2a_data     ),
        .trim_out       ( data_trimmed      )
    );

    axi_bram2axi #(
        .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH            ),
        .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH            ),
        .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_SIZE_WIDTH       ),
        .BRAM_DELAY             ( 1                         ),
        .INCLUDE_DATA_FIFO      ( INCLUDE_DATA_FIFO         )
    )
    i_bram2axi (
        .clk                    ( clk                       ),
        .rst_n                  ( rst_n                     ),
        .i_b2a_start            ( b2a_start                 ),
        .o_b2a_done             ( b2a_done                  ),
        .i_b2a_data_addr        ( data_ptr                  ),
        .i_b2a_data_size_bytes  ( data_size_bytes           ),
        .m_axi_awvalid          ( mvp_axi_awvalid           ),
        .m_axi_awready          ( mvp_axi_awready           ),
        .m_axi_awaddr           ( mvp_axi_awaddr            ),
        .m_axi_awlen            ( mvp_axi_awlen             ),
        .m_axi_wvalid           ( mvp_axi_wvalid            ),
        .m_axi_wready           ( mvp_axi_wready            ),
        .m_axi_wdata            ( mvp_axi_wdata             ),
        .m_axi_wstrb            ( mvp_axi_wstrb             ),
        .m_axi_wlast            ( mvp_axi_wlast             ),
        .m_axi_bvalid           ( mvp_axi_bvalid            ),
        .m_axi_bready           ( mvp_axi_bready            ),
        .o_b2a_rdaddr           ( b2a_obuf_addr             ),
        .i_b2a_rddata           ( data_trimmed              )
    );

endmodule
