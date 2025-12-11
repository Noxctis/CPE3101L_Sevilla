
//------------------------------------------------------------------------------
// tb_Problem2.v
// Testbench for 6-bit Universal Shift Register (Problem2)
// Exercises one clock cycle per operation across the control table.
//------------------------------------------------------------------------------
`timescale 1ns/1ps

module tb_Problem2;

    reg        Clk;
    reg        reset;
    reg  [2:0] A;
    reg  [5:0] D;
    reg        RSI;
    reg        LSI;
    wire [5:0] Q;

    // Instantiate UUT
    Problem2 UUT (
        .Clk  (Clk),
        .reset(reset),
        .A    (A),
        .D    (D),
        .RSI  (RSI),
        .LSI  (LSI),
        .Q    (Q)
    );

    // 10 ns period clock (100 MHz)
    initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
    end

    // Readable monitor
    initial begin
        $display("time  rst  A    D     RSI LSI | Q");
        $monitor("%4t  %b   %03b  %06b  %b   %b  | %06b",
                 $time, reset, A, D, RSI, LSI, Q);
    end

    // Stimulus: one posedge per operation
    initial begin
        // Optional wave dump (enable if supported)
        // $dumpfile("Problem2.vcd");
        // $dumpvars(0, tb_Problem2);

        // Assert async reset across a couple of edges
        reset = 1'b1; A = 3'b000; D = 6'b000000; RSI = 1'b0; LSI = 1'b0;
        @(posedge Clk);
        @(posedge Clk);
        reset = 1'b0;

        // 111: Load (parallel)
        D = 6'b101010; A = 3'b111; @(posedge Clk); // Q = 101010

        // 000: Hold
        A = 3'b000; @(posedge Clk);

        // 001: Shift Left (LSB <= RSI)
        RSI = 1'b1; A = 3'b001; @(posedge Clk);    // Q << 1, LSB=1
        RSI = 1'b0; A = 3'b001; @(posedge Clk);    // Q << 1, LSB=0

        // 010: Shift Right (MSB <= LSI)
        LSI = 1'b1; A = 3'b010; @(posedge Clk);    // Q >> 1, MSB=1
        LSI = 1'b0; A = 3'b010; @(posedge Clk);    // Q >> 1, MSB=0

        // 011: Synchronous Clear
        A = 3'b011; @(posedge Clk);                // Q = 000000

        // 100: Synchronous Preset
        A = 3'b100; @(posedge Clk);                // Q = 111111

        // 101: Count Up (one cycle)
        A = 3'b101; @(posedge Clk);

        // 110: Count Down (one cycle)
        A = 3'b110; @(posedge Clk);

        // 000: Hold (final)
        A = 3'b000; @(posedge Clk);

        // Stop for lab capture
        $stop;
    end

endmodule
