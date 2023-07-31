import chisel3._
import chisel3.stage._

import mvp.common._
import mvp.vpu2._

object GenVPU2 extends App {
    emitVerilog(
        new vpu2_top(4096, 1, 4), 
        Array("-td", "generated/vpu2",
              "--emission-options=disableMemRandomization,disableRegisterRandomization"
        )
    )
}
