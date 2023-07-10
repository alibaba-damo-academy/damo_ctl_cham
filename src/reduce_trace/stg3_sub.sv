//////////////////////////////////////////////////
//
// File:            stg3_sub.sv
// Project Name:    MVP
// Module Name:     stg3_sub
// Description:     Substract module as an add-on in stage-3
//
// Author:          Xuanle Ren(qianxuan)
// Email:           xuanle.rxl@alibaba-inc.com
// Setup Data:      06/08/2021
// Modify Date:     24/08/2021
//
//////////////////////////////////////////////////

`include "common_defines.vh"

module stg3_sub #(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 12,
    parameter Q0 = 35'h4_0800_0001,
    parameter Q1 = 35'h4_0008_0001,
    parameter N_POLY_SUB = 2,
    parameter N_POLY = 6
)
(
    input  logic  [N_POLY_SUB-1:0]                      i_we,
    input  logic  [N_POLY_SUB-1:0][ADDR_WIDTH-1:0]      i_addr,
    input  logic  [N_POLY_SUB-1:0][DATA_WIDTH-1:0]      i_data,
    
    output logic  [N_POLY-1:0]                          o_we,
    output logic  [N_POLY-1:0][ADDR_WIDTH-1:0]          o_addr,
    output logic  [N_POLY-1:0][DATA_WIDTH-1:0]          o_data
);
    
    parameter DUP = N_POLY / N_POLY_SUB;

    assign o_we = {DUP{i_we}};
    assign o_addr = {DUP{i_addr}};

    always_comb begin
        o_data = {DUP{i_data}};
        o_data[1] = i_data[1] >= Q0? o_data[1] - Q0 : o_data[1]; 
        o_data[2] = i_data[0] >= Q1? o_data[2] - Q1 : o_data[2]; 
    end
endmodule
