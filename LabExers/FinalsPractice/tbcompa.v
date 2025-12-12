
//------------------------------------------------------------------------------
// tb_Comparator8.v — Testbench for 8-bit comparator
//------------------------------------------------------------------------------
`timescale 1ns / 1ps

module tb_Comparator8;

    reg  [7:0] A, B;
    wire       G, E, L;

    Comparator8 UUT (
        .A(A), .B(B),
        .G(G), .E(E), .L(L)
    );

    initial begin
        $display("time   A        B        | G E L");
        $monitor("%4t   0x%02h    0x%02h    | %b %b %b",
                  $time, A, B, G, E, L);

        // Test vectors
        A = 8'h00; B = 8'h00; #10;  // equal
        A = 8'h01; B = 8'h00; #10;  // greater
        A = 8'h7F; B = 8'h80; #10;  // less (signed viewpoint irrelevant; pure magnitude)
        A = 8'hAA; B = 8'h55; #10;  // greater
        A = 8'hFF; B = 8'hFF; #10;  // equal
        A = 8'h10; B = 8'hF0; #10;  // less
        A = 8'hF0; B = 8'h10; #10;  // greater

        $stop;
    end

endmodule
