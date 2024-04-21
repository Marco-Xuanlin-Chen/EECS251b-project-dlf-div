module DigitalLoopFilter (
  input reset,
  input enable,
  input clock,

  input [5:0] TDC_out,

  input [11:0] Kp,
  input [11:0] Ki,
    
  output [4:0] DLF_out
);

  reg [11:0] out;
  reg [11:0] integrated;
  reg [11:0] preintegration;
  wire [11:0] postshift;

  assign DLF_out = out[11:7];
  assign postshift = {TDC_out, 6'b000000};

  always@(*) begin
      out = Kp * postshift + integrated;
      preintegration = Ki * postshift + integrated;
  end

  always @(posedge clock) begin
      if(!enable | reset) begin
          integrated <= 0;
      end else begin
          integrated <= preintegration;
      end
  end
endmodule
