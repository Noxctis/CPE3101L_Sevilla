module Mux_2x1v2 (
    input wire A,          // Input A
    input wire B,          // Input B
    input wire S,        // Select line
    output reg X           // Output X
);
always @(*) begin
    case (S)
        1'b0: X = A; // If S is 0, output A
        1'b1: X = B; // If S is 1, output B
        default: X = 1'bx; // Default case to handle unexpected values
    endcase
end
endmodule