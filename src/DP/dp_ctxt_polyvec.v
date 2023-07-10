//////////////////////////////////////////////////
// Engineer: Gu Zhen (jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP
// Module Name: dp_ctxt_polyvec
// Modify Date: 08/15/2021 16:10

// Description: 
//////////////////////////////////////////////////

`include "dp_defines.vh"
module dp_ctxt_polyvec #(
    parameter COE_WIDTH         = 35,
    parameter ADDR_WIDTH        = 12,
    parameter NUM_POLY          = 3,
    parameter NUM_BASE_BANK     = 8,
    parameter NUM_SPLIT         = `MAX_N_SPLIT,
    parameter COMMON_URAM_DELAY = `COMMON_URAM_DELAY,    // Number of pipeline Registers
    parameter COMMON_BRAM_DELAY = `COMMON_BRAM_DELAY,
    parameter BRAM_DEPTH        = `BRAM_DEPTH
)(
    input                                                   clk,
    input                                                   rst_n,
    input  [1:0]                                            i_idx_split,
    input                                                   i_wruram_start,
    output                                                  o_wruram_done,
    input  [NUM_SPLIT-1:0]                                  i_uram_mem_en,
    input  [NUM_SPLIT-1:0]                                  i_uram_we,
    output reg [ADDR_WIDTH*NUM_BASE_BANK-1:0]               o_tpp_rdaddr,
    output [ADDR_WIDTH-1:0]                                 o_uram_wraddr,
    input  [ADDR_WIDTH-1:0]                                 i_uram_rdaddr,
    input  [NUM_POLY*COE_WIDTH*2-1:0]                       i_uram_din,
    output [NUM_POLY*COE_WIDTH*2-1:0]                       o_uram_dout
);

wire [NUM_POLY*COE_WIDTH*2-1 : 0]    uram_din;
wire [ADDR_WIDTH-1 : 0]              uram_addr;
reg [ADDR_WIDTH-1:0] wraddr_reg [0:COMMON_BRAM_DELAY-1];
localparam WRURAM_END = NUM_BASE_BANK*BRAM_DEPTH+COMMON_BRAM_DELAY;

localparam S_WRURAM_IDLE = 2'b01;
localparam S_WRURAM_BUSY = 2'b10;

assign uram_addr = (i_uram_we[i_idx_split]?   o_uram_wraddr: i_uram_rdaddr);

reg [1:0]  state, state_nxt;
reg [12:0]  cnt;

always @ (*) begin
    case (state)
        S_WRURAM_IDLE: begin
            if (i_wruram_start) begin
                state_nxt = S_WRURAM_BUSY;
            end else begin
                state_nxt = S_WRURAM_IDLE;
            end
        end
        S_WRURAM_BUSY: begin
            if (cnt == WRURAM_END) begin
                state_nxt = S_WRURAM_IDLE;
            end else state_nxt = S_WRURAM_BUSY;
        end
        default: state_nxt = S_WRURAM_IDLE;
    endcase
end
assign o_wruram_done = (state != S_WRURAM_BUSY);
always @ (posedge clk) begin
    if (~rst_n)
        state <= S_WRURAM_IDLE;
    else
        state <= state_nxt;
end

always @ (posedge clk) begin
    if (~rst_n) begin
        cnt <= 'd0;
        o_tpp_rdaddr = 'd0;
    end
    else begin
        if (state == S_WRURAM_BUSY) begin
            cnt <= cnt + 1;
        end
        else begin
            cnt <= 'd0;
        end
        o_tpp_rdaddr[ADDR_WIDTH-1:0] <= cnt[11:0];
        o_tpp_rdaddr[NUM_BASE_BANK*ADDR_WIDTH-1:ADDR_WIDTH] <= o_tpp_rdaddr[(NUM_BASE_BANK-1)*ADDR_WIDTH-1:0];
    end
end
always@(posedge clk)begin
    wraddr_reg[0] <= o_tpp_rdaddr[ADDR_WIDTH-1:0];
end
genvar idx;
generate
    for(idx = 1; idx <COMMON_BRAM_DELAY; idx = idx + 1) begin 
        always@(posedge clk)begin
            wraddr_reg[idx] <= wraddr_reg[idx-1];
        end
    end
endgenerate

assign o_uram_wraddr = wraddr_reg[COMMON_BRAM_DELAY-1];
wire [NUM_SPLIT*2*NUM_POLY*COE_WIDTH-1 : 0] split_dout;
genvar index_split;
generate
    for(index_split = 0; index_split < NUM_SPLIT; index_split = index_split + 1) begin
        dp_uram_polyvec #(
            .COE_WIDTH(COE_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .NUM_POLY(NUM_POLY),
            .COMMON_URAM_DELAY(COMMON_URAM_DELAY)
        ) polyvec_ntt_ctxt0(
            .clk(clk),
            .mem_en(i_uram_mem_en[index_split]),
            .we(i_uram_we[index_split]),
            .addr(uram_addr),
            .din(i_uram_din[NUM_POLY*COE_WIDTH-1 -: NUM_POLY*COE_WIDTH]),
            .dout(split_dout[NUM_POLY*COE_WIDTH*index_split +: NUM_POLY*COE_WIDTH])
        );
        dp_uram_polyvec #(
            .COE_WIDTH(COE_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .NUM_POLY(NUM_POLY),
            .COMMON_URAM_DELAY(COMMON_URAM_DELAY)
        ) polyvec_ntt_ctxt1(
            .clk(clk),
            .mem_en(i_uram_mem_en[index_split]),
            .we(i_uram_we[index_split]),
            .addr(uram_addr),
            .din(i_uram_din[NUM_POLY*COE_WIDTH*2-1 -: NUM_POLY*COE_WIDTH]),
            .dout(split_dout[NUM_POLY*COE_WIDTH*(index_split+NUM_SPLIT) +: NUM_POLY*COE_WIDTH])
        );
    end
endgenerate 
assign o_uram_dout[0 +: NUM_POLY*COE_WIDTH] = split_dout[i_idx_split*NUM_POLY*COE_WIDTH +: NUM_POLY*COE_WIDTH];
assign o_uram_dout[NUM_POLY*COE_WIDTH +: NUM_POLY*COE_WIDTH] = split_dout[(NUM_SPLIT+i_idx_split)*NUM_POLY*COE_WIDTH +: NUM_POLY*COE_WIDTH];

endmodule
