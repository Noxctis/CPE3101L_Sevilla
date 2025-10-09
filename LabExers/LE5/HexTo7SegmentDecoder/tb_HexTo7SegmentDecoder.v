/*
File:           tb_HexTo7SegmentDecoder.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for HexTo7SegmentDecoder 
*/

module tb_HexTo7SegmentDecoder;

    reg [3:0] hex;
    reg       dp;
    wire [7:0] seg;

    HexTo7SegmentDecoder UUT (
        .hex(hex),
        .dp(dp),
        .seg(seg)
    );

    initial begin
        $display("Time\tHex\tDP\tSeg");
        $monitor("%0t\t%h\t%b\t%b", $time, hex, dp, seg);

        // Test all hex digits with varying DP values
        dp = 1; // DP off
        hex = 4'h0; #10;
        hex = 4'h1; #10;
        hex = 4'h2; #10;
        hex = 4'h3; #10;
        hex = 4'h4; #10;
        hex = 4'h5; #10;
        hex = 4'h6; #10;
        hex = 4'h7; #10;
        hex = 4'h8; #10;
        hex = 4'h9; #10;
        hex = 4'hA; #10;
        hex = 4'hB; #10;
        hex = 4'hC; #10;
        hex = 4'hD; #10;
        hex = 4'hE; #10;
        hex = 4'hF; #10;

        dp = 0; // DP on
        hex = 4'hA; #10;
        hex = 4'hF; #10;

        $stop;
    end

endmodule