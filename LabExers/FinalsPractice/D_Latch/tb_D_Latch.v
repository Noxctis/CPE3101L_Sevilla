
//------------------------------------------------------------------------------
// tb_D_Latch.v — Testbench for Positive-level D Latch (async active-high reset)
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

module tb_D_Latch;

    // inputs as regs, outputs as wires
    reg  Clk, Reset, D;
    wire Q;

    // instantiate UUT
    D_Latch UUT (
        .Clk   (Clk),
        .Reset (Reset),
        .D     (D),
        .Q     (Q)
    );

    // clock: 10 ns period → toggles every 5 ns
    initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
    end

    // initial reset sequence
    initial begin
        Reset = 1'b1;  // start with reset asserted
        D     = 1'b0;
        #12;           // hold reset across a couple of clock transitions
        Reset = 1'b0;  // deassert reset
    end

    // stimulus: exercise transparency and hold
    initial begin
        $display("Time(ns)\tClk\tReset\tD\tQ");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, Clk, Reset, D, Q);

        // After reset deassertion:
        // While Clk=1 → latch transparent (Q follows D)
        // While Clk=0 → latch holds previous value

        // Wait until reset is low
        @(negedge Reset);

        // 1) Transparent phase: change D while Clk=1
        @(posedge Clk); D = 1;   // Q should go to 1 immediately (Clk=1)
        #3             D = 0;   // Q should follow to 0 (Clk still 1)
        #3             D = 1;   // Q follows to 1

        // 2) Hold phase: change D while Clk=0
        @(negedge Clk); D = 0;  // Q should HOLD previous value (1)
        #3             D = 1;   // still holds (Clk=0)

        // 3) Transparency again
        @(posedge Clk);         // Clk=1 → Q becomes D=1

        // 4) Async reset in the middle (independent of Clk)
        #2 Reset = 1;           // Q clears to 0 immediately
        #4 Reset = 0;           // release reset

        // 5) Final checks: transparent and hold one more time
        @(posedge Clk); D = 1;  // Q → 1 (transparent)
        @(negedge Clk); D = 0;  // Q holds at 1

        $stop;  // end simulation for lab capture
    end

endmodule
