package dlf

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import scala.math._

// make reset synchronous to allow testing
class LoopGain[T<:Data](alg_width: Int, kp_width: Int, ki_width: Int, e_width: Int) extends Module {
    val io = IO{new Bundle{
        // val arstb = Input(AsyncReset())
        val e_shot = Input(UInt(2.W))
        val alg = Input(SInt(alg_width.W))
        val dlf_kp = Input(UInt(kp_width.W))
        val dlf_ki = Input(UInt(ki_width.W))
        // val e_temp = Output(SInt(alg_width.W))
        val e_i = Output(SInt(e_width.W))
        val e_p = Output(SInt(e_width.W))
    }}

    val reset_i = this.reset

    val e_temp = Wire(SInt(alg_width.W))
    // io.e_temp := e_temp
    e_temp := 1.S
    when (io.e_shot === 0.U){
        e_temp := 0.S
    } .elsewhen(io.e_shot.head(1) === 0.U){
        e_temp := io.alg.head(5).asSInt + 1.S
    } .otherwise {
        e_temp := -io.alg.head(5).asSInt - 1.S
    }

    io.e_i := withReset(reset_i){
        RegNext(e_temp << io.dlf_ki, 0.S)
    }
    io.e_p := withReset(reset_i){
        RegNext(e_temp << io.dlf_kp, 0.S)
    }
}

class LoopGainTester extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "LoopGain"

    it should "reset synchronously" in {
        test(new LoopGain(16, 4, 4, 8)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.io.e_i.expect(0.S)
            c.io.e_p.expect(0.S)
        }
    }

    it should "output 0 for both e_i and e_p when e_shot is 00" in {
        test(new LoopGain(16, 4, 4, 8)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.reset.poke(false.B)
            c.io.e_shot.poke(0.U)
            c.io.dlf_ki.poke(0.U)
            c.io.dlf_kp.poke(0.U)
            c.clock.step()
            c.io.e_i.expect(0.S)
            c.io.e_p.expect(0.S)
        }
    }

    it should "output 1 for both e_i and e_p when e_shot is 01 and alg is 0" in {
        test(new LoopGain(16, 4, 4, 8)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.reset.poke(false.B)
            c.io.e_shot.poke(1.U)
            c.io.alg.poke(0.S)
            println(c.io.alg.peek().litValue)
            c.io.dlf_ki.poke(0.U)
            c.io.dlf_kp.poke(0.U)
            c.clock.step()
            c.io.e_i.expect(1.S)
            c.io.e_p.expect(1.S)
        }
    }

    it should "output 2 for both e_i and e_p when e_shot is 01 and alg is 2^10 and dlf_kp/ki is 0" in {
        test(new LoopGain(16, 4, 4, 8)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.reset.poke(false.B)
            c.io.e_shot.poke(1.U)
            c.io.alg.poke(pow(2,11).toInt.S)
            println(c.io.alg.peek().litValue.toInt.toBinaryString)
            c.io.dlf_ki.poke(0.U)
            c.io.dlf_kp.poke(0.U)
            c.clock.step()
            c.io.e_i.expect(2.S)
            c.io.e_p.expect(2.S)
        }
    }

    it should "output -1 for both e_i and e_p when e_shot is 11 and alg is 0 and dlf_kp/ki is 0" in {
        test(new LoopGain(16, 4, 4, 30)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.reset.poke(false.B)
            c.io.e_shot.poke(3.U)
            c.io.alg.poke(0.S)
            println(c.io.alg.peek().litValue.toInt.toBinaryString)
            c.io.dlf_ki.poke(0.U)
            c.io.dlf_kp.poke(0.U)
            c.clock.step()
            c.io.e_i.expect(-1.S)
            c.io.e_p.expect(-1.S)
        }
    }

    it should "output -16 for both e_i and e_p when e_shot is 11 and alg is 0x7800 and dlf_kp/ki is 0" in {
        test(new LoopGain(16, 4, 4, 30)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.reset.poke(false.B)
            c.io.e_shot.poke(3.U)
            c.io.alg.poke(0x7800.S)
            println(c.io.alg.peek().litValue.toInt.toBinaryString)
            c.io.dlf_ki.poke(0.U)
            c.io.dlf_kp.poke(0.U)
            c.clock.step()
            c.io.e_i.expect(-16.S)
            c.io.e_p.expect(-16.S)
        }
    }

    it should "output 2 for both e_i and 32 e_p when e_shot is 01 and alg is 2^10 and dlf_ki is 0 and dlf_kp is 4" in {
        test(new LoopGain(16, 4, 4, 8)){ c =>
            c.reset.poke(true.B)
            c.clock.step()
            c.reset.poke(false.B)
            c.io.e_shot.poke(1.U)
            c.io.alg.poke(pow(2,11).toInt.S)
            println(c.io.alg.peek().litValue.toInt.toBinaryString)
            c.io.dlf_ki.poke(0.U)
            c.io.dlf_kp.poke(4.U)
            c.clock.step()
            c.io.e_i.expect(2.S)
            c.io.e_p.expect(32.S)
        }
    }
}