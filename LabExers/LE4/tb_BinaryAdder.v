`timescale 1 ns / 1 ps
module tb_BinaryAdder();
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    // Instantiate the BinaryAdder module
    BinaryAdder #(.n(4)) UUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $display("Time\tA\tB\tCin\tSum\tCout");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, Cin, Sum, Cout);

        A = 4'd0; B = 4'd0; Cin = 1'b0; #10;
        A = 4'd3; B = 4'd5; Cin = 1'b0; #10;
        A = 4'd7; B = 4'd8; Cin = 1'b1; #10;
        A = 4'd15; B = 4'd1; Cin = 1'b0; #10;
        A = 4'd9; B = 4'd6; Cin = 1'b1; #10;
        A = 4'd2; B = 4'd3; Cin = 1'b0; #10;
        A = 4'd1; B = 4'd1; Cin = 1'b1; #10;
        A = 4'd4; B = 4'd4; Cin = 1'b0; #10;

        $stop;
    end

    initial begin
        $monitor("Time = %2d ns\t A = %b\t B = %b\t Cin = %b\t => Sum = %b\t Cout = %b\t {Cout, Sum} = %2d", $time, A, B, Cin, Sum, Cout, (Sum+(Cout*(16))));
    end
endmodule
