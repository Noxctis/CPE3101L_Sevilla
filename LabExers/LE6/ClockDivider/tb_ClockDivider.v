/*
File:           tb_ClockDivider.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for ClockDivider
*/

`timescale 1ns / 1ps

module tb_ClockDivider;

    reg clk_in, nReset;
    wire clk_out;

    ClockDivider #(.DIV_FACTOR(10)) uut (
        .clk_in(clk_in),
        .nReset(nReset),
        .clk_out(clk_out)
    );

    initial begin
        clk_in = 0;
        forever #1 clk_in = ~clk_in; // 1 time unit period
    end

    initial begin
        $display("Time\tclk_in\tnReset\tclk_out");
        $monitor("%0t\t%b\t%b\t%b", $time, clk_in, nReset, clk_out);

        // Assert reset
        nReset = 0; #5;
        nReset = 1;

        
        #200;

        $stop;
    end

endmodule