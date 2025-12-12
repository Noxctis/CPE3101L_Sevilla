module comparator8bit (
    input  wire        Clk,    // Clock
    input  wire        nReset,  // Asynchronous reset, active high
    input  wire [7:0]  A,      // 8-bit input A
    input  wire [7:0]  B,      // 8-bit input B
    output reg  [2:0]  R       // Result: R[2]=A>B, R[1]=A==B, R[0]=A<B
);

    // Sequential process: update comparison result on each clock edge
    always @(posedge Clk or negedge nReset) begin
        if (!nReset) begin
            // On reset, clear the result
            R <= 3'b000;
        end else begin
            // Behavioral comparison using if/else
            if (A > B)
                R <= 3'b100;   // A > B
            else if (A == B)
                R <= 3'b010;   // A == B
            else
                R <= 3'b001;   // A < B
        end
    end

endmodule