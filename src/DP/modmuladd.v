//////////////////////////////////////////////////
// Engineer: Gu Zhen(jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP
// Module Name: modmuladd
// Modify Date: 03/14/2021 16:10

// Description: include mod mul and add for 3 types of moduli
//////////////////////////////////////////////////
module modmuladd#(
    parameter MWIDTH = 39,
    parameter Q_TYPE=2,
    parameter MODMULADD_PIP_LEVEL = 5
)
(
    input                        clk,
    input   [MWIDTH-1:0]         i_a,
    input   [MWIDTH-1:0]         i_b,
    input   [MWIDTH-1:0]         i_c,
    input                        ma_en,
    output  reg [MWIDTH-1:0]     o_modmuladd
);

(* use_dsp48 = "yes" *)reg [2*MWIDTH-1:0] product;
reg [MWIDTH-1:0]   i_a_reg, i_b_reg, i_c_reg[0:1];
reg     [2*MWIDTH-1:0]   prod_reg;
//TODO : pipelined design of muladd
//       MWIDTH/COE_WIDTH
//muladd

always@(posedge clk) begin
    (* use_dsp48 = "yes" *)product <= i_a_reg * i_b_reg ;
    i_c_reg[0] <= (ma_en? i_c: 'b0);
    i_c_reg[1] <= i_c_reg[0];
    i_a_reg    <= i_a;
    i_b_reg    <= i_b;
    prod_reg <= product+i_c_reg[1];
end
wire    [MWIDTH-1:0]     HE_Q;
wire    [MWIDTH+2:0]     prod_h;             //prod_h        =   product>>(n-2)  //2n-(n-2)=n+2
reg     [2*MWIDTH+2:0]   shift_sum;          //shift_sum     =   prod_h*T        //(n+2)+n+1=2n+3
wire    [MWIDTH-1:0]     quo;                //quo           =   shift_sum>>(n+3)//2n+3-(n+3)=n
reg     [MWIDTH:0]       res;                //res           =   product-quo*q   //n+1
                                                //o_modmuladd   =   res-(1/0)*q     //n
     
assign prod_h = product[2*MWIDTH-1 : MWIDTH-2];
assign quo = shift_sum[2*MWIDTH+2 : MWIDTH+3];
if (Q_TYPE == 0) begin
    assign HE_Q=35'd17314086913;
    //q = 2^34+2^27+1
    //2^(2n+1)/q = 2^37-2^30+2^23-2^16+2^9-2^3-2^2

    //pip-1
    always@(posedge clk) begin
        shift_sum <= (prod_h<<37)-(prod_h<<30)+(prod_h<<23)-(prod_h<<16)+(prod_h<<9)-(prod_h<<3)-(prod_h<<2);
    end
    //pip-2
    always@(posedge clk) begin
        res <= prod_reg-(quo<<34)-(quo<<27)-quo;
    end

end else if (Q_TYPE == 1) begin
    assign HE_Q=35'd17180393473;
    //q = 2^34+2^19+1
    //2^(2n+1)/q = 2^37-2^22+2^7-2^3-1

    //pip-1
    always@(posedge clk) begin
        shift_sum <= (prod_h<<37)-(prod_h<<22)+(prod_h<<7)-(prod_h<<3)-prod_h;
    end

    //pip-2
    always@(posedge clk) begin
        res <= prod_reg-(quo<<34)-(quo<<19)-quo;
    end
end else begin
    assign HE_Q=39'd274886295553;
    //q = 2^38+2^23+1
    //2^(2n+1)/q = 2^41-2^26+2^11-2^3-1

    //pip-1
    always@(posedge clk) begin
        shift_sum <= (prod_h<<41)-(prod_h<<26)+(prod_h<<11)-(prod_h<<3)-prod_h;
    end

    //pip-2
    always@(posedge clk) begin
        res <= prod_reg-(quo<<38)-(quo<<23)-quo;
    end
end

//pip-3
always@(posedge clk) begin
    if (res < HE_Q) begin
        o_modmuladd <= res;
    end else if(res < {HE_Q,1'b0}) begin
        o_modmuladd <= res-HE_Q;
    end else begin
        o_modmuladd <= res-{HE_Q,1'b0};
    end
end

endmodule
