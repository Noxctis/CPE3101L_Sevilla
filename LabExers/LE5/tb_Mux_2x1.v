`timescale 1 ns / 1 ps
module tb_Mux_2x1();

reg A;
reg B;
reg S;
wire X;

Mux_2x1 uut (
    .A(A),
    .B(B),
    .S(S),
    .X(X)
);

initial begin
    $display("Starting 2x1 MUX Testbench at time %0t", $time);

    S = 1'b0; {A, B} = 2'b00; #5;
              {A, B} = 2'b01; #5;
              {A, B} = 2'b10; #5;
              {A, B} = 2'b11; #5;
    S = 1'b1; {A, B} = 2'b00; #5;
              {A, B} = 2'b01; #5;
                {A, B} = 2'b10; #5;
                {A, B} = 2'b11; #5;


    $display("Ending 2x1 MUX Testbench at time %0t", $time);
    $stop;
end

initial begin
    $monitor("At time %2d ns\t S = %b, A = %b, B = %b\t X = %b", $time, S, A, B, X);
end

endmodule
