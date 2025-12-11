
`timescale 1ns/1ps

module tb_Problem1;

    reg  D_in;
    reg  CLK;
    reg  reset;
    wire P_even;   

    // --- Choose one UUT ---
    Problem1 UUT (
        .D_in (D_in),
        .CLK  (CLK),
        .reset(reset),
        .P_even(P_even)
    );

    // 10 ns period clock
    initial begin
        CLK = 1'b0;
        forever #5 CLK = ~CLK;
    end

    // Log
    initial begin
        $display("time  reset  D_in | P_out");
        $monitor("%4t    %b      %b   |  %b", $time, reset, D_in, P_even);
    end

    // Stimulus: show toggle-on-1, hold-on-0, and async reset
    initial begin
        // Optional VCD
        // $dumpfile("Problem1.vcd");
        // $dumpvars(0, tb_Problem1);

        reset = 1'b1; D_in = 1'b0; #12;   // assert async reset across edges
        reset = 1'b0;

        // Apply bitstream: 1,0,1,1,0
        @(posedge CLK); D_in = 1'b1;   // toggle
        @(posedge CLK); D_in = 1'b0;   // hold
        @(posedge CLK); D_in = 1'b1;   // toggle
        @(posedge CLK); D_in = 1'b1;   // toggle
        @(posedge CLK); D_in = 1'b0;   // hold

        // Async reset in-flight
        #3 reset = 1'b1;   // immediate clear (odd→0, even→1)
        #7 reset = 1'b0;

        // Resume a couple more samples
        @(posedge CLK); D_in = 1'b1;   // toggle
        @(posedge CLK); D_in = 1'b0;   // hold

        $stop;
    end

endmodule
