//////////////////////////////////////////////////
// Engineer: Gu Zhen (jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP_v12
// Module Name: dp_top
// Modify Date: 03/12/2022 16:10

// Description: include tripple-pingpong modules and dp cores, uram is initantiated for ciphertext storage
//////////////////////////////////////////////////

`include "dp_defines.vh"

module dp_top#(
    parameter COE_WIDTH          = 39,
    parameter ADDR_WIDTH         = 9,        // Depth of ram is 1<<ADDR_WIDTH
    parameter URAM_ADDR_WIDTH    = 12,
    parameter NUM_SPLIT          = `MAX_N_SPLIT,
    parameter LOG_NUM_BANK       = 3,        // width of the bank select signal
    parameter NUM_POLY           = 3,        // number of polys in one polyvec
    parameter NUM_BASE_BANK      = 8,        // number of banks for one poly
    parameter COMMON_BRAM_DELAY  = `COMMON_BRAM_DELAY,
    parameter COMMON_URAM_DELAY  = `COMMON_URAM_DELAY,
    parameter BRAM_DEPTH         = `BRAM_DEPTH,
    parameter DP_MADD_PIP_DELAY  = 4
)(
    input                                               clk,
    input                                               rst_n,
    // axi control and input ports
    input [1:0]                                         i_idx_split,           
    input [1:0]                                         i_mode,                 //01 for ciphertext vec, 10 for plaintext mat
    input                                               i_axi_done,
    input [NUM_BASE_BANK*NUM_POLY*2-1:0]                i_axi_we,
    input [ADDR_WIDTH*NUM_BASE_BANK-1:0]                i_axi_wraddr,
    input [COE_WIDTH*NUM_BASE_BANK-1:0]                 i_axi_data,
    // ntt control ports
    input                                               i_ntt_start,
    output                                              o_ntt_done,
    input                                               i_wruram_start,
    output                                              o_wruram_done,
    // madd control ports
    input                                               i_madd_start,
    output                                              o_madd_done,
    output                                              o_madd_we,
    output [ADDR_WIDTH+LOG_NUM_BANK-1:0]                o_madd_wraddr,
    output [COE_WIDTH*NUM_POLY*4-1:0]                   o_madd_data,
    output [ADDR_WIDTH+LOG_NUM_BANK-1:0]                o_madd_rdaddr,
    input  [COE_WIDTH*NUM_POLY*4-1:0]                   i_madd_data
);

localparam M_CTXT = 2'b01;
localparam M_PTXT = 2'b10;
localparam NUM_BANK = NUM_BASE_BANK * NUM_POLY;
wire axi_ntt_madd_done;
//wire madd_mux_done;

wire [1:0] o_ntt_done_base;
wire [1:0] o_madd_done_base;

/* done control logic */
assign axi_ntt_madd_done = i_axi_done && o_ntt_done && (i_mode==M_CTXT? o_wruram_done : o_madd_done);

/* ntt internal signals */
(* keep = "true" *) wire [NUM_BASE_BANK*NUM_POLY*2-1:0]                 ntt_we;
(* keep = "true" *) wire [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1:0]      ntt_wraddr;
(* keep = "true" *) wire [COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1:0]       ntt_tpp_data;
(* keep = "true" *) wire [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1:0]      ntt_rdaddr;
(* keep = "true" *) wire [COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1:0]       tpp_ntt_data;
(* keep = "true" *) wire [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]        madd_rdaddr;
(* keep = "true" *) wire  [COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1 : 0]    tpp_madd_data;
(* keep = "true" *) wire [ADDR_WIDTH+LOG_NUM_BANK-1:0]                  madd_curaddr;
(* keep = "true" *) wire  [COE_WIDTH*NUM_POLY*2-1 : 0]                  madd_dina;
(* keep = "true" *) wire  [(ADDR_WIDTH+LOG_NUM_BANK)*NUM_BASE_BANK-1 : 0]madd_dina_rdaddr;


//URAM logic
wire    [NUM_SPLIT-1 : 0]                         uram_en_bundle[0: NUM_SPLIT-1];
wire    [NUM_SPLIT-1 : 0]                         uram_mem_en;
wire    [NUM_SPLIT-1 : 0]                         uram_we;
wire    [URAM_ADDR_WIDTH*NUM_BASE_BANK-1 : 0]     uram_tpp_rdaddr;
wire    [URAM_ADDR_WIDTH-1 : 0]                   uram_rdaddr, uram_wraddr; 
wire    [COE_WIDTH*NUM_POLY*2 -1 : 0]             uram_din, uram_dout;       

 
genvar idx;
generate
    for(idx = 0; idx < NUM_SPLIT; idx = idx + 1) begin
        assign uram_en_bundle [idx] = 'd1 << idx;
    end
endgenerate

assign uram_mem_en = uram_en_bundle[i_idx_split];
//always @ (*) begin
//    if(o_wruram_done) uram_we <= 'd0;
//    else if(i_mode == M_CTXT) uram_we = uram_en_bundle[i_idx_split];
//    else uram_we = 'd0;
//end
assign uram_we = (o_wruram_done? 'd0: (i_mode == M_CTXT? uram_en_bundle[i_idx_split] : 'd0));
dp_ctxt_polyvec #(
    .COE_WIDTH(COE_WIDTH),
    .ADDR_WIDTH(URAM_ADDR_WIDTH),
    .NUM_POLY(NUM_POLY),
    .NUM_BASE_BANK(NUM_BASE_BANK),
    .NUM_SPLIT(NUM_SPLIT),
    .COMMON_URAM_DELAY(COMMON_URAM_DELAY),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
    .BRAM_DEPTH(BRAM_DEPTH)
) ctxt_polyvec(
    .clk(clk),
    .rst_n(rst_n),
    .i_idx_split(i_idx_split),
    .i_wruram_start(i_wruram_start),
    .o_wruram_done(o_wruram_done),
    .i_uram_mem_en(uram_mem_en),
    .i_uram_we(uram_we),
    .o_tpp_rdaddr(uram_tpp_rdaddr),
    .o_uram_wraddr(uram_wraddr),
    .i_uram_rdaddr(uram_rdaddr),
    .i_uram_din(uram_din),
    .o_uram_dout(uram_dout)
);
genvar idx_poly;
generate
    for(idx_poly = 0; idx_poly < NUM_POLY; idx_poly = idx_poly + 1) begin
        assign uram_din[idx_poly*COE_WIDTH +: COE_WIDTH] =  tpp_madd_data[COE_WIDTH*(NUM_BASE_BANK*idx_poly+uram_wraddr[LOG_NUM_BANK-1:0]) +: COE_WIDTH];
        assign madd_dina[idx_poly*COE_WIDTH +: COE_WIDTH] =  tpp_madd_data[COE_WIDTH*(NUM_BASE_BANK*idx_poly+madd_curaddr[LOG_NUM_BANK-1:0]) +: COE_WIDTH];
        assign uram_din[(NUM_POLY+idx_poly)*COE_WIDTH +: COE_WIDTH] =  tpp_madd_data[COE_WIDTH*(NUM_BASE_BANK*(NUM_POLY+idx_poly)+uram_wraddr[LOG_NUM_BANK-1:0]) +: COE_WIDTH];
        assign madd_dina[(NUM_POLY+idx_poly)*COE_WIDTH +: COE_WIDTH] =  tpp_madd_data[COE_WIDTH*(NUM_BASE_BANK*(NUM_POLY+idx_poly)+madd_curaddr[LOG_NUM_BANK-1:0]) +: COE_WIDTH];
    end
    for(idx_poly = 0; idx_poly < NUM_BASE_BANK; idx_poly = idx_poly + 1) begin
        assign madd_rdaddr[ADDR_WIDTH*idx_poly +: ADDR_WIDTH] = (i_mode == M_CTXT? uram_tpp_rdaddr[idx_poly*URAM_ADDR_WIDTH+LOG_NUM_BANK +: ADDR_WIDTH] : madd_dina_rdaddr[idx_poly*URAM_ADDR_WIDTH+LOG_NUM_BANK +: ADDR_WIDTH]);
        assign madd_rdaddr[ADDR_WIDTH*(idx_poly+NUM_BASE_BANK) +: ADDR_WIDTH] = (i_mode == M_CTXT? uram_tpp_rdaddr[idx_poly*URAM_ADDR_WIDTH+LOG_NUM_BANK +: ADDR_WIDTH] : madd_dina_rdaddr[idx_poly*URAM_ADDR_WIDTH+LOG_NUM_BANK +: ADDR_WIDTH]);
        assign madd_rdaddr[ADDR_WIDTH*(idx_poly+2*NUM_BASE_BANK) +: ADDR_WIDTH] = (i_mode == M_CTXT? uram_tpp_rdaddr[idx_poly*URAM_ADDR_WIDTH+LOG_NUM_BANK +: ADDR_WIDTH] : madd_dina_rdaddr[idx_poly*URAM_ADDR_WIDTH+LOG_NUM_BANK +: ADDR_WIDTH]);
    end
endgenerate


/* instance of a depth=8 triple buffer */

/* instance of the triple buffer */
(* keep = "true" *) dp_triple_pp_buffer#(
    .COE_WIDTH        (COE_WIDTH),
    .ADDR_WIDTH       (ADDR_WIDTH),                 // Depth of ram is 1<<ADDR_WIDTH
    .LOG_NUM_BANK     (LOG_NUM_BANK),
    .NUM_POLY         (NUM_POLY),                   // number of polys in one polyvec
    .NUM_BASE_BANK    (NUM_BASE_BANK),              // number of banks for one poly
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
tri_pp0(
    .clk                (clk),
    .rst_n              (rst_n),
    .i_done             (axi_ntt_madd_done),
    .i_axi_we           (i_axi_we[NUM_BASE_BANK*NUM_POLY-1                -: NUM_BASE_BANK*NUM_POLY]),
    .i_axi_wraddr       (i_axi_wraddr),
    .i_axi_data         (i_axi_data),
    .i_ntt_we           (ntt_we[NUM_BASE_BANK*NUM_POLY-1                  -: NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_wraddr       (ntt_wraddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1   -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_data         (ntt_tpp_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1  -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_rdaddr       (ntt_rdaddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1   -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_data         (tpp_ntt_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1  -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_madd_rdaddr      (madd_rdaddr),
    .o_madd_data        (tpp_madd_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1 -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY])
);

/* instance two dp_core */
(* keep = "true" *) dp_core#(
    .COE_WIDTH        (COE_WIDTH),
    .ADDR_WIDTH       (ADDR_WIDTH),                 // Depth of ram is 1<<ADDR_WIDTH
    .URAM_ADDR_WIDTH  (URAM_ADDR_WIDTH),
    .NUM_SPLIT        (NUM_SPLIT),
    .NUM_POLY         (NUM_POLY),                 // number of polys in one polyvec
    .NUM_BASE_BANK    (NUM_BASE_BANK),              // number of banks for one poly
    .LOG_NUM_BANK     (LOG_NUM_BANK),               // width of the bank select signal
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
    .COMMON_URAM_DELAY(COMMON_URAM_DELAY),
    .DP_MADD_PIP_DELAY(DP_MADD_PIP_DELAY)
)
dp0(
    .clk                  (clk),
    .rst_n                (rst_n),
    // ntt ports
    .i_idx_split          (i_idx_split),
    .ntt_start            (i_ntt_start),
    .ntt_done             (o_ntt_done_base[0]),
    .o_ntt_we             (ntt_we[NUM_BASE_BANK*NUM_POLY-1                 -: NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_wraddr         (ntt_wraddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1  -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_data           (ntt_tpp_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1 -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_rdaddr         (ntt_rdaddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1  -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_data           (tpp_ntt_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1 -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    // madd ports
    .i_madd_start         (i_madd_start),
    .o_madd_done          (o_madd_done_base[0]),
    // madd ports to downstream buffer
    .o_madd_nxt_we            (o_madd_we),          // avoid multi-driven
    .o_madd_nxt_wraddr        ({o_madd_wraddr[ADDR_WIDTH-1:0],o_madd_wraddr[ADDR_WIDTH +: LOG_NUM_BANK]}),          // multi-driven
    .o_madd_nxt_dout          (o_madd_data[COE_WIDTH*NUM_POLY*2-1    -: COE_WIDTH*NUM_POLY*2]),
    // madd ports from upstream buffer
    .o_madd_nxt_rdaddr        ({o_madd_rdaddr[ADDR_WIDTH-1:0],o_madd_rdaddr[ADDR_WIDTH +: LOG_NUM_BANK]}),
    .i_madd_nxt_din_psum      (i_madd_data[COE_WIDTH*NUM_POLY*2-1 -: COE_WIDTH*NUM_POLY*2]),
    .o_madd_curaddr           (madd_curaddr),
    .o_madd_rdaddr        (madd_dina_rdaddr),          // multi-driven
    .i_madd_dina          (madd_dina[COE_WIDTH*NUM_POLY-1 -: COE_WIDTH*NUM_POLY]),
    .o_uram_addr          (uram_rdaddr),
    .i_uram_din           (uram_dout)
);

/* instance of the triple buffer */
(* keep = "true" *) dp_triple_pp_buffer#(
    .COE_WIDTH        (COE_WIDTH),
    .ADDR_WIDTH       (ADDR_WIDTH),                 // Depth of ram is 1<<ADDR_WIDTH
    .LOG_NUM_BANK     (LOG_NUM_BANK),
    .NUM_POLY         (NUM_POLY),                 // number of polys in one polyvec
    .NUM_BASE_BANK    (NUM_BASE_BANK),              // number of banks for one poly
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
tri_pp1(
    .clk                (clk),
    .rst_n              (rst_n),
    .i_done             (axi_ntt_madd_done),
    .i_axi_we           (i_axi_we[NUM_BASE_BANK*NUM_POLY*2-1                -: NUM_BASE_BANK*NUM_POLY]),
    .i_axi_wraddr       (i_axi_wraddr),
    .i_axi_data         (i_axi_data),
    .i_ntt_we           (ntt_we[NUM_BASE_BANK*NUM_POLY*2-1                  -: NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_wraddr       (ntt_wraddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1   -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_data         (ntt_tpp_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1  -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_rdaddr       (ntt_rdaddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1   -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_data         (tpp_ntt_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1  -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_madd_rdaddr      (madd_rdaddr),
    .o_madd_data        (tpp_madd_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1 -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY])
);

/* instance two dp_core */
(* keep = "true" *) dp_core#(
    .COE_WIDTH        (COE_WIDTH),
    .ADDR_WIDTH       (ADDR_WIDTH),                 // Depth of ram is 1<<ADDR_WIDTH
    .URAM_ADDR_WIDTH  (URAM_ADDR_WIDTH),
    .NUM_SPLIT        (NUM_SPLIT),
    .NUM_POLY         (NUM_POLY),                 // number of polys in one polyvec
    .NUM_BASE_BANK    (NUM_BASE_BANK),              // number of banks for one poly
    .LOG_NUM_BANK     (LOG_NUM_BANK),               // width of the bank select signal
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
    .COMMON_URAM_DELAY(COMMON_URAM_DELAY),
    .DP_MADD_PIP_DELAY(DP_MADD_PIP_DELAY)
)
dp1(
    .clk                  (clk),
    .rst_n                (rst_n),
    // ntt ports
    .i_idx_split          (i_idx_split),
    .ntt_start            (i_ntt_start),
    .ntt_done             (o_ntt_done_base[1]),
    .o_ntt_we             (ntt_we[NUM_BASE_BANK*NUM_POLY*2-1                 -: NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_wraddr         (ntt_wraddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1  -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_data           (ntt_tpp_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1 -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .o_ntt_rdaddr         (ntt_rdaddr[ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1  -: ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    .i_ntt_data           (tpp_ntt_data[COE_WIDTH*NUM_BASE_BANK*NUM_POLY*2-1 -: COE_WIDTH*NUM_BASE_BANK*NUM_POLY]),
    // madd ports
    .i_madd_start         (i_madd_start),
    .o_madd_done          (o_madd_done_base[1]),
    .o_madd_nxt_we            (),          // avoid multi-driven
    .o_madd_nxt_wraddr        (),          // multi-driven
    .o_madd_nxt_dout          (o_madd_data[COE_WIDTH*NUM_POLY*4-1    -: COE_WIDTH*NUM_POLY*2]),
    .o_madd_nxt_rdaddr        (),
    .i_madd_nxt_din_psum      (i_madd_data[COE_WIDTH*NUM_POLY*4-1 -: COE_WIDTH*NUM_POLY*2]),
    .o_madd_curaddr           (),
    .o_madd_rdaddr        (),          // multi-driven
    .i_madd_dina          (madd_dina[2*COE_WIDTH*NUM_POLY-1 -: COE_WIDTH*NUM_POLY]),
    .o_uram_addr          (),
    .i_uram_din           (uram_dout)
);



/* instance of the double buffer */


assign o_ntt_done = &o_ntt_done_base;
assign o_madd_done = &o_madd_done_base;

endmodule
