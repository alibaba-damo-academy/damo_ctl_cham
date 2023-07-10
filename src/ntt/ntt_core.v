//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: ntt_core
// Modify Date: 07/14/2021 16:10

// Description: ntt top module
//              input a polynomial in normal domain and twiddle factor, output the polynomial in ntt domain.
//              instance 4pe
//              Detail see specification.
//////////////////////////////////////////////////


module ntt_core#(
    parameter COE_WIDTH = 35,
    parameter Q_TYPE = 0,
    parameter COMMON_BRAM_DELAY = 2,
    parameter COMMON_MULRED_DELAY = 5,
    parameter COMMON_SWAP_DELAY = 2,
    parameter COMMON_NTT_PIP_DELAY = COMMON_BRAM_DELAY + COMMON_MULRED_DELAY + COMMON_SWAP_DELAY
)
(
    input                       clk,
    input                       rst_n,
    input                       ntt_start,
    input    [8*COE_WIDTH-1:0]  i_data_b_l,// 8 data input port
    input    [8*COE_WIDTH-1:0]  i_data_b_r,// 8 data input port
    output                      o_we_a_l,
    output                      o_we_a_r,
    output   [8*COE_WIDTH-1:0]  o_data_a, // 8 data output port
    output   [8:0]              o_addr_a_l,
    output   [8:0]              o_addr_a_r,
    output   [8:0]              o_addr_b_l,
    output   [8:0]              o_addr_b_r,
    output                      ntt_done
);

/* Control signal */
wire        coe_mux_sel;
wire [3:0]  tf_mux_sel;
wire        swap_mux0_sel;
wire        swap_mux1_sel;

/* COE ram and sel */
wire [COE_WIDTH-1:0] i_u_pe0;
wire [COE_WIDTH-1:0] i_v_pe0;
wire [COE_WIDTH-1:0] i_u_pe1;
wire [COE_WIDTH-1:0] i_v_pe1;
wire [COE_WIDTH-1:0] i_u_pe2;
wire [COE_WIDTH-1:0] i_v_pe2;
wire [COE_WIDTH-1:0] i_u_pe3;
wire [COE_WIDTH-1:0] i_v_pe3;

assign i_u_pe0 = coe_mux_sel? i_data_b_r[COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[COE_WIDTH-1 -: COE_WIDTH];
assign i_v_pe0 = coe_mux_sel? i_data_b_r[5*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[5*COE_WIDTH-1 -: COE_WIDTH];
assign i_u_pe1 = coe_mux_sel? i_data_b_r[2*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[2*COE_WIDTH-1 -: COE_WIDTH];
assign i_v_pe1 = coe_mux_sel? i_data_b_r[6*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[6*COE_WIDTH-1 -: COE_WIDTH];
assign i_u_pe2 = coe_mux_sel? i_data_b_r[3*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[3*COE_WIDTH-1 -: COE_WIDTH];
assign i_v_pe2 = coe_mux_sel? i_data_b_r[7*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[7*COE_WIDTH-1 -: COE_WIDTH];
assign i_u_pe3 = coe_mux_sel? i_data_b_r[4*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[4*COE_WIDTH-1 -: COE_WIDTH];
assign i_v_pe3 = coe_mux_sel? i_data_b_r[8*COE_WIDTH-1 -: COE_WIDTH]:i_data_b_l[8*COE_WIDTH-1 -: COE_WIDTH];

/* PE out */
wire [COE_WIDTH-1:0] o_u_pe0;
wire [COE_WIDTH-1:0] o_v_pe0;
wire [COE_WIDTH-1:0] o_u_pe1;
wire [COE_WIDTH-1:0] o_v_pe1;
wire [COE_WIDTH-1:0] o_u_pe2;
wire [COE_WIDTH-1:0] o_v_pe2;
wire [COE_WIDTH-1:0] o_u_pe3;
wire [COE_WIDTH-1:0] o_v_pe3;

/* TF rom and sel */
wire [10:0] o_addr_tf;
wire [COE_WIDTH-1:0] tf_rom0;
wire [COE_WIDTH-1:0] tf_rom1;
wire [COE_WIDTH-1:0] tf_rom2;
wire [COE_WIDTH-1:0] tf_rom3;

wire [COE_WIDTH-1:0] tf_pe0;
wire [COE_WIDTH-1:0] tf_pe1;
wire [COE_WIDTH-1:0] tf_pe2;
wire [COE_WIDTH-1:0] tf_pe3;

assign tf_pe0 = tf_rom0;
assign tf_pe1 = ((tf_mux_sel == 10) | (tf_mux_sel == 11))?  tf_rom1:tf_rom0;
assign tf_pe2 = (tf_mux_sel == 11)?                         tf_rom2:tf_rom0;
assign tf_pe3 = (tf_mux_sel == 11)?                         tf_rom3:
                (tf_mux_sel == 10)?                         tf_rom1:tf_rom0;

ntt_cu#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY),
    .COMMON_NTT_PIP_DELAY(COMMON_NTT_PIP_DELAY)
)
cu(
    .clk(clk),
    .rst_n(rst_n),
    .ntt_start(ntt_start),
    .coe_mux_sel(coe_mux_sel),
    .tf_mux_sel(tf_mux_sel),       // delay of stage_cnt
    .swap_mux0_sel(swap_mux0_sel),
    // .swap_mux1_sel(swap_mux1_sel),
    .o_we_a_l(o_we_a_l),
    .o_we_a_r(o_we_a_r),
    .o_addr_a_l(o_addr_a_l),
    .o_addr_a_r(o_addr_a_r),
    .o_addr_b_l(o_addr_b_l),
    .o_addr_b_r(o_addr_b_r),
    .o_addr_tf(o_addr_tf),
    .ntt_done(ntt_done)
);

tf_rom_wrapper#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .NTT_INTT_CASE(0),
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
bv_tfsr(
    .clk(clk),
    .addr_tfsr(o_addr_tf),
    .tf_rom0(tf_rom0),
    .tf_rom1(tf_rom1),
    .tf_rom2(tf_rom2),
    .tf_rom3(tf_rom3)
);


/* PE0 instance */
ct_butterfly#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .MULRED_PIP_LEVEL(COMMON_MULRED_DELAY)
)
ct_pe0(
    .clk(clk),
    .i_u(i_u_pe0), 
    .i_v(i_v_pe0), 
    .i_omega(tf_pe0),
    .o_u(o_u_pe0), 
    .o_v(o_v_pe0)
);

ntt_pe_swap#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE)
)
swap0(
    .clk(clk),
    .mux_sel(swap_mux0_sel),
    .i_coe_a(o_u_pe0),
    .i_coe_b(o_v_pe0),
    .o_coe_a(o_data_a[COE_WIDTH-1 -: COE_WIDTH]),
    .o_coe_b(o_data_a[2*COE_WIDTH-1 -: COE_WIDTH])
);

/* PE1 instance */
ct_butterfly#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .MULRED_PIP_LEVEL(COMMON_MULRED_DELAY)
)
ct_pe1(
    .clk(clk),
    .i_u(i_u_pe1), 
    .i_v(i_v_pe1), 
    .i_omega(tf_pe1),
    .o_u(o_u_pe1), 
    .o_v(o_v_pe1)
);

ntt_pe_swap#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE)
)
swap1(
    .clk(clk),
    .mux_sel(swap_mux0_sel),
    .i_coe_a(o_u_pe1),
    .i_coe_b(o_v_pe1),
    .o_coe_a(o_data_a[3*COE_WIDTH-1 -: COE_WIDTH]),
    .o_coe_b(o_data_a[4*COE_WIDTH-1 -: COE_WIDTH])
);

/* PE2 instance */
ct_butterfly#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .MULRED_PIP_LEVEL(COMMON_MULRED_DELAY)
)
ct_pe2(
    .clk(clk),
    .i_u(i_u_pe2), 
    .i_v(i_v_pe2), 
    .i_omega(tf_pe2),
    .o_u(o_u_pe2), 
    .o_v(o_v_pe2)
);

ntt_pe_swap#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE)
)
swap2(
    .clk(clk),
    .mux_sel(swap_mux0_sel),
    .i_coe_a(o_u_pe2),
    .i_coe_b(o_v_pe2),
    .o_coe_a(o_data_a[5*COE_WIDTH-1 -: COE_WIDTH]),
    .o_coe_b(o_data_a[6*COE_WIDTH-1 -: COE_WIDTH])
);

/* PE3 instance */
ct_butterfly#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .MULRED_PIP_LEVEL(COMMON_MULRED_DELAY)
)
ct_pe3(
    .clk(clk),
    .i_u(i_u_pe3), 
    .i_v(i_v_pe3), 
    .i_omega(tf_pe3),
    .o_u(o_u_pe3), 
    .o_v(o_v_pe3)
);

ntt_pe_swap#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE)
)
swap3(
    .clk(clk),
    .mux_sel(swap_mux0_sel),
    .i_coe_a(o_u_pe3),
    .i_coe_b(o_v_pe3),
    .o_coe_a(o_data_a[7*COE_WIDTH-1 -: COE_WIDTH]),
    .o_coe_b(o_data_a[8*COE_WIDTH-1 -: COE_WIDTH])
);
endmodule
