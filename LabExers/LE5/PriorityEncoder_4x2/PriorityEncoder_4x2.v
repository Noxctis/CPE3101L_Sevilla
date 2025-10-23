module PriorityEncoder_4x2 (
    input wire [3:0] D,      // 4-bit input
    output reg [1:0] Y,      // 2-bit output
    output reg       V    // Valid output
);

always @(*) begin
    casez (D)
        4'b1???: begin
            Y = 2'b11; // Highest priority
            V = 1'b1;
        end
        4'b01??: begin
            Y = 2'b10;
            V = 1'b1;
        end
        4'b001?: begin
            Y = 2'b01;
            V = 1'b1;
        end
        4'b0001: begin
            Y = 2'b00; // Lowest priority
            V = 1'b1;
        end
        default: begin
            Y = 2'bxx; // Default output when no inputs are high
            V = 1'b0;  // No valid input
        end
    endcase
end

endmodule