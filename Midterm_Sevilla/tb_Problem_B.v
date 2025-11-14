`timescale 1ns / 1ps
// Testbench for HexTo7SegmentDecoder
// CHrys SEan T. SEvilla
module tb_Problem_B();

    reg  [3:0] Thermo_in;
    reg        Turbo_in;
    wire        Err_out;
    wire [7:0] BGraph_out;

    // Instantiate the DUT
    Problem_B UUT (
        .Thermo_in(Thermo_in),
        .Turbo_in(Turbo_in),
        .Err_out(Err_out),
        .BGraph_out(BGraph_out)
    );

    integer i;

    initial begin
        $display("Time(ns) | en dp hex | seg[7:0] (DP a..g) | seg[6]=a seg[5]=b");
        $display("-----------------------------------------------------------");
        Turbo_in = 1'b0; #10
		  Thermo_in = 4'b0000; #10;
        Thermo_in = 4'b0001; #10;
        Thermo_in = 4'b0100; #10;
        Thermo_in = 4'b0100; #10;
        Thermo_in = 4'b1000; #10;

		  
		  Turbo_in = 1'b1; #10
		  Thermo_in = 4'b0000; #10;
        Thermo_in = 4'b0001; #10;
        Thermo_in = 4'b0100; #10;
        Thermo_in = 4'b0100; #10;
        Thermo_in = 4'b1000; #10;


        $display("Test complete.");
        $stop;
    end
endmodule
