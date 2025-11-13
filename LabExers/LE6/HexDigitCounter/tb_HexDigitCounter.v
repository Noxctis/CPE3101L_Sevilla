/*
File:           tb_HexDigitCounter.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for HexDigitCounter
*/

`timescale 1ns / 1ps

module tb_HexDigitCounter;

    reg clk_in, nReset, load, count_en, up, dp;
    reg [3:0] data_in;
    wire [7:0] seg;

    HexDigitCounter uut (
        .clk_in(clk_in),
        .nReset(nReset),
        .load(load),
        .count_en(count_en),
        .up(up),
        .data_in(data_in),
        .dp(dp),
        .seg(seg)
    );

    // Generate input clock
    initial begin
        clk_in = 0;
        forever #1 clk_in = ~clk_in; // Fast clock for simulation
    end

    initial begin
        $display("Time\tCount\tSeg");
        nReset = 0; load = 0; count_en = 0; up = 1; dp = 1; data_in = 4'h0; #5;
        nReset = 1;

        // Load value
        load = 1; data_in = 4'hA; #10;
        load = 0;

        // Count up
        count_en = 1; up = 1; #100;

        // Count down
        up = 0; #100;

        // Reset
        nReset = 0; #10;
        nReset = 1; #10;

        $stop;
    end

endmodule
