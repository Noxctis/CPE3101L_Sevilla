/*
File:           tb_Dec2x4.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for Dec2x4 (2-to-4 Decoder with active-high enable)
*/

`timescale 1 ns / 1 ps

module tb_Dec2x4();

  // DUT I/O
  reg        E;
  reg  [1:0] A;   // A[1]=MSB, A[0]=LSB
  wire [3:0] D;   // D[3:0] = {D3, D2, D1, D0}

  // Instantiate Unit Under Test (UUT)
  Dec2x4 UUT (.E(E), .A(A), .D(D));

  initial
  begin
    // Header using $display
    $display("Time(ns) |  E  |  A  |   D    ");
    $display("--------------------------------");

    // ---- E = 0, all A combinations ----
    E = 1'b0; A = 2'b00; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9
    E = 1'b0; A = 2'b01; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9
    E = 1'b0; A = 2'b10; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9
    E = 1'b0; A = 2'b11; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9

    // ---- E = 1, all A combinations ----
    E = 1'b1; A = 2'b00; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9
    E = 1'b1; A = 2'b01; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9
    E = 1'b1; A = 2'b10; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #9
    E = 1'b1; A = 2'b11; #1 $display("%8t |  %b  | %b | %b", $time, E, A, D); #29

    // Stop simulation here
    $stop;

    // After stop: set up $monitor (will print if simulation is resumed)
    $monitor("Monitor -> t=%0t E=%b A=%b D=%b", $time, E, A, D);
  end

endmodule
