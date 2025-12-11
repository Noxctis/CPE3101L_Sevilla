
//------------------------------------------------------------------------------
// tb_Problem1.v
// Testbench for Problem1 (running odd-parity sequential circuit)
//------------------------------------------------------------------------------
`timescale 1ns/1ps

module tb_Problem1;

    reg  D_in;
    reg  CLK;
    reg  reset;
    wire P_odd;

    // Instantiate Unit Under Test (UUT)
    Problem1 UUT (
        .D_in (D_in),
        .CLK  (CLK),
        .reset(reset),
        .P_odd(P_odd)
    );

    // 10 ns period clock (100 MHz)
    initial begin
        CLK = 1'b0;
        forever #5 CLK = ~CLK;
    end

    // Stimulus
    initial begin
        // Wave dump (optional; enable if your simulator supports VCD)
        // $dumpfile("Problem1.vcd");
        // $dumpvars(0, tb_Problem1);

        $display("time  reset D_in | P_odd");
        $monitor("%4t    %b     %b   |   %b", $time, reset, D_in, P_odd);

        // Initialize
        reset = 1'b1;  // assert async reset
        D_in  = 1'b0;
        #12;           // hold reset across a couple of rising edges

        reset = 1'b0;  // de-assert reset

        // Apply a bitstream with parity commentary:
        // Stream: 1,0,1,1,0  → running odd parity should be: 1,1,0,1,1

        @(posedge CLK); D_in = 1'b1;  // toggle parity: 0->1
        @(posedge CLK); D_in = 1'b0;  // hold parity: 1->1
        @(posedge CLK); D_in = 1'b1;  // toggle parity: 1->0
        @(posedge CLK); D_in = 1'b1;  // toggle parity: 0->1
        @(posedge CLK); D_in = 1'b0;  // hold parity: 1->1

        // Check asynchronous reset in-flight (between clocks)
        #3 reset = 1'b1;              // immediate clear to 0
        #7 reset = 1'b0;

        // Resume a couple more bits
        @(posedge CLK); D_in = 1'b1;  // toggle: 0->1
        @(posedge CLK); D_in = 1'b0;  // hold: 1->1

        // Stop simulation for lab report capture
        $stop;
    end

endmodule
