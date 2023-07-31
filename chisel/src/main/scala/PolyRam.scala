package mvp.polyram

import chisel3._
import chisel3.util._
import chisel3.experimental._

import mvp.common._

class poly_ram(dataWidth: Int, addrWidth: Int, nBanks: Int)
    extends BlackBox(Map("COE_WIDTH" -> IntParam(dataWidth),
                         "ADDR_WIDTH" -> IntParam(addrWidth),
                         "NUM_BASE_BANK" -> IntParam(nBanks)
            )) {

    val io = IO(new Bundle {
        val clk = Input(Clock())
        val wea = Input(UInt(nBanks.W))
        val addra = Input(UInt((addrWidth * nBanks).W))
        val dina = Input(UInt((dataWidth * nBanks).W))
        val addrb = Input(UInt((addrWidth * nBanks).W))
        val doutb = Output(UInt((dataWidth * nBanks).W))
    })
}

class poly_ram_wrapper(dataWidth: Int, addrWidth: Int, nBanks: Int) extends Module {
    override val desiredName = s"poly_ram_${dataWidth}_${addrWidth}_${nBanks}"

    val io = IO(new Bundle {
        val wr = Flipped(new BufWrPort(dataWidth, addrWidth, nBanks))
        val rd = Flipped(new BufRdPort(dataWidth, addrWidth, nBanks))
    })

    val u_ram = Module(new poly_ram(dataWidth, addrWidth, nBanks))

    u_ram.io.clk    := clock
    u_ram.io.wea    := io.wr.en.asUInt
    u_ram.io.addra  := io.wr.addr.asUInt
    u_ram.io.dina   := io.wr.data.asUInt
    u_ram.io.addrb  := io.rd.addr.asUInt
    io.rd.data      := utils.expand(u_ram.io.doutb, dataWidth)
}
