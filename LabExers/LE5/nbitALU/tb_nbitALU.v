/*
File:           tb_nbitALU.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for nbitALU with carry_in support
*/
module tb_nbitALU;

    reg [3:0] A, B;
    reg [2:0] mode;
    reg carry_in;
    wire [3:0] Y;
    wire carry_out;

    nbitALU #(4) UUT (
        .A(A),
        .B(B),
        .mode(mode),
        .carry_in(carry_in),
        .Y(Y),
        .carry_out(carry_out)
    );

    initial begin
        $display("Time\tMode\tA\tB\tCin\tY\tCout");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b", $time, mode, A, B, carry_in, Y, carry_out);

        // ADDITION (000)
        mode = 3'b000; carry_in = 0; A = 4'b0011; B = 4'b0101; #10;
        mode = 3'b000; carry_in = 1; A = 4'b1111; B = 4'b0001; #10;
        mode = 3'b000; carry_in = 0; A = 4'b1000; B = 4'b0110; #10;

        // SUBTRACTION (001)
        mode = 3'b001; carry_in = 0; A = 4'b0101; B = 4'b0011; #10;
        mode = 3'b001; carry_in = 1; A = 4'b0001; B = 4'b0010; #10;
        mode = 3'b001; carry_in = 0; A = 4'b1111; B = 4'b1010; #10;

        // AND (010)
        mode = 3'b010; carry_in = 0; A = 4'b1100; B = 4'b1010; #10;
        mode = 3'b010; carry_in = 0; A = 4'b1111; B = 4'b0000; #10;
        mode = 3'b010; carry_in = 0; A = 4'b1010; B = 4'b0110; #10;

        // OR (011)
        mode = 3'b011; carry_in = 0; A = 4'b1100; B = 4'b1010; #10;
        mode = 3'b011; carry_in = 0; A = 4'b0000; B = 4'b0000; #10;
        mode = 3'b011; carry_in = 0; A = 4'b1111; B = 4'b0000; #10;

        // XOR (100)
        mode = 3'b100; carry_in = 0; A = 4'b1100; B = 4'b1010; #10;
        mode = 3'b100; carry_in = 0; A = 4'b1111; B = 4'b1111; #10;
        mode = 3'b100; carry_in = 0; A = 4'b0000; B = 4'b1111; #10;

        // COMPLEMENT (101)
        mode = 3'b101; carry_in = 0; A = 4'b1010; B = 4'b0000; #10;
        mode = 3'b101; carry_in = 0; A = 4'b1111; B = 4'b0000; #10;
        mode = 3'b101; carry_in = 0; A = 4'b0000; B = 4'b0000; #10;

        // INCREMENT (110)
        mode = 3'b110; carry_in = 0; A = 4'b0001; B = 4'b0000; #10;
        mode = 3'b110; carry_in = 0; A = 4'b1111; B = 4'b0000; #10;
        mode = 3'b110; carry_in = 0; A = 4'b1000; B = 4'b0000; #10;

        // DECREMENT (111)
        mode = 3'b111; carry_in = 0; A = 4'b0010; B = 4'b0000; #10;
        mode = 3'b111; carry_in = 0; A = 4'b0000; B = 4'b0000; #10;
        mode = 3'b111; carry_in = 0; A = 4'b1111; B = 4'b0000; #10;

        $stop;
    end

endmodule