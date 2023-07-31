import chisel3._
import chisel3.stage._

import mvp.common._
import mvp.buffer._

object GenWrItf extends App {
    emitVerilog(new poly_wr_interface(39, 512, 8), Array("-td", "generated/writf"))
}
