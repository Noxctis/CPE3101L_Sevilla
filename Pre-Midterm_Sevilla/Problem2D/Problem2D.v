// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code Problem2D
//
module Problem2D (A, B, C, D, F);

	input		A, B, C, D;
	output	F;
	
	wire		w1,w2,w3;
	
	
	not		N1 (w1,D); //w1=Not D
	and		A1 (w2, C, w1); //w2 = C and notD
	and		A2 (w3, A, B, D);//w3 = A and B and D
	or			O1	(F,w2,w3);		// F = w2 or w3
	
endmodule
