//////////////////////////////////////////////////
// Engineer: Gu Zhen(jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP
// Module Name: madd_top
// Modify Date: 03/14/2021 16:10

// Description: contains madd address generation and a madd core
//////////////////////////////////////////////////
`include "dp_defines.vh"
module madd_top #(
    parameter COE_WIDTH=39,
    parameter ADDR_WIDTH         = 9,        // Depth of ram is 1<<ADDR_WIDTH
    parameter URAM_ADDR_WIDTH    = 12,
    parameter LOG_NUM_BANK       = 3,        // width of the bank select signal
    parameter NUM_POLY           = 6,        // number of polys in one polyvec
    parameter NUM_BASE_BANK      = 8,        // number of banks for one poly
    parameter COMMON_BRAM_DELAY  = `COMMON_BRAM_DELAY,
    parameter COMMON_URAM_DELAY  = `COMMON_URAM_DELAY,
    parameter DP_MADD_PIP_DELAY  = 4
)(
    input                                                     clk,
    input                                                     rst_n,
    input                                                     i_madd_start,
    output                                                    o_madd_done,
    input       [1:0]                                         i_idx_split,
    output      reg                                           o_madd_nxt_we,         // o_we_a_l,
    output      [ADDR_WIDTH+LOG_NUM_BANK-1:0]                 o_madd_nxt_wraddr,     //o_addr_a_l,
    output      [COE_WIDTH*NUM_POLY-1:0]                      o_madd_nxt_dout,       //o_data_a
    output      [ADDR_WIDTH+LOG_NUM_BANK-1:0]                 o_madd_nxt_rdaddr,
    input       [COE_WIDTH*NUM_POLY-1:0]                      i_madd_nxt_din_psum,
    output      [ADDR_WIDTH+LOG_NUM_BANK-1:0]                 o_madd_curaddr,
    output      [(ADDR_WIDTH+LOG_NUM_BANK)*NUM_BASE_BANK-1:0] o_madd_rdaddr,
    input       [COE_WIDTH*NUM_POLY-1:0]                      i_madd_dina,
    output      [URAM_ADDR_WIDTH-1:0]                         o_madd_uram_rdaddr,
    input       [COE_WIDTH*NUM_POLY-1:0]                      i_madd_dinb
);

localparam MADD_IDLE = 2'b01;
localparam MADD_BUSY = 2'b10;
localparam RAM_DELAY = COMMON_URAM_DELAY > COMMON_BRAM_DELAY? COMMON_URAM_DELAY:COMMON_BRAM_DELAY;
localparam MADD_BUSY_END = NUM_BASE_BANK*(1<<ADDR_WIDTH)+RAM_DELAY+DP_MADD_PIP_DELAY+1;

reg [1:0]                   state, state_nxt;
reg [12:0]                  cnt;
reg [ADDR_WIDTH+LOG_NUM_BANK-1:0]  madd_addr_reg[RAM_DELAY+DP_MADD_PIP_DELAY:0];
reg [(ADDR_WIDTH+LOG_NUM_BANK)*(RAM_DELAY+NUM_BASE_BANK)-1:0]  madd_rdaddr_reg;

assign o_madd_nxt_wraddr = madd_addr_reg[RAM_DELAY+DP_MADD_PIP_DELAY];
assign o_madd_nxt_rdaddr = madd_addr_reg[RAM_DELAY-COMMON_BRAM_DELAY];
assign o_madd_rdaddr = madd_rdaddr_reg[(RAM_DELAY-COMMON_BRAM_DELAY)*(ADDR_WIDTH+LOG_NUM_BANK) +: NUM_BASE_BANK*(ADDR_WIDTH+LOG_NUM_BANK)];
assign o_madd_uram_rdaddr = madd_addr_reg[RAM_DELAY-COMMON_URAM_DELAY];
assign o_madd_curaddr = madd_addr_reg[RAM_DELAY];
//assign o_madd_nxt_we = (cnt>RAM_DELAY+DP_MADD_PIP_DELAY+1? 1'b1:1'b0);
always @ (*) begin
    case (state)
        MADD_IDLE: begin
            if (i_madd_start) begin
                state_nxt = MADD_BUSY;
            end else begin
                state_nxt = MADD_IDLE;
            end
        end
        MADD_BUSY: begin
            if (cnt == MADD_BUSY_END) begin
                state_nxt = MADD_IDLE;
            end else state_nxt = MADD_BUSY;
        end
        default: state_nxt = MADD_IDLE;
    endcase
end
assign o_madd_done = (state != MADD_BUSY);
always @ (posedge clk) begin
    if (~rst_n || cnt == MADD_BUSY_END) begin
        o_madd_nxt_we <= 'b0;
    end else if(cnt == RAM_DELAY+DP_MADD_PIP_DELAY+1) begin
        o_madd_nxt_we <= 'b1;
    end 
end
always @ (posedge clk) begin
    if (~rst_n)
        state <= MADD_IDLE;
    else
        state <= state_nxt;
end

always @ (posedge clk) begin
    if (~rst_n) begin
        cnt <= 'd0;
    end
    else if (state == MADD_BUSY)
        cnt <= cnt + 1;
    else
        cnt <= 'd0;
end

integer idx;
always @ (posedge clk) begin
    madd_addr_reg[0] <= madd_rdaddr_reg[0 +: ADDR_WIDTH+LOG_NUM_BANK];
    for(idx = 1; idx <= RAM_DELAY+DP_MADD_PIP_DELAY; idx = idx + 1) begin
        madd_addr_reg[idx] <= madd_addr_reg[idx-1];
    end
    madd_rdaddr_reg[0 +: ADDR_WIDTH+LOG_NUM_BANK] <= cnt[11:0];
    madd_rdaddr_reg[ADDR_WIDTH+LOG_NUM_BANK +: (ADDR_WIDTH+LOG_NUM_BANK)*(NUM_BASE_BANK+RAM_DELAY-1)] <= madd_rdaddr_reg[0 +: (ADDR_WIDTH+LOG_NUM_BANK)*(NUM_BASE_BANK+RAM_DELAY-1)];
end

madd#(
    .COE_WIDTH(COE_WIDTH),
    .DP_MADD_PIP_DELAY(DP_MADD_PIP_DELAY),
    .NUM_POLY(6)
) madd_core
(
    .clk(clk),
    .rst_n(rst_n),
    .i_idx_split(i_idx_split),
    .i_dina(i_madd_dina),
    .i_dinb(i_madd_dinb),
    .i_psum(i_madd_nxt_din_psum),
    .o_dout(o_madd_nxt_dout)
);
endmodule
