// `include "monox_defines.vh"

/*
    Author: Jianming Tong (jianming.tong@gatech.edu)
    Modified by: Shengrong Liu (srliu1997@pku.edu.cn)
*/

module cross_aggressive_seq#(
    parameter DATA_WIDTH = 64,
    parameter MODULUS_WIDTH = 35,
    parameter IN_MODULUS = 35'h4_0008_0001
)(
    input clk,
    input [MODULUS_WIDTH-1:0] A, B, C, D,
    output reg [DATA_WIDTH-1:0] AC_sum, BD_sum,
    output reg [MODULUS_WIDTH-1:0] AC_sub, BD_sub
);

/*
    first clock cycle: modulus arithmetic.
*/

reg [MODULUS_WIDTH:0] AC_sum_tmp, BD_sum_tmp, AC_sub_tmp, BD_sub_tmp;
reg AC_sub_flag, BD_sub_flag;

always @(posedge clk)
    AC_sum_tmp <= A + C;

always @(posedge clk)
    BD_sum_tmp <= B + D;

always @(posedge clk)
    AC_sub_tmp <= A - C;

always @(posedge clk)
    AC_sub_flag <= A >= C;

always @(posedge clk)
    BD_sub_tmp <= B - D;

always @(posedge clk)
    BD_sub_flag <= B >= D;

/*
    second clock cycle: unsigned results correction for modulus result.
*/

always @(posedge clk) begin
    AC_sum[MODULUS_WIDTH-1:0] <= AC_sum_tmp >= IN_MODULUS ? AC_sum_tmp - IN_MODULUS : AC_sum_tmp;
    AC_sum[DATA_WIDTH-1:MODULUS_WIDTH] <= 0;
end

always @(posedge clk) begin
    BD_sum[MODULUS_WIDTH-1:0] <= BD_sum_tmp >= IN_MODULUS ? BD_sum_tmp - IN_MODULUS : BD_sum_tmp;
    BD_sum[DATA_WIDTH-1:MODULUS_WIDTH] <= 0;
end

always @(posedge clk)
    AC_sub <= AC_sub_flag ? AC_sub_tmp : AC_sub_tmp + IN_MODULUS;

always @(posedge clk)
    BD_sub <= BD_sub_flag ? BD_sub_tmp : BD_sub_tmp + IN_MODULUS;

endmodule

/*
    Top Module:  cross_aggressive_seq.v
    Data:        Unsign format, 64 bit (most significant (64-35) bits are 0)
    Role:        read the corresponding address from BRAM and execute negate or bypass
    Warm-up:     Not input & output valid, start process when detecting high i_en.
                 the first data comes out "3" cycles after i_en set high.
                 initial interval (II = 1)
    Timing:      Sequential Logic, 3-cycle latency
                    first cycle: normal subtraction & add
                    second cycle: sub&add's result correction to modulus sub & modulus add
                    third cycle: output selection & zero extension (for A+B & C+D)
    Dummy Data:  {DATA_WIDTH{1'b0}}
    Function:

                                            ||
                                            ||
                first clock cycle           ||                  second clock cycle
                                            ||
                                            ||
                                                                inner_o_select_ctrl[0]
                                                        >=modulus   _______
                                                            |-------|_reg_|-------------------------
                            _________                       |                                      |
                            |       |                       |     __________                       |
            A      -------> |       |  res_uncorrected      |    |          |    res_corrected    |\v
            B      -------> |       | [MODULUS_WIDTH:0]     |    |  normal  |    [0*IRW+:IRW]     | \
                            |normal |------------------------->  |   sub    |-------------------->|1 \         _______________
    [MODULUS_WIDTH-1:0]     |  ADD  |    IN_MODULUS----------->  |in-modulus|                     |   |----->  |zero extension| ---> o_data_bus[DATA_WIDTH-1:0]
                            |       |                            |__________|                     |   |        |______________|
                            |_______|                                          ------------------>|0 /
                                                                                res_uncorrected   | /
                                                                                [0*MW+:MW]        |/


                                                                inner_o_select_ctrl[1]
                                                        >=modulus _______
                            ________                      |-------|_reg_|-------------------------
                            |       |                     |                                      |
            C      -------> |       |                     |     __________                       |
            D      -------> |       |  res_uncorrected    |    |          |     res_corrected   |\v
                            |normal |  [1*IRW+:IRW]       |    |  normal  |     [1*IRW+:IRW]    | \
    [MODULUS_WIDTH-1:0]     |  ADD  |------------------------->|   sub    |-------------------->|1 \         _______________
                            |       |    IN_MODULUS----------->|in-modulus|                     |   |----->  |zero extension| ---> o_data_bus[1*DATA_WIDTH+:DATA_WIDTH]
                            |_______|                          |__________|                     |   |        |______________|
                                                                            ------------------->|0 /
                                                                                res_uncorrected | /
                                                                                [1*MW+:MW]      |/


                                                                sub_correct[0]
                                                        A >= B    _______
                            _________                     |-------|_reg_|-------------------------
                            |       |                     |                                      |
            A      -------> |       |                     |     __________                       |
            B      -------> |  SUB  |  res_uncorrected    |    |          |     res_corrected   |\v
                            |normal |   [2*IRW+:IRW]      |    |  normal  |     [2*IRW+:IRW]    | \
    [MODULUS_WIDTH-1:0]     |  A-B  |------------------------->|   add    |-------------------->|1 \
                            |       |    IN_MODULUS----------->|in+modulus|                     |   |-----> o_data_bus[2*MW+:MW]
                            |_______|                          |__________|                     |   |
                                                                            ------------------->|0 /
                                                                                res_uncorrected | /
                                                                                [2*MW+:MW]      |/


                                                                sub_correct[1]
                                                        A >= B    _______
                            _________                     |-------|_reg_|-------------------------
                            |       |                     |                                      |
                            |       |                     |     __________                       |
            C      -------> |       |  res_uncorrected    |    |          |     res_corrected   |\v
            D      -------> |  SUB  |   [3*IRW+:IRW]      |    |  normal  |     [3*IRW+:IRW]    | \
                            |normal |------------------------->|   add    |-------------------->|1 \
    [MODULUS_WIDTH-1:0]     |  C-D  |    IN_MODULUS----------->|in+modulus|                     |   |-----> o_data_bus[3*MW+:MW]
                            |       |                          |__________|                     |   |
                            |_______|                                        ------------------>|0 /
                                                                                res_uncorrected | /
                                                                                [3*MW+:MW]      |/

    Abbreviate:
        IRW = INNER_RES_WIDTH = MODULUS_WIDTH + 1
        MW  = MODULUS_WIDTH

    Data layout:
            i_data layout
            MSB                                                           LSB
            [MODULUS_WIDTH | MODULUS_WIDTH | MODULUS_WIDTH | MODULUS_WIDTH]
                    D               C               B               A

            res_uncorrected
            MSB                                                                   LSB
            [MODULUS_WIDTH+1 | MODULUS_WIDTH+1 | MODULUS_WIDTH+1 | MODULUS_WIDTH+1]
                   C-D               A-B               C+D               A+B

            o_data layout
            MSB                                                           LSB
            [MODULUS_WIDTH | MODULUS_WIDTH | MODULUS_WIDTH | MODULUS_WIDTH]
                   C-D             A-B             C+D             A+B
    Note:
        In this design, we assume the bit length of the modulus is smaller than the bit length of the data.
*/