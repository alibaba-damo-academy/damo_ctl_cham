//////////////////////////////////////////////////
// Author: Zhang Yichi (changlv)
// Email: changlv.zyc@alibaba-inc.com
//
// Project Name: MVP
// Module Name: vpu2_defines 
// Modify Date: 07/09/2021 16:30
//
// Description: Attributes and parameters of VPU2
//////////////////////////////////////////////////

`ifndef __VPU2_DEFINES_VH__
`define __VPU2_DEFINES_VH__

`define VPU2_DELAY     (`COMMON_URAM_DELAY + `COMMON_MODMUL_DELAY + `COMMON_MODADD_DELAY)

`define VPU2_RD_BEGIN  0
`define VPU2_WR_BEGIN  (`VPU2_RD_BEGIN + `VPU2_DELAY)

`define VPU2_RD_END    (`VPU2_RD_BEGIN + `COMMON_DATA_LENGTH)
`define VPU2_WR_END    (`VPU2_WR_BEGIN + `COMMON_DATA_LENGTH)

`define VPU2_BUSY_END  (`VPU2_WR_END)   // when state BUSY -> IDLE

`endif // __VPU2_DEFINES_VH__
