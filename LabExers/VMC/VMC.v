// Chrys Sean T. Sevilla and Cyril John Christian Calo
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for Vending Machine Controller (VMC)

module VMC (
    // System Inputs
    input wire CLOCK,          // Negative-edged clock
    input wire nRESET,         // Asynchronous active low reset
    
    // User Interface Inputs
    input wire START,          // Synchronous active high
    input wire OK,             // Synchronous active high
    input wire CANCEL,         // Active high (Refund/Cancel)
    input wire SELECT,         // Synchronous active high
    
    // Coin Mechanism Inputs
    input wire COIN_1,         
    input wire COIN_5,         
    input wire COIN_10,        
    
    // Actuator Outputs
    output wire [2:0] ITEM,    // LED Indicator (Binary encoded or One-hot)
    output reg DISPENSE,       // Product Actuator
    output reg C1,             // Change Actuator (1 Peso)
    output reg C5,             // Change Actuator (5 Pesos)
    output reg C10,            // Change Actuator (10 Pesos)
    
    // Debug/Display Outputs
    output wire [7:0] DBG_COST,
    output wire [7:0] DBG_PAID,
    output wire [7:0] DBG_CHANGE
);

    // ================= State Encoding =================
    localparam [2:0] 
        S_IDLE          = 3'd0,
        S_SELECT        = 3'd1,
        S_PAY           = 3'd2,
        S_DISPENSE_ITEM = 3'd3,
        S_CALC_CHANGE   = 3'd4, 
        S_REFUND        = 3'd5, 
        S_OUT_CHANGE    = 3'd6; 

    // ================= Internal Registers =================
    reg [2:0] state;
    reg [7:0] balance;      
    reg [7:0] price;
    reg [7:0] change_due;         // Working register (counts down)
    reg [7:0] final_change_display; // Display register (static)
    reg [1:0] item_ptr;     
    
    // Edge Detection Registers
    reg prev_sel, prev_ok, prev_c1, prev_c5, prev_c10;

    // ================= Output Logic (Combinational) =================
    // LED Indicator for selected item
    reg [2:0] item_leds;
    always @(*) begin
        case (item_ptr)
            2'd1: item_leds = 3'b001;
            2'd2: item_leds = 3'b010;
            2'd3: item_leds = 3'b100;
            default: item_leds = 3'b000;
        endcase
    end
    assign ITEM = (state == S_SELECT) ? item_leds : 3'b000;

    // ================= Block 1: FSM Control Path & Outputs =================
    always @(negedge CLOCK or negedge nRESET) begin
        if (!nRESET) begin
            state <= S_IDLE;
            DISPENSE <= 1'b0;
            C1 <= 1'b0; C5 <= 1'b0; C10 <= 1'b0;
        end 
        else begin
            // Default Output State (Pulse behavior)
            DISPENSE <= 1'b0;
            C1 <= 1'b0; C5 <= 1'b0; C10 <= 1'b0;

            // Global Cancel (Refund) Logic
            if (CANCEL && state != S_IDLE && state != S_OUT_CHANGE && state != S_REFUND) begin
                state <= S_REFUND;
            end
            else begin
                case (state)
                    S_IDLE: begin
                        if (START) state <= S_SELECT;
                    end

                    S_SELECT: begin
                        if (OK && !prev_ok) state <= S_PAY;
                    end

                    S_PAY: begin
                        // Move to dispense only if fully paid
                        if (OK && !prev_ok && balance >= price) begin
                            state <= S_DISPENSE_ITEM;
                        end
                    end

                    S_DISPENSE_ITEM: begin
                        DISPENSE <= 1'b1; // Trigger solenoid
                        state <= S_CALC_CHANGE;
                    end

                    S_CALC_CHANGE: begin
                        // One cycle delay for calculation
                        state <= S_OUT_CHANGE; 
                    end

                    S_REFUND: begin
                        // One cycle delay to move balance to change_due
                        state <= S_OUT_CHANGE;      
                    end

                    S_OUT_CHANGE: begin
                        if (change_due == 8'd0) begin
                            state <= S_IDLE;
                        end else begin
                            // Activate coin return actuators based on greedy algorithm
                            // Note: Matches the decrement logic in Datapath block
                            if (change_due >= 8'd10)      C10 <= 1'b1;
                            else if (change_due >= 8'd5)  C5 <= 1'b1;
                            else if (change_due >= 8'd1)  C1 <= 1'b1;
                        end
                    end

                    default: state <= S_IDLE;
                endcase
            end
        end
    end

    // ================= Block 2: Datapath Logic =================
    always @(negedge CLOCK or negedge nRESET) begin
        if (!nRESET) begin
            balance <= 8'd0;
            price <= 8'd0;
            change_due <= 8'd0;
            final_change_display <= 8'd0;
            item_ptr <= 2'd0;
            prev_sel <= 0; prev_ok <= 0;
            prev_c1 <= 0; prev_c5 <= 0; prev_c10 <= 0;
        end 
        else begin
            // Edge Detection Updates
            prev_sel <= SELECT;
            prev_ok <= OK;
            prev_c1 <= COIN_1;
            prev_c5 <= COIN_5;
            prev_c10 <= COIN_10;

            case (state)
                S_IDLE: begin
                    balance <= 8'd0;
                    change_due <= 8'd0;
                    if (START) begin
                        final_change_display <= 8'd0; 
                        item_ptr <= 2'd1;
                        price <= 8'd3; // Default Item 1 Price
                    end
                end

                S_SELECT: begin
                    if (SELECT && !prev_sel) begin
                        if (item_ptr == 2'd3) begin
                            item_ptr <= 2'd1;
                            price <= 8'd3;
                        end else begin
                            item_ptr <= item_ptr + 2'd1;
                            // Set Price based on Item
                            if (item_ptr == 2'd1) price <= 8'd5; // Moving to Item 2
                            else price <= 8'd12;                 // Moving to Item 3
                        end
                    end
                end

                S_PAY: begin
                    if (balance < price) begin
                        if (COIN_1 && !prev_c1)        balance <= balance + 8'd1;
                        else if (COIN_5 && !prev_c5)   balance <= balance + 8'd5;
                        else if (COIN_10 && !prev_c10) balance <= balance + 8'd10;
                    end
                end

                S_CALC_CHANGE: begin
                    change_due <= balance - price;
                    final_change_display <= balance - price;
                    balance <= 8'd0; 
                end

                S_REFUND: begin
                    change_due <= balance;
                    final_change_display <= balance;
                    balance <= 8'd0; 
                end

                S_OUT_CHANGE: begin
                    // Decrement Change Logic (Greedy Algorithm)
                    if (change_due >= 8'd10)      change_due <= change_due - 8'd10;
                    else if (change_due >= 8'd5)  change_due <= change_due - 8'd5;
                    else if (change_due >= 8'd1)  change_due <= change_due - 8'd1;
                end
            endcase
        end
    end

    // ================= Debug Assignments =================
    assign DBG_COST   = price;
    assign DBG_PAID   = balance;
    assign DBG_CHANGE = final_change_display; 

endmodule
