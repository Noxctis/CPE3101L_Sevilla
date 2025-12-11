
//------------------------------------------------------------------------------
// tb_SeqCounter_LoadUD.v — compact TB for screenshots
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

module tb_CustomSeqCounter;

    // Match the DUT parameters
    localparam integer WIDTH   = 4; // <-- EDIT HERE: set to 6 to test 6-bit outputs
    localparam integer SEQ_LEN = 7;
    localparam integer IDXW    = 3;

    reg                 Clk, nReset, load, count_en, up;
    reg  [WIDTH-1:0]    data_in;
    wire [WIDTH-1:0]    Q;

    CustomSeqCounter #(.WIDTH(WIDTH), .SEQ_LEN(SEQ_LEN), .IDXW(IDXW)) UUT (
        .Clk     (Clk),
        .nReset  (nReset),
        .load    (load),
        .count_en(count_en),
        .up      (up),
        .data_in (data_in),
        .Q       (Q)
    );

    // 10 ns clock
    initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
    end

    initial begin
        $display("time  nRst load en up data | Q");
        $monitor("%4t   %b    %b   %b  %b  %2h  | %2h",
                 $time, nReset, load, count_en, up, data_in, Q);

        // Reset to first sequence entry (S0)
        nReset=0; load=0; count_en=0; up=1; data_in={WIDTH{1'b0}};
        @(posedge Clk);
        @(posedge Clk);
        nReset=1; // release → Q=S0

        // Load S6 (value 6), then count UP: 6 -> 8 -> 9 -> 15 -> 0
        load=1; data_in={ {(WIDTH-4){1'b0}}, 4'b0110 }; @(posedge Clk);
        load=0;

        count_en=1; up=1;
        repeat (4) @(posedge Clk);
        count_en=0; @(posedge Clk);

        // Load S6 again, then count DOWN: 6 -> 3 -> 2 -> 0 -> 15
        load=1; data_in={ {(WIDTH-4){1'b0}}, 4'b0110 }; @(posedge Clk);
        load=0;

        count_en=1; up=0;
        repeat (4) @(posedge Clk);
        count_en=0; @(posedge Clk);

        $stop;
    end

endmodule
