/*
File:           tb_ComplexCounter.v
Author:         Chrys Sean T. Sevilla
Class:          CPE 3101L
Group/Schedule: Group 4 Fri 10:30 - 1:30 PM
Description:    Testbench file for ComplexCounter
*/

`timescale 1ns/1ps

module tb_ComplexCounter;

    // 1. Inputs (Regs) and Outputs (Wires)
    reg CLOCK;
    reg nRESET;
    reg M;
    wire [2:0] COUNT;

    // 2. Instantiate the Unit Under Test (UUT)
    ComplexCounter uut (
        .CLOCK(CLOCK), 
        .nRESET(nRESET), 
        .M(M), 
        .COUNT(COUNT)
    );

    // 3. Clock Generation (50 MHz equivalent -> 20ns period)
    initial CLOCK = 0;
    always #10 CLOCK = ~CLOCK; 

    // 4. Test Sequence
    initial begin
        // Initialize Inputs
        nRESET = 1; // Not reset
        M = 0;      // Start in Binary Mode
        
        // --- RESET SEQUENCE ---
        $display("--- Starting Simulation ---");
        $display("Applying Synchronous Reset...");
        
        // Assert Reset (Active Low)
        // Since the DUT triggers on NEGEDGE, we hold reset low across a negative edge
        @(posedge CLOCK);
        nRESET = 0;
        @(posedge CLOCK);
        nRESET = 1;
        $display("Reset Complete. State should be 000.");
        
        // --- TEST CASE 1: BINARY COUNTING (M=0) ---
        $display("\n--- Test 1: Binary Counting Mode (M=0) ---");
        M = 0;
        
        // Let it run for 10 clock cycles (more than full 8 states)
        repeat (10) @(negedge CLOCK); 
        
        // --- TEST CASE 2: GRAY CODE COUNTING (M=1) ---
        $display("\n--- Test 2: Gray Code Counting Mode (M=1) ---");
        M = 1;
        
        // Let it run for 10 clock cycles
        repeat (10) @(negedge CLOCK);

        // --- TEST CASE 3: SWITCHING MODES MID-COUNT ---
        $display("\n--- Test 3: Switching Modes Mid-Count ---");
        
        // Reset again to start from known state
        @(posedge CLOCK);
        nRESET = 0;
        @(posedge CLOCK);
        nRESET = 1;
        
        // Start in Binary (M=0)
        M = 0;
        $display("Mode 0 (Binary): Counting to 010...");
        @(negedge CLOCK); // 000 -> 001
        @(negedge CLOCK); // 001 -> 010
        
        // Current State is 010.
        // If M=0 (Binary), next is 011.
        // If M=1 (Gray),   next is 110.
        
        $display("Switching to Mode 1 (Gray) NOW...");
        M = 1; 
        
        @(negedge CLOCK); 

        repeat (2) @(negedge CLOCK);
        
        $display("\n--- Simulation Finished ---");
        $stop;
    end

    // 5. Monitor Output
    initial begin
        $monitor("Time: %t | CLK: %b | RST: %b | Mode: %b | COUNT: %b (%d)", 
                 $time, CLOCK, nRESET, M, COUNT, COUNT);
    end

endmodule