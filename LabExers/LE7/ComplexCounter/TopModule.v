
module TopModule (
    input  wire CLK50MHZ,   // 
    input  wire BTN_nRESET, // 
    input  wire SW_M,       // 
    output wire [2:0] LED   // 
);
    wire slow_clk;

    // Divide 50MHz 
    ClockDivider #(.DIV_FACTOR(25_000_000)) u_div (
        .clk_in (CLK50MHZ),
        .nReset (BTN_nRESET),    // async reset OK for divider
        .clk_out(slow_clk)
    );

    
    reg [1:0] sr_reset;
    reg [1:0] sr_m;
    always @(posedge slow_clk) begin
        sr_reset <= {sr_reset[0], BTN_nRESET};
        sr_m     <= {sr_m[0], SW_M};
    end
    wire nRESET_sync = sr_reset[1];
    wire M_sync      = sr_m[1];

    // Counter (negative-edge)
    ComplexCounter u_cnt (
        .CLOCK (slow_clk),
        .nRESET(nRESET_sync),
        .M     (M_sync),
        .COUNT (LED)
    );
endmodule
