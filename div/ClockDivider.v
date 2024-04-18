module DivLatch2(
  input   io_rst,
  input   io_input_clock,
  output  io_div2_clk,
  input   io_en
);
  wire  _io_div2_clk_T = ~io_rst; // @[div.scala 59:60]
  wire  _io_div2_clk_T_3 = ~io_div2_clk; // @[div.scala 60:19]
  reg  io_div2_clk_r; // @[Reg.scala 35:20]
  assign io_div2_clk = io_div2_clk_r; // @[div.scala 61:7]
  always @(posedge io_input_clock or posedge _io_div2_clk_T) begin
    if (_io_div2_clk_T) begin // @[Reg.scala 36:18]
      io_div2_clk_r <= 1'h0; // @[Reg.scala 36:22]
    end else if (io_en) begin // @[Reg.scala 35:20]
      io_div2_clk_r <= _io_div2_clk_T_3;
    end
  end
endmodule
module ClockMux(
  input   io_clocksIn_1,
  output  io_clockOut
);
  assign io_clockOut = io_clocksIn_1; // @[div.scala 35:17]
endmodule
module ClockMuxTree(
  input   io_in_clks_1,
  input   io_in_clks_4,
  output  io_out_clk
);
  wire  io_out_clk_mux_io_clocksIn_1; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clockOut; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_0_mux_io_clocksIn_1; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_0_mux_io_clockOut; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_1_mux_io_clockOut; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clockOut; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_clocksIn_1; // @[div.scala 84:21]
  wire  io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_clockOut; // @[div.scala 84:21]
  ClockMux io_out_clk_mux ( // @[div.scala 84:21]
    .io_clocksIn_1(io_out_clk_mux_io_clocksIn_1),
    .io_clockOut(io_out_clk_mux_io_clockOut)
  );
  ClockMux io_out_clk_mux_io_clocksIn_0_mux ( // @[div.scala 84:21]
    .io_clocksIn_1(io_out_clk_mux_io_clocksIn_0_mux_io_clocksIn_1),
    .io_clockOut(io_out_clk_mux_io_clocksIn_0_mux_io_clockOut)
  );
  ClockMux io_out_clk_mux_io_clocksIn_1_mux ( // @[div.scala 84:21]
    .io_clocksIn_1(io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1),
    .io_clockOut(io_out_clk_mux_io_clocksIn_1_mux_io_clockOut)
  );
  ClockMux io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux ( // @[div.scala 84:21]
    .io_clocksIn_1(io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1),
    .io_clockOut(io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clockOut)
  );
  ClockMux io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux ( // @[div.scala 84:21]
    .io_clocksIn_1(io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_clocksIn_1),
    .io_clockOut(io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_clockOut)
  );
  assign io_out_clk = io_out_clk_mux_io_clockOut; // @[div.scala 101:14]
  assign io_out_clk_mux_io_clocksIn_1 = io_out_clk_mux_io_clocksIn_1_mux_io_clockOut; // @[div.scala 96:26]
  assign io_out_clk_mux_io_clocksIn_0_mux_io_clocksIn_1 = io_in_clks_1; // @[div.scala 87:73]
  assign io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1 = io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_clockOut
    ; // @[div.scala 96:26]
  assign io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_0_mux_io_clocksIn_1 = 1'h0; // @[div.scala 89:48]
  assign io_out_clk_mux_io_clocksIn_1_mux_io_clocksIn_1_mux_io_clocksIn_1 = io_in_clks_4; // @[div.scala 87:73]
endmodule
module ClockDivider(
  input        clock,
  output       io_div_clk_div,
  input  [4:0] io_sel_clk_div,
  input        io_rst,
  input        io_en
);
  wire  clk_div_map_0_io_rst; // @[div.scala 117:62]
  wire  clk_div_map_0_io_input_clock; // @[div.scala 117:62]
  wire  clk_div_map_0_io_div2_clk; // @[div.scala 117:62]
  wire  clk_div_map_0_io_en; // @[div.scala 117:62]
  wire  clk_div_map_1_io_rst; // @[div.scala 117:62]
  wire  clk_div_map_1_io_input_clock; // @[div.scala 117:62]
  wire  clk_div_map_1_io_div2_clk; // @[div.scala 117:62]
  wire  clk_div_map_1_io_en; // @[div.scala 117:62]
  wire  clk_div_map_2_io_rst; // @[div.scala 117:62]
  wire  clk_div_map_2_io_input_clock; // @[div.scala 117:62]
  wire  clk_div_map_2_io_div2_clk; // @[div.scala 117:62]
  wire  clk_div_map_2_io_en; // @[div.scala 117:62]
  wire  clk_div_map_3_io_rst; // @[div.scala 117:62]
  wire  clk_div_map_3_io_input_clock; // @[div.scala 117:62]
  wire  clk_div_map_3_io_div2_clk; // @[div.scala 117:62]
  wire  clk_div_map_3_io_en; // @[div.scala 117:62]
  wire  clk_div_map_4_io_rst; // @[div.scala 117:62]
  wire  clk_div_map_4_io_input_clock; // @[div.scala 117:62]
  wire  clk_div_map_4_io_div2_clk; // @[div.scala 117:62]
  wire  clk_div_map_4_io_en; // @[div.scala 117:62]
  wire  div_mux_tree_io_in_clks_1; // @[div.scala 134:30]
  wire  div_mux_tree_io_in_clks_4; // @[div.scala 134:30]
  wire  div_mux_tree_io_out_clk; // @[div.scala 134:30]
  DivLatch2 clk_div_map_0 ( // @[div.scala 117:62]
    .io_rst(clk_div_map_0_io_rst),
    .io_input_clock(clk_div_map_0_io_input_clock),
    .io_div2_clk(clk_div_map_0_io_div2_clk),
    .io_en(clk_div_map_0_io_en)
  );
  DivLatch2 clk_div_map_1 ( // @[div.scala 117:62]
    .io_rst(clk_div_map_1_io_rst),
    .io_input_clock(clk_div_map_1_io_input_clock),
    .io_div2_clk(clk_div_map_1_io_div2_clk),
    .io_en(clk_div_map_1_io_en)
  );
  DivLatch2 clk_div_map_2 ( // @[div.scala 117:62]
    .io_rst(clk_div_map_2_io_rst),
    .io_input_clock(clk_div_map_2_io_input_clock),
    .io_div2_clk(clk_div_map_2_io_div2_clk),
    .io_en(clk_div_map_2_io_en)
  );
  DivLatch2 clk_div_map_3 ( // @[div.scala 117:62]
    .io_rst(clk_div_map_3_io_rst),
    .io_input_clock(clk_div_map_3_io_input_clock),
    .io_div2_clk(clk_div_map_3_io_div2_clk),
    .io_en(clk_div_map_3_io_en)
  );
  DivLatch2 clk_div_map_4 ( // @[div.scala 117:62]
    .io_rst(clk_div_map_4_io_rst),
    .io_input_clock(clk_div_map_4_io_input_clock),
    .io_div2_clk(clk_div_map_4_io_div2_clk),
    .io_en(clk_div_map_4_io_en)
  );
  ClockMuxTree div_mux_tree ( // @[div.scala 134:30]
    .io_in_clks_1(div_mux_tree_io_in_clks_1),
    .io_in_clks_4(div_mux_tree_io_in_clks_4),
    .io_out_clk(div_mux_tree_io_out_clk)
  );
  assign io_div_clk_div = div_mux_tree_io_out_clk; // @[div.scala 137:20]
  assign clk_div_map_0_io_rst = io_rst; // @[div.scala 124:34]
  assign clk_div_map_0_io_input_clock = clock; // @[div.scala 128:26]
  assign clk_div_map_0_io_en = io_en; // @[div.scala 123:33]
  assign clk_div_map_1_io_rst = io_rst; // @[div.scala 124:34]
  assign clk_div_map_1_io_input_clock = clk_div_map_0_io_div2_clk; // @[div.scala 128:26]
  assign clk_div_map_1_io_en = io_en; // @[div.scala 123:33]
  assign clk_div_map_2_io_rst = io_rst; // @[div.scala 124:34]
  assign clk_div_map_2_io_input_clock = clk_div_map_1_io_div2_clk; // @[div.scala 128:26]
  assign clk_div_map_2_io_en = io_en; // @[div.scala 123:33]
  assign clk_div_map_3_io_rst = io_rst; // @[div.scala 124:34]
  assign clk_div_map_3_io_input_clock = clk_div_map_2_io_div2_clk; // @[div.scala 128:26]
  assign clk_div_map_3_io_en = io_en; // @[div.scala 123:33]
  assign clk_div_map_4_io_rst = io_rst; // @[div.scala 124:34]
  assign clk_div_map_4_io_input_clock = clk_div_map_3_io_div2_clk; // @[div.scala 128:26]
  assign clk_div_map_4_io_en = io_en; // @[div.scala 123:33]
  assign div_mux_tree_io_in_clks_1 = clk_div_map_1_io_div2_clk; // @[div.scala 115:28 120:47]
  assign div_mux_tree_io_in_clks_4 = clk_div_map_4_io_div2_clk; // @[div.scala 115:28 126:23]
endmodule
