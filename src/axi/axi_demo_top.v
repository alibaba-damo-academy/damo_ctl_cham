module axi_demo_top #(
    parameter AXI_ADDR_WIDTH        = 64,
    parameter AXI_DATA_WIDTH        = 512,
    parameter AXI_XFER_SIZE_WIDTH   = 32
)
(
    // System Signals
    input   wire    clk,
    input   wire    rst_n,
    
    // AXI4 Interfaces
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

    output  wire                                mvp_axi_arvalid,
    input   wire                                mvp_axi_arready,
    output  wire    [AXI_ADDR_WIDTH-1:0]        mvp_axi_araddr,
    output  wire    [7:0]                       mvp_axi_arlen,

    input   wire                                mvp_axi_rvalid,
    output  wire                                mvp_axi_rready,
    input   wire    [AXI_DATA_WIDTH-1:0]        mvp_axi_rdata,
    input   wire                                mvp_axi_rlast,

    // Control Signals 
    input   wire                                ap_start,
    output  wire                                ap_idle,
    output  wire                                ap_done,
    output  wire                                ap_ready,

    input   wire    [AXI_ADDR_WIDTH-1:0]        ksk_ptr,
    input   wire    [AXI_ADDR_WIDTH-1:0]        pre_ptr,
    input   wire    [AXI_ADDR_WIDTH-1:0]        output_ptr,
    input   wire    [31:0]                      command,    // 0 - init, 1 - run
    input   wire    [31:0]                      level,
    input   wire    [31:0]                      index
);

    localparam S_IDLE           = 4'd0;
    localparam S_KSK_AXIRD      = 4'd2;
    localparam S_KSK_AXIWR      = 4'd4;
    localparam S_PRE_AXIRD      = 4'd10;
    localparam S_PRE_AXIRD_CONT = 4'd11;
    localparam S_PRE_AXIWR      = 4'd12;

    localparam KSK_DATA_WIDTH   = 39;
    localparam PRE_DATA_WIDTH   = 35;
    localparam DATA_WIDTH       = 39;

    localparam KSK_SIZE_BYTES = 32'h0048_0000;      // 144 polynomials
    localparam PRE_SIZE_BYTES = 32'h0008_0000;      // 16 polynomials (for test)
    // localparam PRE_SIZE_BYTES = 32'h0200_0000;      // 1024 polynomials
    localparam BATCH_SIZE_BYTES = 32'h0004_0000;    // 8 polynomials


    reg [3:0] state;
    reg [3:0] state_nxt;

    wire axird_start, axird_done, axird_alldone;
    wire axiwr_start, axiwr_done;
    

    /* FSM begin */
    always @ (*) begin
        state_nxt = state;
    
        case (state)
            S_IDLE: begin
                if (ap_start && command == 1'b0 && axird_alldone)
                    state_nxt = S_KSK_AXIRD;
                else if (ap_start && command == 1'b1 && axird_alldone)
                    state_nxt = S_PRE_AXIRD;
            end
            
            S_KSK_AXIRD: begin
                if (axird_alldone)
                    state_nxt = S_KSK_AXIWR;
            end

            S_KSK_AXIWR: begin
                if (axiwr_done)
                    state_nxt = S_IDLE;
            end

            S_PRE_AXIRD: begin
                if (axird_alldone)
                    state_nxt = S_PRE_AXIWR;
            end
            
            S_PRE_AXIWR: begin
                if (axiwr_done)
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


    /* external control signals begin */
    assign ap_idle = (state == S_IDLE);
    assign ap_done = (state_nxt == S_IDLE) && (state != S_IDLE);
    assign ap_ready = ap_done;
    /* external control signals end */


    /* internal control signals begin */
    wire axi_initstart, axird_start, axiwr_start;
    wire ksk_rd_start, ksk_wr_start, pre_rd_start, pre_wr_start;
    assign ksk_rd_start = state != S_KSK_AXIRD && state_nxt == S_KSK_AXIRD;
    assign ksk_wr_start = state != S_KSK_AXIWR && state_nxt == S_KSK_AXIWR;
    assign pre_rd_start = state != S_PRE_AXIRD && state_nxt == S_PRE_AXIRD;
    assign pre_wr_start = state != S_PRE_AXIWR && state_nxt == S_PRE_AXIWR;
    assign axird_initstart = ksk_rd_start || pre_rd_start;
    assign axiwr_start = ksk_wr_start || pre_wr_start;
    /* internal control signals end */

    
    /* data signals begin */
    wire [63:0] axird_pre_wren;
    wire [71:0] axird_pre_addr;
    wire [8*PRE_DATA_WIDTH-1:0] axird_pre_data;
    
    wire [11:0] b2a_addr;
    wire [31:0] ksk_rdaddr;
    wire [31:0] pre_rdaddr;
    assign ksk_rdaddr = {'b0, b2a_addr};
    assign pre_rdaddr = {'b0, b2a_addr};

    wire [4*DATA_WIDTH-1:0] b2a_data;
    wire [12*KSK_DATA_WIDTH-1:0] ksk_rddata;
    wire [8*PRE_DATA_WIDTH-1:0] pre_rddata;
    wire [4*DATA_WIDTH-1:0] ksk_rddata_trimmed;
    wire [4*DATA_WIDTH-1:0] pre_rddata_trimmed;
    assign b2a_data = command ? pre_rddata_trimmed : ksk_rddata_trimmed;
    // assign b2a_data = ksk_rddata_trimmed;

    data_trimmer #(
        .IN_WIDTH       ( KSK_DATA_WIDTH    ),
        .OUT_WIDTH      ( DATA_WIDTH        ),
        .DATA_COUNT     ( 4                 )
    )
    i_ksk_rddata_trimmer (
        .trim_in        ( ksk_rddata[4*KSK_DATA_WIDTH-1:0]  ),
        .trim_out       ( ksk_rddata_trimmed    )
    );

    data_trimmer #(
        .IN_WIDTH       ( PRE_DATA_WIDTH    ),
        .OUT_WIDTH      ( DATA_WIDTH        ),
        .DATA_COUNT     ( 4                 )
    )
    i_pre_rddata_trimmer (
        .trim_in        ( pre_rddata[4*PRE_DATA_WIDTH-1:0]  ),
        .trim_out       ( pre_rddata_trimmed    )
    );
    /* data signals end */


    /* input begin */
    axi_data_rd_top #(
        .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH        ),
        .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH        ),
        .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_SIZE_WIDTH   ),
        .INCLUDE_DATA_FIFO      ( 0                     ),
        .KSK_DATA_WIDTH         ( KSK_DATA_WIDTH        ),
        .PRE_DATA_WIDTH         ( PRE_DATA_WIDTH        ),
        .RAM_DELAY              ( 3                     )
    )
    i_axird_top (
        .clk                    ( clk                   ),
        .rst_n                  ( rst_n                 ),
        .mvp_axi_arvalid        ( mvp_axi_arvalid       ),
        .mvp_axi_arready        ( mvp_axi_arready       ),
        .mvp_axi_araddr         ( mvp_axi_araddr        ),
        .mvp_axi_arlen          ( mvp_axi_arlen         ),
        .mvp_axi_rvalid         ( mvp_axi_rvalid        ),
        .mvp_axi_rready         ( mvp_axi_rready        ),
        .mvp_axi_rdata          ( mvp_axi_rdata         ),
        .mvp_axi_rlast          ( mvp_axi_rlast         ),
        .i_axird_command        ( command               ),
        .i_axird_initstart      ( axird_initstart       ),
        .i_axird_start          ( axird_start           ),
        .o_axird_done           ( axird_done            ),
        .o_axird_alldone        ( axird_alldone         ),
        .ksk_ptr                ( ksk_ptr               ),
        .pre_ptr                ( pre_ptr               ),
        .ksk_size_bytes         ( KSK_SIZE_BYTES        ),
        .pre_size_bytes         ( PRE_SIZE_BYTES        ),
        .i_axird_ksk_stage      ( ksk_rdaddr[15:12]     ),
        .i_axird_ksk_rdaddr     ( ksk_rdaddr[11:0]      ),
        .o_axird_ksk_rddata     ( ksk_rddata            ),
        .o_axird_pre_wren       ( axird_pre_wren        ),
        .o_axird_pre_wraddr     ( axird_pre_addr        ),
        .o_axird_pre_wrdata     ( axird_pre_data        )
    );
    
    reg [99:0] done_mx;
    always @ (posedge clk) begin
        if (axird_start)
            done_mx <= 'b0;
        else
            done_mx <= {done_mx[98:0], axird_done};
    end
    wire axird_done_pulse;
    assign axird_done_pulse = axird_done & ~done_mx[0];
    assign axird_start = command ? axird_initstart || (~axird_done_pulse & done_mx[99]) : axird_initstart;
    /* input end */


    /* simulate preprocess pingpong buffer begin */
    pre_buffer #(
        .DATA_WIDTH     ( PRE_DATA_WIDTH    )
    )
    i_pre_buffer (
        .clk            ( clk               ),
        .rst_n          ( rst_n             ),
        .i_pre_wr_en    ( axird_pre_wren    ),
        .i_pre_wr_addr  ( axird_pre_addr    ),
        .i_pre_wr_data  ( axird_pre_data    ),
        .i_pre_rd_addr  ( pre_rdaddr        ),
        .o_pre_rd_data  ( pre_rddata        )
    );
    /* simulate preprocess pingpong buffer end */


    /* output begin */
    wire [AXI_XFER_SIZE_WIDTH-1:0] output_size;
    assign output_size = BATCH_SIZE_BYTES / 2;
    
    axi_data_wr_top #(
        .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH        ),
        .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH        ),
        .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_SIZE_WIDTH   ),
        .INCLUDE_DATA_FIFO      ( 0                     ),
        .DATA_WIDTH             ( DATA_WIDTH            ),
        .RAM_DELAY              ( 3                     )
    )
    i_axiwr_top (
        .clk                    ( clk                   ),
        .rst_n                  ( rst_n                 ),
        .mvp_axi_awvalid        ( mvp_axi_awvalid       ),
        .mvp_axi_awready        ( mvp_axi_awready       ),
        .mvp_axi_awaddr         ( mvp_axi_awaddr        ),
        .mvp_axi_awlen          ( mvp_axi_awlen         ),
        .mvp_axi_wvalid         ( mvp_axi_wvalid        ),
        .mvp_axi_wready         ( mvp_axi_wready        ),
        .mvp_axi_wdata          ( mvp_axi_wdata         ),
        .mvp_axi_wstrb          ( mvp_axi_wstrb         ),
        .mvp_axi_wlast          ( mvp_axi_wlast         ),
        .mvp_axi_bvalid         ( mvp_axi_bvalid        ),
        .mvp_axi_bready         ( mvp_axi_bready        ),
        .i_axiwr_start          ( axiwr_start           ),
        .o_axiwr_done           ( axiwr_done            ),
        .data_ptr               ( output_ptr            ),
        .data_size_bytes        ( output_size           ),
        .o_axiwr_rdaddr         ( b2a_addr              ),
        .i_axiwr_rddata         ( b2a_data              )
    );
    /* output end */

endmodule
