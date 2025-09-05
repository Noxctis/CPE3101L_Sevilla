// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for 2-to-4 Decoder (active-high enable)

module Dec2x4 (E, A, D);
  input        E;
  input  [1:0] A;     // A[1]=MSB, A[0]=LSB
  output [3:0] D;     // D[3:0]

  wire nA1, nA0;

  not N1 (nA1, A[1]);
  not N0 (nA0, A[0]);

  and G0 (D[0], E, nA1, nA0);
  and G1 (D[1], E, nA1, A[0]);
  and G2 (D[2], E, A[1], nA0);
  and G3 (D[3], E, A[1], A[0]);
endmodule