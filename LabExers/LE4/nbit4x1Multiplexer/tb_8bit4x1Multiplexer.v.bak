/*
File:           tb_8bit4x1Multiplexer.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for 8-Bit 4-to-1 Line Multiplexer 
*/

module tb_8bit4x1Multiplexer;

    reg [7:0] A, B, C, D;
    reg [1:0] S;
    wire [7:0] Y;

    // Instantiate the UUT with default n = 4
    nbit4x1Multiplexer #(.n(8)) UUT (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .S(S),
        .Y(Y)
    );

    initial begin
        $display("Time\tS\tY\t A\t  B\t   C\t    D");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b", $time, S, Y, A, B, C, D);

        
		  // Set 8-bit inputs
        A = 8'b00000011;
        B = 8'b00001100;
        C = 8'b00110000;
        D = 8'b11000000;

        // Test all selector values
        S = 2'b00; #10; // Expect Y = A
        S = 2'b01; #10; // Expect Y = B
        S = 2'b10; #10; // Expect Y = C
        S = 2'b11; #10; // Expect Y = D


        $stop;
    end

endmodule