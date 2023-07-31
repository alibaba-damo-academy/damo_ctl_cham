package mvp.common

import math._

import chisel3._
import chisel3.util._
import chisel3.experimental._

object utils {
    val MOD = List(0x408000001L, 0x400080001L, 0x4000800001L) // q0, q1, p
    val PIMQ = List(14972836665L, 8017516954L)
    val PINIMQ = List(5173364534L, 6872437018L)
    val MODWIDTH = MOD.map(x => x.U.getWidth)

    def log2(in: Int) : Int = round(log10(in) / log10(2)).toInt

    def slice(data: UInt, begin: Int, end: Int) : UInt = {
        VecInit(data.asBools.slice(begin, end)).asUInt
    }

    def expand(data: UInt, width: Int) : Vec[UInt] = {
        val n = data.getWidth / width
        VecInit(List.tabulate(n) { x =>
            VecInit(data.asBools
                        .slice(x * width, (x+1) * width)
            ).asUInt
        })
    }

    def repeat[T <: Data](n: Int, data: T) : Vec[T] = {
        VecInit(List.fill(n)(data))
    }
}

class VpuRdPort(dataWidth: Int, addrWidth: Int, nBanks: Int) extends Bundle {
    val addr = Output(UInt(addrWidth.W))
    val data = Input(UInt(dataWidth.W))
}

class VpuWrPort(dataWidth: Int, addrWidth: Int, nBanks: Int) extends Bundle {
    val en = Output(Bool())
    val addr = Output(UInt(addrWidth.W))
    val data = Output(UInt(dataWidth.W))
}

class BufRdPort(dataWidth: Int, addrWidth: Int, nBanks: Int) extends Bundle {
    val addr = Output(Vec(nBanks, UInt(addrWidth.W)))
    val data = Input(Vec(nBanks, UInt(dataWidth.W)))
}

class BufWrPort(dataWidth: Int, addrWidth: Int, nBanks: Int) extends Bundle {
    val en = Output(Vec(nBanks, Bool()))
    val addr = Output(Vec(nBanks, UInt(addrWidth.W)))
    val data = Output(Vec(nBanks, UInt(dataWidth.W)))
}


class modadd(mod: Long) extends Module {
    override val desiredName = s"modadd_${mod}"

    val modSig = mod.U
    val t = chiselTypeOf(modSig)
    
    val io = IO(new Bundle {
        val in1 = Input(t)
        val in2 = Input(t)
        val out = Output(t)
    })

    val modadd_stg0 = Reg(t)

    val sum = io.in1 +& io.in2
    when(sum < modSig) {
        modadd_stg0 := sum
    }.otherwise {
        modadd_stg0 := sum - modSig
    }

    io.out := modadd_stg0
}

object modadd {
    val delay = 1
}

class modsub(mod: Long) extends Module {
    override val desiredName = s"modsub_$mod"

    val modSig = mod.U
    val t = chiselTypeOf(modSig)
    
    val io = IO(new Bundle {
        val in1 = Input(t)
        val in2 = Input(t)
        val out = Output(t)
    })

    val modsub_stg0 = Reg(t)

    val diff = io.in1 - io.in2
    when(io.in1 < io.in2) {
        modsub_stg0 := diff + modSig 
    }.otherwise {
        modsub_stg0 := diff
    }

    io.out := modsub_stg0
}

object modsub {
    val delay = 1
}

class modmul(mod: Long) extends Module {
    override val desiredName = s"modmul_$mod"

    val modSig = mod.U
    val t = chiselTypeOf(modSig)
    val width = t.getWidth

    val io = IO(new Bundle {
        val in1 = Input(t)
        val in2 = Input(t)
        val out = Output(t)
    })

    val imodSig = (1.U << (2 * width)) / modSig
    val prod = ShiftRegister(io.in1 * io.in2, 3)

    val modmul_stg0 = RegNext(io.in1 * io.in2)
    val modmul_stg1 = RegNext((modmul_stg0 >> (width - 1)) * imodSig)
    val modmul_stg2 = RegNext((modmul_stg1 >> (width + 1)) * modSig)
    val modmul_stg3 = Reg(t)

    val diff = prod - modmul_stg2
    when(diff < modSig) {
        modmul_stg3 := diff
    }.elsewhen(diff < modSig * 2.U) {
        modmul_stg3 := diff - modSig
    }.otherwise {
        modmul_stg3 := diff - modSig * 2.U
    }

    io.out := modmul_stg3
}

object modmul {
    val delay = 4
}

class modsubred(q: Long) extends BlackBox(Map("MOD" -> IntParam(q))) {
    val io = IO(new Bundle {
        val clk = Input(Clock())
        val rst_n = Input(Bool())

        val i_sub_vld = Input(Bool())
        val o_sub_vldout = Output(Bool())

        val i_sub_din_0 = Input(UInt(39.W))
        val i_sub_din_1 = Input(UInt(39.W))
        val o_sub_dout = Output(UInt(35.W))
    })
}

object modsubred {
    val delay = 2
}
