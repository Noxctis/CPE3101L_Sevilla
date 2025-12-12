
//------------------------------------------------------------------------------
// ComparatorN.v
// Parameterized magnitude comparator.
// Set N=8 for 8-bit; change N for other widths.
//------------------------------------------------------------------------------
module ComparatorN #(parameter integer N = 8) (
    input  wire [N-1:0] A,
    input  wire [N-1:0] B,
    output wire         G,  // A > B
    output wire         E,  // A == B
    output wire         L   // A < B
);
    assign G = (A >  B);
    assign E = (A == B);
    assign L = (A <  B);
endmodule
