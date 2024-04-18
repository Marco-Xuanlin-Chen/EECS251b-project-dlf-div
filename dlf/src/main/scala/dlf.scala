package dlf

import java.io._
import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

import scala.math._

class IntegralPath[T<:Data](dlf_ic_width: Int, dlf_i_width: Int, ic_shift: Int) extends Module{
    val io = IO{new Bundle{
        val en = Input(Bool())
        val rst = Input(AsyncReset())
        val dlf_ic = Input(SInt(dlf_ic_width.W))
        val dlf_i = Input(SInt(dlf_i_width.W))
        val ki = Input(SInt())
        val dlf_i_out = Output(SInt(dlf_i_width.W))
    }}
    val dlf_i_temp = io.ki * dlf_ic + dlf_i

    io.dlf_i_out := withReset(!io.rst.asBool){RegEnable((0.B ## dlf_i_temp.tail(1)).asSInt, dlf_i_temp << ic_shift, io.en)}
}

class ProportionalPath[T<:Data](dlf_i_width: Int, ic_shift: Int) extends Module{
    val io = IO{new Bundle{
        val dlf_p = Input(SInt(dlf_i_width.W))
        val dlf_i_out = Input(SInt(dlf_i_width.W))
        val kp = Input(SInt())
        val dlf_out = Output(SInt(dlf_i_width.W))
    }}
    val mag = kp * io.dlf_p
    io.dlf_out := io.dlf_i_out + (mag << ic_shift)
}

//TODO: Implement DSM
//TODO: Add a differential path to the PID controller for experimenting with

class DigitalLoopFilter[T<:Data](kp_width: Int,
                                ki_width: Int,
                                dlf_ic_width: Int,
                                dlf_i_width: Int,
                                dco_fcw_width: Int,
                                ic_shift: Int,
                                max_fcw: Int,
                                min_fcw: Int,
                                ) extends Module {
    val io = IO(new Bundle{
    val rst = Input(AsyncReset())
    val dlf_ic = Input(SInt(dlf_ic_width.W))
    val dlf_kp = Input(UInt(kp_width.W))
    val dlf_ki = Input(UInt(ki_width.W))
    val fcw_out = Output(SInt(dco_fcw_width.W))
  })

    val alg = Module(new AdaptiveLoopGain(buf_depth, alg_width, alg_ic_width, alg_ga_width, alg_gain_max_power, kp_width, ki_width, dlf_i_width, ic_shift))
    val i_path = Module(new IntegralPath(dlf_ic_width, dlf_i_width, ic_shift))
    val p_path = Module(new ProportionalPath(dlf_i_width, ic_shift))

    // Connect sub-cells
    i_path.io.rst := io.rst

    // i_path
    val dlf_i_prop = io.dlf_ic << ic_shift
    i_path.io.dlf_ic := io.dlf_ic
    i_path.io.dlf_i := i_path.io.dlf_i_out
    i_path.io.ki := io.dlf_ki


    // p gain
    p_path.io.dlf_i_out := i_path.io.dlf_i_out
    p_path.io.kp := dlf_kp
    p_path.io.dlf_p := dlf_i_prop

    val fcw_next = Wire(SInt(dco_fcw_width.W))

    i_path.io.en := true.B

    when (p_path.io.dlf_out.head(dco_fcw_width).asSInt >= max_fcw.S){
        fcw_next := max_fcw.S
    } .elsewhen (p_path.io.dlf_out.head(dco_fcw_width).asSInt <= min_fcw.S){
        fcw_next := min_fcw.S
    } .otherwise {
        fcw_next := p_path.io.dlf_out.head(dco_fcw_width).asSInt
    }

    io.fcw_out := withReset(reset_i.asBool){RegEnable(fcw_next, p_path.io.dlf_out.asSInt, true.B)}
}

object VerilogMain extends App{
    def printFile(f: java.io.File)(op: java.io.PrintWriter => Unit) {
        val p = new java.io.PrintWriter(f)
        try { op(p) } finally { p.close() }
    }

    val pretty = Array(
    "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )
    getVerilogString(new DigitalLoopFilter(4, 4, 8, 15, 8, 15, 255, 0), pretty)
}
