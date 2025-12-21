
//------------------------------------------------------------------------------
// RaceLightsController.v
// Mealy FSM for race lights with timed holds.
// CLOCK: 1 Hz, negative-edged sample
// nRESET: asynchronous active-low
// START: level to begin sequence
// Outputs: RED, YELLOW, GREEN (one-hot)
//
// Timing (at 1 Hz):
// - After START=1 in RED idle: RED holds 1 second
// - YELLOW holds 1 second
// - GREEN holds 3 seconds
// - Return to RED idle
//------------------------------------------------------------------------------
module RaceLightsController (
    input  wire CLOCK,      // negative-edged 1 Hz clock
    input  wire nRESET,     // async active-low reset
    input  wire START,      // start command
    output reg  RED,
    output reg  YELLOW,
    output reg  GREEN
);
    // States (encoded)
    localparam [2:0]
        S_RED_IDLE    = 3'd0,  // red on, waiting for START
        S_RED_HOLD    = 3'd1,  // red extra hold 1s after START
        S_YELLOW_HOLD = 3'd2,  // yellow 1s
        S_GREEN_HOLD  = 3'd3;  // green 3s, then back to red idle

    // Hold durations (seconds @ 1Hz)
    localparam integer T_RED_EXTRA = 1;
    localparam integer T_YELLOW    = 1;
    localparam integer T_GREEN     = 3;

    reg [2:0] state, next_state;
    reg [3:0] timer, next_timer;  // up to >=3 seconds; 4 bits enough

    // Combinational Mealy outputs + next-state/time
    always @* begin
        // defaults
        next_state = state;
        next_timer = timer;
        RED    = 1'b0;
        YELLOW = 1'b0;
        GREEN  = 1'b0;

        case (state)
            S_RED_IDLE: begin
                RED = 1'b1;
                next_timer = 4'd0; // idle: timer cleared
                // Mealy transition depends on input START
                if (START) begin
                    next_state = S_RED_HOLD;
                    next_timer = 4'd0; // start new hold
                end
            end

            S_RED_HOLD: begin
                RED = 1'b1;
                if (timer >= T_RED_EXTRA-1) begin
                    next_state = S_YELLOW_HOLD;
                    next_timer = 4'd0;
                end else begin
                    next_timer = timer + 1'b1;
                end
            end

            S_YELLOW_HOLD: begin
                YELLOW = 1'b1;
                if (timer >= T_YELLOW-1) begin
                    next_state = S_GREEN_HOLD;
                    next_timer = 4'd0;
                end else begin
                    next_timer = timer + 1'b1;
                end
            end

            S_GREEN_HOLD: begin
                GREEN = 1'b1;
                if (timer >= T_GREEN-1) begin
                    next_state = S_RED_IDLE; // return to reset state
                    next_timer = 4'd0;
                end else begin
                    next_timer = timer + 1'b1;
                end
            end

            default: begin
                RED = 1'b1;           // safe default: show red
                next_state = S_RED_IDLE;
                next_timer = 4'd0;
            end
        endcase
    end

    // Sequential state/timer with negative-edge clock and async reset
    always @(negedge CLOCK or negedge nRESET) begin
        if (!nRESET) begin
            state <= S_RED_IDLE;  // forced reset state
            timer <= 4'd0;
        end else begin
            state <= next_state;
            timer <= next_timer;
        end
    end
endmodule
