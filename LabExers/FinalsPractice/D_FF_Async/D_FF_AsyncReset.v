
module D_FF_AsyncReset (
    input  wire Clk,
    input  wire nReset,  // active-low asynchronous
    input  wire D,
    output reg  Q
);
    always @(posedge Clk or negedge nReset) begin
        if (!nReset)		 // reset active when nReset = 0
            Q <= 1'b0;   // immediate clear, independent of clock 
        else
            Q <= D;      // normal operation
    end
endmodule
