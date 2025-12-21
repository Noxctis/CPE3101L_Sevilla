// Chrys Sean T. Sevilla and Cyril John Christian Calo
// Group 4 CPE 3101L 10:30AM - 1:30PM
// Verilog HDL code for Vending Machine Controller Testbench (tb_VMC)

`timescale 1ns/1ps

module tb_VMC;

    // ==========================================
    // 1. Signal Declarations
    // ==========================================
    // Inputs (Regs)
    reg CLOCK = 0;
    reg nRESET = 0;
    reg START = 0; 
    reg OK = 0; 
    reg CANCEL = 0; 
    reg SELECT = 0;
    reg COIN_1 = 0; 
    reg COIN_5 = 0; 
    reg COIN_10 = 0;

    // Outputs (Wires)
    wire [2:0] ITEM; 
    wire DISPENSE, C1, C5, C10;
    
    // Debug Outputs
    wire [7:0] DBG_COST;
    wire [7:0] DBG_PAID;
    wire [7:0] DBG_CHANGE;

    // ==========================================
    // 2. Unit Under Test (UUT) Instantiation
    // ==========================================
    VMC dut (
        .CLOCK(CLOCK), 
        .nRESET(nRESET),
        .START(START), 
        .OK(OK), 
        .CANCEL(CANCEL), 
        .SELECT(SELECT),
        .COIN_1(COIN_1), 
        .COIN_5(COIN_5), 
        .COIN_10(COIN_10),
        .ITEM(ITEM), 
        .DISPENSE(DISPENSE), 
        .C1(C1), 
        .C5(C5), 
        .C10(C10),
        .DBG_COST(DBG_COST),
        .DBG_PAID(DBG_PAID),
        .DBG_CHANGE(DBG_CHANGE)
    );

    // ==========================================
    // 3. Clock Generation
    // ==========================================
    // 50 MHz Clock -> 20ns Period
    always #10 CLOCK = ~CLOCK;

    // ==========================================
    // 4. Input Pulse Task
    // ==========================================
    // Helper task to drive synchronous inputs safely
    task pulse(input integer sel);
        begin
            @(posedge CLOCK); // Sync with positive edge
            case (sel)
              0: START    = 1;
              1: OK       = 1;
              2: SELECT   = 1;
              3: COIN_1   = 1; 
              4: COIN_5   = 1; 
              5: COIN_10  = 1; 
            endcase
            
            @(posedge CLOCK); // Hold for 1 cycle
            
            // Clear all pulses
            START = 0; OK = 0; SELECT = 0;
            COIN_1 = 0; COIN_5 = 0; COIN_10 = 0;
            
            #5; // Small delay between actions
        end
    endtask

    // ==========================================
    // 5. Test Sequence
    // ==========================================
    initial begin
        // --- System Reset ---
        $display("--- [T=0] System Reset ---");
        nRESET = 0; 
        #30; 
        nRESET = 1; 
        #20;

        // ------------------------------------------------------------
        // Test Case 1: Standard Purchase (Item 1, Exact Change)
        // Expected: Item 1 Selected -> Pay 3.00 -> Dispense -> No Change
        // ------------------------------------------------------------
        $display("\n--- Test 1: Item 1 (Price 3), Exact Payment ---");
        pulse(0);       // START (Default selects Item 1)
        pulse(1);       // OK (Confirm Selection) -> State: PAY
        
        pulse(3);       // Insert 1.00
        pulse(3);       // Insert 1.00
        pulse(3);       // Insert 1.00 (Total Paid: 3.00)
        
        pulse(1);       // OK -> DISPENSE
        #60;            // Wait for dispense and idle return

        // ------------------------------------------------------------
        // Test Case 2: Overpayment (Item 2, Change Needed)
        // Expected: Item 2 Selected -> Pay 10.00 -> Dispense -> Change 5.00
        // ------------------------------------------------------------
        $display("\n--- Test 2: Item 2 (Price 5), Pay 10 (Expect Change: 5) ---");
        pulse(0);       // START (Item 1)
        pulse(2);       // SELECT (Advance to Item 2)
        pulse(1);       // OK -> State: PAY
        
        pulse(5);       // Insert 10.00 (Total Paid: 10.00)
        pulse(1);       // OK -> DISPENSE
        #100;           // Wait (needs extra time for C5 pulse)

        // ------------------------------------------------------------
        // Test Case 3: Cancellation (Item 3, Refund)
        // Expected: Item 3 Selected -> Partial Pay -> Cancel -> Full Refund
        // ------------------------------------------------------------
        $display("\n--- Test 3: Item 3 (Price 12), Partial Pay + CANCEL ---");
        pulse(0);       // START
        pulse(2);       // SELECT (Item 2)
        pulse(2);       // SELECT (Item 3)
        pulse(1);       // OK -> State: PAY
        
        pulse(5);       // Insert 10.00
        pulse(3);       // Insert 1.00 (Total Paid: 11.00 - Insufficient)
        
        $display(" > User presses CANCEL button...");
        #15 CANCEL = 1; // Assert Async Cancel
        #30 CANCEL = 0; // Release
        #150;           // Wait for refund loop (C10 + C1)

        $display("\n--- Simulation Finished ---");
        $stop;
    end
    
    // ==========================================
    // 6. Monitor / Logging
    // ==========================================
    initial begin
        
        $monitor("Time: %t | IN(1/5/10/OK): %b %b %b %b | ITEM: %b | DISP: %b | OUT_CHG(1/5/10): %b %b %b | REM_CHG: %d", 
                 $time, 
                 COIN_1, COIN_5, COIN_10, OK,  // Inputs
                 ITEM, DISPENSE,               // Status
                 C1, C5, C10,                  // Actuators
                 DBG_CHANGE                    // Debug Value
                 );
    end

endmodule