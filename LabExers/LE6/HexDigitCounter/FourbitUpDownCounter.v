// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for FourbitUpDownCounter

module FourbitUpDownCounter (
    input wire clk,           // Clock input
    input wire reset,         // Active-low reset
    input wire load,          // Parallel load enable
    input wire count_en,      // Count enable
    input wire up,            // Direction: 1 = up, 0 = down
    input wire [3:0] data_in, // Parallel data input
    output reg [3:0] count    // Counter output
);

    always @(posedge clk or negedge reset) begin
        if (!reset)
            count <= 4'b0000; // Reset to 0
        else if (load)
            count <= data_in; // Load parallel input
        else if (count_en) begin
            if (up)
                count <= count + 4'd1; // Count up
            else
                count <= count - 4'd1; // Count down
        end
        // else: no change
    end

endmodule
