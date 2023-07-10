module out_output_transposer #(
    parameter DATA_WIDTH    = 39,
    parameter URAM_DELAY    = 3
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire                        i_obuf_reset,
    input   wire                        i_obuf_start,
    output  wire                        o_obuf_done,

    output  wire    [11:0]              o_obuf_addr, // 4096 depth
    input   wire    [4*DATA_WIDTH-1:0]  i_obuf_data,

    input   wire    [10:0]              i_obuf_addr, // 2048 depth
    output  wire    [8*DATA_WIDTH-1:0]  o_obuf_data
);

    localparam S_IDLE = 2'd0;
    localparam S_BUSY = 2'd1;
    localparam S_DONE = 2'd3; // wait for buffer wr


    /* FSM begin */
    reg [1:0] state;
    reg [1:0] state_nxt;
    reg [11:0] count;

    always @ (*) begin
        state_nxt = state;
        
        case (state)
            S_IDLE: begin
                if (i_obuf_start)
                    state_nxt = S_BUSY;
            end

            S_BUSY: begin
                if (o_obuf_addr == 12'd4095)
                    state_nxt = S_DONE;
            end

            S_DONE: begin
                if (count == URAM_DELAY + 1)
                    state_nxt = S_IDLE;
            end
        endcase
    end

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            state <= S_IDLE;
        else if (i_obuf_reset)
            state <= S_IDLE;
        else
            state <= state_nxt;
    end

    always @ (posedge clk) begin
        if (state == S_BUSY || state == S_DONE)
            count <= count + 1;
        else
            count <= 'b0;
    end
    
    assign o_obuf_done = (state == S_IDLE);
    /* FSM end */


    /* compensate for input read latency begin */
    assign o_obuf_addr = count;

    reg [URAM_DELAY*12-1:0] iaddr_mx;
    if(URAM_DELAY == 1) begin
        always @ (posedge clk) begin
            iaddr_mx <= o_obuf_addr;
        end
    end
    else begin
        always @ (posedge clk) begin
            iaddr_mx <= {o_obuf_addr, iaddr_mx[URAM_DELAY*12-1:12]};
        end
    end
    /* compensate for input read latency end */


    /* assign output data begin */
    reg [10:0] oaddr_m1;
    always @ (posedge clk) begin
        oaddr_m1 <= i_obuf_addr;
    end

    wire [32*DATA_WIDTH-1:0] o_data_ori;
    assign o_obuf_data = o_data_ori[oaddr_m1[10:9] * 8*DATA_WIDTH +: 8*DATA_WIDTH];
    /* assign output data end */

    
    /* instantiate transpose buffer begin */
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: gen_buf

            wire iwren;
            wire [8:0] iaddr;
            wire [DATA_WIDTH-1:0] idata;
            wire [8*DATA_WIDTH-1:0] idata_buf;
            reg [8*DATA_WIDTH-1:0] idata_buf_r;

            assign iwren = (iaddr_mx[2:0] == 3'd7);
            assign iaddr = iaddr_mx[11:3];
            assign idata = i_obuf_data[i*DATA_WIDTH +: DATA_WIDTH];

            assign idata_buf = {idata, idata_buf_r[DATA_WIDTH +: (8-1)*DATA_WIDTH]};
            always @ (posedge clk) begin
                idata_buf_r <= idata_buf;
            end

            wire [8:0] oaddr;
            wire [8*DATA_WIDTH-1:0] odata;

            assign oaddr = i_obuf_addr[8:0];
            assign o_data_ori[i*8*DATA_WIDTH +: 8*DATA_WIDTH] = odata;

            xpm_memory_sdpram #(
                .ADDR_WIDTH_A           ( 9                     ),
                .ADDR_WIDTH_B           ( 9                     ),
                .AUTO_SLEEP_TIME        ( 0                     ),
                .BYTE_WRITE_WIDTH_A     ( 8 * DATA_WIDTH        ),
                .CASCADE_HEIGHT         ( 0                     ),
                .CLOCKING_MODE          ( "common_clock"        ),
                .ECC_MODE               ( "no_ecc"              ),
                .MEMORY_INIT_FILE       ( "none"                ),
                .MEMORY_INIT_PARAM      ( "0"                   ),
                .MEMORY_OPTIMIZATION    ( "true"                ),
                .MEMORY_PRIMITIVE       ( "distributed"         ),
                .MEMORY_SIZE            ( 512 * 8 * DATA_WIDTH  ),
                .MESSAGE_CONTROL        ( 0                     ),
                .READ_DATA_WIDTH_B      ( 8 * DATA_WIDTH        ),
                .READ_LATENCY_B         ( 1                     ),
                .READ_RESET_VALUE_B     ( "0"                   ),
                .RST_MODE_A             ( "SYNC"                ),
                .RST_MODE_B             ( "SYNC"                ),
                .SIM_ASSERT_CHK         ( 0                     ),
                .USE_EMBEDDED_CONSTRAINT( 0                     ),
                .USE_MEM_INIT           ( 0                     ),
                .WAKEUP_TIME            ( "disable_sleep"       ),
                .WRITE_DATA_WIDTH_A     ( 8 * DATA_WIDTH        ),
                .WRITE_MODE_B           ( "read_first"          )
            )
            i_ibuf_lutram_sdpram (
                .clka   ( clk               ),
                .clkb   ( clk               ),
                .ena    ( 1'b1              ),
                .enb    ( 1'b1              ),
                .addra  ( iaddr             ),
                .addrb  ( oaddr             ),
                .wea    ( iwren             ),
                .dina   ( idata_buf         ),
                .doutb  ( odata             ),
                .regceb ( 1'b1              ),
                .rstb   ( 1'b0              )
            );
        end
    endgenerate
    /* instantiate transpose buffer end */

endmodule
