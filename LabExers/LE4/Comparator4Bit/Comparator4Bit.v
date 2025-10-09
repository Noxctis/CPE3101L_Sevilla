// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for 4 bit Comparator (active-high enable)

module Comparator4Bit (
    input  [3:0] A, // 4-bit input A
    input  [3:0] B, // 4-bit input B
    output [2:0] R  // Output: R[2] = G, R[1] = E, R[0] = L
);

    assign R[2] = (A > B) 	? 1'b1 : 1'b0;  // G: A > B
    assign R[1] = (A == B) ? 1'b1 : 1'b0;  // E: A == B
    assign R[0] = (A < B) 	? 1'b1 : 1'b0;  // L: A < B

endmodule
