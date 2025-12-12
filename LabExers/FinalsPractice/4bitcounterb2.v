
//------------------------------------------------------------------------------
// SetB_EvenUpDownCounter.v — strict evens, wrap-around at ends
// - c = 0 : +2 (14 wraps to 0)
// - c = 1 : -2 (0 wraps to 14)
// - c = 3 : HOLD
// Active-low asynchronous reset; parallel load; count enable.
//------------------------------------------------------------------------------
module SetB_EvenUpDownCounter (
    input  wire       clk,        // posedge clock
    input  wire       reset,      // active-low async reset
    input  wire       load,       // parallel load enable
    input  wire       count_en,   // count enable
    input  wire [1:0] c,          // control: 0=+2, 1=-2, 3=hold (2=hold)
    input  wire [3:0] data_in,    // parallel data (any 4-bit value)
    output reg  [3:0] count       // current count
);

    // Endpoints for even sequence
    localparam [3:0] MIN_EVEN = 4'd0;   // 0000
    localparam [3:0] MAX_EVEN = 4'd14;  // 1110

    // If you want strict even-only behavior, keep this normalization.
    // It forces LSB=0, e.g., 7 -> 6, 13 -> 12.
    // If you want to accept ANY data_in (even/odd), replace load branch with: count <= data_in;
    function [3:0] normalize_even;
        input [3:0] v;
        begin
            normalize_even = {v[3:1], 1'b0}; // force even
        end
    endfunction

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 4'd0; // start at 0
        end else if (load) begin
            // Use normalize_even(data_in) for even-only; or just count <= data_in; if you allow odd loads
            count <= normalize_even(data_in);
        end else if (count_en) begin
            case (c)
                2'b00: begin
                    // UP by 2, WRAP at top: 14 -> 0
                    if (count == MAX_EVEN)
                        count <= MIN_EVEN;
                    else
                        count <= count + 4'd2;
                end
                2'b01: begin
                    // DOWN by 2, WRAP at bottom: 0 -> 14
                    if (count == MIN_EVEN)
                        count <= MAX_EVEN;
                    else
                        count <= count - 4'd2;
                end
                2'b11: begin
                    // HOLD explicitly when c=3
                    count <= count;
                end
                default: begin
                    // Treat c=2 as HOLD
                    count <= count;
                end
            endcase
        end
        // else: hold
    end

endmodule
