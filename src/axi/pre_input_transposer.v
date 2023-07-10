module pre_input_transposer #(
    parameter DATA_WIDTH    = 39
)
(
    input   wire    clk,
    input   wire    rst_n,

    input   wire                        i_ibuf_reset,
    output  wire                        o_ibuf_done,

    input   wire                        i_ibuf_wren,
    input   wire    [11:0]              i_ibuf_addr,    // 0 ~ 3071
    input   wire    [8*DATA_WIDTH-1:0]  i_ibuf_data,

    output  wire    [47:0]              o_ibuf_wren,    // p5b7 ~ p0b7 ~ p0b0 : p = polyn, b = bank = 1/8 polyn
    output  wire    [71:0]              o_ibuf_addr,    // 9 * 8
    output  wire    [8*DATA_WIDTH-1:0]  o_ibuf_data     // 35/39 * 8
);


    reg input_completed_r;
    wire input_completed;       // all 8 polynomials received
    wire output_completed;      // all 8 polynomials saved to ram
    assign o_ibuf_done = input_completed_r & output_completed;
    

    /* input logic begin */
    wire [8:0] count_i_coeff;   // number of coeff in a polynomial received
    wire [2:0] count_i_polyn;   // number of polyn received

    assign count_i_coeff = i_ibuf_addr[8:0];
    assign count_i_polyn = i_ibuf_addr[11:9];
    assign input_completed = ({count_i_polyn, count_i_coeff} == 12'hbff);

    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n)
            input_completed_r <= 1'b0;
        else if (i_ibuf_reset)
            input_completed_r <= 1'b0;
        else if (o_ibuf_done)
            input_completed_r <= 1'b0;
        else if (input_completed)
            input_completed_r <= 1'b1;
        else
            input_completed_r <= input_completed_r;
    end
    /* input logic end */


    reg [7:0] o_comp;
    assign output_completed = &o_comp[7:0];

    genvar i, j;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_buf

            wire iwren;
            wire [5:0] iaddr;
            assign iwren = (count_i_coeff[8:6] == i) && i_ibuf_wren;
            assign iaddr = count_i_coeff;

            reg [5:0] owren;
            reg [5:0] owren_m1; // lutram delay = 1 cycle
            wire [8:0] oaddr;
            reg [8:0] oaddr_m1; // lutram delay = 1 cycle
            reg [DATA_WIDTH-1:0] odata;

            assign o_ibuf_wren[i*6 +: 6] = owren_m1;
            assign o_ibuf_addr[i*9 +: 9] = oaddr_m1;
            assign o_ibuf_data[i*DATA_WIDTH +: DATA_WIDTH] = odata;

            always @ (posedge clk) begin
                oaddr_m1 <= oaddr;
                owren_m1 <= owren;
            end

            /* instantiate buffer begin */
            wire [8*DATA_WIDTH-1:0] ram_dout;
            wire [8*DATA_WIDTH-1:0] ram_din;
            assign ram_din = i_ibuf_data;

            xpm_memory_sdpram #(
                .ADDR_WIDTH_A           ( 6                     ),
                .ADDR_WIDTH_B           ( 6                     ),
                .AUTO_SLEEP_TIME        ( 0                     ),
                .BYTE_WRITE_WIDTH_A     ( 8 * DATA_WIDTH        ),
                .CASCADE_HEIGHT         ( 0                     ),
                .CLOCKING_MODE          ( "common_clock"        ),
                .ECC_MODE               ( "no_ecc"              ),
                .MEMORY_INIT_FILE       ( "none"                ),
                .MEMORY_INIT_PARAM      ( "0"                   ),
                .MEMORY_OPTIMIZATION    ( "true"                ),
                .MEMORY_PRIMITIVE       ( "distributed"         ),
                .MEMORY_SIZE            ( 8 * DATA_WIDTH * 64   ),
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
                .addra  ( iaddr[5:0]        ),
                .addrb  ( oaddr[8:3]        ),
                .wea    ( iwren             ),
                .dina   ( ram_din           ),
                .doutb  ( ram_dout          ),
                .regceb ( 1'b1              ),
                .rstb   ( 1'b0              )
            );

            always @ (*) begin
                odata = 'b0;
                case (oaddr_m1[2:0])
                    3'd0: odata = ram_dout[0 * DATA_WIDTH +: DATA_WIDTH];
                    3'd1: odata = ram_dout[1 * DATA_WIDTH +: DATA_WIDTH];
                    3'd2: odata = ram_dout[2 * DATA_WIDTH +: DATA_WIDTH];
                    3'd3: odata = ram_dout[3 * DATA_WIDTH +: DATA_WIDTH];
                    3'd4: odata = ram_dout[4 * DATA_WIDTH +: DATA_WIDTH];
                    3'd5: odata = ram_dout[5 * DATA_WIDTH +: DATA_WIDTH];
                    3'd6: odata = ram_dout[6 * DATA_WIDTH +: DATA_WIDTH];
                    3'd7: odata = ram_dout[7 * DATA_WIDTH +: DATA_WIDTH];
                endcase
            end
            /* instantiate buffer end */


            /* output logic begin */
            reg vld;
            wire [8:0] count_o_coeff;
            wire [2:0] count_o_polyn;

            assign oaddr = count_o_coeff;

            always @ (posedge clk or negedge rst_n) begin
                if (~rst_n)
                    vld <= 1'b0;
                else if (i_ibuf_reset)
                    vld <= 1'b0;
                else if (count_i_coeff[8:6] == i &&
                         count_i_coeff[5:0] == 6'd62 && // early start
                         i_ibuf_wren)
                    vld <= 1'b1;
                else if (vld && count_o_coeff == 9'd511)
                    vld <= 1'b0;
                else
                    vld <= vld;
            end

            counter #(.C_WIDTH(12), . MAX_COUNT('hbff), .C_INIT(12'd0))
            i_cntr_output(
                .clk        ( clk                               ),
                .clken      ( 1'b1                              ),
                .rst        ( ~rst_n                            ),
                .load       ( i_ibuf_reset                      ),
                .incr       ( vld                               ),
                .decr       ( 1'b0                              ),
                .load_value ( 12'd0                             ),
                .count      ( {count_o_polyn, count_o_coeff}    ),
                .is_zero    (                                   )
            );

            always @ (*) begin
                owren = 'b0;
                if (vld) begin
                    case (count_o_polyn)
                        3'd0: owren = 6'b00_0001;
                        3'd1: owren = 6'b00_0010;
                        3'd2: owren = 6'b00_0100;
                        3'd3: owren = 6'b00_1000;
                        3'd4: owren = 6'b01_0000;
                        3'd5: owren = 6'b10_0000;
                    endcase
                end
            end
            
            always @ (posedge clk or negedge rst_n) begin
                if (~rst_n)
                    o_comp[i] <= 1'b0;
                else if (i_ibuf_reset)
                    o_comp[i] <= 1'b0;
                else if (o_ibuf_done)
                    o_comp[i] <= 1'b0;
                else if ({count_o_polyn, count_o_coeff} == 12'hbff)
                    o_comp[i] <= 1'b1;
                else
                    o_comp[i] <= o_comp[i];
            end
            /* output logic end */

        end
    endgenerate

endmodule
