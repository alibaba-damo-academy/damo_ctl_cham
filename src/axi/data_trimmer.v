module data_trimmer #(
    parameter IN_WIDTH      = 64,
    parameter OUT_WIDTH     = 39,
    parameter DATA_COUNT    = 8
)
(
    input   wire    [DATA_COUNT*IN_WIDTH-1:0]   trim_in,
    output  wire    [DATA_COUNT*OUT_WIDTH-1:0]  trim_out
);

    localparam DIFF_WIDTH = OUT_WIDTH - IN_WIDTH;

    genvar i;
    generate
        for (i = 0; i < DATA_COUNT; i = i + 1) begin : gen_trim
            if (IN_WIDTH > OUT_WIDTH) begin
                assign trim_out[i*OUT_WIDTH +: OUT_WIDTH] =
                       trim_in[i*IN_WIDTH +: OUT_WIDTH];
            end
            else if (IN_WIDTH < OUT_WIDTH) begin
                assign trim_out[i*OUT_WIDTH +: OUT_WIDTH] =
                       {{DIFF_WIDTH{1'b0}}, trim_in[i*IN_WIDTH +: IN_WIDTH]};
            end
            else begin
                assign trim_out[i*OUT_WIDTH +: OUT_WIDTH] =
                       trim_in[i*IN_WIDTH +: IN_WIDTH];
            end
        end
    endgenerate

endmodule
