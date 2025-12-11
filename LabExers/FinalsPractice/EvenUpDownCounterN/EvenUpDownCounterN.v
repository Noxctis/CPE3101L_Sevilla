
//------------------------------------------------------------------------------
// EvenUpDownCounterN.v
// Counts even numbers up or down (step size = 2).
//------------------------------------------------------------------------------
module EvenUpDownCounterN #(parameter integer N = 4) (
    input  wire         Clk,
    input  wire         Reset,     // async active-high
    input  wire         Enable,
    input  wire         Up,        // 1 = up, 0 = down
    output reg [N-1:0]  Q
);
    localparam [N-1:0] TWO = {{(N-2){1'b0}}, 2'b10}; // value 2 with width N

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            Q <= {N{1'b0}};         // start at 0 (even)
        end else if (Enable) begin
            Q <= Up ? (Q + TWO)     // up by 2
                    : (Q - TWO);    // down by 2 (wraps modulo 2^N)
        end
    end
endmodule
