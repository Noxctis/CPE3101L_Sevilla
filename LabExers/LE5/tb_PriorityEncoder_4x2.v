`timescale 1 ns / 1 ps
module tb_PriorityEncoder_4x2();

reg [3:0] D;
wire [1:0] Y;
wire V;

PriorityEncoder_4x2 uut (
    .D(D),
    .Y(Y),
    .V(V)
);

initial begin
    $display("Starting 4x2 Priority Encoder Testbench at time %0t", $time);

    D = 4'b0000;

    repeat(16)
    #5 D = D + 4'b0001;

    $display("Ending 4x2 Priority Encoder Testbench at time %0t", $time);
    $stop;
end

initial begin
    $monitor("At time %2d ns\t D = %B => Y = %B\t V = %b", $time, D, Y, V);
end

endmodule