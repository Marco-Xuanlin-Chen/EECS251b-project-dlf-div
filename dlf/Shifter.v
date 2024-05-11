module shifter (
  input reset,
  input enable,
  input [2:0] shifter,
  input [11:0] dlf_out,

  output [4:0] VCO_val
);

  reg [4:0] shifted;
  assign VCO_val = shifted;
  always@(*) begin
    if (reset| !enable) begin
      shifted = 0;
    end else if (shifter == 1) begin
      shifted = dlf_out[5:1];
    end else if (shifter == 2) begin
      shifted = dlf_out[6:2];
    end else if (shifter == 3) begin
      shifted = dlf_out[7:3];
    end else if (shifter == 4) begin
      shifted = dlf_out[8:4];
    end else if (shifter == 5) begin
      shifted = dlf_out[9:5];
    end else if (shifter == 6) begin
      shifted = dlf_out[10:6];
    end else if (shifter == 7) begin
      shifted = dlf_out[11:7];
    end else begin
      shifted = dlf_out[4:0];
    end
  end
endmodule
