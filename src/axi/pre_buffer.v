module pre_buffer #(
    parameter DATA_WIDTH    = 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire    [63:0]              i_pre_wr_en,
    input   wire    [71:0]              i_pre_wr_addr,
    input   wire    [8*DATA_WIDTH-1:0]  i_pre_wr_data,

    input   wire    [11:0]              i_pre_rd_addr,
    output  wire    [8*DATA_WIDTH-1:0]  o_pre_rd_data
);

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_pre_bram
        
            wire wren;
            reg  [11:0] wraddr;
            wire [DATA_WIDTH-1:0] wrdata;
            wire [11:0] rdaddr;
            wire [DATA_WIDTH-1:0] rddata;

            wire [7:0] pre_wr_en_split;
            wire [8:0] pre_wr_addr_split;
            wire [DATA_WIDTH-1:0] pre_wr_data_split;
            
            assign pre_wr_en_split = i_pre_wr_en[(i%8) * 8 +: 8];
            assign pre_wr_addr_split = i_pre_wr_addr[(i%8) * 9 +: 9];
            assign pre_wr_data_split = i_pre_wr_data[(i%8) * DATA_WIDTH +: DATA_WIDTH];

            assign wren = |pre_wr_en_split;
            assign wrdata = pre_wr_data_split;
            
            always @ (*) begin
                wraddr = {3'b0, pre_wr_addr_split};
                case (pre_wr_en_split)
                    8'b0000_0001: wraddr[11:9] = 3'd0;
                    8'b0000_0010: wraddr[11:9] = 3'd1;
                    8'b0000_0100: wraddr[11:9] = 3'd2;
                    8'b0000_1000: wraddr[11:9] = 3'd3;
                    8'b0001_0000: wraddr[11:9] = 3'd4;
                    8'b0010_0000: wraddr[11:9] = 3'd5;
                    8'b0100_0000: wraddr[11:9] = 3'd6;
                    8'b1000_0000: wraddr[11:9] = 3'd7;
                endcase
            end

            assign rdaddr = i_pre_rd_addr[11:0];
            assign o_pre_rd_data[i*DATA_WIDTH +: DATA_WIDTH] = rddata;
                               
            xpm_memory_sdpram #(
                .ADDR_WIDTH_A           ( 12                    ),
                .ADDR_WIDTH_B           ( 12                    ),
                .AUTO_SLEEP_TIME        ( 0                     ),
                .BYTE_WRITE_WIDTH_A     ( DATA_WIDTH            ),
                .CASCADE_HEIGHT         ( 0                     ),
                .CLOCKING_MODE          ( "common_clock"        ),
                .ECC_MODE               ( "no_ecc"              ),
                .MEMORY_INIT_FILE       ( "none"                ),
                .MEMORY_INIT_PARAM      ( "0"                   ),
                .MEMORY_OPTIMIZATION    ( "true"                ),
                .MEMORY_PRIMITIVE       ( "block"               ),
                .MEMORY_SIZE            ( DATA_WIDTH * 4096     ),
                .MESSAGE_CONTROL        ( 0                     ),
                .READ_DATA_WIDTH_B      ( DATA_WIDTH            ),
                .READ_LATENCY_B         ( 3                     ),
                .READ_RESET_VALUE_B     ( "0"                   ),
                .RST_MODE_A             ( "SYNC"                ),
                .RST_MODE_B             ( "SYNC"                ),
                .SIM_ASSERT_CHK         ( 0                     ),
                .USE_EMBEDDED_CONSTRAINT( 0                     ),
                .USE_MEM_INIT           ( 0                     ),
                .WAKEUP_TIME            ( "disable_sleep"       ),
                .WRITE_DATA_WIDTH_A     ( DATA_WIDTH            ),
                .WRITE_MODE_B           ( "read_first"          )
            )
            i_sdpram_w35_d4096 (
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
    
endmodule
