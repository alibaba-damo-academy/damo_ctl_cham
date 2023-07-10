// `include "monox_defines.vh"

/*
    Author: Jianming Tong (jianming.tong@gatech.edu)
    Modified by: Shengrong Liu (srliu1997@pku.edu.cn)
*/

module shuffle_seq#(
    parameter DATA_WIDTH = 64,
    parameter MODULUS_WIDTH = 35,
    parameter INDEX_WIDTH = 13,
    parameter IN_MODULUS = 35'h4_0008_0001
)(
    input clk,
    input rst_n,

    input i_valid,                             // input data valid
    input [MODULUS_WIDTH-1:0] i_data,          // input data
    input [INDEX_WIDTH-1:0] i_galois_elt,      // input galois

    output reg [DATA_WIDTH-1:0] o_data,        // output data --> for writing BRAM
    output reg [INDEX_WIDTH-2:0] o_addr,       // output addr --> for writing BRAM
    output reg o_we                            // output write enable --> for writing BRAM
);

always @(posedge clk or negedge rst_n)
    if (!rst_n)
        o_we <= 1'b0;
    else
        o_we <= i_valid;

reg [INDEX_WIDTH-1:0] index_raw;

always @(posedge clk)
    if (i_valid)
        index_raw <= index_raw + i_galois_elt;
    else
        index_raw <= 0;

always @(posedge clk)
    if (i_valid)
        o_addr <= index_raw[INDEX_WIDTH-2:0];

wire [MODULUS_WIDTH-1:0] negate;

assign negate = i_data ? IN_MODULUS - i_data : 0;

always @(posedge clk)
    if (i_valid)
        o_data <= {{(DATA_WIDTH - MODULUS_WIDTH){1'b0}}, index_raw[INDEX_WIDTH-1] ? negate : i_data};

endmodule

/*
    Top Module:  shuffle.v
    Data:        Unsign format, 64 bit (most significant (bit 64 ~ bit 35) are 0)
    Role:        read the corresponding address from BRAM and execute negate or bypass
    Warm-up:     Not input & output valid, start process when detecting high i_valid.
                 the first data comes out "2" cycles after i_valid set high.
                 initial interval (II = 1)
    Timing:      Sequential Logic, 2-cycle latency
                    first cycle: address generation & negate res
                    second cycle: output selection & zero extension.
    Dummy Data:  {DATA_WIDTH{1'b0}}
    Function:
                                                    ||
                        first_cycle                 ||                second_cycle
                                                    ||
                                ____
        [INDEX_WIDTH-1:0]       |   |
        i_galois_elt  ------->  |   |
                ____            | + |---------------> index_raw[INDEX_WIDTH-2:0]------------------------> o_addr
        |--->   _|_|    --->    |   |    |                   |
        |inner_index_raw        |___|    |                   |
        |________________________________|                   |
                                                    index_raw[INDEX_WIDTH-1]
                                __________                   |
                                |         |                  |
        IN_MODULUS -----------> |  normal | inner_negate    |\v                     ________________
                                |   sub   |------------->   |1\                    |                |
            i_data -----------> |         |                 |  |----> inner_res--> | zero_extension | --> o_data
        [MODULUS_WIDTH-1:0] |   |_________| inner_by        |  |                   |________________|
                            |--------------------------->   |0/
                                                            |/
*/