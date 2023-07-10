//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: intt_cu
// Modify Date: 07/19/2021 16:10

// Description: intt control unit
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module intt_cu#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0,
    parameter NTT_LOGN = 12,
    parameter COMMON_BRAM_DELAY = 2,
    parameter COMMON_NTT_PIP_DELAY = 12
)(
    input                    clk,
    input                    rst_n,
    input                    ntt_start,
    // output        [3:0]   cu_stage_cnt,
    // output                cu_cnt,
    output                   coe_mux_sel,      // delay of stage_cnt
    output           [3:0]   tf_mux_sel,       // delay of stage_cnt
    output                   swap_mux0_sel,
    // output                swap_mux1_sel,
    output                   o_we_a_l,
    output                   o_we_a_r,
    output           [8:0]   o_addr_a_l,
    output           [8:0]   o_addr_a_r,
    output           [8:0]   o_addr_b_l,
    output           [8:0]   o_addr_b_r,
    output    reg    [10:0]  o_addr_tf,
    output                   ntt_done
);

/* FSM params */
localparam NTT_IDLE = 2'b01;
localparam NTT_BUSY = 2'b10;

reg [1:0] cur_state;
reg [1:0] nxt_state;

/* other control signal */
reg [12:0] cnt;
reg [COMMON_NTT_PIP_DELAY:0] busy;

wire [3:0] stage_cnt;
wire [8:0] bf_cnt;

assign stage_cnt = cnt[12:9];
assign bf_cnt = cnt[8:0];

/* ram port delay reg */
reg [3:0] stage_cnt_reg [0:COMMON_NTT_PIP_DELAY];
reg [8:0] bf_cnt_reg    [0:COMMON_NTT_PIP_DELAY];

/* tf addr index */
wire [8:0] addr_tf_index;

/* FSM */
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        cur_state <= 2'b01;
    end
    else begin
        cur_state <= nxt_state;
    end
end

always @(*) begin   // next state
    case (cur_state)
        2'b01: begin    // IDLE
            if(ntt_start)
                nxt_state = 2'b10;
            else
                nxt_state = 2'b01;
        end 
        2'b10: begin    // NTT
            if(!(|busy[COMMON_NTT_PIP_DELAY:0]))   // end
                nxt_state = 2'b01;
            else
                nxt_state = 2'b10;
        end
        default: 
            nxt_state = 2'b01;
    endcase
end

always @(posedge clk) begin // cnt
    if(~rst_n) begin
        cnt <= 'b0;
    end
    else begin
        case(nxt_state)
            2'b01: begin
                cnt <= 'b0;
            end
            2'b10: begin
                if(cnt == 13'd6143) begin
                    cnt <= 'b0;
                end
                else if (cnt == 13'd0)begin
                    if (ntt_start)
                        cnt <= cnt + 1'b1;
                    else
                        cnt <= 'b0;
                end else begin
                    cnt <= cnt + 1'b1;
                end
            end
            default: cnt <= 'b0;
        endcase
    end
end

/* busy */
always@(*) begin
    busy[0] = !(cnt == 13'd0);
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        busy[COMMON_NTT_PIP_DELAY:1] <= 'b0;
    else
        busy[COMMON_NTT_PIP_DELAY:1] <= busy[COMMON_NTT_PIP_DELAY-1:0];
end

assign ntt_done = !(|busy);

genvar index_pip_delay;
generate
    for(index_pip_delay = 0; index_pip_delay < COMMON_NTT_PIP_DELAY; index_pip_delay = index_pip_delay+1) begin
        always @(posedge clk) begin
            stage_cnt_reg[index_pip_delay+1] <= stage_cnt_reg[index_pip_delay];
            bf_cnt_reg[index_pip_delay+1] <= bf_cnt_reg[index_pip_delay];
        end
    end
endgenerate

/* Address generation */
always@(*) begin
    bf_cnt_reg[0] = bf_cnt;
    stage_cnt_reg[0] = stage_cnt;
end

assign coe_mux_sel = stage_cnt_reg[COMMON_BRAM_DELAY][0];
assign swap_mux0_sel = bf_cnt_reg[COMMON_BRAM_DELAY+1][0];
//assign swap_mux1_sel = bf_cnt_reg[0][COMMON_NTT_PIP_DELAY-1];
assign tf_mux_sel = stage_cnt_reg[COMMON_BRAM_DELAY];

assign o_we_a_l = (nxt_state  == 2'b10)? stage_cnt_reg[COMMON_NTT_PIP_DELAY][0]:1'b0;
assign o_we_a_r = (nxt_state  == 2'b10)?(~stage_cnt_reg[COMMON_NTT_PIP_DELAY][0]):1'b0;
assign o_addr_a_l = bf_cnt_reg[COMMON_NTT_PIP_DELAY][0]? {1'b1,bf_cnt_reg[COMMON_NTT_PIP_DELAY][8:1]}:{1'b0,bf_cnt_reg[COMMON_NTT_PIP_DELAY][8:1]};
assign o_addr_a_r = bf_cnt_reg[COMMON_NTT_PIP_DELAY][0]? {1'b1,bf_cnt_reg[COMMON_NTT_PIP_DELAY][8:1]}:{1'b0,bf_cnt_reg[COMMON_NTT_PIP_DELAY][8:1]};
assign o_addr_b_l = bf_cnt[8:0];
assign o_addr_b_r = bf_cnt[8:0];
assign addr_tf_index = cnt[0]? {1'b1,bf_cnt[8:1]}:{1'b0,bf_cnt[8:1]};
always @(*) begin
    case(stage_cnt)
        0: o_addr_tf = (1 << (NTT_LOGN-1-0)) - 10'd512 + addr_tf_index[8:0];
        1: o_addr_tf = (1 << (NTT_LOGN-1-1)) + addr_tf_index[8:0];
        2: o_addr_tf = (1 << (NTT_LOGN-1-2)) + addr_tf_index[8:0];
        3: o_addr_tf = (1 << (NTT_LOGN-1-3)) + addr_tf_index[7:0];
        4: o_addr_tf = (1 << (NTT_LOGN-1-4)) + addr_tf_index[6:0];
        5: o_addr_tf = (1 << (NTT_LOGN-1-5)) + addr_tf_index[5:0];
        6: o_addr_tf = (1 << (NTT_LOGN-1-6)) + addr_tf_index[4:0];
        7: o_addr_tf = (1 << (NTT_LOGN-1-7)) + addr_tf_index[3:0];
        8: o_addr_tf = (1 << (NTT_LOGN-1-8)) + addr_tf_index[2:0];
        9: o_addr_tf = (1 << (NTT_LOGN-1-9)) + addr_tf_index[1:0];
        10: o_addr_tf = (1 << (NTT_LOGN-1-10)) + addr_tf_index[0];
        11: o_addr_tf = (1 << (NTT_LOGN-1-11));
        default: o_addr_tf = 0;
    endcase
end

endmodule
