// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for a half adder circuit
//
module HalfAdder (x, y, C, S);

	input		x, y;
	output	C, S;
	
	xor		X1 (S, x, y);
	and		A1 (C, x, y);
	
endmodule
