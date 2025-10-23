`timescale 1 ns / 1 ps
module tb_2x4Dec;

reg En;
reg [1:0] A;
wire [3:0] Y;
Decoder_2x4 uut (
    .En(En),
    .A(A),
    .Y(Y)
);

initial begin
    $display("Starting 2x4 Decoder Testbench at time %0t", $time);

    {En, A} = 3'b000; #5;
    {En, A} = 3'b001; #5;
    {En, A} = 3'b010; #5;
    {En, A} = 3'b011; #5;
    
    {En, A} = 3'b100; #5;
    {En, A} = 3'b101; #5;
    {En, A} = 3'b110; #5;
    {En, A} = 3'b111; #5;
    $display("Ending 2x4 Decoder Testbench at time %0t", $time);
    $stop;
end

initial begin
    $monitor("At time %2d ns\t En = %b, A = %b\t Y = %b", $time, En, A, Y);
end
endmodule
