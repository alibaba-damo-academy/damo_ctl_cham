/*
    Top Module:  controller_seq.v
    Data:        No input data, only input control signals exist:
                    each input start - 1 bit
                    each output done - 1 bit
                    each output level - 4 bit
    Role:        take external overall start signal, manage start & level for each input modules
    Timing:      Sequential Logic, 5/6-cycle latency

    Author:      Jianming Tong (jianming.tong@gatech.edu)
    Author:      Yanheng Lu (yanheng.lyh@alibaba-inc.com)
    Time:        20210801
*/

`include "common_defines.vh"

module control#(
    parameter LEVEL_WIDTH=4,
    parameter MVP_STATUS_WIDTH=10,
    parameter REDUCE_BUFFER_WIDTH=12
)(
    // timing signals
    clk,
    rst_n,
    i_mvp_start,
    o_mvp_done,
    o_mvp_idle,
    o_stage_cnt, // for debug

    // modules control signals
    i_wruram_done,
    i_axi_s0_done,
    i_axi_s0_alldone,
    i_dp_ntt_s1_done,
    i_dp_muladd_s2_done,
    i_intt_s3_done,
    i_mext_s4_done,
    i_mux_monox_s5_done,
    i_ntt_s6_done,
    i_mulacc_s7_done,
    i_intt_s8_done,
    i_ms_addx_s9_done,

    o_wruram_start,
    o_axi_s0_start,
    o_dp_ntt_s1_start,
    o_dp_muladd_s2_start,
    o_intt_s3_start,
    o_mext_s4_start,
    o_mux_monox_s5_start,
    o_ntt_s6_start,
    o_mulacc_s7_start,
    o_intt_s8_start,
    o_ms_addx_s9_start,

    i_command,
    i_reduce_level,
    i_col_size,
    i_split,
    i_index,

    // flow control signals
    o_dp_mode,
    o_idx_split,
    o_switch_mode,
    o_reduce_trace,
    o_mux_s5_mode,
    o_pre_tpp_switch,
    o_last_write,

    // level data signals
    o_mux_monox_s5_n,
    o_mulacc_s7_n,
    o_ms_addx_s9_n,
    o_coeff_index,
    o_uram_index
);

    // interface
    input                                       clk;
    input                                       rst_n;

    input                                       i_mvp_start;
    output                                      o_mvp_done;
    output                                      o_mvp_idle;
    output      [ 15 : 0]                       o_stage_cnt;

    input                                       i_wruram_done;
    input                                       i_axi_s0_done;
    input                                       i_axi_s0_alldone;
    input                                       i_dp_ntt_s1_done;
    input                                       i_dp_muladd_s2_done;
    input                                       i_intt_s3_done;
    input                                       i_mext_s4_done;
    input                                       i_mux_monox_s5_done;
    input                                       i_ntt_s6_done;
    input                                       i_mulacc_s7_done;
    input                                       i_intt_s8_done;
    input                                       i_ms_addx_s9_done;
    output                                      o_wruram_start;
    output                                      o_axi_s0_start;
    output                                      o_dp_ntt_s1_start;
    output                                      o_dp_muladd_s2_start;
    output                                      o_intt_s3_start;
    output                                      o_mext_s4_start;
    output                                      o_mux_monox_s5_start;
    output                                      o_ntt_s6_start;
    output                                      o_mulacc_s7_start;
    output                                      o_intt_s8_start;
    output                                      o_ms_addx_s9_start;

    input       [ 31 : 0]                       i_command;
    input       [LEVEL_WIDTH-1:0]               i_reduce_level;
    input       [ 31 : 0]                       i_col_size;
    input       [ 31 : 0]                       i_split;
    input       [ 31 : 0]                       i_index;

    output      [  1 : 0]                       o_dp_mode;
    output      [  2 : 0]                       o_idx_split;
    output                                      o_switch_mode;
    output                                      o_reduce_trace;
    output                                      o_mux_s5_mode;
    output                                      o_pre_tpp_switch;
    output                                      o_last_write;

    output      [LEVEL_WIDTH-1:0]               o_mux_monox_s5_n;
    output      [LEVEL_WIDTH-1:0]               o_mulacc_s7_n;
    output      [LEVEL_WIDTH-1:0]               o_ms_addx_s9_n;
    output      [ 11          :0]               o_coeff_index;
    output      [LEVEL_WIDTH-1:0]               o_uram_index;

    wire        [LEVEL_WIDTH-1:0]               o_mux_monox_s5_n;
    wire        [LEVEL_WIDTH-1:0]               o_mulacc_s7_n;
    wire        [LEVEL_WIDTH-1:0]               o_ms_addx_s9_n;
    wire        [LEVEL_WIDTH-1:0]               o_uram_index;

    reg                                         o_mvp_idle;
    reg         [          11 :0]               o_coeff_index;
    reg         [          15 :0]               o_stage_cnt;
    //reg                                         o_dp_muladd_s2_start;
    //wire                                        o_dp_muladd_s2_start_w;
    //reg                                         o_pre_tpp_switch;

    wire                                        mvp_real_start;
    wire                                        skip_trace;
    wire                                        all_stage_done;
    reg                                         start_pulse_r;
    reg                                         reduce_trace_r;
    reg         [MVP_STATUS_WIDTH-1:0]          mvp_status_r;
    wire        [MVP_STATUS_WIDTH-1:0]          mvp_status_nxt;
    reg         [LEVEL_WIDTH-1:0]               n_s5_r;
    reg         [LEVEL_WIDTH-1:0]               n_s6_r;
    reg         [LEVEL_WIDTH-1:0]               n_s7_r;
    reg         [LEVEL_WIDTH-1:0]               n_s8_r;
    reg         [LEVEL_WIDTH-1:0]               n_s9_r;
    reg         [REDUCE_BUFFER_WIDTH-1:0]       rb_status_r;
    reg         [1:0]                           delay;

    reg         [1:0]                           s2_cnt;
    reg         [11:0]                          s4_cnt;
    wire                                        stall_nxt;
    wire                                        stall_for_s2;
    wire                                        stall_for_s4;
    reg                                         stall_r;
    reg                                         stall_s2_r;
    reg                                         stall_s4_r;
    reg                                         stall_s0s1s2_r;
    reg                                         stall_s3s4_r;
    reg                                         write_uram;
    reg         [1:0]                           write_uram_cnt;

    assign mvp_real_start = i_command[0] & i_mvp_start;
    assign skip_trace = i_command[1];
    assign all_stage_done = (i_axi_s0_done       | !mvp_status_r[0]) &
                            (i_dp_ntt_s1_done    | !mvp_status_r[1]) &
                            (i_dp_muladd_s2_done | !mvp_status_r[2]) &
                            (i_wruram_done       | !mvp_status_r[2]) &
                            (i_intt_s3_done      | !mvp_status_r[3]) &
                            (i_mext_s4_done      | !mvp_status_r[4]) &
                            (i_mux_monox_s5_done | !mvp_status_r[5]) &
                            (i_ntt_s6_done       | !mvp_status_r[6]) &
                            (i_mulacc_s7_done    | !mvp_status_r[7]) &
                            (i_intt_s8_done      | !mvp_status_r[8]) &
                            (i_ms_addx_s9_done   | !mvp_status_r[9]) &
                            (delay == 2'b11);
    assign stall_nxt = (n_s8_r < 12) ? rb_status_r[n_s8_r] : 1'b0;
    assign stall_for_s2 = (s2_cnt != 0) & mvp_status_r[2];
    assign stall_for_s4 = (s4_cnt != i_index - 1) & mvp_status_r[3];

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            o_mvp_idle <= 1'b1;
        else if(mvp_real_start)
            o_mvp_idle <= 1'b0;
        else if(o_mvp_done)
            o_mvp_idle <= 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            o_stage_cnt <= 16'b0;
        else if(mvp_real_start)
            o_stage_cnt <= 16'b0;
        else if(start_pulse_r)
            o_stage_cnt <= o_stage_cnt + 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            delay <= 2'b0;
        else if(all_stage_done)
            delay <= 2'b0;
        else if(delay < 2'b11)
            delay <= delay + 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            start_pulse_r <= 1'b0;
        else if(all_stage_done & !o_mvp_idle)
            start_pulse_r <= 1'b1;
        else
            start_pulse_r <= 1'b0;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            reduce_trace_r <= 1'b0;
        else if(mvp_real_start)
            reduce_trace_r <= 1'b0;
        else if((n_s8_r == i_reduce_level) & !skip_trace)
            reduce_trace_r <= 1'b1;

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            stall_r <= 1'b0;
        else if(all_stage_done)
            stall_r <= stall_nxt;

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            stall_s2_r <= 1'b0;
        else if(all_stage_done)
            stall_s2_r <= stall_for_s2;

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            stall_s4_r <= 1'b0;
        else if(all_stage_done)
            stall_s4_r <= stall_for_s4;

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            stall_s0s1s2_r <= 1'b0;
        else if(all_stage_done)
            stall_s0s1s2_r <= stall_nxt & mvp_status_r[4] & !stall_for_s2;

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            stall_s3s4_r <= 1'b0;
        else if(all_stage_done)
            stall_s3s4_r <= stall_nxt & mvp_status_r[4];

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            mvp_status_r <= {MVP_STATUS_WIDTH{1'b0}};
        else if(mvp_real_start)
            mvp_status_r <= {MVP_STATUS_WIDTH{1'b0}};
        else if(all_stage_done)
            mvp_status_r <= mvp_status_nxt;

    assign mvp_status_nxt[0] = ((stall_nxt & mvp_status_r[4] & !stall_for_s2) | stall_for_s4) ? mvp_status_r[0] : !i_axi_s0_alldone;
    assign mvp_status_nxt[1] = ((stall_nxt & mvp_status_r[4] & !stall_for_s2) | stall_for_s4) ? mvp_status_r[1] : mvp_status_r[0];
    assign mvp_status_nxt[2] = ((stall_nxt & mvp_status_r[4] & !stall_for_s2) | stall_for_s4) ? mvp_status_r[2] : mvp_status_r[1];
    assign mvp_status_nxt[3] = ((stall_nxt & mvp_status_r[4]) | stall_for_s4 | stall_for_s2) ? mvp_status_r[3] : (mvp_status_r[2] & !write_uram);
    assign mvp_status_nxt[4] = ((stall_nxt & mvp_status_r[4]) | stall_for_s2) ? (!stall_nxt ? 1'b0 : mvp_status_r[4]) : mvp_status_r[3];
    assign mvp_status_nxt[5] = ((reduce_trace_r) ? mvp_status_r[8] : (mvp_status_r[4]|stall_nxt)) & (n_s8_r < 12);
    assign mvp_status_nxt[6] = mvp_status_r[5];
    assign mvp_status_nxt[7] = mvp_status_r[6];
    assign mvp_status_nxt[8] = mvp_status_r[7];
    assign mvp_status_nxt[9] = mvp_status_r[8];

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
        begin
            n_s5_r <= {LEVEL_WIDTH{1'b0}};
            n_s6_r <= {LEVEL_WIDTH{1'b0}};
            n_s7_r <= {LEVEL_WIDTH{1'b0}};
            n_s8_r <= {LEVEL_WIDTH{1'b0}};
            n_s9_r <= {LEVEL_WIDTH{1'b0}};
        end
        else if(mvp_real_start)
        begin
            n_s5_r <= {LEVEL_WIDTH{1'b0}};
            n_s6_r <= {LEVEL_WIDTH{1'b0}};
            n_s7_r <= {LEVEL_WIDTH{1'b0}};
            n_s8_r <= {LEVEL_WIDTH{1'b0}};
            n_s9_r <= {LEVEL_WIDTH{1'b0}};
        end
        else if (all_stage_done)
        begin
            n_s5_r <= (!mvp_status_nxt[5]) ? {LEVEL_WIDTH{1'b0}} :
                      ((stall_nxt|reduce_trace_r) ? n_s8_r + 1: 'd1);
            n_s6_r <= n_s5_r;
            n_s7_r <= n_s6_r;
            n_s8_r <= n_s7_r;
            n_s9_r <= n_s8_r;
        end
    end

    always @(posedge clk or negedge rst_n)
        if(!rst_n)
            rb_status_r <= {REDUCE_BUFFER_WIDTH{1'b0}};
        else if(mvp_real_start)
            rb_status_r <= {REDUCE_BUFFER_WIDTH{1'b0}};
        else if(stall_nxt & all_stage_done)
            rb_status_r[n_s8_r] <= 1'b0;
        else if((!stall_nxt) & mvp_status_r[8] & all_stage_done & (n_s8_r != 'd0))
            rb_status_r[n_s8_r] <= 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            s2_cnt <= 'b0;
        else if(mvp_real_start)
            s2_cnt <= 'b0;
        else if((s2_cnt == (i_split[2:0] - 1'b1)) & o_dp_muladd_s2_start)
            s2_cnt <= 'b0;
        //else if(i_dp_muladd_s2_done & mvp_status_r[2] & all_stage_done)
        else if(o_dp_muladd_s2_start)
            s2_cnt <= s2_cnt + 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            s4_cnt <= 'b0;
        else if(mvp_real_start)
            s4_cnt <= 'b0;
        //else if((s4_cnt == (i_index[11:0] - 1'b1)) & i_mext_s4_done & mvp_status_r[4] & all_stage_done)
        else if((s4_cnt == (i_index[11:0] - 1'b1)) & o_mext_s4_start)
            s4_cnt <= 'b0;
        //else if(i_mext_s4_done & mvp_status_r[4] & all_stage_done)
        else if(o_mext_s4_start)
            s4_cnt <= s4_cnt + 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            write_uram_cnt <= 'b0;
        else if(mvp_real_start)
            write_uram_cnt <= 'b0;
        else if(write_uram & i_wruram_done & mvp_status_r[2] & all_stage_done & (write_uram_cnt == i_split[2:0] - 1))
            write_uram_cnt <= 'b0;
        else if(write_uram & i_wruram_done & mvp_status_r[2] & all_stage_done)
            write_uram_cnt <= write_uram_cnt + 1'b1;

    always@(posedge clk or negedge rst_n)
        if(!rst_n)
            write_uram <= 1'b0;
        else if(mvp_real_start)
            write_uram <= 1'b1;
        else if((write_uram_cnt == i_split[2:0] - 1) & i_wruram_done & all_stage_done & mvp_status_r[2])
            write_uram <= 1'b0;

    always@(*)
        if(i_index > 1)
            o_coeff_index = (s4_cnt == 0) ? i_index * i_col_size - 1 : s4_cnt * i_col_size - 1; 
        else if(i_split[2:0] == 'b1)
            o_coeff_index = i_col_size - 1'b1;
        else
            o_coeff_index = 'hfff;

    assign o_pre_tpp_switch = (i_dp_muladd_s2_done & ((s2_cnt == 0) | !mvp_status_r[2])) &
                              i_intt_s3_done & !o_dp_muladd_s2_start & !o_intt_s3_start & !o_mext_s4_start &
                              (i_mext_s4_done & ((s4_cnt == 0) | !mvp_status_r[4]));

    //output signals generation
    //always@(posedge clk) o_dp_muladd_s2_start <= o_dp_muladd_s2_start_w;
    assign o_mvp_done = ((n_s9_r == 12) | (skip_trace & (n_s9_r == i_reduce_level))) & mvp_status_r[9] & all_stage_done;  // Xuanle
    assign o_reduce_trace = reduce_trace_r;
    assign o_axi_s0_start = start_pulse_r & mvp_status_r[0] & !stall_s0s1s2_r & !stall_s4_r;
    assign o_dp_ntt_s1_start = start_pulse_r & mvp_status_r[1] & !stall_s0s1s2_r & !stall_s4_r & !o_mvp_idle;
    assign o_dp_muladd_s2_start = start_pulse_r & mvp_status_r[2] & !stall_s0s1s2_r & !stall_s4_r & !write_uram;
    assign o_wruram_start = start_pulse_r & mvp_status_r[2] & write_uram;
    assign o_intt_s3_start = start_pulse_r & mvp_status_r[3] & !stall_s3s4_r & !stall_s4_r & !stall_s2_r;
    assign o_mext_s4_start = start_pulse_r & mvp_status_r[4] & !stall_s3s4_r & !stall_s2_r;
    assign o_mux_monox_s5_start = start_pulse_r & mvp_status_r[5];
    assign o_ntt_s6_start = start_pulse_r & mvp_status_r[6];
    assign o_mulacc_s7_start = start_pulse_r & mvp_status_r[7];
    assign o_intt_s8_start = start_pulse_r & mvp_status_r[8];
    assign o_ms_addx_s9_start = start_pulse_r & mvp_status_r[9];
    assign o_mux_s5_mode = stall_r | reduce_trace_r;
    assign o_switch_mode = start_pulse_r & (|mvp_status_r[9:5]);
    assign o_uram_index = (reduce_trace_r | o_mvp_idle) ? 'd0 : (n_s9_r - 1);
    assign o_mulacc_s7_n = (n_s7_r > i_reduce_level) ? (12 + i_reduce_level - n_s7_r) : n_s7_r - 1;
    assign o_ms_addx_s9_n = (n_s9_r >= i_reduce_level) ? 'd0 : n_s5_r;  // Xuanle
    assign o_mux_monox_s5_n = (n_s5_r > i_reduce_level) ? (13 + i_reduce_level - n_s5_r) : n_s5_r;
    assign o_last_write = (n_s9_r == 12) | (skip_trace & (n_s9_r == i_reduce_level));
    assign o_dp_mode = write_uram ? 2'b01 : 2'b10;
    assign o_idx_split = write_uram ? {1'b0, write_uram_cnt} : ((s2_cnt == 0) ? (i_split[2:0] - 1) : {1'b0, s2_cnt - 1});

endmodule
