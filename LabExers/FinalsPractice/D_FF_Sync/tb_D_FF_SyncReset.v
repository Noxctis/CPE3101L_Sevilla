
// Testbench file of D Flip-flop
`timescale 1 ns / 1 ps
module tb_D_FF_SyncReset ();

    // inputs as reg, outputs as wire
    reg  Clk, nReset, D;
    wire Q;

    // instantiate UUT
    D_FF_SyncReset UUT ( .Clk(Clk), .nReset(nReset), .D(D), .Q(Q) );

    // set initial value for clock
    initial
        Clk = 1'b0;

    // clock generator
    always
        #5   Clk = ~Clk;   // toggles/complements the clock every after 5 ns

    // set reset value
    initial begin
        nReset = 1'b1;     // reset is initially disabled (active low)
        #4  nReset = 1'b0; // reset is enabled after 4 ns (active low)
        #10 nReset = 1'b1; // reset is then disabled after 10 ns
        #25 nReset = 1'b0; // reset is enabled after 25 ns
        #10 nReset = 1'b1; // reset is then disabled again after 10 ns
    end

    // generate stimuli
    initial begin
        $display("Starting simulation at %0d ns...", $time);
        D = 1'b1; #12      // set first delay before clock edge (every 5 ns)
        D = 1'b0; #10
        D = 1'b1; #10
        D = 1'b0; #12
        $display("Finished simulation at %0d ns.", $time);
        $stop;
    end

    // response monitor
    initial
        $monitor("Time = %2d ns\t Clk = %b\t nReset = %b\t D = %b\t Q = %b",
                 $time, Clk, nReset, D, Q);
endmodule
