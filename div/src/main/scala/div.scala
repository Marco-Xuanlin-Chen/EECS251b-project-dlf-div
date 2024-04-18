package div

import java.io._
import chisel3._
import chisel3.util._
import scala.math._

/**
    author: Marco
    credited to Sean for latched based design. 
*/

trait ClockDivParams [T<:Data] {
    val n_div_sel: Int
    val max_div: Int
}

class ClockDivIO [T <: Data] (n_div_sel: Int) extends Bundle {
  val div_clk_div = Output(Clock())
  val sel_clk_div = Input(UInt(n_div_sel.W))
  val rst = Input(AsyncReset())
  val en = Input(Bool())
}

//The mux blackbox used to select divison based on n divisn inputs
class ClockMux () extends Module{
  val io = IO(new Bundle{
    val sel = Input(Bool())
    val clocksIn = Input(Vec(2, Clock()))
    val clockOut = Output(Clock())
  })
  if (io.sel == true.B) {
    io.clockOut := io.clocksIn(0)
  } else {
    io.clockOut := io.clocksIn(1)
  }
}

/*due to bug, currently only assume 6 outputs, ordinary to /32
class ClockMux (n_div_sel: Int) extends Module {
  val io = IO (new Bundle {
    val rst = Input(AsyncReset())
    val input_clock = Input(Vec(n_div_sel, Clock()))
    val div2_clk = Output(Clock())
    val en = Input(Bool())
  })
}*/

/*latch divide the clock by 2 each time*/
class DivLatch2 [T<:Data] () extends RawModule {
    val io = IO(new Bundle{
        val rst = Input(AsyncReset())
        val input_clock = Input(Clock())
        val div2_clk = Output(Clock())
        val en = Input(Bool())
    })
    val reset = Wire(Bool())
    reset := !io.rst.asBool
    io.div2_clk := withClockAndReset(io.input_clock, reset.asAsyncReset){
        RegEnable(!io.div2_clk.asBool, false.B, io.en)
    }.asClock
}

class ClockMuxTree [T<:Data] (n_sel: Int, n_inputs: Int = 0) extends Module {
  var in_n = 0
  if (n_inputs == 0){
    in_n = math.pow(2, n_sel).toInt
  } else {
    in_n = n_inputs
  }
  /*
  in_clks: clock inputs, all 5 of them
  out_clks: clock output, selction of either of them
  sel_clk: n input that select the value for division. (debugging purposes)
  */
  val io = IO(new Bundle{
    val in_clks = Input(Vec(in_n, Clock()))
    val out_clk = Output(Clock())
    val sel_clk = Input(UInt(n_sel.W))
  })

  def RecursiveMuxTree (vec: IndexedSeq[Clock], depth: Int): Clock = {
    val midpt = vec.length / 2
    val mux = Module(new ClockMux())
    if (vec.size <= 2) {
      mux.io.sel := io.sel_clk(depth)
      vec.zipWithIndex.foreach{case (wire, idx) => mux.io.clocksIn(idx) := wire}
      if (vec.size == 1) {
        mux.io.clocksIn(1) := RegInit(false.B).asClock
      }
    }
    else {
      mux.io.sel := io.sel_clk((log(midpt) / log(2)).abs.floor.toInt)
      val (left, right) = vec.splitAt(midpt)
      mux.io.clocksIn(0) := RecursiveMuxTree(left, depth - 1)
      mux.io.clocksIn(1) := RecursiveMuxTree(right, depth - 1)
    }
    return mux.io.clockOut
  }

  io.out_clk := RecursiveMuxTree(io.in_clks, n_sel - 1)

}


//high level definition for the whole clock divider
class ClockDivider [T<:Data] (n_div_sel: Int, max_div: Int) extends Module {
    val io = IO(new ClockDivIO(n_div_sel))
    val maxDepthDiv = (log(max_div) / log(2)).ceil.toInt
    val maxDepth = maxDepthDiv.ceil.toInt
    val minDepthDiv = maxDepthDiv - n_div_sel
    // Sanity checks
    require(n_div_sel > 0, "Must have one select bit for clock")
    require(minDepthDiv >= 0, "Too many bits to select for required max fbdiv ratio")
    val clk_div_nets = Wire(Vec(maxDepth, Clock()))
    // Instantiate all latches
    val clk_div_map = (0 until maxDepth).map{i: Int => Module(new DivLatch2())}
    // Connect all latch outputs to top level Vec
    (0 until maxDepth).zip(clk_div_map).foreach{
        case (idx, inst) => clk_div_nets(idx) := inst.io.div2_clk
    }
    // Connect all ClockDiv2 ens and resets to top level en
    clk_div_map.foreach{_.io.en := io.en}
    clk_div_map.foreach{_.io.rst := io.rst}
    // Connect ClockDiv2s in a cascade so each is another power of 2 division
    clk_div_nets.last := clk_div_map.foldLeft(this.clock){ // this connection is technically redundant, check if necessary
      (A, B) => {
        B.io.input_clock := A
        B.io.div2_clk
      }
    }

    //high level connections
    val div_mux_tree = Module(new ClockMuxTree(log2Ceil(n_div_sel), maxDepthDiv - minDepthDiv))
    div_mux_tree.io.in_clks := clk_div_nets.slice(minDepthDiv, maxDepthDiv)
    div_mux_tree.io.sel_clk := io.sel_clk_div
    io.div_clk_div := div_mux_tree.io.out_clk
}

//initialize generation
object VerilogMain extends App{
    def printFile(f: java.io.File)(op: java.io.PrintWriter => Unit) {
        val p = new java.io.PrintWriter(f)
        try { op(p) } finally { p.close() }
    }

    val pretty = Array(
    "--emission-options", "disableMemRandomization,disableRegisterRandomization"
    )

    getVerilogString(new ClockDivider(5, 32), pretty)
}
