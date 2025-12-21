// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for RaceLightsController

module Top (
    input  wire CLK50MHZ,   // board clock 50 MHz
    input  wire BTN_nRESET, // (active-low)
    input  wire SW_START,   // start switch (active-high)
    output wire RED,
    output wire YELLOW,
    output wire GREEN
);
    wire clk_1hz;

    // Divide 50MHz -> 1Hz
    ClockDivider #(.DIV_FACTOR(25_000_000)) u_div (
        .clk_in (CLK50MHZ),
        .nReset (BTN_nRESET),   // async reset
        .clk_out(clk_1hz)
    );

    // Race lights controller @ 1Hz, negative-edge sampling
    RaceLightsController u_ctrl (
        .CLOCK (clk_1hz),
        .nRESET(BTN_nRESET),    // async active-low
        .START (SW_START),
        .RED   (RED),
        .YELLOW(YELLOW),
        .GREEN (GREEN)
    );
endmodule
