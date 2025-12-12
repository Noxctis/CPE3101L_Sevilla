
`timescale 1ns / 1ps
module tb_comparator8bit;

    reg Clk, nReset;
    reg [7:0] A, B;
    wire [2:0] R; // R[2]=A>B, R[1]=A==B, R[0]=A<B

    // Instantiate DUT
    comparator8bit UUT (
        .Clk(Clk),
        .nReset(nReset),
        .A(A),
        .B(B),
        .R(R)
    );

    // Clock generation: 10 ns period
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end

    initial begin
        $display("Time\tReset\tA\tB\tR");
        $monitor("%0t\t%b\t%h\t%h\t%b", $time, nReset, A, B, R);

        // Initial reset
        nReset = 0; A = 8'h00; B = 8'h00;
        #10 nReset = 1; // Release reset

        // Test cases
        A = 8'h00; B = 8'h00; #10; // Equal
        A = 8'h05; B = 8'h03; #10; // Greater
        A = 8'h02; B = 8'h07; #10; // Less
        A = 8'hFF; B = 8'hFF; #10; // Equal
        A = 8'h10; B = 8'hF0; #10; // Less
        A = 8'hF0; B = 8'h10; #10; // Greater

        $stop;
    end

endmodule
