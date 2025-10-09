/*
File:           tb_nbitALU.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for nbitALU 
*/
module tb_nbitALU;

    reg [3:0] A, B;
    reg [2:0] mode;
    wire [3:0] Y;
    wire carry_out;

    nbitALU #(4) UUT (
        .A(A),
        .B(B),
        .mode(mode),
        .Y(Y),
        .carry_out(carry_out)
    );

    initial begin
        $display("Time\tMode\tA\tB\tY\tCarry");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, mode, A, B, Y, carry_out);

        // Test Addition
        mode = 3'b000; A = 4'b0011; B = 4'b0101; #10;
        mode = 3'b000; A = 4'b1111; B = 4'b0001; #10;
        mode = 3'b000; A = 4'b1000; B = 4'b1000; #10;

        // Test Subtraction
        mode = 3'b001; A = 4'b0101; B = 4'b0011; #10;
        mode = 3'b001; A = 4'b0001; B = 4'b0010; #10;
        mode = 3'b001; A = 4'b1111; B = 4'b1111; #10;

        // Test AND
        mode = 3'b010; A = 4'b1100; B = 4'b1010; #10;
        mode = 3'b010; A = 4'b1111; B = 4'b0000; #10;
        mode = 3'b010; A = 4'b1111; B = 4'b1111; #10;

        // Test OR
        mode = 3'b011; A = 4'b1100; B = 4'b1010; #10;
        mode = 3'b011; A = 4'b0000; B = 4'b0000; #10;
        mode = 3'b011; A = 4'b1111; B = 4'b0000; #10;

        // Test XOR
        mode = 3'b100; A = 4'b1100; B = 4'b1010; #10;
        mode = 3'b100; A = 4'b1111; B = 4'b1111; #10;
        mode = 3'b100; A = 4'b0000; B = 4'b1111; #10;

        // Test Complement
        mode = 3'b101; A = 4'b1010; B = 4'b0000; #10;
        mode = 3'b101; A = 4'b1111; B = 4'b0000; #10;
        mode = 3'b101; A = 4'b0000; B = 4'b0000; #10;

        // Test Increment
        mode = 3'b110; A = 4'b0001; B = 4'b0000; #10;
        mode = 3'b110; A = 4'b1111; B = 4'b0000; #10;
        mode = 3'b110; A = 4'b1000; B = 4'b0000; #10;

        // Test Decrement
        mode = 3'b111; A = 4'b0010; B = 4'b0000; #10;
        mode = 3'b111; A = 4'b0000; B = 4'b0000; #10;
        mode = 3'b111; A = 4'b1111; B = 4'b0000; #10;

        $stop;
    end

endmodule
