//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: vpu4_defines
// Modify Date: 07/14/2021 16:00
// Description: Attributes and parameters of VPU4
//////////////////////////////////////////////////

`ifndef __VPU4_DEFINES_VH__
`define __VPU4_DEFINES_VH__

`define VPU4_DELAY      (`COMMON_BRAM_DELAY + `COMMON_MODSUB_DELAY + `COMMON_MODMUL_DELAY)

`define VPU4_RD_BEGIN   0
`define VPU4_WR_BEGIN   (`VPU4_RD_BEGIN + `VPU4_DELAY)

`define VPU4_RD_END     (`VPU4_RD_BEGIN + `COMMON_DATA_LENGTH)
`define VPU4_WR_END     (`VPU4_WR_BEGIN + `COMMON_DATA_LENGTH)

`define VPU4_BUSY_END   (`VPU4_WR_END)   // when state BUSY -> IDLE

`endif // __VPU4_DEFINES_VH__

