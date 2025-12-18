
`timescale 1ns/1ps
module tb_Problem_D;

    reg clk, reset;
    reg [1:0] A;

    wire [3:0] Z;

    Problem_D UUT (
        .clk(clk), .reset(reset), 
         .A(A),
         .Z(Z)
    );

    initial begin clk=0; forever #5 clk=~clk; end

    initial begin
        $display("time  rst load en c  data | count");
        $monitor("%4t    %b %02b  | %4d",
            $time, reset, A, Z);

        reset=1; A=2'b00; 
        @(posedge clk); @(posedge clk); reset=0;

        //repeat even incerment 6 times
         A=2'b00; repeat (8) @(posedge clk);

		  reset=1; A=2'b00; 
        @(posedge clk); @(posedge clk); reset=0;
        //repeat odd increment 6 times
        A=2'b01; repeat (4) @(posedge clk);
		  
		  reset=1; A=2'b00; 
        @(posedge clk); @(posedge clk); reset=0;
        A=2'b10; repeat (2) @(posedge clk);

        A=2'b11; repeat (2) @(posedge clk);
		  
        $stop;
    end
endmodule
