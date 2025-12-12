
//------------------------------------------------------------------------------
// SetB_EvenUpDownCounter.v
// 4-bit even up/down counter with clamp at ends and explicit hold.
// - c = 0 : +2 until 14, then HOLD
// - c = 1 : -2 until 0,  then HOLD
// - c = 3 : HOLD (explicit)
// Active-low asynchronous reset; parallel load; count enable.
//------------------------------------------------------------------------------
module SetB_EvenUpDownCounter (
    input  wire       clk,        // posedge clock
    input  wire       reset,      // active-low async reset
    input  wire       load,       // parallel load enable
    input  wire       count_en,   // count enable
    input  wire [1:0] c,          // control: 0=+2, 1=-2, 3=hold
    input  wire [3:0] data_in,    // parallel data (any 4-bit value)
    output reg  [3:0] count       // current count
);

    // endpoints
    localparam [3:0] MIN_EVEN = 4'd0;
    localparam [3:0] MAX_EVEN = 4'd14;

    // make sure loaded value is even if you want strict even sequence
    // (comment out normalization if you want to accept any data_in)
    function [3:0] normalize_even;
        input [3:0] v;
        begin
            normalize_even = {v[3:1], 1'b0}; // force LSB=0 (nearest lower even)
        end
    endfunction

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 4'd0; // assume start at 0
        end else if (load) begin
            count <= normalize_even(data_in);
        end else if (count_en) begin
            case (c)
                2'b00: begin
                    if (count < MAX_EVEN)
                        count <= count + 4'd2;    // up by 2
                    else
                        count <= MAX_EVEN;        // clamp/hold at 14
                end
                2'b01: begin
                    if (count > MIN_EVEN)
                        count <= count - 4'd2;    // down by 2
                    else
                        count <= MIN_EVEN;        // clamp/hold at 0
                end
                2'b11: begin
                    count <= count;               // hold
                end
                default: begin
                    count <= count;               // treat c=2 as hold
                end
            endcase
        end
        // else: hold
    end

endmodule
