/*
File:					tb_Problem2D.v
Author:				Chrys Sean T. Sevilla
Class:				CPE 3101L
Group/Schedule: 	Group 4 Fri 10:30 - 1:30 PM
Description:		Testbench file for Problem2D

*/

`timescale 1 ns/ 1 ps

module tb_Problem2D();

	reg	A, B, C, D;
	wire	F;
	
	Problem2D UUT (
	.A  (A),   
	.B  (B),
	.C  (C),
	.D  (D),      
	.F  (F)
	);
	
	initial
  begin
    // Header using $display
    $display("Time(ns) | A | B | C | D | F |");
    $display("--------------------------------");

		A = 0;	B = 0;	C = 0;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 0;	C = 0;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 0;	C = 1;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 0;	C = 1;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 1;	C = 0;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 1;	C = 0;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 1;	C = 1;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 0;	B = 1;	C = 1;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 0;	C = 0;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 0;	C = 0;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 0;	C = 1;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 0;	C = 1;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 1;	C = 0;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 1;	C = 0;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 1;	C = 1;	D = 0;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #9
		A = 1;	B = 1;	C = 1;	D = 1;	#1 $display("%8t | %b | %b | %b | %b | %b |", $time, A, B, C, D, F); #29

    // Stop simulation here
    $stop;

  end

endmodule
