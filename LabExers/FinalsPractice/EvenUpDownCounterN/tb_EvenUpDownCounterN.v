
//------------------------------------------------------------------------------
// tb_EvenUpDownCounterN.v
// Exercises: reset, one up step, hold, one down step, then stop.
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

module tb_EvenUpDownCounterN;

    // parameters
    localparam integer N = 4;

    // DUT I/O
    reg                Clk, Reset, Enable, Up;
    wire [N-1:0]       Q;

    // Instantiate DUT
    EvenUpDownCounterN #(.N(N)) UUT (
        .Clk   (Clk),
        .Reset (Reset),
        .Enable(Enable),
        .Up    (Up),
        .Q     (Q)
    );

    // 10 ns period clock
    initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
    end

    // Simple stimulus
    initial begin
        $display("time  Clk Rst En Up | Q");
        $monitor("%4t   %b   %b  %b  %b | %02h",
                 $time, Clk, Reset, Enable, Up, Q);

        // Start with async reset asserted
        Reset  = 1'b1; Enable = 1'b0; Up = 1'b1;
        @(posedge Clk);  // allow a clock edge under reset
        @(posedge Clk);
        Reset  = 1'b0;  // release reset → Q=0

        // One UP step (by 2)
        Enable = 1'b1; Up = 1'b1;
        @(posedge Clk); // Q: 0 -> 2
        Enable = 1'b0;  // hold
        @(posedge Clk);

        // One DOWN step (by 2)
        Enable = 1'b1; Up = 1'b0;
        @(posedge Clk); // Q: 2 -> 0
        Enable = 1'b0;
        @(posedge Clk);

        // A few more up steps to show even sequence
        Enable = 1'b1; Up = 1'b1;
        repeat (5) @(posedge Clk); // 0->2->4->6->8->10
        Enable = 1'b0;

        $stop;
    end

endmodule
