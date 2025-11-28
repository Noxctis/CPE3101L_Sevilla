
//------------------------------------------------------------------------------
// ClockDivider.v
// Divide 50 MHz down to a low rate (e.g., 1 Hz).
// Async active-low reset.
//------------------------------------------------------------------------------
module ClockDivider #(
    parameter integer DIV_FACTOR = 25_000_000  // 50MHz -> 1Hz
) (
    input  wire clk_in,     // 50 MHz input clock
    input  wire nReset,     // async active-low reset
    output reg  clk_out     // divided clock
);
    // Width big enough for DIV_FACTOR-1
    localparam integer CNTW = $clog2(DIV_FACTOR);
    reg [CNTW-1:0] counter;

    always @(posedge clk_in or negedge nReset) begin
        if (!nReset) begin
            counter <= {CNTW{1'b0}};
            clk_out <= 1'b0;
        end else begin
            if (counter == DIV_FACTOR - 1) begin
                counter <= {CNTW{1'b0}};
                clk_out <= ~clk_out; // toggle every DIV_FACTOR ticks
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end
endmodule
