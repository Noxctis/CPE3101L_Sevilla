
//------------------------------------------------------------------------------
// OddUpDownCounterN.v
// Counts odd numbers up or down by 2.
// Clk: posedge, nReset: active-low asynchronous reset.
//------------------------------------------------------------------------------
module OddUpDownCounterN #(parameter integer N = 4) (
    input  wire         Clk,
    input  wire         nReset,   // active-low async reset
    input  wire         Enable,   // step enable
    input  wire         Up,       // 1 = up, 0 = down
    output reg  [N-1:0] Q
);
    localparam [N-1:0] TWO = {{(N-2){1'b0}}, 2'b10};

    always @(posedge Clk or negedge nReset) begin
        if (!nReset) begin
            Q <= {{(N-1){1'b0}}, 1'b1};   // start at 1 (odd)
        end else if (Enable) begin
            Q <= Up ? (Q + TWO) : (Q - TWO);  // stays odd
        end
    end

endmodule
