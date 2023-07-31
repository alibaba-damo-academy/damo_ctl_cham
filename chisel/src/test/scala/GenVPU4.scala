import chisel3._
import chisel3.stage._

import mvp.common._
import mvp.vpu4._

object GenVPU4 extends App {
    emitVerilog(
        new vpu4_top(4096, 1), 
        Array("-td", "generated/vpu4",
              "--emission-options=disableMemRandomization,disableRegisterRandomization"
        )
    )
}
