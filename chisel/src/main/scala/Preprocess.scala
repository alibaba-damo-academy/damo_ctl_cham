package mvp.preprocess

import mvp.common._
import mvp.intt._
import mvp.vpu4._
import mvp.polyram._
import mvp.buffer._

import chisel3._
import chisel3.util._

class preprocess_top_chisel extends Module {
    val bramDelay = 1

    val io = IO(new Bundle {
        val i_intt_start = Input(Bool())
        val o_intt_done = Output(Bool())
        val i_vpu4_start = Input(Bool())
        val o_vpu4_done = Output(Bool())
        val i_pre_switch = Input(Bool())
        val i_mux_done = Input(Bool())

        val i_coeff_index = Input(UInt(12.W))
        
        val dp1_wr = MixedVec(
            List.tabulate(6) { x => Flipped(new VpuWrPort(utils.MODWIDTH(x/2), 12, 8)) }
        )
        val dp1_rd = MixedVec(
            List.tabulate(6) { x => Flipped(new VpuRdPort(utils.MODWIDTH(x/2), 12, 8)) }
        )
        val mux_rd = MixedVec(
            List.tabulate(4) { x => Flipped(new VpuRdPort(utils.MODWIDTH(x%2), 12, 8)) }
        )
    })

    val u_intt = List.tabulate(6) { x => Module(new intt_wrapper(x/2)) }
    val u_vpu4 = Module(new vpu4_top(4096, 1))

    val u_intt_buf = List.tabulate(6) { x =>
        Module(new poly_ram_wrapper(utils.MODWIDTH(x/2), 9, 8))
    }
    val u_tpp = List.tabulate(6) { x =>
        Module(new triple_pp_buffer(utils.MODWIDTH(x/2), 512, 8))
    }
    val u_dpp = List.tabulate(4) { x =>
        Module(new double_pp_buffer(utils.MODWIDTH(x%2), 512, 8))
    }

    val u_dp1_wr_itf = List.tabulate(6) { x =>
        Module(new poly_wr_interface(utils.MODWIDTH(x/2), 512, 8))
    }
    val u_dp1_rd_itf = List.tabulate(6) { x =>
        Module(new poly_rd_interface(utils.MODWIDTH(x/2), 512, 8, bramDelay))
    }
    val u_vpu4_rd_itf = List.tabulate(6) { x =>
        Module(new poly_rd_interface(utils.MODWIDTH(x/2), 512, 8, bramDelay))
    }
    val u_vpu4_wr_itf = List.tabulate(4) { x =>
        Module(new poly_wr_interface(utils.MODWIDTH(x%2), 512, 8))
    }
    val u_mux_rd_itf = List.tabulate(4) { x =>
        Module(new poly_rd_interface(utils.MODWIDTH(x%2), 512, 8, bramDelay))
    }

    for (i <- 0 until 6) {
        io.dp1_wr(i)            <> u_dp1_wr_itf(i).io.vpu_wr
        io.dp1_rd(i)            <> u_dp1_rd_itf(i).io.vpu_rd

        u_tpp(i).io.polyvec0_wr <> u_dp1_wr_itf(i).io.buf_wr
        u_tpp(i).io.polyvec0_rd <> u_dp1_rd_itf(i).io.buf_rd
        u_tpp(i).io.polyvec1_wr <> u_intt(i).io.wr_l
        u_tpp(i).io.polyvec1_rd <> u_intt(i).io.rd_l
        u_tpp(i).io.polyvec2_rd <> u_vpu4_rd_itf(i).io.buf_rd
        u_tpp(i).io.polyvec2_wr <> DontCare

        u_intt(i).io.wr_r       <> u_intt_buf(i).io.wr
        u_intt(i).io.rd_r       <> u_intt_buf(i).io.rd

        u_vpu4.io.vpu4_rd(i)    <> u_vpu4_rd_itf(i).io.vpu_rd
    }

    for (i <- 0 until 4) {
        u_vpu4.io.vpu4_wr(i)    <> u_vpu4_wr_itf(i).io.vpu_wr

        u_dpp(i).io.polyvec0_wr <> u_vpu4_wr_itf(i).io.buf_wr
        u_dpp(i).io.polyvec0_rd <> DontCare
        u_dpp(i).io.polyvec1_rd <> u_mux_rd_itf(i).io.buf_rd
        u_dpp(i).io.polyvec1_wr <> DontCare

        io.mux_rd(i)            <> u_mux_rd_itf(i).io.vpu_rd
    }

    for (i <- 0 until 6) {
        io.i_intt_start <> u_intt(i).io.ntt_start
    }
    io.o_intt_done      := u_intt(0).io.ntt_done && u_intt(1).io.ntt_done &&
                           u_intt(2).io.ntt_done && u_intt(3).io.ntt_done &&
                           u_intt(4).io.ntt_done && u_intt(5).io.ntt_done

    io.i_vpu4_start     <> u_vpu4.io.i_vpu4_start
    io.o_vpu4_done      <> u_vpu4.io.o_vpu4_done
    io.i_coeff_index    <> u_vpu4.io.i_vpu4_coeff_index

    for (i <- 0 until 6) {
        u_tpp(i).io.i_done := io.i_pre_switch
    }

    for (i <- 0 until 4) {
        u_dpp(i).io.i_done := io.o_vpu4_done && io.i_mux_done
    }
}
