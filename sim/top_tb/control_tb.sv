module control_tb #(
    parameter LEVEL_WIDTH = 4,
    parameter N_STAGE = 11
)
(
    input   logic                                   clk,
    input   logic                                   rst_n,
    // start/done
    input   logic                                   i_init,
    output  logic   [N_STAGE-1:0]                   o_start,
    input   logic   [N_STAGE-1:0]                   i_done,
    output  logic                                   o_switch_mode,
    
    // level
    input   logic   [LEVEL_WIDTH-1:0]               i_level,
    output  logic   [4:0][LEVEL_WIDTH-1:0]          o_level_x5
);

    localparam  N_REDUCE_STAGE = 5;
    localparam  REDUCE_START_STAGE = 5;

    logic                                       alldone, alldone_d1, alldone_d2, alldone_d3;
    logic                                       start_valid;
    logic [N_STAGE-1:0]                         status_r, status_nxt;
    logic [N_REDUCE_STAGE-1:0][LEVEL_WIDTH-1:0] level, level_nxt;

    // init
    logic                                   init_d1, init_d2, init;
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            init_d1 <= 0;
            init_d2 <= 0;
        end
        else begin
            init_d1 <= i_init;
            init_d2 <= init_d1;
        end
    end
    assign init = init_d1 & ~init_d2;

    // done
    assign alldone = &(~status_r | i_done) & (|status_r);

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            alldone_d1 <= 0;
            alldone_d2 <= 0;
            alldone_d3 <= 0;
        end
        else begin
            alldone_d1 <= alldone;
            alldone_d2 <= alldone_d1;
            alldone_d3 <= alldone_d2;
        end
    end
    assign start_valid = alldone_d2 & ~alldone_d3;
    assign o_switch_mode = start_valid;


    // status
    assign o_start = (start_valid | init)? status_nxt : 0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) status_r <= 0;
        else status_r <= status_nxt;
    end
    assign status_nxt = start_valid ? {status_r[N_STAGE-2:0], 1'b0} :
                        init? {status_r[N_STAGE-2:0], 1'b1} : status_r;


    // level
    assign o_level_x5 = level;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) level <= 0;
        else level <= level_nxt;
    end
    assign level_nxt = start_valid & status_r[REDUCE_START_STAGE-1]? {level[N_REDUCE_STAGE-2:0], i_level} :
                        start_valid ? {level[N_REDUCE_STAGE-2:0], {LEVEL_WIDTH{1'b0}}} : level;


endmodule
