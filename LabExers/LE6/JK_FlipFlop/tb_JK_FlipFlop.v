/*
File:           tb_JK_FlipFlop.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for JK_FlipFlop (with Qnot)
*/
module tb_JK_FlipFlop;

    reg clk, reset, J, K;
    wire Q, Qnot;

    // Instantiate Unit Under Test (UUT)
    JK_FlipFlop UUT (
        .clk(clk),
        .reset(reset),
        .J(J),
        .K(K),
        .Q(Q),
        .Qnot(Qnot)
    );

    // Clock generation: 10 time units period
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle every 5 units → 10 units period
    end

    initial begin
        $display("Time\tReset\tJ\tK\tQ\tQnot");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, reset, J, K, Q, Qnot);

        // Initial reset
        reset = 1; J = 0; K = 0; #10;
        reset = 0;

        // Test all JK combinations
        J = 0; K = 0; #10; // No change
        J = 0; K = 1; #10; // Reset
        J = 1; K = 0; #10; // Set
        J = 1; K = 1; #10; // Toggle
        J = 0; K = 0; #10; // No change
        J = 1; K = 1; #10; // Toggle
        J = 0; K = 1; #10; // Reset

        $stop;
    end

endmodule
