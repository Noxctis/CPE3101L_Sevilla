module BinaryAdder#(parameter n = 4)(
    input  [n-1:0] A, B,
    input          Cin,
    output [n-1:0] Sum,
    output         Cout
);

    wire [n:0] sum_temp;

    assign sum_temp = {1'b0, A} + {1'b0, B} + Cin;
    assign Sum = sum_temp[n-1:0];
    assign Cout = sum_temp[n];
endmodule
