import chisel3._
import chisel3.stage._

import mvp.common._
import mvp.intt._

object GenINTT extends App {
    emitVerilog(new intt_wrapper(0), Array("-td", "generated/intt"))
}
