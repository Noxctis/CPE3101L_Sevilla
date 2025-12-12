
`timescale 1ns/1ps
module tb_SetB_EvenUpDownCounter;

    reg clk, reset, load, count_en;
    reg [1:0] c;
    reg [3:0] data_in;
    wire [3:0] count;

    SetB_EvenUpDownCounter UUT (
        .clk(clk), .reset(reset), .load(load),
        .count_en(count_en), .c(c),
        .data_in(data_in), .count(count)
    );

    initial begin clk=0; forever #5 clk=~clk; end

    initial begin
        $display("time  rst load en c  data | count");
        $monitor("%4t   %b   %b    %b %02b  %4b | %4b",
            $time, reset, load, count_en, c, data_in, count);

        // Reset
        reset=0; load=0; count_en=0; c=2'b00; data_in=4'h0;
        @(posedge clk); @(posedge clk); reset=1;

        // Load 6 (normalized to even -> 6)
        load=1; data_in=4'd6; @(posedge clk); load=0;

        // c=0 up by 2 until clamp at 14
        count_en=1; c=2'b00; repeat (6) @(posedge clk); // 6,8,10,12,14,14
        // hold via c=3
        c=2'b11; repeat (2) @(posedge clk);

        // c=1 down by 2 until clamp at 0
        c=2'b01; repeat (8) @(posedge clk);            // 14,12,...,0,0

        // load odd (e.g., 7) -> normalizes to 6
        load=1; data_in=4'd7; @(posedge clk); load=0;

        // c=2 (unused) behaves as hold
        c=2'b10; repeat(3) @(posedge clk);

        $stop;
    end
endmodule
