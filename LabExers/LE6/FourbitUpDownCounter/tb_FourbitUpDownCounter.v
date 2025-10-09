/*
File:           tb_FourbitUpDownCounter.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for FourbitUpDownCounter
*/

module tb_FourbitUpDownCounter;

    reg clk, reset, load, count_en, up;
    reg [3:0] data_in;
    wire [3:0] count;

    FourbitUpDownCounter UUT (
        .clk(clk),
        .reset(reset),
        .load(load),
        .count_en(count_en),
        .up(up),
        .data_in(data_in),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Time\tReset\tLoad\tCount_en\tUp\tData_in\tCount");
        $monitor("%0t\t%b\t%b\t%b\t\t%b\t%b\t%b", $time, reset, load, count_en, up, data_in, count);

        // Initial reset
        reset = 0; load = 0; count_en = 0; up = 0; data_in = 4'b0000; #10;
        reset = 1;

        // Load value
        load = 1; data_in = 4'b0101; #10;
        load = 0;

        // No change
        count_en = 0; up = 0; #10;

        // Count down
        count_en = 1; up = 0; #30;

        // Count up
        up = 1; #30;

        // Reset again
        reset = 0; #10;
        reset = 1; #10;

        $stop;
    end

endmodule
