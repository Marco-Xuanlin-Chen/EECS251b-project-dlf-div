circuit ClockDivider :
  module DivLatch2 :
    output io : { flip rst : AsyncReset, flip input_clock : Clock, div2_clk : Clock, flip en : UInt<1>}

    wire reset : UInt<1> @[div.scala 57:21]
    node _reset_T = asUInt(io.rst) @[div.scala 58:22]
    node _reset_T_1 = eq(_reset_T, UInt<1>("h0")) @[div.scala 58:14]
    reset <= _reset_T_1 @[div.scala 58:11]
    node _io_div2_clk_T = asAsyncReset(reset) @[div.scala 59:60]
    node _io_div2_clk_T_1 = asUInt(io.div2_clk) @[div.scala 60:32]
    node _io_div2_clk_T_2 = bits(_io_div2_clk_T_1, 0, 0) @[div.scala 60:32]
    node _io_div2_clk_T_3 = eq(_io_div2_clk_T_2, UInt<1>("h0")) @[div.scala 60:19]
    reg io_div2_clk_r : UInt<1>, io.input_clock with :
      reset => (_io_div2_clk_T, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.en : @[Reg.scala 36:18]
      io_div2_clk_r <= _io_div2_clk_T_3 @[Reg.scala 36:22]
    node _io_div2_clk_T_4 = asClock(io_div2_clk_r) @[div.scala 61:7]
    io.div2_clk <= _io_div2_clk_T_4 @[div.scala 59:17]

  module DivLatch2_1 :
    output io : { flip rst : AsyncReset, flip input_clock : Clock, div2_clk : Clock, flip en : UInt<1>}

    wire reset : UInt<1> @[div.scala 57:21]
    node _reset_T = asUInt(io.rst) @[div.scala 58:22]
    node _reset_T_1 = eq(_reset_T, UInt<1>("h0")) @[div.scala 58:14]
    reset <= _reset_T_1 @[div.scala 58:11]
    node _io_div2_clk_T = asAsyncReset(reset) @[div.scala 59:60]
    node _io_div2_clk_T_1 = asUInt(io.div2_clk) @[div.scala 60:32]
    node _io_div2_clk_T_2 = bits(_io_div2_clk_T_1, 0, 0) @[div.scala 60:32]
    node _io_div2_clk_T_3 = eq(_io_div2_clk_T_2, UInt<1>("h0")) @[div.scala 60:19]
    reg io_div2_clk_r : UInt<1>, io.input_clock with :
      reset => (_io_div2_clk_T, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.en : @[Reg.scala 36:18]
      io_div2_clk_r <= _io_div2_clk_T_3 @[Reg.scala 36:22]
    node _io_div2_clk_T_4 = asClock(io_div2_clk_r) @[div.scala 61:7]
    io.div2_clk <= _io_div2_clk_T_4 @[div.scala 59:17]

  module DivLatch2_2 :
    output io : { flip rst : AsyncReset, flip input_clock : Clock, div2_clk : Clock, flip en : UInt<1>}

    wire reset : UInt<1> @[div.scala 57:21]
    node _reset_T = asUInt(io.rst) @[div.scala 58:22]
    node _reset_T_1 = eq(_reset_T, UInt<1>("h0")) @[div.scala 58:14]
    reset <= _reset_T_1 @[div.scala 58:11]
    node _io_div2_clk_T = asAsyncReset(reset) @[div.scala 59:60]
    node _io_div2_clk_T_1 = asUInt(io.div2_clk) @[div.scala 60:32]
    node _io_div2_clk_T_2 = bits(_io_div2_clk_T_1, 0, 0) @[div.scala 60:32]
    node _io_div2_clk_T_3 = eq(_io_div2_clk_T_2, UInt<1>("h0")) @[div.scala 60:19]
    reg io_div2_clk_r : UInt<1>, io.input_clock with :
      reset => (_io_div2_clk_T, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.en : @[Reg.scala 36:18]
      io_div2_clk_r <= _io_div2_clk_T_3 @[Reg.scala 36:22]
    node _io_div2_clk_T_4 = asClock(io_div2_clk_r) @[div.scala 61:7]
    io.div2_clk <= _io_div2_clk_T_4 @[div.scala 59:17]

  module DivLatch2_3 :
    output io : { flip rst : AsyncReset, flip input_clock : Clock, div2_clk : Clock, flip en : UInt<1>}

    wire reset : UInt<1> @[div.scala 57:21]
    node _reset_T = asUInt(io.rst) @[div.scala 58:22]
    node _reset_T_1 = eq(_reset_T, UInt<1>("h0")) @[div.scala 58:14]
    reset <= _reset_T_1 @[div.scala 58:11]
    node _io_div2_clk_T = asAsyncReset(reset) @[div.scala 59:60]
    node _io_div2_clk_T_1 = asUInt(io.div2_clk) @[div.scala 60:32]
    node _io_div2_clk_T_2 = bits(_io_div2_clk_T_1, 0, 0) @[div.scala 60:32]
    node _io_div2_clk_T_3 = eq(_io_div2_clk_T_2, UInt<1>("h0")) @[div.scala 60:19]
    reg io_div2_clk_r : UInt<1>, io.input_clock with :
      reset => (_io_div2_clk_T, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.en : @[Reg.scala 36:18]
      io_div2_clk_r <= _io_div2_clk_T_3 @[Reg.scala 36:22]
    node _io_div2_clk_T_4 = asClock(io_div2_clk_r) @[div.scala 61:7]
    io.div2_clk <= _io_div2_clk_T_4 @[div.scala 59:17]

  module DivLatch2_4 :
    output io : { flip rst : AsyncReset, flip input_clock : Clock, div2_clk : Clock, flip en : UInt<1>}

    wire reset : UInt<1> @[div.scala 57:21]
    node _reset_T = asUInt(io.rst) @[div.scala 58:22]
    node _reset_T_1 = eq(_reset_T, UInt<1>("h0")) @[div.scala 58:14]
    reset <= _reset_T_1 @[div.scala 58:11]
    node _io_div2_clk_T = asAsyncReset(reset) @[div.scala 59:60]
    node _io_div2_clk_T_1 = asUInt(io.div2_clk) @[div.scala 60:32]
    node _io_div2_clk_T_2 = bits(_io_div2_clk_T_1, 0, 0) @[div.scala 60:32]
    node _io_div2_clk_T_3 = eq(_io_div2_clk_T_2, UInt<1>("h0")) @[div.scala 60:19]
    reg io_div2_clk_r : UInt<1>, io.input_clock with :
      reset => (_io_div2_clk_T, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.en : @[Reg.scala 36:18]
      io_div2_clk_r <= _io_div2_clk_T_3 @[Reg.scala 36:22]
    node _io_div2_clk_T_4 = asClock(io_div2_clk_r) @[div.scala 61:7]
    io.div2_clk <= _io_div2_clk_T_4 @[div.scala 59:17]

  module ClockMux :
    input clock : Clock
    input reset : Reset
    output io : { flip sel : UInt<1>, flip clocksIn : Clock[2], clockOut : Clock}

    io.clockOut <= io.clocksIn[1] @[div.scala 35:17]

  module ClockMux_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip sel : UInt<1>, flip clocksIn : Clock[2], clockOut : Clock}

    io.clockOut <= io.clocksIn[1] @[div.scala 35:17]

  module ClockMux_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip sel : UInt<1>, flip clocksIn : Clock[2], clockOut : Clock}

    io.clockOut <= io.clocksIn[1] @[div.scala 35:17]

  module ClockMux_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip sel : UInt<1>, flip clocksIn : Clock[2], clockOut : Clock}

    io.clockOut <= io.clocksIn[1] @[div.scala 35:17]

  module ClockMux_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip sel : UInt<1>, flip clocksIn : Clock[2], clockOut : Clock}

    io.clockOut <= io.clocksIn[1] @[div.scala 35:17]

  module ClockMuxTree :
    input clock : Clock
    input reset : Reset
    output io : { flip in_clks : Clock[5], out_clk : Clock, flip sel_clk : UInt<3>}

    inst io_out_clk_mux of ClockMux @[div.scala 84:21]
    io_out_clk_mux.clock <= clock
    io_out_clk_mux.reset <= reset
    node _io_out_clk_mux_io_sel_T = bits(io.sel_clk, 1, 1) @[div.scala 93:31]
    io_out_clk_mux.io.sel <= _io_out_clk_mux_io_sel_T @[div.scala 93:18]
    inst io_out_clk_mux_io_clocksIn_0_mux of ClockMux_1 @[div.scala 84:21]
    io_out_clk_mux_io_clocksIn_0_mux.clock <= clock
    io_out_clk_mux_io_clocksIn_0_mux.reset <= reset
    node _io_out_clk_mux_io_clocksIn_0_mux_io_sel_T = bits(io.sel_clk, 1, 1) @[div.scala 86:31]
    io_out_clk_mux_io_clocksIn_0_mux.io.sel <= _io_out_clk_mux_io_clocksIn_0_mux_io_sel_T @[div.scala 86:18]
    io_out_clk_mux_io_clocksIn_0_mux.io.clocksIn[0] <= io.in_clks[0] @[div.scala 87:73]
    io_out_clk_mux_io_clocksIn_0_mux.io.clocksIn[1] <= io.in_clks[1] @[div.scala 87:73]
    io_out_clk_mux.io.clocksIn[0] <= io_out_clk_mux_io_clocksIn_0_mux.io.clockOut @[div.scala 95:26]
    inst io_out_clk_mux_io_clocksIn_1_mux of ClockMux_2 @[div.scala 84:21]
    io_out_clk_mux_io_clocksIn_1_mux.clock <= clock
    io_out_clk_mux_io_clocksIn_1_mux.reset <= reset
    node _io_out_clk_mux_io_clocksIn_1_mux_io_sel_T = bits(io.sel_clk, 0, 0) @[div.scala 93:31]
    io_out_clk_mux_io_clocksIn_1_mux.io.sel <= _io_out_clk_mux_io_clocksIn_1_mux_io_sel_T @[div.scala 93:18]
    inst io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux of ClockMux_3 @[div.scala 84:21]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux.clock <= clock
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux.reset <= reset
    node _io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_sel_T = bits(io.sel_clk, 0, 0) @[div.scala 86:31]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux.io.sel <= _io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_sel_T @[div.scala 86:18]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux.io.clocksIn[0] <= io.in_clks[2] @[div.scala 87:73]
    reg io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[div.scala 89:38]
    node _io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1_T = asClock(io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1_REG) @[div.scala 89:48]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux.io.clocksIn[1] <= _io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1_T @[div.scala 89:28]
    io_out_clk_mux_io_clocksIn_1_mux.io.clocksIn[0] <= io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux.io.clockOut @[div.scala 95:26]
    inst io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux of ClockMux_4 @[div.scala 84:21]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux.clock <= clock
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux.reset <= reset
    node _io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_sel_T = bits(io.sel_clk, 0, 0) @[div.scala 86:31]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux.io.sel <= _io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_sel_T @[div.scala 86:18]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux.io.clocksIn[0] <= io.in_clks[3] @[div.scala 87:73]
    io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux.io.clocksIn[1] <= io.in_clks[4] @[div.scala 87:73]
    io_out_clk_mux_io_clocksIn_1_mux.io.clocksIn[1] <= io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux.io.clockOut @[div.scala 96:26]
    io_out_clk_mux.io.clocksIn[1] <= io_out_clk_mux_io_clocksIn_1_mux.io.clockOut @[div.scala 96:26]
    io.out_clk <= io_out_clk_mux.io.clockOut @[div.scala 101:14]

  module ClockDivider :
    input clock : Clock
    input reset : UInt<1>
    output io : { div_clk_div : Clock, flip sel_clk_div : UInt<5>, flip rst : AsyncReset, flip en : UInt<1>}

    wire clk_div_nets : Clock[5] @[div.scala 115:28]
    inst clk_div_map_0 of DivLatch2 @[div.scala 117:62]
    inst clk_div_map_1 of DivLatch2_1 @[div.scala 117:62]
    inst clk_div_map_2 of DivLatch2_2 @[div.scala 117:62]
    inst clk_div_map_3 of DivLatch2_3 @[div.scala 117:62]
    inst clk_div_map_4 of DivLatch2_4 @[div.scala 117:62]
    clk_div_nets[0] <= clk_div_map_0.io.div2_clk @[div.scala 120:47]
    clk_div_nets[1] <= clk_div_map_1.io.div2_clk @[div.scala 120:47]
    clk_div_nets[2] <= clk_div_map_2.io.div2_clk @[div.scala 120:47]
    clk_div_nets[3] <= clk_div_map_3.io.div2_clk @[div.scala 120:47]
    clk_div_nets[4] <= clk_div_map_4.io.div2_clk @[div.scala 120:47]
    clk_div_map_0.io.en <= io.en @[div.scala 123:33]
    clk_div_map_1.io.en <= io.en @[div.scala 123:33]
    clk_div_map_2.io.en <= io.en @[div.scala 123:33]
    clk_div_map_3.io.en <= io.en @[div.scala 123:33]
    clk_div_map_4.io.en <= io.en @[div.scala 123:33]
    clk_div_map_0.io.rst <= io.rst @[div.scala 124:34]
    clk_div_map_1.io.rst <= io.rst @[div.scala 124:34]
    clk_div_map_2.io.rst <= io.rst @[div.scala 124:34]
    clk_div_map_3.io.rst <= io.rst @[div.scala 124:34]
    clk_div_map_4.io.rst <= io.rst @[div.scala 124:34]
    clk_div_map_0.io.input_clock <= clock @[div.scala 128:26]
    clk_div_map_1.io.input_clock <= clk_div_map_0.io.div2_clk @[div.scala 128:26]
    clk_div_map_2.io.input_clock <= clk_div_map_1.io.div2_clk @[div.scala 128:26]
    clk_div_map_3.io.input_clock <= clk_div_map_2.io.div2_clk @[div.scala 128:26]
    clk_div_map_4.io.input_clock <= clk_div_map_3.io.div2_clk @[div.scala 128:26]
    clk_div_nets[4] <= clk_div_map_4.io.div2_clk @[div.scala 126:23]
    inst div_mux_tree of ClockMuxTree @[div.scala 134:30]
    div_mux_tree.clock <= clock
    div_mux_tree.reset <= reset
    div_mux_tree.io.in_clks[0] <= clk_div_nets[0] @[div.scala 135:29]
    div_mux_tree.io.in_clks[1] <= clk_div_nets[1] @[div.scala 135:29]
    div_mux_tree.io.in_clks[2] <= clk_div_nets[2] @[div.scala 135:29]
    div_mux_tree.io.in_clks[3] <= clk_div_nets[3] @[div.scala 135:29]
    div_mux_tree.io.in_clks[4] <= clk_div_nets[4] @[div.scala 135:29]
    div_mux_tree.io.sel_clk <= io.sel_clk_div @[div.scala 136:29]
    io.div_clk_div <= div_mux_tree.io.out_clk @[div.scala 137:20]

