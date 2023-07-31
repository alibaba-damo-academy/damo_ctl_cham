package mvp.vpu2

import chisel3._
import chisel3.util._

import mvp.common._

class vpu2_datapath(modType: Int) extends Module {
    override val desiredName = s"vpu4_dp_${utils.MOD(modType)}"

    val mod = utils.MOD(modType).U
    val t = chiselTypeOf(mod)

    val io = IO(new Bundle {
        val i_dp_din = Input(Vec(2, t))
        val i_dp_extdin = Input(Vec(4, t))
        val o_dp_dout = Output(Vec(2, t))
    })

    val u_modmul = List.tabulate(4) { x => Module(new modmul(utils.MOD(modType))) }
    val u_modadd = List.tabulate(2) { x => Module(new modadd(utils.MOD(modType))) }

    for (i <- 0 until 4) {
        u_modmul(i).io.in1 <> io.i_dp_din(i>>1)
        u_modmul(i).io.in2 <> io.i_dp_extdin(i)
    }

    for (i <- 0 until 2) {
        u_modadd(i).io.in1 <> u_modmul(i+0).io.out
        u_modadd(i).io.in2 <> u_modmul(i+2).io.out
    }

    for (i <- 0 until 2) {
        io.o_dp_dout(i) <> u_modadd(i).io.out
    }
}

object vpu2_datapath {
    val delay = modmul.delay + modadd.delay
}

class vpu2_top(nElems: Int, bramDelay: Int, uramDelay: Int) extends Module {
    val mod = utils.MOD.map(x => x.U)
    val t = mod.map(x => chiselTypeOf(x))

    val readDelay = math.max(bramDelay, uramDelay)

    val io = IO(new Bundle {
        val i_vpu2_start = Input(Bool())
        val o_vpu2_done = Output(Bool())
        
        val i_vpu2_din = Input(MixedVec(
            List.tabulate(3)(x => Vec(2, t(x)))
        ))
        val i_vpu2_extdin = Input(MixedVec(
            List.tabulate(3)(x => Vec(4, t(x)))
        ))
        val o_vpu2_dout = Output(MixedVec(
            List.tabulate(3)(x => Vec(2, t(x)))
        ))

        val o_vpu2_rden = Output(Bool())
        val o_vpu2_wren = Output(Bool())
        val o_vpu2_rdaddr = Output(UInt(utils.log2(nElems).W))
        val o_vpu2_wraddr = Output(UInt(utils.log2(nElems).W))
    })

    val idle :: busy :: ending :: Nil = Enum(3)
    val state = RegInit(idle)

    val (count, wrap) = Counter(state === busy, nElems)

    switch (state) {
        is (idle) {
            when (io.i_vpu2_start) {
                state := busy
            }
        }
        is (busy) {
            when (wrap) {
                state := ending
            }
        }
        is (ending) {
            when (!io.o_vpu2_wren) {
                state := idle
            }
        }
    }

    io.o_vpu2_done := state =/= busy

    io.o_vpu2_rden := state === busy
    io.o_vpu2_wren := ShiftRegister(io.o_vpu2_rden, readDelay + vpu2_datapath.delay)
    io.o_vpu2_rdaddr := count
    io.o_vpu2_wraddr := ShiftRegister(io.o_vpu2_rdaddr, readDelay + vpu2_datapath.delay)

    val din_sync = ShiftRegister(io.i_vpu2_din, readDelay - bramDelay)
    val extdin_sync = ShiftRegister(io.i_vpu2_extdin, readDelay - uramDelay)

    val u_dp = List.tabulate(3) { x => Module(new vpu2_datapath(x)) }

    for (i <- 0 until 3) {
        for (j <- 0 until 2) {
            u_dp(i).io.i_dp_din(j) := din_sync(i)(j)
        }
        for (j <- 0 until 4) {
            u_dp(i).io.i_dp_extdin(j) := extdin_sync(i)(j)
        }
        for (j <- 0 until 2) {
            io.o_vpu2_dout(i)(j) := u_dp(i).io.o_dp_dout(j)
        }
    }
}
