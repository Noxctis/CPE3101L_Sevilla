
`timescale 1ns/1ps
module tb_OddUpDownCounterN;

    localparam integer N = 4;

    reg              Clk, nReset, Enable, Up;
    wire [N-1:0]     Q;

    // DUT
    OddUpDownCounterN #(.N(N)) UUT (
        .Clk   (Clk),
        .nReset(nReset),
        .Enable(Enable),
        .Up    (Up),
        .Q     (Q)
    );

    // 10 ns period clock
    initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
    end

    initial begin
        $display("time  Clk nRst En Up | Q");
        $monitor("%4t   %b   %b   %b  %b | %02h", $time, Clk, nReset, Enable, Up, Q);

        // Active-low async reset across a couple edges
        nReset = 1'b0; Enable = 1'b0; Up = 1'b1;
        @(posedge Clk);
        @(posedge Clk);
        nReset = 1'b1;                   // release → Q = 1

        // One UP step: 1 -> 3
        Enable = 1'b1; Up = 1'b1; @(posedge Clk);
        Enable = 1'b0; @(posedge Clk);   // hold

        // One DOWN step: 3 -> 1
        Enable = 1'b1; Up = 1'b0; @(posedge Clk);
        Enable = 1'b0; @(posedge Clk);   // hold

        // A few more UP steps: 1,3,5,7,9...
        Enable = 1'b1; Up = 1'b1; repeat (4) @(posedge Clk);
        Enable = 1'b0;

        $stop;
    end

endmodule
