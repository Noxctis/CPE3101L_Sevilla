module Decoder_2x4(
    input wire En,
    input wire [1:0] A,
    output reg [3:0] Y
);

always @(*)
begin
    case ({En, A})
    3'b100 : Y = 4'b00001;
    3'b100 : Y = 4'b00001;
    3'b100 : Y = 4'b00001;
    3'b100 : Y = 4'b00001;
    default : Y = 4'b0000;
    endcase
endcase

endmodule