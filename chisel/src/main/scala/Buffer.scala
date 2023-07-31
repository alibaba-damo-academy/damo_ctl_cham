package mvp.buffer

import chisel3._
import chisel3.util._
import chisel3.experimental._

import mvp.common._
import mvp.polyram._

class poly_rd_interface(width: Int, nElems: Int, nBanks: Int, readDelay: Int) extends Module {
    override val desiredName = s"poly_rd_interface_${width}_${nElems}_${nBanks}_${readDelay}"

    val dataWidth = width
    val hiAddrWidth = utils.log2(nBanks)
    val loAddrWidth = utils.log2(nElems)
    val addrWidth = hiAddrWidth + loAddrWidth

    val io = IO(new Bundle {
        val vpu_rd = Flipped(new VpuRdPort(dataWidth, addrWidth, nBanks))
        val buf_rd = new BufRdPort(dataWidth, loAddrWidth, nBanks)
    })

    val lo_addr = utils.slice(io.vpu_rd.addr, 0, loAddrWidth)
    val hi_addr = utils.slice(io.vpu_rd.addr, loAddrWidth, addrWidth)

    io.buf_rd.addr := utils.repeat(nBanks, lo_addr)

    var lut = List.tabulate(nBanks) { x => (x.U -> io.buf_rd.data(x)) }

    io.vpu_rd.data := MuxLookup(ShiftRegister(hi_addr, readDelay), 0.U, lut)
}

class poly_wr_interface(width: Int, nElems: Int, nBanks: Int) extends Module {
    override val desiredName = s"poly_wr_interface_${width}_${nElems}_${nBanks}"

    val dataWidth = width
    val hiAddrWidth = utils.log2(nBanks)
    val loAddrWidth = utils.log2(nElems)
    val addrWidth = hiAddrWidth + loAddrWidth

    val io = IO(new Bundle {
        val vpu_wr = Flipped(new VpuWrPort(dataWidth, addrWidth, nBanks))
        val buf_wr = new BufWrPort(dataWidth, loAddrWidth, nBanks)
    })

    val lo_addr = utils.slice(io.vpu_wr.addr, 0, loAddrWidth)
    val hi_addr = utils.slice(io.vpu_wr.addr, loAddrWidth, addrWidth)

    io.buf_wr.addr := utils.repeat(nBanks, lo_addr)
    io.buf_wr.data := utils.repeat(nBanks, io.vpu_wr.data)

    when (io.vpu_wr.en) {
        io.buf_wr.en := UIntToOH(hi_addr).asBools
    } .otherwise {
        io.buf_wr.en := utils.repeat(nBanks, 0.B)
    }
}

class double_pp_buffer(width: Int, nElems: Int, nBanks: Int) extends Module {
    override val desiredName = s"double_pp_buffer_${width}_${nElems}_${nBanks}"

    val io = IO(new Bundle {
        val i_done = Input(Bool())
        val polyvec0_rd = Flipped(new BufRdPort(width, utils.log2(nElems), nBanks))
        val polyvec0_wr = Flipped(new BufWrPort(width, utils.log2(nElems), nBanks))
        val polyvec1_rd = Flipped(new BufRdPort(width, utils.log2(nElems), nBanks))
        val polyvec1_wr = Flipped(new BufWrPort(width, utils.log2(nElems), nBanks))
    })
    
    val done_r = RegNext(io.i_done)

    val s01 :: s10 :: Nil = Enum(2)
    val state = RegInit(s01)
    when (io.i_done && !done_r) {
        switch (state) {
            is (s01) { state := s10 }
            is (s10) { state := s01 }
        }
    }

    val u_ram = List.fill(2) {
        Module(new poly_ram_wrapper(width, utils.log2(nElems), nBanks))
    }

    when (state === s01) {
        io.polyvec0_rd <> u_ram(0).io.rd
        io.polyvec0_wr <> u_ram(0).io.wr
        io.polyvec1_rd <> u_ram(1).io.rd
        io.polyvec1_wr <> u_ram(1).io.wr
    } .elsewhen (state === s10) {
        io.polyvec0_rd <> u_ram(1).io.rd
        io.polyvec0_wr <> u_ram(1).io.wr
        io.polyvec1_rd <> u_ram(0).io.rd
        io.polyvec1_wr <> u_ram(0).io.wr
    } .otherwise {
        io := DontCare
        u_ram(0).io := DontCare
        u_ram(1).io := DontCare
    }
}

class triple_pp_buffer(width: Int, nElems: Int, nBanks: Int) extends Module {
    override val desiredName = s"triple_pp_buffer_${width}_${nElems}_${nBanks}"

    val io = IO(new Bundle {
        val i_done = Input(Bool())
        val polyvec0_rd = Flipped(new BufRdPort(width, utils.log2(nElems), nBanks))
        val polyvec0_wr = Flipped(new BufWrPort(width, utils.log2(nElems), nBanks))
        val polyvec1_rd = Flipped(new BufRdPort(width, utils.log2(nElems), nBanks))
        val polyvec1_wr = Flipped(new BufWrPort(width, utils.log2(nElems), nBanks))
        val polyvec2_rd = Flipped(new BufRdPort(width, utils.log2(nElems), nBanks))
        val polyvec2_wr = Flipped(new BufWrPort(width, utils.log2(nElems), nBanks))
    })
    
    val done_r = RegNext(io.i_done)

    val s012 :: s201 :: s120 :: Nil = Enum(3)
    val state = RegInit(s012)
    when (io.i_done && !done_r) {
        switch (state) {
            is (s012) { state := s201 }
            is (s201) { state := s120 }
            is (s120) { state := s012 }
        }
    }

    val u_ram = List.fill(3) {
        Module(new poly_ram_wrapper(width, utils.log2(nElems), nBanks))
    }

    when (state === s012) {
        io.polyvec0_rd <> u_ram(0).io.rd
        io.polyvec0_wr <> u_ram(0).io.wr
        io.polyvec1_rd <> u_ram(1).io.rd
        io.polyvec1_wr <> u_ram(1).io.wr
        io.polyvec2_rd <> u_ram(2).io.rd
        io.polyvec2_wr <> u_ram(2).io.wr
    } .elsewhen (state === s201) {
        io.polyvec0_rd <> u_ram(2).io.rd
        io.polyvec0_wr <> u_ram(2).io.wr
        io.polyvec1_rd <> u_ram(0).io.rd
        io.polyvec1_wr <> u_ram(0).io.wr
        io.polyvec2_rd <> u_ram(1).io.rd
        io.polyvec2_wr <> u_ram(1).io.wr
    } .elsewhen (state === s120) {
        io.polyvec0_rd <> u_ram(1).io.rd
        io.polyvec0_wr <> u_ram(1).io.wr
        io.polyvec1_rd <> u_ram(2).io.rd
        io.polyvec1_wr <> u_ram(2).io.wr
        io.polyvec2_rd <> u_ram(0).io.rd
        io.polyvec2_wr <> u_ram(0).io.wr
    } .otherwise {
        io := DontCare
        u_ram(0).io := DontCare
        u_ram(1).io := DontCare
        u_ram(2).io := DontCare
    }
}
