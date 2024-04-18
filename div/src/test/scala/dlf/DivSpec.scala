package div

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

class DivSetup extends Module {
  val io = IO(new Bundle{
    val div_clk_div = Output(Clock())
    val sel_clk_div = Input(UInt(5.W))
    val rst = Input(AsyncReset())
    val en = Input(Bool())
  })
  val divider = Module(new ClockDivider(5, 32))
  io.div_clk_div := divider.io.div_clk_div
  divider.io.sel_clk_div := io.sel_clk_div
  divider.io.rst := false.B.asAsyncReset
  divider.io.en := io.en
}

class DivSpec extends AnyFreeSpec with ChiselScalatestTester {
    "Runs" in {
    test(
      new DivSetup()
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.setTimeout(20000)
      dut.io.sel_clk_div.poke(5.U)
      dut.io.en.poke(true.B)
      dut.reset.poke(false.B)
      
      dut.clock.step()
      dut.reset.poke(true.B)
      dut.clock.step()
      dut.reset.poke(false.B)
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.reset.poke(true.B)
      //dut.io.en.expect(true.B)
    }
  }
}
