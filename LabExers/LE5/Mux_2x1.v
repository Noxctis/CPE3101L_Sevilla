module Mux_2x1 (
    input wire A,          // Input A
    input wire B,          // Input B
    input wire S,        // Select line
    output reg X           // Output X
);
always @(*) begin
    if (S == 1'b0) begin
        X = A; // If S is 0, output A
    end else begin
        X = B; // If S is 1, output B
    end
end
endmodule