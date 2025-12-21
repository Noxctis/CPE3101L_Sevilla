// Chrys Sean T. Sevilla
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for RaceLightsController

module RaceLightsController (
    input  wire CLOCK,     // negative-edge 1 Hz
    input  wire nRESET,    // async active-low
    input  wire START,
    output reg  RED,
    output reg  YELLOW,
    output reg  GREEN
);

    // Explicit States for every second of the sequence
    localparam [2:0]
        S_RED_IDLE = 3'd0,  // Waiting for start
        S_RED_1S   = 3'd1,  // Red on for 1 sec after start
        S_YEL_1S   = 3'd2,  // Yellow on for 1 sec
        S_GRN_1S   = 3'd3,  // Green sec 1
        S_GRN_2S   = 3'd4,  // Green sec 2
        S_GRN_3S   = 3'd5;  // Green sec 3

    reg [2:0] state, next_state;

    // 1. Next State Logic (Combinational)
    always @(*) begin
        case (state)
            S_RED_IDLE: begin
                if (START) next_state = S_RED_1S;   // Start pressed
                else       next_state = S_RED_IDLE; // Wait
            end

            S_RED_1S:   next_state = S_YEL_1S;   // Red done (1s), go Yellow

            S_YEL_1S:   next_state = S_GRN_1S;   // Yellow done (1s), go Green

            S_GRN_1S:   next_state = S_GRN_2S;   // Green tick 1
            S_GRN_2S:   next_state = S_GRN_3S;   // Green tick 2
            S_GRN_3S:   next_state = S_RED_IDLE; // Green tick 3 (Done) -> Reset

            default:    next_state = S_RED_IDLE;
        endcase
    end

    // 2. Output Logic
    always @(*) begin
        // Default to off
        RED = 0; YELLOW = 0; GREEN = 0;

        case (state)
            S_RED_IDLE: RED = 1;
            S_RED_1S:   RED = 1;
            
            S_YEL_1S:   YELLOW = 1;
            
            S_GRN_1S:   GREEN = 1;
            S_GRN_2S:   GREEN = 1;
            S_GRN_3S:   GREEN = 1;
            
            default:    RED = 1;
        endcase
    end

    // 3. Sequential Logic
    always @(negedge CLOCK or negedge nRESET) begin
        if (!nRESET) begin
            state <= S_RED_IDLE;
        end else begin
            state <= next_state;
        end
    end

endmodule
