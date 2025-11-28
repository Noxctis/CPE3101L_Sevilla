
module TopModule (
    input wire clk_in,       // 50 MHz clock
    input wire nReset,       // Active-low reset
    input wire load,         // Load enable
    input wire count_en,     // Count enable
    input wire up,           // Direction control
    input wire [3:0] data_in,// Parallel input
    output wire [3:0] count  // Counter output
);

    wire slow_clk; // Output of ClockDivider

    // Instantiate ClockDivider
    ClockDivider clk_div_inst (
        .clk_in(clk_in),
        .nReset(nReset),
        .clk_out(slow_clk)
    );

    // Instantiate FourbitUpDownCounter
    FourbitUpDownCounter counter_inst (
        .clk(slow_clk),       // Use divided clock
        .reset(nReset),       // Active-low reset
        .load(load),
        .count_en(count_en),
        .up(up),
        .data_in(data_in),
        .count(count)
    );

endmodule
