import chisel3._
import chisel3.stage._

import mvp.preprocess._

object GenPreprocess extends App {
    emitVerilog(
        new preprocess_top_chisel(), 
        Array("-td", "generated/preprocess",
              "--emission-options=disableMemRandomization,disableRegisterRandomization"
        )
    )
}
