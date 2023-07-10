//////////////////////////////////////////////////
// Author: Gu Zhen (jingchen)
// Email: guzhen.gz@alibaba-inc.com
//
// Project Name: MVP
// Module Name: dp_defines
// Modify Date: 12/03/2022 13:00
// Description: Attributes of dp modules
//////////////////////////////////////////////////

`ifndef __DP_DEFINES_VH__
`define __DP_DEFINES_VH__

`timescale 1ns/100ps

//`define SIMULATION
`define FPGA

`define COMMON_DATA_LENGTH      4096
`define COMMON_BRAM_DELAY       1       // delay of Block RAM
`define COMMON_URAM_DELAY       1       // delay of Ultra RAM
`define COMMON_MODMUL_DELAY     4       // delay of ModMul module
`define COMMON_MODADD_DELAY     1       // delay of ModAdd module
`define COMMON_MODSUB_DELAY     1       // delay of ModSub module
`define COMMON_MODSUBRED_DELAY  2       // delay of ModSubRed module
`define COMMON_MODMULADD_DELAY  4       // delay of ModMulAdd module
`define DP_MADD_PIP_DELAY       5
`define NUM_BASE_BANK           8
`define COE_WIDTH_0             35
`define COE_WIDTH_1             35
`define COE_WIDTH_2             39
`define N 4096
`define BRAM_DEPTH 512
`define  Q0 17314086913    // Q35 0
`define  Q1 17180393473    // Q35 1
`define  Q2 274886295553  // Q39
`define  Qinv0 17309859841
`define  Qinv1 17176199041
`define  Qinv2 274819184641
`define MAX_N_SPLIT 4
`define NUM_CTXT    2
`define NUM_MOD     3
`endif // __DP_DEFINES_VH__
