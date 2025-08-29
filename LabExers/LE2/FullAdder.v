// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for Half Adder and Full Adder

module HalfAdder (x, y, C, S);
  input  x, y;
  output C, S;

  xor X1 (S, x, y);
  and A1 (C, x, y);
endmodule

module FullAdder (Cin, A, B, FaS, FaC);
  input  Cin, A, B;
  output FaS, FaC;
  wire   C1, S1, C2;

  // First half adder: adds A and B
  HalfAdder HA1 (A, B, C1, S1);

  // Second half adder: adds S1 and Cin
  HalfAdder HA2 (S1, Cin, C2, FaS);

  // Final carry output
  or O1 (FaC, C1, C2);
endmodule
