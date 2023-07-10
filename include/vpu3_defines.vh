//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: VPU3
// Modify Date: 07/14/2021 15:30
//
// Description: Attributes and parameters of VP3U
//////////////////////////////////////////////////

`ifndef __VPU3_DEFINES_VH__
`define __VPU3_DEFINES_VH__

`define VPU3_DELAY      (`COMMON_BRAM_DELAY + `COMMON_MODADD_DELAY + `COMMON_MODSUBRED_DELAY + `COMMON_MODSUB_DELAY + `COMMON_MODMUL_DELAY + `COMMON_MODADD_DELAY)

`define VPU3_RD_BEGIN   0
`define VPU3_RDA_BEGIN  (`VPU3_RD_BEGIN + `COMMON_MODADD_DELAY + `COMMON_MODSUBRED_DELAY)
`define VPU3_RDB_BEGIN  (`VPU3_RD_BEGIN + `COMMON_MODADD_DELAY + `COMMON_MODSUBRED_DELAY + `COMMON_MODSUB_DELAY + `COMMON_MODMUL_DELAY)
`define VPU3_RDC_BEGIN  (`VPU3_RD_BEGIN + 0)
`define VPU3_WR_BEGIN   (`VPU3_RD_BEGIN + `VPU3_DELAY)

`define VPU3_RD_END     (`VPU3_RD_BEGIN + `COMMON_DATA_LENGTH)
`define VPU3_RDA_END    (`VPU3_RDA_BEGIN + `COMMON_DATA_LENGTH)
`define VPU3_RDB_END    (`VPU3_RDB_BEGIN + `COMMON_DATA_LENGTH)
`define VPU3_RDC_END    (`VPU3_RDC_BEGIN + `COMMON_DATA_LENGTH)
`define VPU3_WR_END     (`VPU3_WR_BEGIN + `COMMON_DATA_LENGTH)

`define VPU3_BUSY_END   (`VPU3_WR_END)   // when state BUSY -> IDLE

`endif // __VPU3_DEFINES_VH__

