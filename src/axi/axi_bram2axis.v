module axi_bram2axis #(
    parameter AXI_ADDR_WIDTH        = 64,
    parameter AXI_DATA_WIDTH        = 512,
    parameter AXI_XFER_SIZE_WIDTH   = 32,
    parameter BRAM_ADDR_WIDTH       = 32,
    parameter BRAM_DATA_WIDTH       = 512,
    parameter BRAM_DELAY            = 2
)
(
    input   wire    clk,
    input   wire    rst_n,

    // Control Signals
    input   wire                                i_b2as_start,
    output  wire                                o_b2as_done,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   i_b2as_data_size_bytes,

    // AXI4-Stream Interface (wr)
    output  wire                                m_axis_tvalid,
    input   wire                                m_axis_tready,
    output  wire    [AXI_DATA_WIDTH-1:0]        m_axis_tdata,
    output  wire                                m_axis_tlast,

    // BRAM Interface (rd)
    output  wire    [BRAM_ADDR_WIDTH-1:0]       o_b2as_rdaddr,
    input   wire    [BRAM_DATA_WIDTH-1:0]       i_b2as_rddata
);

    localparam S_IDLE = 1'd0;
    localparam S_BUSY = 1'd1;


    wire [BRAM_ADDR_WIDTH:0] xfer_depth;
    assign xfer_depth = i_b2as_data_size_bytes * 8 / BRAM_DATA_WIDTH;


    /* FSM begin */
    reg state, state_nxt;

    assign o_b2as_done = (state == S_IDLE);
    
    initial state <= S_IDLE;

    always @ (*) begin
        state_nxt = state;

        case (state)
            S_IDLE: begin
                if (i_b2as_start)
                    state_nxt = S_BUSY;
            end

            S_BUSY: begin
                if (m_axis_tlast && m_axis_tvalid && m_axis_tready)
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
    /* FSM end */

    
    /* function begin */
    reg [BRAM_ADDR_WIDTH:0] addr;
    assign o_b2as_rdaddr = addr;

    // indicates whether the bram output is valid/new or not
    wire vld_mx;
    reg vld, vld_m1, vld_m2, vld_m3;

    // indicates whether the bram output is the last data
    wire last_mx;
    reg last, last_m1, last_m2, last_m3;

    // let vld & last signal coincide with the bram output
    generate
        if (BRAM_DELAY == 1) begin
            assign vld_mx = vld_m1;
            assign last_mx = last_m1;
        end
        else if (BRAM_DELAY == 2) begin
            assign vld_mx = vld_m2;
            assign last_mx = last_m2;
        end
        else begin
            assign vld_mx = vld_m3;
            assign last_mx = last_m3;
        end
    endgenerate

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            {vld_m3, vld_m2, vld_m1} <= 'b0;
            {last_m3, last_m2, last_m1} <= 'b0;
        end
        else if (state == S_BUSY) begin
            {vld_m3, vld_m2, vld_m1} <= {vld_m2, vld_m1, vld};
            {last_m3, last_m2, last_m1} <= {last_m2, last_m1, last};
        end
        else begin
            {vld_m3, vld_m2, vld_m1} <= 'b0;
            {last_m3, last_m2, last_m1} <= 'b0;
        end
    end

    // if buffer fifo is half-full, then stop reading data from bram
    wire bram_stall;
    wire fifo_full, addr_exceed;
    assign bram_stall = fifo_full | addr_exceed;
    assign addr_exceed = (addr >= xfer_depth - 1) && !(&addr);

    always @ (posedge clk) begin
        if (state == S_BUSY && ~bram_stall) begin
            addr <= addr + 1;
            vld <= 1'b1;
        end
        else if (state == S_BUSY && bram_stall) begin
            addr <= addr;
            vld <= 1'b0;
        end
        else begin
            addr <= ~'b0;
            vld <= 1'b0;
        end
    end

    // indicates whether the data going to be read is the last data
    always @ (*) begin
        if (state == S_BUSY && addr == xfer_depth - 1)
            last <= 1'b1;
        else
            last <= 1'b0;
    end

    // instantiate buffer fifo
    xpm_fifo_sync # (
        .FIFO_MEMORY_TYPE       ( "auto"                ),
        .ECC_MODE               ( "no_ecc"              ), // string; "no_ecc" or "en_ecc";
        .FIFO_WRITE_DEPTH       ( 16                    ), // positive integer
        .WRITE_DATA_WIDTH       ( BRAM_DATA_WIDTH+1     ), // positive integer
        .WR_DATA_COUNT_WIDTH    ( 4                     ), // positive integer, not used
        .PROG_FULL_THRESH       ( 8                     ), // positive integer, not used
        .FULL_RESET_VALUE       ( 0                     ), // positive integer; 0 or 1
        .USE_ADV_FEATURES       ( "1F1F"                ) , // string; "0000" to "1F1F";
        .READ_MODE              ( "fwft"                ), // string; "std" or "fwft";
        .FIFO_READ_LATENCY      ( 0                     ), // positive integer;
        .READ_DATA_WIDTH        ( AXI_DATA_WIDTH+1      ), // positive integer
        .RD_DATA_COUNT_WIDTH    ( 4                     ), // positive integer, not used
        .PROG_EMPTY_THRESH      ( 8                     ), // positive integer, not used
        .DOUT_RESET_VALUE       ( "0"                   ), // string, don't care
        .WAKEUP_TIME            ( 0                     )  // positive integer; 0 or 2;
    )
    inst_rd_xpm_fifo_sync (
        .sleep          ( 1'b0                          ),
        .rst            ( ~rst_n                        ),
        .wr_clk         ( clk                           ),
        .wr_en          ( vld_mx                        ),
        .din            ( {last_mx, i_b2as_rddata}      ),
        .full           (                               ),
        .overflow       (                               ),
        .prog_full      ( fifo_full                     ),
        .wr_data_count  (                               ),
        .almost_full    (                               ),
        .wr_ack         (                               ),
        .wr_rst_busy    (                               ),
        .rd_en          ( m_axis_tready                 ),
        .dout           ( {m_axis_tlast, m_axis_tdata}  ),
        .empty          (                               ),
        .prog_empty     (                               ),
        .rd_data_count  (                               ),
        .almost_empty   (                               ),
        .data_valid     ( m_axis_tvalid                 ),
        .underflow      (                               ),
        .rd_rst_busy    (                               ),
        .injectsbiterr  ( 1'b0                          ),
        .injectdbiterr  ( 1'b0                          ),
        .sbiterr        (                               ),
        .dbiterr        (                               )
    );

    /* function end */

endmodule
