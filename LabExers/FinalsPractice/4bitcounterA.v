
module A_StepCounter (
    input  wire       clk,        // posedge clock
    input  wire       reset,      // active-low async reset
    input  wire       load,       // parallel load
    input  wire       count_en,   // count enable
    input  wire [1:0] c,          // control: 0=+3, 1=+1, 3=hold
    input  wire [3:0] data_in,    // parallel data
    output reg  [3:0] count       // current count
);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 4'd0; // assume start at 0
        end else if (load) begin
            count <= data_in;
        end else if (count_en) begin
            case (c)
                2'b00: count <= count + 4'd3; // modulo 16 naturally
                2'b01: count <= count + 4'd1;
                2'b11: count <= count;        // hold
                default: count <= count;      // treat other codes as hold
            endcase
        end
        // else: hold
    end

endmodule
