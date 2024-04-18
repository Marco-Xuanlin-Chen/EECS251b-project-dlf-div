`timescale 1ps/1fs

module FrequencyCounterTestBench;

reg reset;
reg io_clock1;
reg io_clock2;
reg io_en;
reg [3:0] io_offset;
wire signed [3:0] io_count_diff;
wire io_diff_valid;

integer f, i;

realtime time_now;

FrequencyCounter dut (
    .reset(reset),
    .io_clock1(io_clock1),
    .io_clock2(io_clock2),
    .io_en(io_en),
    .io_offset(io_offset),
    .io_count_diff(io_count_diff),
    .io_diff_valid(io_diff_valid)
);

initial begin
    $dumpfile("freq_counter_test.vcd");
    // $recordfile("freq_counter_test.trn");
    $dumpvars(3, FrequencyCounterTestBench);
    // $recordvars();
end

initial begin
    f = $fopen("freq_counter_test.csv", "w");
    $fwrite(f, "Time (s), io_clock_1, io_clock_2, io_en, io_offset, io_count_diff, io_diff_valid\n");
    #100
    reset = 1'b1;
    io_clock1 = 1'b0;
    io_clock2 = 1'b0;
    io_en = 1'b0;
    io_offset = 4'b0;
    // Run a few clock cycles to make sure everything is reset
    for (i=0; i<=4; i=i+1) begin
        #10
        io_clock1 = ~io_clock1;
        io_clock2 = ~io_clock2;
    end
    #100
    // Deassert reset and assert enable
    reset = 1'b0;
    io_en = 1'b1;
    #100
    // TEST 1: Clocks matched, offset 0
    $display("TEST 1: Clocks matched, offset 0");
    for (i=0; i<=11; i=i+1) begin
        #10
        io_clock1 = ~io_clock1;
        #(5)
        io_clock2 = ~io_clock2;
    end
    for (i=0; i<=11; i=i+1) begin
        #10
        io_clock2 = ~io_clock2;
        #(5)
        io_clock1 = ~io_clock1;
    end
    // TEST 2: Clock 2 double clock 1 frequency, offset 0
    $display("TEST 2: Clock 2 double clock 1 frequency, offset 0");
    for (i=0; i<=21; i=i+1) begin
        #2 io_clock2 = ~io_clock2;
        #5 io_clock2 = ~io_clock2;
        #3 io_clock1 = ~io_clock1;
    end
    // TEST 3: Clock 2 8x clock 1 frequency, offset 0
    $display("TEST 3: Clock 2 8x clock 1 frequency, offset 0");
    for (i=0; i<=21; i=i+1) begin
        #1.5 io_clock2 = ~io_clock2;
        #1.5 io_clock2 = ~io_clock2;
        #1.5 io_clock2 = ~io_clock2;
        #0.5 io_clock1 = ~io_clock1;
        #1 io_clock2 = ~io_clock2;
        #1.5 io_clock2 = ~io_clock2;
        #1.5 io_clock2 = ~io_clock2;
        #1.5 io_clock2 = ~io_clock2;
        #1.5 io_clock2 = ~io_clock2;
    end
    // TEST 4: Clock 2 double clock 1 frequency, offset 1
    $display("TEST 4: Clock 2 double clock 1 frequency, offset 1");
    io_offset = 4'b1;
    for (i=0; i<=21; i=i+1) begin
        #2 io_clock2 = ~io_clock2;
        #5 io_clock2 = ~io_clock2;
        #3 io_clock1 = ~io_clock1;
    end
    // TEST 5: Clock 1 8x clock 2 frequency, offset 0
    io_offset = 4'b0;
    $display("TEST 5: Clock 1 8x clock 2 frequency, offset 0");
    for (i=0; i<=21; i=i+1) begin
        #1.5 io_clock1 = ~io_clock1;
        #1.5 io_clock1 = ~io_clock1;
        #1.5 io_clock1 = ~io_clock1;
        #0.5 io_clock2 = ~io_clock2;
        #1 io_clock1 = ~io_clock1;
        #1.5 io_clock1 = ~io_clock1;
        #1.5 io_clock1 = ~io_clock1;
        #1.5 io_clock1 = ~io_clock1;
        #1.5 io_clock1 = ~io_clock1;
    end
    $finish;
    $fclose(f);
end

initial begin
    #100
    forever begin
        #1 $fwrite(f,"%t, %b, %b, %b, %b, %b, %b\n", $time, io_clock1, io_clock2, io_en, io_offset, io_count_diff, io_diff_valid);
    end
end

endmodule