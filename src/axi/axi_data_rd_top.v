module axi_data_rd_top #(
    parameter AXI_ADDR_WIDTH        = 64,
    parameter AXI_DATA_WIDTH        = 512,
    parameter AXI_XFER_SIZE_WIDTH   = 32,
    parameter INCLUDE_DATA_FIFO     = 0,
    parameter KSK_DATA_WIDTH        = 39,
    parameter PRE_DATA_WIDTH        = 35,
    parameter RAM_DELAY             = 3
)
(
    // System Signals
    input   wire    clk,
    input   wire    rst_n,
    
    // AXI4 Interfaces for Input Data
    output  wire                                mvp_axi_arvalid,
    input   wire                                mvp_axi_arready,
    output  wire    [AXI_ADDR_WIDTH-1:0]        mvp_axi_araddr,
    output  wire    [7:0]                       mvp_axi_arlen,

    input   wire                                mvp_axi_rvalid,
    output  wire                                mvp_axi_rready,
    input   wire    [AXI_DATA_WIDTH-1:0]        mvp_axi_rdata,
    input   wire                                mvp_axi_rlast,

    // Control Signals 
    input   wire    [31:0]                      i_axird_command,    // 0 - init, 1 - run
    input   wire                                i_axird_initstart,
    input   wire                                i_axird_start,
    output  wire                                o_axird_done,
    output  wire                                o_axird_alldone,

    input   wire    [AXI_ADDR_WIDTH-1:0]        ksk_ptr,
    input   wire    [AXI_ADDR_WIDTH-1:0]        mat_ptr,
    input   wire    [AXI_ADDR_WIDTH-1:0]        vec_ptr,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   ksk_size_bytes,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   mat_size_bytes,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   vec_size_bytes,
    input   wire    [14:0]                      data_size_batches, //1 more bit for vec_size

    // KSK Data
    input   wire    [3:0]                       i_axird_ksk_stage,
    input   wire    [11:0]                      i_axird_ksk_rdaddr, // every addr contains 1 data from each uram, 12 in total
    output  wire    [12*KSK_DATA_WIDTH-1:0]     o_axird_ksk_rddata,

    // Preprocess Data
    output  wire    [47:0]                      o_axird_pre_wren,   // p5b7 ~ p0b7 ~ p0b0 : p = polyn, b = bank = 1/8 polyn
    output  wire    [71:0]                      o_axird_pre_wraddr, // 9 * 8
    output  wire    [8*PRE_DATA_WIDTH-1:0]      o_axird_pre_wrdata  // 35/39 * 8
);

    localparam S_IDLE       = 2'd0;
    localparam S_KSK        = 2'd1;
    localparam S_PRE_XFER   = 2'd2;
    localparam S_PRE_HALT   = 2'd3;

    localparam BATCH_SIZE_BYTES = 32'h00030000; // 6 polynomials

    wire a2b_wren;
    wire ksk_wren;
    wire ibuf_wren;
    assign ksk_wren = ~i_axird_command & a2b_wren;
    assign ibuf_wren = i_axird_command & a2b_wren;

    wire [31:0] a2b_addr;
    wire [31:0] ksk_wraddr;
    wire [31:0] ibuf_addr;
    reg  [14:0] count_batch;
    assign ksk_wraddr = a2b_addr;
    assign ibuf_addr = a2b_addr - count_batch * 12'hc00;
    
    wire [AXI_DATA_WIDTH-1:0] a2b_data;
    wire [AXI_DATA_WIDTH-1:0] ksk_wrdata;
    wire [AXI_DATA_WIDTH-1:0] ibuf_din;
    assign ksk_wrdata = a2b_data;
    assign ibuf_din = a2b_data;

    // init (command = 0): axi -> axi2bram -> ksk buffer
    // run  (command = 1): axi -> axi2bram -> input transposer -> pre buffer
    wire a2b_done, ibuf_done;
    
    reg [1:0] state;
    reg [1:0] state_nxt;
    
    //wire [11:0] data_size_batches; //1 more bit for vec_size
    //assign data_size_batches = (mat_size_bytes + vec_size_bytes) / BATCH_SIZE_BYTES;
    //wire [13:0] data_size_batches; //1 more bit for vec_size；2 more bits for longvec
    //assign data_size_batches = (mat_size_bytes + vec_size_bytes) / BATCH_SIZE_BYTES;
    
    always @ (*) begin
        state_nxt <= state;
        
        case (state)
            S_IDLE: begin
                if (i_axird_command == 1'b0 && i_axird_initstart)
                    state_nxt <= S_KSK;
                else if (i_axird_command == 1'b1 && i_axird_initstart)
                    state_nxt <= S_PRE_XFER;
            end
            
            S_KSK: begin
                if (a2b_done)
                    state_nxt <= S_IDLE;
            end
            
            S_PRE_XFER: begin
                if (ibuf_addr == 12'hbff && a2b_wren)
                    state_nxt <= S_PRE_HALT;
            end
            
            S_PRE_HALT: begin
                if (count_batch == data_size_batches && ibuf_done)
                    state_nxt <= S_IDLE;
                else if (i_axird_start)
                    state_nxt <= S_PRE_XFER;
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
        if (~rst_n) begin
            count_batch <= 'b0;
        end
        else if (state == S_PRE_XFER && state_nxt == S_PRE_HALT) begin
            count_batch <= count_batch + 1;
        end
        else if (state == S_IDLE || state == S_KSK) begin
            count_batch <= 'b0;
        end
    end

    wire o_axird_done_w;
    reg  o_axird_done_r; 
    assign o_axird_done_w = i_axird_command ? 
                            (state == S_IDLE || state == S_PRE_HALT && ibuf_done) :
                            (state == S_IDLE);
    assign o_axird_done = o_axird_done_r;
    assign o_axird_alldone = (state == S_IDLE);

    always @ (posedge clk or negedge rst_n)
        if (~rst_n)
            o_axird_done_r <= 1'b1;
        else if(i_axird_start | i_axird_initstart)
            o_axird_done_r <= 1'b0;
        else if(o_axird_done_w)
            o_axird_done_r <= 1'b1;

    /* instantiate axi2bram begin */
    wire [AXI_ADDR_WIDTH-1:0] input_ptr;
    wire [AXI_XFER_SIZE_WIDTH-1:0] input_size;
    assign input_ptr = i_axird_command ? vec_ptr : ksk_ptr; //assume mat is directly after vec
    assign input_size = i_axird_command ? (vec_size_bytes + mat_size_bytes) : ksk_size_bytes;
    
    wire a2b_ready;
    assign a2b_ready = i_axird_command ? (state == S_PRE_XFER) : 1'b1;

    axi_axi2bram #(
        .AXI_ADDR_WIDTH         ( AXI_ADDR_WIDTH            ),
        .AXI_DATA_WIDTH         ( AXI_DATA_WIDTH            ),
        .AXI_XFER_SIZE_WIDTH    ( AXI_XFER_SIZE_WIDTH       ),
        .BRAM_DELAY             ( RAM_DELAY                 ),
        .INCLUDE_DATA_FIFO      ( INCLUDE_DATA_FIFO         )
    )
    i_axi2bram (
        .clk                    ( clk                       ),
        .rst_n                  ( rst_n                     ),
        .i_a2b_start            ( i_axird_initstart         ),
        .o_a2b_done             ( a2b_done                  ),
        .i_a2b_ready            ( a2b_ready                 ),
        .i_a2b_data_addr        ( input_ptr                 ),
        .i_a2b_data_size_bytes  ( input_size                ),
        .m_axi_arvalid          ( mvp_axi_arvalid           ),
        .m_axi_arready          ( mvp_axi_arready           ),
        .m_axi_araddr           ( mvp_axi_araddr            ),
        .m_axi_arlen            ( mvp_axi_arlen             ),
        .m_axi_rvalid           ( mvp_axi_rvalid            ),
        .m_axi_rready           ( mvp_axi_rready            ),
        .m_axi_rdata            ( mvp_axi_rdata             ),
        .m_axi_rlast            ( mvp_axi_rlast             ),
        .o_a2b_wren             ( a2b_wren                  ),
        .o_a2b_wraddr           ( a2b_addr                  ),
        .o_a2b_wrdata           ( a2b_data                  )
    );
    /* instantiate axi2bram end */


    /* instantiate ksk buffer begin */
    wire [8*KSK_DATA_WIDTH-1:0] ksk_wrdata_trim; // trimmed write data

    wire [3:0] ksk_wr_stage;
    wire [3:0] ksk_wr_index;
    wire [8:0] ksk_wr_addr;

    data_trimmer #(
        .IN_WIDTH       ( 64                ),
        .OUT_WIDTH      ( KSK_DATA_WIDTH    ),
        .DATA_COUNT     ( 8                 )
    )
    i_ksk_input_trimmer (
        .trim_in        ( ksk_wrdata        ),
        .trim_out       ( ksk_wrdata_trim   )
    );

    /*
    ksk_addr_gen
    i_ksk_addr_gen (
        .clk            ( clk               ),
        .i_ksk_addr_in  ( ksk_wraddr        ),
        .o_ksk_stage    ( ksk_wr_stage      ),
        .o_ksk_index    ( ksk_wr_index      ),
        .o_ksk_addr_out ( ksk_wr_addr       )
    );
    */

    ksk_buffer #(
        .DATA_WIDTH     ( KSK_DATA_WIDTH    ),
        .URAM_DELAY     ( RAM_DELAY         )
    )
    i_ksk_buffer (
        .clk            ( clk                       ),
        .rst_n          ( rst_n                     ),
        .i_ksk_wr_en    ( ksk_wren                  ),
        /*
        .i_ksk_wr_stage ( ksk_wr_stage              ),
        .i_ksk_wr_index ( ksk_wr_index              ),
        .i_ksk_wr_addr  ( ksk_wr_addr               ),
        */
        .i_ksk_wr_stage ( ksk_wraddr[16:9] / 12     ),
        .i_ksk_wr_index ( ksk_wraddr[16:9] % 12     ),
        .i_ksk_wr_addr  ( ksk_wraddr[8:0]           ),
        .i_ksk_wr_data  ( ksk_wrdata_trim           ),
        .i_ksk_rd_stage ( i_axird_ksk_stage         ),
        .i_ksk_rd_addr  ( i_axird_ksk_rdaddr        ),
        .o_ksk_rd_data  ( o_axird_ksk_rddata        )
    );
    /* instantiate ksk buffer end */
    

    /* instantiate preprocess input buffer begin */
    wire [8*PRE_DATA_WIDTH-1:0] ibuf_din_trim;

    data_trimmer #(
        .IN_WIDTH       ( 64                ),
        .OUT_WIDTH      ( PRE_DATA_WIDTH    ),
        .DATA_COUNT     ( 8                 )
    )
    i_pre_input_trimmer (
        .trim_in        ( ibuf_din          ),
        .trim_out       ( ibuf_din_trim     )
    );

    pre_input_transposer #(
        .DATA_WIDTH     ( PRE_DATA_WIDTH    )
    )
    i_pre_input_transposer (
        .clk            ( clk                       ),
        .rst_n          ( rst_n                     ),
        .i_ibuf_reset   ( 1'b0                      ),
        .o_ibuf_done    ( ibuf_done                 ),
        .i_ibuf_wren    ( ibuf_wren                 ),
        .i_ibuf_addr    ( ibuf_addr[11:0]           ),
        .i_ibuf_data    ( ibuf_din_trim             ),
        .o_ibuf_wren    ( o_axird_pre_wren          ),
        .o_ibuf_addr    ( o_axird_pre_wraddr        ),
        .o_ibuf_data    ( o_axird_pre_wrdata        )
    );
    /* instantiate preprocess input buffer end */

endmodule
