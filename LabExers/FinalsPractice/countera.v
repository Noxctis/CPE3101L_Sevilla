
module A_StepCounter (
    input  wire       clk,        // posedge clock
    input  wire       reset,      // active-low async reset
    input  wire       load,       // parallel load
    input  wire       count_en,   // count enable
    input  wire [1:0] c,          // control: 0=+3, 1=+1, 3=hold
    input  wire [3:0] data_in,    // parallel data
    output reg  [3:0] count       // current count
);

    reg [3:0] next_count;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 4'd0; // assume start at 0
        end else if (load) begin
            count <= data_in;
        end else if (count_en) begin
            next_count = count; // default hold
            case (c)
                2'b00: next_count = count + 4'd3;
                2'b01: next_count = count + 4'd1;
                2'b11: next_count = count;
                default: next_count = count;
            endcase

            if (next_count >= 4'd14) begin
                count <= 4'd0; // explicit wrap once 14 or above is reached
            end else begin
                count <= next_count;
            end
        end
        // else: hold
    end

endmodule
