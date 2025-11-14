//=============================================================
// Aircon Thermostat Display Logic
//=============================================================
module Problem_B (
    input  [3:0] Thermo_In,     // 0000=Off, 0001=Low Fan, 0010=High Fan, 0100=Low Cool, 1000=High Cool
    input        Turbo_In,      // 0=Normal, 1=Turbo
    output reg [7:0] BGraph_Out, // 8-LED bar graph output
    output reg       Err_Out     // Error indicator
);

    always @(*) begin
        Err_Out = 0;
        case ({Turbo_In, Thermo_In})
            //=================================================
            // OFF
            //=================================================
            5'b00000: BGraph_Out = 8'b00000000; // Normal
            5'b10000: BGraph_Out = 8'b00000000; // Turbo (no effect)
            
            //=================================================
            // LOW FAN
            //=================================================
            5'b00001: BGraph_Out = 8'b00000011; // Normal
            5'b10001: BGraph_Out = 8'b00000111; // Turbo
            
            //=================================================
            // HIGH FAN
            //=================================================
            5'b00010: BGraph_Out = 8'b00001111; // Normal
            5'b10010: BGraph_Out = 8'b00011111; // Turbo
            
            //=================================================
            // LOW COOL
            //=================================================
            5'b00100: BGraph_Out = 8'b00111111; // Normal
            5'b10100: BGraph_Out = 8'b01111111; // Turbo
            
            //=================================================
            // HIGH COOL
            //=================================================
            5'b01000: BGraph_Out = 8'b01111111; // Normal
            5'b11000: BGraph_Out = 8'b11111111; // Turbo

            //=================================================
            // INVALID INPUT
            //=================================================
            default: begin
                BGraph_Out = 8'b00000000;
                Err_Out = 1;
            end
        endcase
    end

endmodule
