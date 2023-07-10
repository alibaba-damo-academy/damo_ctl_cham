//////////////////////////////////////////////////
// Engineer: Chen Zhaohui (xinming)
// Email: chenzhaohui.czh@alibaba-inc.com
//
// Project Name: MVP
// Module Name: triple_pp_buffer
// Modify Date: 07/26/2021 16:10

// Description: wrapper for a triple-pingpong buffer
//////////////////////////////////////////////////

`include "dp_defines.vh"
module dp_triple_pp_buffer#(
    parameter COE_WIDTH          = 39,
    parameter Q_TYPE             = 0,
    parameter ADDR_WIDTH         = 9,        // Depth of ram is 1<<ADDR_WIDTH
    parameter LOG_NUM_BANK       = 3,        // width of the bank select signal
    parameter NUM_POLY           = 3,        // number of polys in one polyvec
    parameter NUM_BASE_BANK      = 8,        // number of banks for one poly
    parameter COMMON_BRAM_DELAY  = `COMMON_BRAM_DELAY
)(
    input                                                clk,
    input                                                rst_n,
    input                                                i_done,
    // axi input port (axi size)   
    input  [NUM_BASE_BANK*NUM_POLY-1:0]                  i_axi_we,
    input  [ADDR_WIDTH*NUM_BASE_BANK-1:0]                i_axi_wraddr,
    input  [COE_WIDTH*NUM_BASE_BANK-1:0]                 i_axi_data,
    // ntt inout port (ntt size)   
    input  [NUM_BASE_BANK*NUM_POLY-1:0]                  i_ntt_we,   
    input  [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]       i_ntt_wraddr,
    input  [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]        i_ntt_data,
    input  [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]       i_ntt_rdaddr,
    output  reg  [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  o_ntt_data,
    // madd output port (madd size)
    input  [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]       i_madd_rdaddr,
    output reg [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]    o_madd_data
);

localparam S_AXI_NTT_MADD = 2'd0;
localparam S_NTT_MADD_AXI = 2'd1;
localparam S_MADD_AXI_NTT = 2'd2;

reg [1:0] mode;
reg [1:0] mode_nxt;

reg i_done_reg;

always@(posedge clk) begin
    if(!rst_n)
        i_done_reg <= 0;
    else
        i_done_reg <= i_done;
end

always@(posedge clk) begin
    if(!rst_n)
        mode <= S_AXI_NTT_MADD;
    else
        mode <= mode_nxt;
end

always@(*) begin
    if((i_done_reg == 0) && (i_done == 1)) begin
        case(mode)
            S_AXI_NTT_MADD: mode_nxt = S_NTT_MADD_AXI;
            S_NTT_MADD_AXI: mode_nxt = S_MADD_AXI_NTT;
            S_MADD_AXI_NTT: mode_nxt = S_AXI_NTT_MADD;
            default: mode_nxt = S_AXI_NTT_MADD;
        endcase
    end
    else begin
        mode_nxt = mode;
    end
end

// input port 0 (mem size)
wire    [NUM_BASE_BANK*NUM_POLY-1:0]             inf_mem_weaxi;
wire    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  inf_mem_addraxi;
wire    [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   inf_mem_dataaxi;
// output port 1 (mem size)
wire    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  inf_mem_addrmadd;

/* AXI interface shows here,madd assignment is implemented with poly interface */
assign inf_mem_weaxi = i_axi_we;
assign inf_mem_addraxi = {NUM_POLY{i_axi_wraddr}};
assign inf_mem_dataaxi = {NUM_POLY{i_axi_data}};

// interface between peripheral and memory
assign inf_mem_addrmadd = {NUM_POLY{i_madd_rdaddr}};

reg    [NUM_BASE_BANK*NUM_POLY-1:0]             wea_polyvec0;
reg    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addra_polyvec0;
reg    [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   dina_polyvec0;
reg    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addrb_polyvec0;
wire   [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   doutb_polyvec0;
reg    [NUM_BASE_BANK*NUM_POLY-1:0]             wea_polyvec1;
reg    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addra_polyvec1;
reg    [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   dina_polyvec1;
reg    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addrb_polyvec1;
wire   [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   doutb_polyvec1;
reg    [NUM_BASE_BANK*NUM_POLY-1:0]             wea_polyvec2;
reg    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addra_polyvec2;
reg    [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   dina_polyvec2;
reg    [ADDR_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]  addrb_polyvec2;
wire   [COE_WIDTH*NUM_BASE_BANK*NUM_POLY-1:0]   doutb_polyvec2;

/* mode controlled mux */
always@(*) begin 
    case(mode)
        S_AXI_NTT_MADD: begin
            wea_polyvec0 = inf_mem_weaxi;
            addra_polyvec0 = inf_mem_addraxi;
            dina_polyvec0 = inf_mem_dataaxi;
            addrb_polyvec0 = 'd0;
            wea_polyvec1 = i_ntt_we;
            addra_polyvec1 = i_ntt_wraddr;
            dina_polyvec1 = i_ntt_data;
            addrb_polyvec1 = i_ntt_rdaddr;
            o_ntt_data = doutb_polyvec1;
            wea_polyvec2 = 'd0;
            addra_polyvec2 = 'd0;
            dina_polyvec2 = 'd0;
            addrb_polyvec2 = i_madd_rdaddr;
            o_madd_data = doutb_polyvec2;
        end
        S_NTT_MADD_AXI: begin
            wea_polyvec2 = inf_mem_weaxi;
            addra_polyvec2 = inf_mem_addraxi;
            dina_polyvec2 = inf_mem_dataaxi;
            addrb_polyvec2 = 'd0;
            wea_polyvec0 = i_ntt_we;
            addra_polyvec0 = i_ntt_wraddr;
            dina_polyvec0 = i_ntt_data;
            addrb_polyvec0 = i_ntt_rdaddr;
            o_ntt_data = doutb_polyvec0;
            wea_polyvec1 = 'd0;
            addra_polyvec1 = 'd0;
            dina_polyvec1 = 'd0;
            addrb_polyvec1 = i_madd_rdaddr;
            o_madd_data = doutb_polyvec1;
        end
        S_MADD_AXI_NTT: begin
            wea_polyvec1 = inf_mem_weaxi;
            addra_polyvec1 = inf_mem_addraxi;
            dina_polyvec1 = inf_mem_dataaxi;
            addrb_polyvec1 = 'd0;
            wea_polyvec2 = i_ntt_we;
            addra_polyvec2 = i_ntt_wraddr;
            dina_polyvec2 = i_ntt_data;
            addrb_polyvec2 = i_ntt_rdaddr;
            o_ntt_data = doutb_polyvec2;
            wea_polyvec0 = 'd0;
            addra_polyvec0 = 'd0;
            dina_polyvec0 = 'd0;
            addrb_polyvec0 = i_madd_rdaddr;
            o_madd_data = doutb_polyvec0;
        end
        default begin
            wea_polyvec0 = 'd0;
            addra_polyvec0 = 'd0;
            dina_polyvec0 = 'd0;
            addrb_polyvec0 = 'd0;
            o_madd_data = 'd0;
            wea_polyvec1 = 'd0;
            addra_polyvec1 = 'd0;
            dina_polyvec1 = 'd0;
            addrb_polyvec1 = 'd0;
            wea_polyvec2 = 'd0;
            addra_polyvec2 = 'd0;
            dina_polyvec2 = 'd0;
            addrb_polyvec2 = 'd0;
            o_ntt_data = 'd0;
        end
    endcase
end 
    
polyvec_ram#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(ADDR_WIDTH),                    // Depth of ram is 1<<ADDR_WIDTH
    .NUM_POLY(NUM_POLY),                        // number of polys in one polyvec
    .NUM_BASE_BANK(NUM_BASE_BANK),              // number of banks for one poly
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
polyvec_0(
    .clk(clk),
    .wea(wea_polyvec0),
    .addra(addra_polyvec0),
    .dina(dina_polyvec0),
    .addrb(addrb_polyvec0),
    .doutb(doutb_polyvec0)
);

polyvec_ram#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(ADDR_WIDTH),                    // Depth of ram is 1<<ADDR_WIDTH
    .NUM_POLY(NUM_POLY),                        // number of polys in one polyvec
    .NUM_BASE_BANK(NUM_BASE_BANK),              // number of banks for one poly
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
polyvec_1(
    .clk(clk),
    .wea(wea_polyvec1),
    .addra(addra_polyvec1),
    .dina(dina_polyvec1),
    .addrb(addrb_polyvec1),
    .doutb(doutb_polyvec1)
);

polyvec_ram#(
    .COE_WIDTH(COE_WIDTH),
    .Q_TYPE(Q_TYPE),
    .ADDR_WIDTH(ADDR_WIDTH),                    // Depth of ram is 1<<ADDR_WIDTH
    .NUM_POLY(NUM_POLY),                        // number of polys in one polyvec
    .NUM_BASE_BANK(NUM_BASE_BANK),              // number of banks for one poly
    .COMMON_BRAM_DELAY(COMMON_BRAM_DELAY)
)
polyvec_2(
    .clk(clk),
    .wea(wea_polyvec2),
    .addra(addra_polyvec2),
    .dina(dina_polyvec2),
    .addrb(addrb_polyvec2),
    .doutb(doutb_polyvec2)
);

endmodule
