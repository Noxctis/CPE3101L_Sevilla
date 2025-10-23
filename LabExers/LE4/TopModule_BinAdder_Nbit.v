module TopModule_BinAdder_Nbit (
    input  [3:0] A4, B4,
    input        C4in,
    output [3:0] Sum4,
    output       C4out,

    input [7:0] A8, B8,
    input       C8in,
    output [7:0] Sum8,
    output      C8out
);

    BinaryAdder #(.n(8)) Adder_8bit (
        .A(A8),
        .B(B8),
        .Cin(C8in),
        .Sum(Sum8),
        .Cout(C8out)
    );

    BinaryAdder #(.n(4)) Adder_4bit (
        .A(A4),
        .B(B4),
        .Cin(C4in),
        .Sum(Sum4),
        .Cout(C4out)
    );

    
endmodule