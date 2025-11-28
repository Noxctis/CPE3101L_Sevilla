/*
File:           tb_HexDigitCounter.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench for HexDigitCounter (1 up cycle, 1 down cycle)
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

    // Clock generation
    initial begin
        clk_in = 0;
        forever #1 clk_in = ~clk_in; // Fast clock for simulation
    end

    // Force slow_clk to bypass divider
    initial begin
        force uut.slow_clk = clk_in;
    end

    // Decode function for seg
    function [3:0] decode_seg;
        input [7:0] seg;
        begin
            case (seg)
                8'hC0: decode_seg = 4'h0;
                8'hF9: decode_seg = 4'h1;
                8'hA4: decode_seg = 4'h2;
                8'hB0: decode_seg = 4'h3;
                8'h99: decode_seg = 4'h4;
                8'h92: decode_seg = 4'h5;
                8'h82: decode_seg = 4'h6;
                8'hF8: decode_seg = 4'h7;
                8'h80: decode_seg = 4'h8;
                8'h90: decode_seg = 4'h9;
                8'h88: decode_seg = 4'hA;
                8'h83: decode_seg = 4'hB;
                8'hC6: decode_seg = 4'hC;
                8'hA1: decode_seg = 4'hD;
                8'h86: decode_seg = 4'hE;
                8'h8E: decode_seg = 4'hF;
                default: decode_seg = 4'hX;
            endcase
        end
    endfunction

    initial begin

        $display("Time\tReset\tLoad\tCountEn\tUp\tDataIn\tSeg\tDigit");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%h\t%h\t%h", 
                  $time, nReset, load, count_en, up, data_in, seg, decode_seg(seg));

        // Initial reset
        nReset = 0; load = 0; count_en = 0; up = 1; dp = 1; data_in = 4'h0;
        #5 nReset = 1;

        // Load A
        load = 1; data_in = 4'hA; #10;
        load = 0;

        // Count up for 1 cycle
        count_en = 1; up = 1; #20;

        // Count down for 1 cycle
        up = 0; #20;

        // Stop simulation
        $stop;
    end

endmodule
