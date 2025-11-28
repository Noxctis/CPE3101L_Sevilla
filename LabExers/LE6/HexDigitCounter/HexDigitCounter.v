// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for HexDigitCounter

module HexDigitCounter (
    input wire clk_in,       // 50 MHz FPGA clock
    input wire nReset,       // Active-low reset
    input wire load,         // Load enable for counter
    input wire count_en,     // Count enable
    input wire up,           // Direction: 1 = up, 0 = down
    input wire [3:0] data_in,// Parallel load data
    input wire dp,           // Decimal point control
    output wire [7:0] seg   // 7-segment output (active low)
);

    wire slow_clk;           // Output from clock divider
    wire [3:0] count;        // Output from counter

    // Instantiate Clock Divider
    ClockDivider #(.DIV_FACTOR(12_500_000)) clk_div (
        .clk_in(clk_in),
        .nReset(nReset),
        .clk_out(slow_clk)
    );

    // Instantiate 4-bit Up/Down Counter
    FourbitUpDownCounter counter (
        .clk(slow_clk),
        .reset(nReset),
        .load(load),
        .count_en(count_en),
        .up(up),
        .data_in(data_in),
        .count(count)
    );

    // Instantiate Hex-to-7-Segment Decoder
    HexTo7SegmentDecoder decoder (
        .hex(count),
        .dp(dp),
        .seg(seg)
    );

endmodule