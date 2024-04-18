circuit DigitalLoopFilter :
  module IntegralPath :
    input clock : Clock
    input reset : Reset
    output io : { flip en : UInt<1>, flip rst : AsyncReset, flip dlf_ic : SInt<8>, flip dlf_i : SInt<15>, flip ki : SInt, dlf_i_out : SInt<15>}

    node _dlf_i_temp_T = mul(io.ki, io.dlf_ic) @[dlf.scala 19:28]
    node _dlf_i_temp_T_1 = add(_dlf_i_temp_T, io.dlf_i) @[dlf.scala 19:40]
    node _dlf_i_temp_T_2 = tail(_dlf_i_temp_T_1, 1) @[dlf.scala 19:40]
    node dlf_i_temp = asSInt(_dlf_i_temp_T_2) @[dlf.scala 19:40]
    node _io_dlf_i_out_T = asUInt(io.rst) @[dlf.scala 21:39]
    node _io_dlf_i_out_T_1 = eq(_io_dlf_i_out_T, UInt<1>("h0")) @[dlf.scala 21:31]
    node _io_dlf_i_out_T_2 = tail(dlf_i_temp, 1) @[dlf.scala 21:80]
    node _io_dlf_i_out_T_3 = cat(UInt<1>("h0"), _io_dlf_i_out_T_2) @[dlf.scala 21:62]
    node _io_dlf_i_out_T_4 = asSInt(_io_dlf_i_out_T_3) @[dlf.scala 21:85]
    node _io_dlf_i_out_T_5 = shl(dlf_i_temp, 15) @[dlf.scala 21:104]
    reg io_dlf_i_out_r : SInt, clock with :
      reset => (_io_dlf_i_out_T_1, _io_dlf_i_out_T_5) @[Reg.scala 35:20]
    when io.en : @[Reg.scala 36:18]
      io_dlf_i_out_r <= _io_dlf_i_out_T_4 @[Reg.scala 36:22]
    io.dlf_i_out <= io_dlf_i_out_r @[dlf.scala 21:18]

  module ProportionalPath :
    input clock : Clock
    input reset : Reset
    output io : { flip dlf_p : SInt<15>, flip dlf_i_out : SInt<15>, flip kp : SInt, dlf_out : SInt<15>}

    node mag = mul(io.kp, io.dlf_i_out) @[dlf.scala 31:21]
    node _io_dlf_out_T = shl(mag, 15) @[dlf.scala 32:23]
    io.dlf_out <= _io_dlf_out_T @[dlf.scala 32:16]

  module DigitalLoopFilter :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rst : AsyncReset, flip dlf_ic : SInt<8>, flip dlf_kp : UInt<4>, flip dlf_ki : UInt<4>, fcw_out : SInt<8>}

    inst i_path of IntegralPath @[dlf.scala 55:24]
    i_path.clock <= clock
    i_path.reset <= reset
    inst p_path of ProportionalPath @[dlf.scala 56:24]
    p_path.clock <= clock
    p_path.reset <= reset
    node _reset_i_T = asUInt(io.rst) @[dlf.scala 58:28]
    node _reset_i_T_1 = eq(_reset_i_T, UInt<1>("h0")) @[dlf.scala 58:20]
    node reset_i = asAsyncReset(_reset_i_T_1) @[dlf.scala 58:36]
    i_path.io.rst <= io.rst @[dlf.scala 60:19]
    node dlf_i_prop = shl(io.dlf_ic, 15) @[dlf.scala 63:32]
    i_path.io.dlf_ic <= io.dlf_ic @[dlf.scala 64:22]
    i_path.io.dlf_i <= i_path.io.dlf_i_out @[dlf.scala 65:21]
    node _i_path_io_ki_T = asSInt(io.dlf_ki) @[dlf.scala 66:31]
    i_path.io.ki <= _i_path_io_ki_T @[dlf.scala 66:18]
    p_path.io.dlf_i_out <= i_path.io.dlf_i_out @[dlf.scala 70:25]
    node _p_path_io_kp_T = asSInt(io.dlf_kp) @[dlf.scala 71:31]
    p_path.io.kp <= _p_path_io_kp_T @[dlf.scala 71:18]
    p_path.io.dlf_p <= io.dlf_ic @[dlf.scala 72:21]
    wire fcw_next : SInt<8> @[dlf.scala 74:24]
    i_path.io.en <= UInt<1>("h1") @[dlf.scala 76:18]
    node _T = head(p_path.io.dlf_out, 8) @[dlf.scala 78:33]
    node _T_1 = asSInt(_T) @[dlf.scala 78:49]
    node _T_2 = geq(_T_1, asSInt(UInt<9>("hff"))) @[dlf.scala 78:56]
    when _T_2 : @[dlf.scala 78:69]
      fcw_next <= asSInt(UInt<9>("hff")) @[dlf.scala 79:18]
    else :
      node _T_3 = head(p_path.io.dlf_out, 8) @[dlf.scala 80:40]
      node _T_4 = asSInt(_T_3) @[dlf.scala 80:56]
      node _T_5 = leq(_T_4, asSInt(UInt<1>("h0"))) @[dlf.scala 80:63]
      when _T_5 : @[dlf.scala 80:76]
        fcw_next <= asSInt(UInt<1>("h0")) @[dlf.scala 81:18]
      else :
        node _fcw_next_T = head(p_path.io.dlf_out, 8) @[dlf.scala 83:43]
        node _fcw_next_T_1 = asSInt(_fcw_next_T) @[dlf.scala 83:59]
        fcw_next <= _fcw_next_T_1 @[dlf.scala 83:18]
    node _io_fcw_out_T = asUInt(reset_i) @[dlf.scala 86:37]
    reg io_fcw_out_r : SInt, clock with :
      reset => (_io_fcw_out_T, p_path.io.dlf_out) @[Reg.scala 35:20]
    when UInt<1>("h1") : @[Reg.scala 36:18]
      io_fcw_out_r <= fcw_next @[Reg.scala 36:22]
    io.fcw_out <= io_fcw_out_r @[dlf.scala 86:16]

