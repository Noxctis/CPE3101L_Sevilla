
//------------------------------------------------------------------------------
// Problem1.v
// Running odd-parity sequential circuit
// Diagram: D_in -> XOR with Q -> D of DFF; Q is exported as P_odd.
// CLK: positive-edge triggered; reset: asynchronous, active-high.
// Author: Chrys Sean T. Sevilla (Group 4, CPE 3101L, 10:30AM - 1:30PM)
//------------------------------------------------------------------------------
module Problem1 (
    input  wire D_in,    // serial data input
    input  wire CLK,     // posedge clock
    input  wire reset,   // asynchronous active-high reset
    output wire P_odd    // output: running odd parity
);

    // Internal state register (the D flip-flop’s Q)
    reg Q;

    // Async active-high reset and posedge clock behavior
    always @(posedge CLK or posedge reset) begin
        if (reset) begin
            // Reset to known state: even parity baseline
            Q <= 1'b0;
        end else begin
            // Next-state logic from diagram:
            // D <= D_in XOR Q (toggle parity when incoming bit is 1)
            Q <= D_in ^ Q;
        end
    end

    // Output mapping: diagram labels Q as P_odd
    assign P_odd = Q;

endmodule
