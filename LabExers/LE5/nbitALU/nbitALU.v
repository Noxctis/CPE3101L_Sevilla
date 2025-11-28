// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for n

module nbitALU #(parameter n = 4) (
    input  [n-1:0] A, B,
    input  [2:0]   mode,
    input          carry_in,       // Added carry/borrow input
    output reg [n-1:0] Y,
    output reg       carry_out
);

    always @(*) begin
        carry_out = 0; // Default

        case (mode)
            3'b000: {carry_out, Y} = A + B + carry_in;       // Addition with carry
            3'b001: {carry_out, Y} = A - B - carry_in;       // Subtraction with borrow
            3'b010: Y = A & B;                               // Bitwise AND
            3'b011: Y = A | B;                               // Bitwise OR
            3'b100: Y = A ^ B;                               // Bitwise XOR
            3'b101: Y = ~A;                                  // Complement of A
            3'b110: {carry_out, Y} = {1'b0, A} + 5'd1;       // Increment A
            3'b111: {carry_out, Y} = {1'b0, A} - 5'd1;       // Decrement A
            default: Y = {n{1'b0}};
        endcase
    end

endmodule
