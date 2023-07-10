module ksk_buffer #(
    parameter DATA_WIDTH    = 39,
    parameter URAM_DELAY    = 3
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire                        i_ksk_wr_en,
    input   wire    [3:0]               i_ksk_wr_stage,
    input   wire    [3:0]               i_ksk_wr_index,
    input   wire    [8:0]               i_ksk_wr_addr,    // every addr contains 8 data
    input   wire    [8*DATA_WIDTH-1:0]  i_ksk_wr_data,

    input   wire    [3:0]               i_ksk_rd_stage,
    input   wire    [11:0]              i_ksk_rd_addr,    // every addr contains 1 data from each uram, 12 in total
    output  wire    [12*DATA_WIDTH-1:0] o_ksk_rd_data
);

    genvar i;
    generate
        for (i = 0; i < 12; i = i + 1) begin : gen_ksk_uram

            wire wren;
            wire [12:0] wraddr;
            wire [8*DATA_WIDTH-1:0] wrdata;
            wire [12:0] rdaddr;
            wire [8*DATA_WIDTH-1:0] rddata;
            
            reg [3*URAM_DELAY-1:0] rd_sel_mx;
            
            // generate
            if (URAM_DELAY == 1) begin
                always @ (posedge clk) begin
                    rd_sel_mx <= i_ksk_rd_addr[2:0];
                end
            end
            else if (URAM_DELAY > 1) begin
                always @ (posedge clk) begin
                    rd_sel_mx <= {i_ksk_rd_addr[2:0], rd_sel_mx[3*URAM_DELAY-1:3]};
                end
            end
            // endgenerate

            assign wren = i_ksk_wr_en & (i_ksk_wr_index == i);
            assign wraddr = {i_ksk_wr_stage, i_ksk_wr_addr};
            assign wrdata = i_ksk_wr_data;

            assign rdaddr = {i_ksk_rd_stage, i_ksk_rd_addr[11:3]};
            assign o_ksk_rd_data[i*DATA_WIDTH +: DATA_WIDTH] = rddata[rd_sel_mx[2:0]*DATA_WIDTH +: DATA_WIDTH];

            xpm_memory_sdpram #(
                .ADDR_WIDTH_A           ( 13                ),
                .ADDR_WIDTH_B           ( 13                ),
                .AUTO_SLEEP_TIME        ( 0                 ),
                .BYTE_WRITE_WIDTH_A     ( 8 * DATA_WIDTH    ),
                .CASCADE_HEIGHT         ( 0                 ),
                .CLOCKING_MODE          ( "common_clock"    ),
                .ECC_MODE               ( "no_ecc"          ),
                .MEMORY_INIT_FILE       ( "none"            ),
                .MEMORY_INIT_PARAM      ( "0"               ),
                .MEMORY_OPTIMIZATION    ( "true"            ),
                .MEMORY_PRIMITIVE       ( "ultra"           ),
                .MEMORY_SIZE            ( 8 * DATA_WIDTH * 512 * 12 ),
                .MESSAGE_CONTROL        ( 0                 ),
                .READ_DATA_WIDTH_B      ( 8 * DATA_WIDTH    ),
                .READ_LATENCY_B         ( URAM_DELAY        ),
                .READ_RESET_VALUE_B     ( "0"               ),
                .RST_MODE_A             ( "SYNC"            ),
                .RST_MODE_B             ( "SYNC"            ),
                .SIM_ASSERT_CHK         ( 0                 ),
                .USE_EMBEDDED_CONSTRAINT( 0                 ),
                .USE_MEM_INIT           ( 0                 ),
                .WAKEUP_TIME            ( "disable_sleep"   ),
                .WRITE_DATA_WIDTH_A     ( 8 * DATA_WIDTH    ),
                .WRITE_MODE_B           ( "read_first"      )
            )
            i_ksk_uram_spdram (
                .clka   ( clk               ),
                .clkb   ( clk               ),
                .ena    ( 1'b1              ),
                .enb    ( 1'b1              ),
                .wea    ( wren              ),
                .addra  ( wraddr            ),
                .dina   ( wrdata            ),
                .addrb  ( rdaddr            ),
                .doutb  ( rddata            ),
                .regceb ( 1'b1              ),
                .rstb   ( 1'b0              )
            );

        end
    endgenerate
    /* ksk uram end */

endmodule