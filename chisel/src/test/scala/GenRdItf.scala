import chisel3._
import chisel3.stage._

import mvp.common._
import mvp.buffer._

object GenRdItf extends App {
    emitVerilog(new poly_rd_interface(39, 512, 8, 1), Array("-td", "generated/rditf"))
}
