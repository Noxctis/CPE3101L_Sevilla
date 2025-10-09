// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for n-Bit 4-to-1 Line Multiplexer

module nbit4x1Multiplexer #(parameter n = 4) (
    input  [n-1:0] A, B, C, D,     // 4 n-bit inputs
    input  [1:0]   S,              // 2-bit selector
    output [n-1:0] Y               // n-bit output
);

    assign Y = (S == 2'b00) ? A :
               (S == 2'b01) ? B :
               (S == 2'b10) ? C :
										D;

endmodule

