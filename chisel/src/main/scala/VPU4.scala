package mvp.vpu4

import chisel3._
import chisel3.util._

import mvp.common._
import mvp.buffer._

class vpu4_rs(qType: Int) extends Module {
    override val desiredName = s"vpu4_rs_${utils.MOD(qType)}"

    val p = utils.MOD(2).U
    val q = utils.MOD(qType).U
    val pinimq = utils.PINIMQ(qType).U

    val tp = chiselTypeOf(p)
    val tq = chiselTypeOf(q)

    val io = IO(new Bundle {
        val i_rs_a = Input(tq)
        val i_rs_c = Input(tp)
        val i_negate = Input(Bool())
        val o_rs_d = Output(tq)
    })

    val u_modsubred = Module(new modsubred(utils.MOD(qType)))
    u_modsubred.io.clk          := clock
    u_modsubred.io.rst_n        := 1.B
    u_modsubred.io.i_sub_vld    := 1.B
    u_modsubred.io.i_sub_din_0  := io.i_rs_c
    u_modsubred.io.i_sub_din_1  := p >> 1
    
    val u_modsub = Module(new modsub(utils.MOD(qType)))
    u_modsub.io.in1 := ShiftRegister(io.i_rs_a, modsubred.delay)
    u_modsub.io.in2 := u_modsubred.io.o_sub_dout

    val u_modmul = Module(new modmul(utils.MOD(qType)))
    u_modmul.io.in1 := u_modsub.io.out
    u_modmul.io.in2 := pinimq

    val u_modneg = Module(new modsub(utils.MOD(qType)))
    u_modneg.io.in1 := 0.U
    u_modneg.io.in2 := u_modmul.io.out

    when (ShiftRegister(io.i_negate, vpu4_rs.delay)) {
        io.o_rs_d := u_modneg.io.out
    } .otherwise {
        io.o_rs_d := ShiftRegister(u_modmul.io.out, modsub.delay)
    }
}

object vpu4_rs {
    val delay = modsubred.delay + modsub.delay + modmul.delay + modsub.delay
}

class vpu4_top(nElems: Int, bramDelay: Int) extends Module {
    val q0 = utils.MOD(0).U
    val q1 = utils.MOD(1).U
    val p = utils.MOD(2).U
    val pinimq0 = utils.PINIMQ(0).U
    val pinimq1 = utils.PINIMQ(1).U

    val tp = chiselTypeOf(p)
    val tq = chiselTypeOf(q0)

    val addrWidth = utils.log2(nElems)
    val readDelay = bramDelay

    val io = IO(new Bundle {
        val i_vpu4_start = Input(Bool())
        val o_vpu4_done = Output(Bool())

        val i_vpu4_coeff_index = Input(UInt(addrWidth.W))

        val vpu4_rd = MixedVec(
            List.fill(4)(new VpuRdPort(tq.getWidth, addrWidth, 8)) :::
            List.fill(2)(new VpuRdPort(tp.getWidth, addrWidth, 8))
        )
        val vpu4_wr = Vec(4, new VpuWrPort(tq.getWidth, addrWidth, 8))
    })

    val idle :: busy :: ending :: Nil = Enum(3)
    val state = RegInit(idle)

    val (count, wrap) = Counter(state === busy, nElems)

    io.o_vpu4_done := state === idle

    val vpu4_rden = state === busy
    val vpu4_rdaddr = count + io.i_vpu4_coeff_index;
    val vpu4_wren = ShiftRegister(vpu4_rden, readDelay + modadd.delay + vpu4_rs.delay)
    val vpu4_wraddr = ShiftRegister(count, readDelay + modadd.delay + vpu4_rs.delay)

    switch (state) {
        is (idle) {
            when (io.i_vpu4_start) {
                state := busy
            }
        }
        is (busy) {
            when (wrap) {
                state := ending
            }
        }
        is (ending) {
            when (!vpu4_wren) {
                state := idle
            }
        }
    }

    val u_modadd = List.tabulate(2) { x => Module(new modadd(utils.MOD(2))) }
    for (i <- 0 until 2) {
        u_modadd(i).io.in1 := io.vpu4_rd(i+4).data
        u_modadd(i).io.in2 := p >> 1
    }

    val q = List(q0, q1)
    val pinimq = List(pinimq0, pinimq1)
    val u_rs = List.tabulate(4) { x => Module(new vpu4_rs(x/2)) }
    val negate = dontTouch(count >= 0.U - io.i_vpu4_coeff_index)
    for (i <- 0 until 4) {
        u_rs(i).io.i_rs_a := ShiftRegister(io.vpu4_rd(i).data, modadd.delay)
        u_rs(i).io.i_rs_c := u_modadd(i%2).io.out
        u_rs(i).io.i_negate := ShiftRegister(negate, readDelay + modadd.delay)
    }

    val index_hit = ShiftRegister(vpu4_rdaddr === io.i_vpu4_coeff_index,
        readDelay + modadd.delay + vpu4_rs.delay)
    for (i <- 0 until 2) {
        when (index_hit) {
            io.vpu4_wr(i).data := u_rs(i*2).io.o_rs_d
        } .otherwise {
            io.vpu4_wr(i).data := 0.U
        }
        io.vpu4_wr(i+2).data := u_rs(i*2+1).io.o_rs_d
    }

    for (i <- 0 until 6) {
        io.vpu4_rd(i).addr := vpu4_rdaddr
    }

    for (i <- 0 until 4) {
        io.vpu4_wr(i).en := vpu4_wren
        io.vpu4_wr(i).addr := vpu4_wraddr
    }
}
