
`timescale 1ns/1ps
module tb_UpCounter;

    reg Clk, Reset;
    reg [1:0] A;
    wire [3:0] Z;

    Problem_D UUT (
        .Clk(Clk), .Reset(Reset), .A(A),
        .Z(Z)
    );

    initial begin clk=0; forever #5 clk=~clk; end

    initial begin
        $display("time  rst A| Z");
        $monitor("%4t  %b %02b  | %4b",
            $time, Reset, A, Z);

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
