package mvp.intt

import chisel3._
import chisel3.util._
import chisel3.experimental._

import mvp.common._

class intt_core(width: Int, modType: Int)
    extends BlackBox(Map("COE_WIDTH" -> IntParam(width),
                         "Q_TYPE" -> IntParam(modType),
                         "COMMON_BRAM_DELAY" -> IntParam(1)
            )) {
    val io = IO(new Bundle {
        val clk = Input(Clock())
        val rst_n = Input(Bool())
        val ntt_start = Input(Bool())
        val ntt_done = Output(Bool())
        val i_data_b_l = Input(UInt((8*width).W))
        val i_data_b_r = Input(UInt((8*width).W))
        val o_data_a = Output(UInt((8*width).W))
        val o_we_a_l = Output(Bool())
        val o_we_a_r = Output(Bool())
        val o_addr_a_l = Output(UInt(9.W))
        val o_addr_a_r = Output(UInt(9.W))
        val o_addr_b_l = Output(UInt(9.W))
        val o_addr_b_r = Output(UInt(9.W))
    })
}

class intt_wrapper(modType: Int) extends Module {
    override val desiredName = s"intt_${utils.MOD(modType)}"

    val width = utils.MOD(modType).U.getWidth

    val io = IO(new Bundle {
        val ntt_start = Input(Bool())
        val ntt_done = Output(Bool())
        val wr_l = new BufWrPort(width, 9, 8)
        val wr_r = new BufWrPort(width, 9, 8)
        val rd_l = new BufRdPort(width, 9, 8)
        val rd_r = new BufRdPort(width, 9, 8)
    })

    val u_intt = Module(new intt_core(width, modType))

    u_intt.io.clk   := clock
    u_intt.io.rst_n := !(reset.asBool)

    io.ntt_start    <> u_intt.io.ntt_start
    io.ntt_done     <> u_intt.io.ntt_done

    io.wr_l.en      := utils.repeat(8, u_intt.io.o_we_a_l)
    io.wr_l.addr    := utils.repeat(8, u_intt.io.o_addr_a_l)
    io.wr_l.data    := utils.expand(u_intt.io.o_data_a, width)

    io.wr_r.en      := utils.repeat(8, u_intt.io.o_we_a_r)
    io.wr_r.addr    := utils.repeat(8, u_intt.io.o_addr_a_r)
    io.wr_r.data    := utils.expand(u_intt.io.o_data_a, width)

    io.rd_l.addr    := utils.repeat(8, u_intt.io.o_addr_b_l)
    u_intt.io.i_data_b_l    := io.rd_l.data.asUInt

    io.rd_r.addr    := utils.repeat(8, u_intt.io.o_addr_b_r)
    u_intt.io.i_data_b_r    := io.rd_r.data.asUInt
}
