
// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for SeqMod7UpDown (Figure-7 modulo-7 sequence)
//
// Ports match the style of FourbitUpDownCounter:
// - clk       : clock (posedge)
// - reset     : active-low asynchronous reset
// - load      : parallel load enable
// - count_en  : count enable
// - up        : 1 = forward along the sequence, 0 = reverse
// - data_in   : parallel data input (4-bit); if not in sequence, falls back to 0000
// - count     : 4-bit output

module SeqMod7UpDown (
    input  wire       clk,           // Clock input (posedge)
    input  wire       reset,         // Active-low async reset
    input  wire       load,          // Parallel load enable
    input  wire       count_en,      // Count enable
    input  wire       up,            // Direction: 1 = up/forward, 0 = down/reverse
    input  wire [3:0] data_in,       // Parallel data input
    output reg  [3:0] count          // Counter output (current state)
);

    // Helper task: normalize any loaded value to the nearest valid sequence entry.
    // If 'data_in' is not in the defined sequence, we default to 4'b0000.
    function [3:0] normalize_load;
        input [3:0] v;
        begin
            case (v)
                4'b0000, // 0
                4'b0001, // 1
                4'b0010, // 2
                4'b0011, // 3
                4'b1000, // 8
                4'b1001, // 9
                4'b1010: // 10
                    normalize_load = v;
                default:
                    normalize_load = 4'b0000;
            endcase
        end
    endfunction

    // Sequential process mirrors your FourbitUpDownCounter style.
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 4'b0000; // Async clear to first sequence value
        end else if (load) begin
            count <= normalize_load(data_in); // Load, constrained to sequence
        end else if (count_en) begin
            if (up) begin
                // Forward/up progression: 0->1->2->3->8->9->10->0->...
                case (count)
                    4'b0000: count <= 4'b0001; // 0 -> 1
                    4'b0001: count <= 4'b0010; // 1 -> 2
                    4'b0010: count <= 4'b0011; // 2 -> 3
                    4'b0011: count <= 4'b1000; // 3 -> 8
                    4'b1000: count <= 4'b1001; // 8 -> 9
                    4'b1001: count <= 4'b1010; // 9 -> 10
                    4'b1010: count <= 4'b0000; // 10 -> 0 (wrap)
                    default: count <= 4'b0000; // if off path, snap to 0
                endcase
            end else begin
                // Reverse/down progression: 0<-1<-2<-3<-8<-9<-10<-0<-...
                case (count)
                    4'b0000: count <= 4'b1010; // 0 <- 10 (reverse wrap)
                    4'b0001: count <= 4'b0000; // 1 <- 0
                    4'b0010: count <= 4'b0001; // 2 <- 1
                    4'b0011: count <= 4'b0010; // 3 <- 2
                    4'b1000: count <= 4'b0011; // 8 <- 3
                    4'b1001: count <= 4'b1000; // 9 <- 8
                    4'b1010: count <= 4'b1001; // 10 <- 9
                    default: count <= 4'b0000; // if off path, snap to 0
                endcase
            end
        end
        // else: hold
    end

endmodule
