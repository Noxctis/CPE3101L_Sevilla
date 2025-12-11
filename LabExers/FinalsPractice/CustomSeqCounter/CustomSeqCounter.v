
//------------------------------------------------------------------------------
// SeqCounter_LoadUD.v  (Quartus-friendly Verilog-2001)
// Purpose:
//   Walk a custom sequence (e.g., 0 → 2 → 3 → 6 → 8 → 9 → 15 → 0 → …)
//   with support for parallel load, up/down direction, and count enable.
// 
// I/O:
//   - Clk     : positive-edge clock
//   - nReset  : active-low asynchronous reset
//   - load    : when 1, load 'data_in' (must be one of the sequence values)
//   - count_en: when 1, advance one step in the sequence
//   - up      : 1 = forward in sequence, 0 = backward
//   - data_in : value to load (WIDTH-bit; must match a defined sequence entry)
//   - Q       : current output (WIDTH-bit)
//
// How to EDIT (most intuitive):
//   1) Set WIDTH to 4 or 6 (or any width you need).
//   2) Update the sequence literals (4-bit) below if you need a different sequence.
//      They are zero-extended automatically to WIDTH using { {(WIDTH-4){1'b0}}, 4'bXXXX }.
//   3) Keep the forward mapping (seq_val) and reverse mapping (val_to_idx) in sync.
//   4) If you grow the sequence beyond 8 entries, set IDXW = 4 (allows up to 16 entries).
//------------------------------------------------------------------------------
module CustomSeqCounter #(
    parameter integer WIDTH   = 4,  // <-- EDIT HERE: set to 6 for 6-bit outputs
    parameter integer SEQ_LEN = 7,  // number of entries in the sequence
    parameter integer IDXW    = 3   // <-- EDIT HERE: bits to index SEQ_LEN; 3 covers 0..7
) (
    input  wire                 Clk,
    input  wire                 nReset,     // active-low async reset
    input  wire                 load,       // parallel load 'data_in'
    input  wire                 count_en,   // advance one step when 1
    input  wire                 up,         // 1=forward, 0=reverse
    input  wire [WIDTH-1:0]     data_in,    // MUST be one of the defined sequence values
    output reg  [WIDTH-1:0]     Q
);

    //--------------------------------------------------------------------------
    // Sequence values (EDIT HERE if you want a different sequence)
    // Use 4-bit literals and zero-extend to WIDTH with {{(WIDTH-4){1'b0}}, 4'bXXXX}.
    // This makes editing intuitive and keeps syntax Verilog-2001 safe.
    //--------------------------------------------------------------------------
    localparam [WIDTH-1:0] S0  = { {(WIDTH-4){1'b0}}, 4'b0000 }; // 0
    localparam [WIDTH-1:0] S2  = { {(WIDTH-4){1'b0}}, 4'b0010 }; // 2
    localparam [WIDTH-1:0] S3  = { {(WIDTH-4){1'b0}}, 4'b0011 }; // 3
    localparam [WIDTH-1:0] S6  = { {(WIDTH-4){1'b0}}, 4'b0110 }; // 6
    localparam [WIDTH-1:0] S8  = { {(WIDTH-4){1'b0}}, 4'b1000 }; // 8
    localparam [WIDTH-1:0] S9  = { {(WIDTH-4){1'b0}}, 4'b1001 }; // 9
    localparam [WIDTH-1:0] S15 = { {(WIDTH-4){1'b0}}, 4'b1111 }; // 15

    //--------------------------------------------------------------------------
    // Index into the sequence (0 .. SEQ_LEN-1)
    // If SEQ_LEN ≤ 8 → IDXW=3; if SEQ_LEN ≤ 16 → IDXW=4
    //--------------------------------------------------------------------------
    reg [IDXW-1:0] idx;

    //--------------------------------------------------------------------------
    // Forward mapping: index -> value
    // KEEP THIS IN SYNC with the sequence localparams above and SEQ_LEN.
    //--------------------------------------------------------------------------
    function [WIDTH-1:0] seq_val;
        input [IDXW-1:0] i;
        begin
            case (i)
                3'd0: seq_val = S0;
                3'd1: seq_val = S2;
                3'd2: seq_val = S3;
                3'd3: seq_val = S6;
                3'd4: seq_val = S8;
                3'd5: seq_val = S9;
                3'd6: seq_val = S15;
                default: seq_val = S0; // safety
            endcase
        end
    endfunction

    //--------------------------------------------------------------------------
    // Reverse mapping: value -> index (used when 'load' is asserted)
    // If 'data_in' is not found in the sequence, we default to index 0 (S0).
    // You can change this behavior if you prefer to "hold" or assert a flag.
    //--------------------------------------------------------------------------
    function [IDXW-1:0] val_to_idx;
        input [WIDTH-1:0] v;
        begin
            case (v)
                S0  : val_to_idx = 3'd0;
                S2  : val_to_idx = 3'd1;
                S3  : val_to_idx = 3'd2;
                S6  : val_to_idx = 3'd3;
                S8  : val_to_idx = 3'd4;
                S9  : val_to_idx = 3'd5;
                S15 : val_to_idx = 3'd6;
                default: val_to_idx = 3'd0; // not found → fallback to first
            endcase
        end
    endfunction

    //--------------------------------------------------------------------------
    // Sequential control: async reset, parallel load, up/down stepping.
    //--------------------------------------------------------------------------
    always @(posedge Clk or negedge nReset) begin
        if (!nReset) begin
            // Async clear: go to first sequence entry
            idx <= 3'd0;
            Q   <= seq_val(3'd0);
        end else if (load) begin
            // Parallel load: align index to the loaded value
            idx <= val_to_idx(data_in);
            Q   <= seq_val(val_to_idx(data_in));
        end else if (count_en) begin
            if (up) begin
                // Forward step: wrap from last back to 0
                idx <= (idx == SEQ_LEN-1) ? 3'd0 : (idx + 1'b1);
                Q   <= seq_val((idx == SEQ_LEN-1) ? 3'd0 : (idx + 1'b1));
            end else begin
                // Reverse step: wrap from 0 back to last
                idx <= (idx == 3'd0) ? (SEQ_LEN-1) : (idx - 1'b1);
                Q   <= seq_val((idx == 3'd0) ? (SEQ_LEN-1) : (idx - 1'b1));
            end
        end
        // else: hold (no change)
    end

endmodule
