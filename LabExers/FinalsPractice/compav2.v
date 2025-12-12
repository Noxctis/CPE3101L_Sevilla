
module Comparator8_bus (
    input  wire [7:0] A,
    input  wire [7:0] B,
    output wire [2:0] R   // R[2]=G, R[1]=E, R[0]=L
);
    assign R = (A > B)  ? 3'b100 :
               (A == B) ? 3'b010 :
                           3'b001 ;
endmodule
