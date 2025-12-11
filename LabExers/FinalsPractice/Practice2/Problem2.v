
//------------------------------------------------------------------------------
// Problem2.v
// 6-bit Universal Shift Register (behavioral)
// CLK: positive-edge triggered; reset: asynchronous, active-high
// Control Table:
// 000 Hold       | 001 Shift Left  (LSB <= RSI)
// 010 Shift Right| 011 Sync Clear
// 100 Sync Preset| 101 Count Up
// 110 Count Down | 111 Load
// Author: Chrys Sean T. Sevilla (Group 4, CPE 3101L, 10:30AM - 1:30PM)
//------------------------------------------------------------------------------
module Problem2 (
    input  wire       Clk,    // positive-edge triggered clock
    input  wire       reset,  // asynchronous, active-high reset
    input  wire [2:0] A,      // 3-bit control input
    input  wire [5:0] D,      // 6-bit parallel data input
    input  wire       RSI,    // right-shift-in bit (fills LSB on Shift Left)
    input  wire       LSI,    // left-shift-in bit  (fills MSB on Shift Right)
    output reg  [5:0] Q       // 6-bit register output
);

    // Async reset + posedge operations
    always @(posedge Clk or posedge reset) begin
        if (reset) begin
            Q <= 6'b000000;                 // asynchronous clear
        end else begin
            case (A)
                3'b000: Q <= Q;                         // Hold State
                3'b001: Q <= {Q[4:0], RSI};             // Shift Left  (LSB <= RSI)
                3'b010: Q <= {LSI, Q[5:1]};             // Shift Right (MSB <= LSI)
                3'b011: Q <= 6'b000000;                 // Synchronous Clear
                3'b100: Q <= 6'b111111;                 // Synchronous Preset
                3'b101: Q <= Q + 6'd1;                  // Count Up (mod 64 via wrap-around)
                3'b110: Q <= Q - 6'd1;                  // Count Down (mod 64 via wrap-around)
                3'b111: Q <= D;                         // Parallel Load
                default: Q <= Q;                        // Defensive hold
            endcase
        end
    end

endmodule
