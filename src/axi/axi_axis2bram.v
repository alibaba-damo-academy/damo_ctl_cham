module axi_axis2bram #(
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
    input   wire                                i_as2b_start,
    output  wire                                o_as2b_done,
    input   wire                                i_as2b_ready,
    input   wire    [AXI_XFER_SIZE_WIDTH-1:0]   i_as2b_data_size_bytes,

    // AXI4-Stream Interface (rd)
    input   wire                                s_axis_tvalid,
    output  wire                                s_axis_tready,
    input   wire    [AXI_DATA_WIDTH-1:0]        s_axis_tdata,
    input   wire                                s_axis_tlast,

    // BRAM Interface (wr)
    output  wire                                o_as2b_wren,
    output  wire    [BRAM_ADDR_WIDTH-1:0]       o_as2b_wraddr,
    output  wire    [BRAM_DATA_WIDTH-1:0]       o_as2b_wrdata
);

    localparam S_IDLE = 2'd0;
    localparam S_BUSY = 2'd1;
    localparam S_DONE = 2'd3; // wait for bram wr


    wire [BRAM_ADDR_WIDTH:0] xfer_depth;
    assign xfer_depth = i_as2b_data_size_bytes * 8 / BRAM_DATA_WIDTH;


    /* FSM begin */
    reg [1:0] state;
    reg [1:0] state_nxt;
    reg [2:0] count;
    reg [BRAM_ADDR_WIDTH:0] addr; // one more bit to indicate write done

    assign o_as2b_done = (state == S_IDLE);
    assign s_axis_tready = (state == S_BUSY) && i_as2b_ready;

    initial state <= S_IDLE;
    
    always @ (*) begin
        state_nxt = state;

        case (state)
            S_IDLE: begin
                if (i_as2b_start)
                    state_nxt = S_BUSY;
            end

            S_BUSY: begin
                if (addr == xfer_depth)
                    state_nxt = S_DONE;
            end

            S_DONE: begin
                if (count == BRAM_DELAY)
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

    always @ (posedge clk) begin
        if (state == S_DONE)
            count <= count + 1;
        else
            count <= 'b0;
    end
    /* FSM end */


    /* function begin */
    wire rx_flag;
    assign rx_flag = s_axis_tvalid && s_axis_tready;

    assign o_as2b_wren = rx_flag;
    assign o_as2b_wraddr = addr;
    assign o_as2b_wrdata = s_axis_tdata;

    always @ (posedge clk) begin
        if (state == S_BUSY && rx_flag)
            addr <= addr + 1;
        else if (state == S_BUSY && ~rx_flag)
            addr <= addr;
        else
            addr <= 'b0;
    end
    /* function end */

endmodule
