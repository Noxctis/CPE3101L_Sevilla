
// Positive-level D latch with active-high asynchronous reset
module D_Latch (
    input  wire Clk,     // level-sensitive enable (latch opens when Clk=1)
    input  wire Reset,   // async active-high reset
    input  wire D,       // data input
    output reg  Q        // latched output
);

    // Latch modeling: level-sensitive behavior
    // Sensitivity list includes signals that can change Q "immediately"
    always @(*) begin
        if (Reset) begin
            Q = 1'b0;             // async clear
        end else if (Clk) begin
            Q = D;                // transparent when Clk=1
        end
        // else: no assignment → Q retains previous value (latch behavior)
    end

endmodule
