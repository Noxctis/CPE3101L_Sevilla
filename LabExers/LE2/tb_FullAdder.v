/*
File:					tb_FullAdder.v
Author:				Chrys Sean T. Sevilla
Class:				CPE 3101L
Group/Schedule: 	Group 4 Fri 10:30 - 1:30 PM
Description:		Testbench file for FullAdder.v

*/

`timescale 1 ns/ 1 ps

module tb_FullAdder();

	reg	A, B, C_in;
	wire	S, C_out;
	
	FullAdder UUT (.A(A),.B(B),.C_in(Cin),.S(FaS),.C_out(FaC));
	
	initial
	begin
		A = 0;	B = 0;	C_in = 0;	#10
		A = 0;	B = 0;	C_in = 1;	#10
		A = 0;	B = 1;	C_in = 0;	#10
		A = 0;	B = 1;	C_in = 1;	#10
		A = 1;	B = 0;	C_in = 0;	#10
		A = 1;	B = 0;	C_in = 1;	#10
		A = 1;	B = 1;	C_in = 0;	#10
		A = 1;	B = 1;	C_in = 1;	#30
		
		$stop;
	end
	
endmodule
