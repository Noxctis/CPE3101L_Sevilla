// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for ComplexCounter

module ComplexCounter (
    input  wire        CLOCK,   // negative-edged
    input  wire        nRESET,  // synchronous active-low
    input  wire        M,       // 0=binary, 1=gray
    output wire [2:0]  COUNT    // Moore output (state)
);
    // State Encoding
    localparam [2:0]
        S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011,
        S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;

    reg [2:0] state, next_state;

    assign COUNT = state;

    always @* begin
        case (state)
            S0: begin
                if (M == 0) next_state = S1; // Binary: 000 -> 001
                else        next_state = S1; // Gray:   000 -> 001
            end
            
            S1: begin
                if (M == 0) next_state = S2; // Binary: 001 -> 010
                else        next_state = S3; // Gray:   001 -> 011
            end
            
            S2: begin
                if (M == 0) next_state = S3; // Binary: 010 -> 011
                else        next_state = S6; // Gray:   010 -> 110
            end
            
            S3: begin
                if (M == 0) next_state = S4; // Binary: 011 -> 100
                else        next_state = S2; // Gray:   011 -> 010
            end
            
            S4: begin
                if (M == 0) next_state = S5; // Binary: 100 -> 101
                else        next_state = S0; // Gray:   100 -> 000
            end
            
            S5: begin
                if (M == 0) next_state = S6; // Binary: 101 -> 110
                else        next_state = S4; // Gray:   101 -> 100
            end
            
            S6: begin
                if (M == 0) next_state = S7; // Binary: 110 -> 111
                else        next_state = S7; // Gray:   110 -> 111
            end
            
            S7: begin
                if (M == 0) next_state = S0; // Binary: 111 -> 000
                else        next_state = S5; // Gray:   111 -> 101
            end
            
            default: next_state = S0;
        endcase
    end

    // Sequential Logic (Negative Edge Clock, Sync Reset)
    always @(negedge CLOCK) begin
        if (!nRESET) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

endmodule