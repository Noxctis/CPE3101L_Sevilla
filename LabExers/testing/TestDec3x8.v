// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for 3-to-8 Decoder (active-high enable)
// Structural design using two 2x4 Decoders

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

module TestDec3x8 (E, A, D);
  input        E;
  input  [2:0] A;       // A[2]=MSB, A[0]=LSB
  output [7:0] D;       // D[7:0] = {D7..D0}

  wire en_lo, en_hi;    // enables for the two 2x4 decoders
  wire [3:0] d_lo, d_hi;
  wire nA2;             // wire for inverted A[2]

  // NOT gate for A[2]
  not (nA2, A[2]);

  // AND gates for the enable logic
  and (en_lo, E, nA2);  // en_lo = E & ~A[2]
  and (en_hi, E, A[2]);  // en_hi = E & A[2]

  // Instantiate two Dec2x4 blocks
  Dec2x4 DEC_LO (.E(en_lo), .A(A[1:0]), .D(d_lo)); // lower half
  Dec2x4 DEC_HI (.E(en_hi), .A(A[1:0]), .D(d_hi)); // upper half

  // Concatenate outputs
  assign D = {d_hi, d_lo};
endmodule
