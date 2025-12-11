
module D_FF_SyncReset (
    input  wire Clk,
    input  wire nReset,  // active-low synchronous
    input  wire D,
    output reg  Q
);
    always @(posedge Clk) begin
        if (!nReset)		 // reset active when nReset = 0
            Q <= 1'b0;   // reset on clock edge 
        else
            Q <= D;
    end
endmodule
