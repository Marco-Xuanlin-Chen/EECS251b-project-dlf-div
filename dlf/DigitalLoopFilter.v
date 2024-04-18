module IntegralPath(
  input         clock,
  input         io_rst,
  input  [7:0]  io_dlf_ic,
  input  [14:0] io_dlf_i,
  input  [3:0]  io_ki,
  output [14:0] io_dlf_i_out
);
  wire [11:0] _dlf_i_temp_T = $signed(io_ki) * $signed(io_dlf_ic); // @[dlf.scala 19:28]
  wire [14:0] _GEN_1 = {{3{_dlf_i_temp_T[11]}},_dlf_i_temp_T}; // @[dlf.scala 19:40]
  wire [14:0] dlf_i_temp = $signed(_GEN_1) + $signed(io_dlf_i); // @[dlf.scala 19:40]
  wire  _io_dlf_i_out_T_1 = ~io_rst; // @[dlf.scala 21:31]
  wire [14:0] _io_dlf_i_out_T_4 = {1'h0,dlf_i_temp[13:0]}; // @[dlf.scala 21:85]
  wire [29:0] _io_dlf_i_out_T_5 = {$signed(dlf_i_temp), 15'h0}; // @[dlf.scala 21:104]
  reg [29:0] io_dlf_i_out_r; // @[Reg.scala 35:20]
  wire [29:0] _GEN_0 = {{15{_io_dlf_i_out_T_4[14]}},_io_dlf_i_out_T_4}; // @[Reg.scala 36:18 35:20 36:22]
  assign io_dlf_i_out = io_dlf_i_out_r[14:0]; // @[dlf.scala 21:18]
  always @(posedge clock) begin
    if (_io_dlf_i_out_T_1) begin // @[Reg.scala 35:20]
      io_dlf_i_out_r <= _io_dlf_i_out_T_5; // @[Reg.scala 35:20]
    end else begin
      io_dlf_i_out_r <= _GEN_0;
    end
  end
endmodule
module ProportionalPath(
  input  [14:0] io_dlf_i_out,
  input  [3:0]  io_kp,
  output [14:0] io_dlf_out
);
  wire [18:0] mag = $signed(io_kp) * $signed(io_dlf_i_out); // @[dlf.scala 31:21]
  wire [33:0] _io_dlf_out_T = {$signed(mag), 15'h0}; // @[dlf.scala 32:23]
  assign io_dlf_out = _io_dlf_out_T[14:0]; // @[dlf.scala 32:16]
endmodule
module DigitalLoopFilter(
  input        clock,
  input        reset,
  input        io_rst,
  input  [7:0] io_dlf_ic,
  input  [3:0] io_dlf_kp,
  input  [3:0] io_dlf_ki,
  output [7:0] io_fcw_out
);
  wire  i_path_clock; // @[dlf.scala 55:24]
  wire  i_path_io_rst; // @[dlf.scala 55:24]
  wire [7:0] i_path_io_dlf_ic; // @[dlf.scala 55:24]
  wire [14:0] i_path_io_dlf_i; // @[dlf.scala 55:24]
  wire [3:0] i_path_io_ki; // @[dlf.scala 55:24]
  wire [14:0] i_path_io_dlf_i_out; // @[dlf.scala 55:24]
  wire [14:0] p_path_io_dlf_i_out; // @[dlf.scala 56:24]
  wire [3:0] p_path_io_kp; // @[dlf.scala 56:24]
  wire [14:0] p_path_io_dlf_out; // @[dlf.scala 56:24]
  wire [7:0] _T_1 = p_path_io_dlf_out[14:7]; // @[dlf.scala 78:49]
  wire [7:0] _GEN_0 = $signed(_T_1) <= 8'sh0 ? $signed(8'sh0) : $signed(_T_1); // @[dlf.scala 80:76 81:18 83:18]
  wire [8:0] _GEN_1 = {{1{_GEN_0[7]}},_GEN_0}; // @[dlf.scala 78:69 79:18]
  wire  _io_fcw_out_T = ~io_rst; // @[dlf.scala 86:37]
  reg [14:0] io_fcw_out_r; // @[Reg.scala 35:20]
  wire [7:0] fcw_next = _GEN_1[7:0]; // @[dlf.scala 74:24]
  wire [14:0] _GEN_2 = {{7{fcw_next[7]}},fcw_next}; // @[Reg.scala 36:18 35:20 36:22]
  IntegralPath i_path ( // @[dlf.scala 55:24]
    .clock(i_path_clock),
    .io_rst(i_path_io_rst),
    .io_dlf_ic(i_path_io_dlf_ic),
    .io_dlf_i(i_path_io_dlf_i),
    .io_ki(i_path_io_ki),
    .io_dlf_i_out(i_path_io_dlf_i_out)
  );
  ProportionalPath p_path ( // @[dlf.scala 56:24]
    .io_dlf_i_out(p_path_io_dlf_i_out),
    .io_kp(p_path_io_kp),
    .io_dlf_out(p_path_io_dlf_out)
  );
  assign io_fcw_out = io_fcw_out_r[7:0]; // @[dlf.scala 86:16]
  assign i_path_clock = clock;
  assign i_path_io_rst = io_rst; // @[dlf.scala 60:19]
  assign i_path_io_dlf_ic = io_dlf_ic; // @[dlf.scala 64:22]
  assign i_path_io_dlf_i = i_path_io_dlf_i_out; // @[dlf.scala 65:21]
  assign i_path_io_ki = io_dlf_ki; // @[dlf.scala 66:31]
  assign p_path_io_dlf_i_out = i_path_io_dlf_i_out; // @[dlf.scala 70:25]
  assign p_path_io_kp = io_dlf_kp; // @[dlf.scala 71:31]
  always @(posedge clock) begin
    if (_io_fcw_out_T) begin // @[Reg.scala 35:20]
      io_fcw_out_r <= p_path_io_dlf_out; // @[Reg.scala 35:20]
    end else begin
      io_fcw_out_r <= _GEN_2;
    end
  end
endmodule