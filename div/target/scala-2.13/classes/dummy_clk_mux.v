module ClockMux2(
    input wire sel_clk,
    input wire [1:0] in_clks,
    output wire out_clk
)
    assign out_clk = sel_clk ? (in_clks[1]) : (in_clks[0]);
endmodule