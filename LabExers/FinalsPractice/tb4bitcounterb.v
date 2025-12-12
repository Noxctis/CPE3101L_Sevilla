
`timescale 1ns/1ps
module tb_SetA_StepCounter;

    reg clk, reset, load, count_en;
    reg [1:0] c;
    reg [3:0] data_in;
    wire [3:0] count;

    SetA_StepCounter UUT (
        .clk(clk), .reset(reset), .load(load),
        .count_en(count_en), .c(c),
        .data_in(data_in), .count(count)
    );

    initial begin clk=0; forever #5 clk=~clk; end

    initial begin
        $display("time  rst load en c  data | count");
        $monitor("%4t   %b   %b    %b %02b  %4b | %4b",
            $time, reset, load, count_en, c, data_in, count);

        reset=0; load=0; count_en=0; c=2'b00; data_in=4'h0;
        @(posedge clk); @(posedge clk); reset=1;

        // c=0: +3 for 6 cycles (mod 16)
        count_en=1; c=2'b00; repeat (6) @(posedge clk);

        // hold
        c=2'b11; repeat (2) @(posedge clk);

        // c=1: +1 for 4 cycles
        c=2'b01; repeat (4) @(posedge clk);

        // load specific value (e.g., 9), then +3
        load=1; data_in=4'd9; @(posedge clk); load=0;
        c=2'b00; repeat (4) @(posedge clk);

        $stop;
    end
endmodule
