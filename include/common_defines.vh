//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: common_defines
// Modify Date: 07/08/2021 13:00
// Description: Attributes of common modules (modadd, modsub, etc.)
//////////////////////////////////////////////////

`ifndef __COMMON_DEFINES_VH__
`define __COMMON_DEFINES_VH__

`timescale 1ns/1ps

//`define SIMULATION
`define FPGA


`define COMMON_DATA_LENGTH      4096
`define COMMON_BRAM_DELAY       1       // delay of Block RAM
`define COMMON_URAM_DELAY       3       // delay of Ultra RAM
`define COMMON_MODMUL_DELAY     4       // delay of ModMul module
`define COMMON_MODADD_DELAY     1       // delay of ModAdd module
`define COMMON_MODSUB_DELAY     1       // delay of ModSub module
`define COMMON_MODSUBRED_DELAY  2       // delay of ModSubRed module

`endif // __COMMON_DEFINES_VH__
