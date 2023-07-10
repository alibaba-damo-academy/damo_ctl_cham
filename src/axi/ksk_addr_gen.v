module ksk_addr_gen
(
    input   wire    clk,
    input   wire    [31:0]  i_ksk_addr_in,
    output  wire    [3:0]   o_ksk_stage,
    output  wire    [3:0]   o_ksk_index,
    output  wire    [8:0]   o_ksk_addr_out
);

    reg [31:0] addr_in_m1;
    always @ (posedge clk) begin
        addr_in_m1 <= i_ksk_addr_in;
    end
    wire change;
    assign change = (i_ksk_addr_in != addr_in_m1);

    wire [8:0] addr;
    assign addr = i_ksk_addr_in[8:0];
    assign o_ksk_addr_out = addr;

    reg [3:0] stage_r;
    reg [3:0] index_r;
    wire [3:0] stage_nxt;
    wire [3:0] index_nxt;
    reg [3:0] stage_nxt_r;
    reg [3:0] index_nxt_r;

    assign stage_nxt = (addr == 9'd511 && index_r == 4'd11) ? stage_r + 1 : stage_r;
    assign index_nxt = (addr == 9'd511) ? ((index_r == 4'd11) ? 4'd0 : index_r + 1) : index_r;

    always @ (posedge clk) begin
        stage_nxt_r <= stage_nxt;
        index_nxt_r <= index_nxt;
    end

    always @ (posedge clk) begin
        if (i_ksk_addr_in == 'b0) begin
            stage_r <= 'b0;
            index_r <= 'b0;
        end
        else if (change) begin
            stage_r <= stage_nxt_r;
            index_r <= index_nxt_r;
        end
    end

    assign o_ksk_stage = change ? stage_nxt_r : stage_r;
    assign o_ksk_index = change ? index_nxt_r : index_r;

endmodule
