// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for Midterm EXam

module Problem_B (
    input  [3:0] Thermo_in,       // 4-bit hexadecimal input
    input        Turbo_in,
	 output reg   Err_out,
    output reg [7:0] BGraph_out    // 7-segment output: seg[6:0] = segments a-g, seg[7] = DP
);

    always @(*) begin
				Err_out = 0;
            case ({Turbo_in, Thermo_in})
				// Low fan normal Low fan Turbo
				// Hign fan NOrmal High fan turbo
				// Low cool Normal Low cool Turbo
				// High Cool Normal High Cool Turbo
				5'b00000: BGraph_out[7:0] = 8'b00000000; //OFF
				5'b10000: BGraph_out[7:0] = 8'b00000000; //OFF
				
				5'b00001: BGraph_out[7:0] = 8'b00000001; // TURBO LOW FAN
            5'b10001: BGraph_out[7:0] = 8'b00000011; // TURBO LOW FAN
		       
				5'b00010: BGraph_out[7:0] = 8'b00000111; // TURBO HIGH FAN 
            5'b10010: BGraph_out[7:0] = 8'b00001111; // TURBO HIGH FAN
            
				5'b00100: BGraph_out[7:0] = 8'b00011111; // TURBO LOW COOL
				5'b10100: BGraph_out[7:0] = 8'b00111111; // TURBO LOW COOL
            
				5'b01000: BGraph_out[7:0] = 8'b01111111; // TURBO HIGH COOL
				5'b11000: BGraph_out[7:0] = 8'b11111111; // TURBO HIGH COOL
            

            default: 
				BGraph_out[7:0] = 8'b00000000;
            endcase

        end

endmodule
