/*
File:           tb_Dec3x8.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for Dec3x8 (3-to-8 Decoder with active-high enable using two Dec2x4)
*/

`timescale 1 ns / 1 ps

module tb_TestDec3x8();

  // DUT I/O
  reg        E;
  reg  [2:0] A;   // A[2]=MSB, A[0]=LSB
  wire [7:0] D;   // D[7:0] = {D7..D0}

  // Instantiate Unit Under Test (UUT)
  TestDec3x8 UUT (.E(E), .A(A), .D(D));

  initial
  begin
    // Header using $display
    $display("Time(ns) |  E  |  A2 A1 A0 |   D7 D6 D5 D4 D3 D2 D1 D0");
    $display("---------------------------------------------------------");

    // ---- E = 0, all A combinations ----
    E = 1'b0; A = 3'b000; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b001; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b010; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b011; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b100; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b101; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b110; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b0; A = 3'b111; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9

    // ---- E = 1, all A combinations ----
    E = 1'b1; A = 3'b000; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b001; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b010; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b011; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b100; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b101; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b110; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #9
    E = 1'b1; A = 3'b111; #1 $display("%8t |  %b  |   %b  %b  %b  |   %b  %b  %b  %b  %b  %b  %b  %b", $time, E, A[2], A[1], A[0], D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]); #29

    // Stop simulation here
    $stop;

    // After stop: set up $monitor (will print if simulation is resumed)
    $monitor("Monitor -> t=%0t E=%b A=%b D=%b", $time, E, A, D);
  end

endmodule
