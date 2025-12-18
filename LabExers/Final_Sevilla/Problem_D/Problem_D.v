//Chrys Sean T. Sevilla
//Group 3 F 10:30-1:30


module Problem_D (
    input  wire       clk,        // posedge clock
    input  wire       reset,      // active-low async reset


    input  wire [1:0] A,          //

    output reg  [3:0] Z       // current count
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Z <= 4'd0; // assume start at 0
        end else begin
            case (A)
                2'b00: Z <= Z + 4'd2; // modulo 16 naturally
                2'b01: begin
					 Z <= 4'd1; // assume start at 1
					 Z <= Z + 4'd2;
					 end
					 2'b10: Z <= 4'd15;        // set 15
                2'b11: Z <= Z;        // hold
                default: Z <= Z;      // treat other codes as hold
            endcase
        end
        // else: hold
    end

endmodule
