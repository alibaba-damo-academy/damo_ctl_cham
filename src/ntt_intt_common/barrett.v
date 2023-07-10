//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: barrett
// Modify Date: 07/14/2021 16:10

// Description: barrett reduction with shift and addition
//////////////////////////////////////////////////

`include "ntt_intt_defines.vh"
module barrett#(
    parameter COE_WIDTH = 39,
    parameter Q_TYPE = 0
)
(
    input                        clk,
    input      [2*COE_WIDTH-1:0] i_a,
    output reg [COE_WIDTH-1:0]   o_red
);

wire [COE_WIDTH-1:0] HE_Q;

if (Q_TYPE == 2) begin
    assign HE_Q = 39'd`Q2;
    
    reg  [2*COE_WIDTH-1:0]    i_a_reg [0:1];
    // pip1 mult a*T
    reg  [2*COE_WIDTH-1+41:0] a_t;
    wire [COE_WIDTH-1:0]      a_t_w;
    wire [2*COE_WIDTH-1+40:0] i_a_sl40;
    wire [2*COE_WIDTH-1+25:0] i_a_sl25;
    wire [2*COE_WIDTH-1+10:0] i_a_sl10;
    wire [2*COE_WIDTH-1+2:0]  i_a_sl2;
    
    assign i_a_sl40 = i_a << 40;
    assign i_a_sl25 = i_a << 25;
    assign i_a_sl10 = i_a << 10;
    assign i_a_sl2 = i_a << 2;
    
    always@(posedge clk) begin
        i_a_reg[0] <= i_a;
        a_t <= i_a_sl40 - i_a_sl25 + i_a_sl10 - i_a_sl2 - i_a;
    end
    
    assign a_t_w = a_t >> (2 * 39);  // 39 is the width of q
    
    // pip2 mult q*a_t
    reg  [2*COE_WIDTH-1:0]  a_t_q;
    wire [COE_WIDTH-1+38:0] a_t_sl38;
    wire [COE_WIDTH-1+23:0] a_t_sl23;
    
    assign a_t_sl38 = a_t_w << 38;
    assign a_t_sl23 = a_t_w << 23;
    
    always@(posedge clk) begin
       i_a_reg[1] <= i_a_reg[0];
       a_t_q <= a_t_sl38 + a_t_sl23 + a_t_w;
    end
    
    // pip3 sub i_a_reg - a_t_q
    reg [COE_WIDTH:0] i_a_sub_a_t_q;
    always@(posedge clk) begin
       i_a_sub_a_t_q <= i_a_reg[1] - a_t_q; 
    end
    
    // pip4 final sub
    always@(posedge clk) begin
        o_red <= (i_a_sub_a_t_q >= HE_Q)? (i_a_sub_a_t_q - HE_Q) : i_a_sub_a_t_q; 
    end
    
end else if  (Q_TYPE == 0) begin
    assign HE_Q = 35'd`Q0;
    
    reg  [2*COE_WIDTH-1:0]    i_a_reg [0:1];
    // pip1 mult a*T
    reg  [2*COE_WIDTH-1+37:0] a_t;
    wire [COE_WIDTH-1:0]      a_t_w;
    wire [2*COE_WIDTH-1+36:0] i_a_sl36;
    wire [2*COE_WIDTH-1+29:0] i_a_sl29;
    wire [2*COE_WIDTH-1+22:0] i_a_sl22;
    wire [2*COE_WIDTH-1+15:0] i_a_sl15;
    wire [2*COE_WIDTH-1+8:0]  i_a_sl8;
    wire [2*COE_WIDTH-1+2:0]  i_a_sl2;
    wire [2*COE_WIDTH-1+1:0]  i_a_sl1;
    
    assign i_a_sl36 = i_a << 36;
    assign i_a_sl29 = i_a << 29;
    assign i_a_sl22 = i_a << 22;
    assign i_a_sl15 = i_a << 15;
    assign i_a_sl8 = i_a << 8;
    assign i_a_sl2 = i_a << 2;
    assign i_a_sl1 = i_a << 1;
    
    always@(posedge clk) begin
        i_a_reg[0] <= i_a;
        a_t <= i_a_sl36 - i_a_sl29 + i_a_sl22 - i_a_sl15 + i_a_sl8 - i_a_sl2 - i_a_sl1;
    end
    
    assign a_t_w = a_t >> (2 * 35);  // 35 is the width of q
    
    // pip2 mult q*a_t
    reg  [2*COE_WIDTH-1:0]  a_t_q;
    wire [COE_WIDTH-1+38:0] a_t_sl34;
    wire [COE_WIDTH-1+23:0] a_t_sl27;
    
    assign a_t_sl34 = a_t_w << 34;
    assign a_t_sl27 = a_t_w << 27;
    
    always@(posedge clk) begin
        i_a_reg[1] <= i_a_reg[0];
        a_t_q <= a_t_sl34 + a_t_sl27 + a_t_w;
    end
    
    // pip3 sub i_a_reg - a_t_q
    reg [COE_WIDTH:0] i_a_sub_a_t_q;
    always@(posedge clk) begin
       i_a_sub_a_t_q <= i_a_reg[1] - a_t_q; 
    end
    
    // pip4 final sub
    always@(posedge clk) begin
        o_red <= (i_a_sub_a_t_q >= HE_Q)? (i_a_sub_a_t_q - HE_Q) : i_a_sub_a_t_q; 
    end
end else begin
    assign HE_Q = 35'd`Q1;

    reg [2*COE_WIDTH-1:0]     i_a_reg [0:1];
    // pip1 mult a*T
    reg  [2*COE_WIDTH-1+37:0] a_t;
    wire [COE_WIDTH-1:0]      a_t_w;
    wire [2*COE_WIDTH-1+36:0] i_a_sl36;
    wire [2*COE_WIDTH-1+21:0] i_a_sl21;
    wire [2*COE_WIDTH-1+6:0]  i_a_sl6;
    wire [2*COE_WIDTH-1+2:0]  i_a_sl2;
    
    assign i_a_sl36 = i_a << 36;
    assign i_a_sl21 = i_a << 21;
    assign i_a_sl6 = i_a << 6;
    assign i_a_sl2 = i_a << 2;
    
    always@(posedge clk) begin
       i_a_reg[0] <= i_a;
       a_t <= i_a_sl36 - i_a_sl21 + i_a_sl6 - i_a_sl2 - i_a;
    end
    
    assign a_t_w = a_t >> (2 * 35);  // 35 is the width of q
    
    // pip2 mult q*a_t
    reg  [2*COE_WIDTH-1:0]  a_t_q;
    wire [COE_WIDTH-1+34:0] a_t_sl34;
    wire [COE_WIDTH-1+19:0] a_t_sl19;
    
    assign a_t_sl34 = a_t_w << 34;
    assign a_t_sl19 = a_t_w << 19;
    
    always@(posedge clk) begin
        i_a_reg[1] <= i_a_reg[0];
        a_t_q <= a_t_sl34 + a_t_sl19 + a_t_w;
    end
    
    // pip3 sub i_a_reg - a_t_q
    reg [COE_WIDTH:0] i_a_sub_a_t_q;
    always@(posedge clk) begin
        i_a_sub_a_t_q <= i_a_reg[1] - a_t_q; 
    end
    
    // pip4 final sub
    always@(posedge clk) begin
        o_red <= (i_a_sub_a_t_q >= HE_Q)? (i_a_sub_a_t_q - HE_Q) : i_a_sub_a_t_q; 
    end
end
endmodule
