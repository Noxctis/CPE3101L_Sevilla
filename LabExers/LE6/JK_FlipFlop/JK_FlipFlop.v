// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for JK_FlipFlop

module JK_FlipFlop (
    input wire clk,       // Clock (negative-edge triggered)
    input wire reset,     // Asynchronous active-high reset
    input wire J, K,      // JK inputs
    output reg Q,         // Output
    output wire Qnot      // Complement of Q
);

    // Assign Qnot as the inverse of Q
    assign Qnot = ~Q;

    always @(negedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0; // Reset output to 0
        else begin
            case ({J, K})
                2'b00: Q <= Q;         // No change
                2'b01: Q <= 1'b0;      // Reset
                2'b10: Q <= 1'b1;      // Set
                2'b11: Q <= ~Q;        // Toggle
            endcase
        end
    end

endmodule