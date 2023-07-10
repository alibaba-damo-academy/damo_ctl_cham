//////////////////////////////////////////////////
// Engineer: Gu Zhen (jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP
// Module Name: DP_core
// Modify Date: 03/12/2022 16:10

// Description: contains 3 ntt core and 6 muladd core
//////////////////////////////////////////////////

`include "dp_defines.vh"
module dp_core#(
    parameter COE_WIDTH          = 35,
    parameter Q_TYPE             = 0,
    parameter ADDR_WIDTH         = 9,        // Depth of ram is 1<<ADDR_WIDTH
    parameter URAM_ADDR_WIDTH    = 12,
    parameter NUM_SPLIT          = `MAX_N_SPLIT,
    parameter LOG_NUM_BANK       = 3,        // width of the bank select signal
    parameter NUM_POLY           = 3,        // number of polys in one polyvec
    parameter NUM_BASE_BANK      = 8,        // number of banks for one poly
    parameter COMMON_BRAM_DELAY  = 1,
    parameter COMMON_URAM_DELAY  = `COMMON_URAM_DELAY,
    parameter DP_MADD_PIP_DELAY  = 4
)(
    input                                                  clk,
    input                                                  rst_n,
    // ntt ports
    input                                                  ntt_start,
    output                                                 ntt_done,
    input       [1:0]                                      i_idx_split,
    output      [NUM_BASE_BANK*NUM_POLY-1:0]               o_ntt_we,         // o_we_a_l,
    output      [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]    o_ntt_wraddr,     //o_addr_a_l,
    output      [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]     o_ntt_data,       //o_data_a
    output      [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]    o_ntt_rdaddr,     //o_addr_b_l,
    input       [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]     i_ntt_data,       //i_data_b_l,
    // madd ports
    input                                                  i_madd_start,
    output                                                 o_madd_done,
    // madd ports to downstream buffer
    output                                                 o_madd_nxt_we,
    output      [ADDR_WIDTH+LOG_NUM_BANK-1:0]              o_madd_nxt_wraddr,
    output      [COE_WIDTH*NUM_POLY*2-1:0]                 o_madd_nxt_dout,
    // madd ports from upstream buffer
    output      [ADDR_WIDTH+LOG_NUM_BANK-1:0]              o_madd_nxt_rdaddr,
    input       [COE_WIDTH*NUM_POLY*2-1:0]                   i_madd_nxt_din_psum,
    output      [(ADDR_WIDTH+LOG_NUM_BANK)*NUM_BASE_BANK-1:0]              o_madd_rdaddr,
    output      [ADDR_WIDTH+LOG_NUM_BANK-1:0]               o_madd_curaddr,
    input       [COE_WIDTH*NUM_POLY-1:0]                   i_madd_dina,
    output      [URAM_ADDR_WIDTH-1 : 0]                  o_uram_addr,
    input       [NUM_POLY*COE_WIDTH*2-1 : 0]               i_uram_din
);

/* ntt and exclusive buffer wire (i.e.right-side buffer) */
    wire    [NUM_POLY-1:0]                              ntt_done_base;
    wire    [NUM_BASE_BANK*NUM_POLY-1:0]                o_we_a_r;
    wire    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]     o_addr_a_r;
    wire    [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]      i_data_b_r;
    wire    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]     o_addr_b_r;

/* generate #NUM_INTT cores */
genvar index_ntt;
generate
    for(index_ntt= 0; index_ntt<NUM_POLY; index_ntt = index_ntt+1) begin

        wire                      o_we_a_l_base;
        wire                      o_we_a_r_base;
        wire   [ADDR_WIDTH-1:0]   o_addr_a_l_base;
        wire   [ADDR_WIDTH-1:0]   o_addr_a_r_base;
        wire   [ADDR_WIDTH-1:0]   o_addr_b_l_base;
        wire   [ADDR_WIDTH-1:0]   o_addr_b_r_base;

        ntt_core#(
            .COE_WIDTH(39),
            .Q_TYPE (index_ntt),
            .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
        )
        ntt(
            .clk(clk),
            .rst_n(rst_n),
            .ntt_start(ntt_start),
            .ntt_done(ntt_done_base[index_ntt]),
            .i_data_b_l(i_ntt_data[(index_ntt+1)*39*NUM_BASE_BANK-1 -: 39*NUM_BASE_BANK]),
            .i_data_b_r(i_data_b_r[(index_ntt+1)*39*NUM_BASE_BANK-1 -: 39*NUM_BASE_BANK]),
            .o_we_a_l(o_we_a_l_base),
            .o_we_a_r(o_we_a_r_base),
            .o_data_a(o_ntt_data[(index_ntt+1)*39*NUM_BASE_BANK-1 -: 39*NUM_BASE_BANK]),
            .o_addr_a_l(o_addr_a_l_base),
            .o_addr_a_r(o_addr_a_r_base),
            .o_addr_b_l(o_addr_b_l_base),
            .o_addr_b_r(o_addr_b_r_base)
        );
        assign ntt_done = &ntt_done_base;    // ntt_done posedge when all ntt_done_base posedge
        assign o_ntt_we[(index_ntt+1)*NUM_BASE_BANK-1 -: NUM_BASE_BANK] = {NUM_BASE_BANK{o_we_a_l_base}};
        assign o_we_a_r[(index_ntt+1)*NUM_BASE_BANK-1 -: NUM_BASE_BANK] = {NUM_BASE_BANK{o_we_a_r_base}};
        assign o_ntt_wraddr[(index_ntt+1)*ADDR_WIDTH*NUM_BASE_BANK-1 -: ADDR_WIDTH*NUM_BASE_BANK] = {NUM_BASE_BANK{o_addr_a_l_base}};
        assign o_addr_a_r[(index_ntt+1)*ADDR_WIDTH*NUM_BASE_BANK-1 -: ADDR_WIDTH*NUM_BASE_BANK] = {NUM_BASE_BANK{o_addr_a_r_base}};
        assign o_ntt_rdaddr[(index_ntt+1)*ADDR_WIDTH*NUM_BASE_BANK-1 -: ADDR_WIDTH*NUM_BASE_BANK] = {NUM_BASE_BANK{o_addr_b_l_base}};
        assign o_addr_b_r[(index_ntt+1)*ADDR_WIDTH*NUM_BASE_BANK-1 -: ADDR_WIDTH*NUM_BASE_BANK] = {NUM_BASE_BANK{o_addr_b_r_base}};
    end
endgenerate

/* NTT exclusive buffer */
polyvec_ram#(
    .COE_WIDTH(39),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(ADDR_WIDTH),                    // Depth of ram is 1<<ADDR_WIDTH
    .NUM_POLY(NUM_POLY),                        // number of polys in one polyvec
    .NUM_BASE_BANK(NUM_BASE_BANK),              // number of banks for one poly
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
polyvec_ntt(
    .clk(clk),
    .wea(o_we_a_r),
    .addra(o_addr_a_r),
    .dina(o_ntt_data),
    .addrb(o_addr_b_r),
    .doutb(i_data_b_r)
);


/* instance madd */
wire [NUM_POLY*COE_WIDTH*2-1 : 0] madd_dina, uram_din;
wire [NUM_POLY*COE_WIDTH*2-1 : 0] madd_nxt_din_psum, madd_nxt_dout;

madd_top #(
    .COE_WIDTH(COE_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .LOG_NUM_BANK(3),
    .NUM_POLY(NUM_POLY*2),
    .NUM_BASE_BANK(NUM_BASE_BANK),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
    .COMMON_URAM_DELAY(COMMON_URAM_DELAY),
    .DP_MADD_PIP_DELAY(DP_MADD_PIP_DELAY)
) madd
(
    .clk(clk),
    .rst_n(rst_n),
    .i_madd_start(i_madd_start),
    .o_madd_done(o_madd_done),
    .i_idx_split(i_idx_split),
    .o_madd_nxt_we(o_madd_nxt_we),
    .o_madd_nxt_wraddr(o_madd_nxt_wraddr),
    .o_madd_nxt_dout(o_madd_nxt_dout),
    .o_madd_nxt_rdaddr(o_madd_nxt_rdaddr),
    .i_madd_nxt_din_psum(i_madd_nxt_din_psum),
    .o_madd_curaddr(o_madd_curaddr),
    .o_madd_rdaddr(o_madd_rdaddr),
    .i_madd_dina(madd_dina),
    .o_madd_uram_rdaddr(o_uram_addr),
    .i_madd_dinb(uram_din)
);

genvar idx_poly;
generate
    for(idx_poly = 0; idx_poly < NUM_POLY; idx_poly = idx_poly + 1) begin
        assign madd_dina[COE_WIDTH*2*idx_poly +: COE_WIDTH*2] = {2{i_madd_dina[COE_WIDTH*idx_poly +: COE_WIDTH]}};
        assign uram_din[COE_WIDTH*2*idx_poly +: COE_WIDTH*2] = {i_uram_din[COE_WIDTH*(NUM_POLY+idx_poly) +: COE_WIDTH], i_uram_din[COE_WIDTH*idx_poly +: COE_WIDTH]};
    end
endgenerate
endmodule
