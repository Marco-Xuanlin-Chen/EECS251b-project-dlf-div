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

module Mux2(
  input input1,
  input input2,
  output result,
  input choice
);
  reg out = 0;
  assign result = out;
  always@(*) begin
    if(choice==0) begin
      out = input1;
    end else begin
      out = input2;
    end
  end
endmodule

module MuxTree(
  input div0,
  input div2,
  input div4,
  input div8,
  input div16,
  input div32,
  input [2:0] sel,
  output result
);
  wire out01;
  wire out02;
  wire out03;
  wire out11;

  Mux2 mux01(.input1(div0), .input2(div2), .result(out01), .choice(sel[0]));
  Mux2 mux02(.input1(div4), .input2(div8), .result(out02), .choice(sel[0]));
  Mux2 mux03(.input1(div16), .input2(div32), .result(out03), .choice(sel[0]));
  Mux2 mux11(.input1(out01), .input2(out02), .result(out11), .choice(sel[1]));
  Mux2 mux21(.input1(out11), .input2(out03), .result(result), .choice(sel[2]));

endmodule

module ClockDivider(
  input        clock,
  output       io_div_clk_div,
  input  [2:0] io_sel_clk_div,
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
  MuxTree mux(
  .div0(clock),
  .div2(clk_div_map_0_io_div2_clk),
  .div4(clk_div_map_1_io_div2_clk),
  .div8(clk_div_map_2_io_div2_clk),
  .div16(clk_div_map_3_io_div2_clk),
  .div32(clk_div_map_4_io_div2_clk),
  .sel(io_sel_clk_div),
  .result(div_mux_tree_io_out_clk)
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
endmodule
