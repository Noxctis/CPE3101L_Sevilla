`timescale 1ns/1ps

module tb_Problem_B();

    // Testbench signals
    reg  [3:0] Thermo_In;
    reg        Turbo_In;
    wire [7:0] BGraph_Out;
    wire       Err_Out;

    // DUT instantiation
    Problem_B UUT (
        .Thermo_In(Thermo_In),
        .Turbo_In(Turbo_In),
        .BGraph_Out(BGraph_Out),
        .Err_Out(Err_Out)
    );

    initial begin
        $display("===============================================");
        $display("TEST START: AirconDisplay");
        $display("===============================================");

        // OFF
        Turbo_In = 0; Thermo_In = 4'b0000;
        Turbo_In = 1; Thermo_In = 4'b0000;

        // LOW FAN
        Turbo_In = 0; Thermo_In = 4'b0001;
        Turbo_In = 1; Thermo_In = 4'b0001;

        // HIGH FAN
        Turbo_In = 0; Thermo_In = 4'b0010;
        Turbo_In = 1; Thermo_In = 4'b0010;

        // LOW COOL
        Turbo_In = 0; Thermo_In = 4'b0100;
        Turbo_In = 1; Thermo_In = 4'b0100;

        // HIGH COOL
        Turbo_In = 0; Thermo_In = 4'b1000;
        Turbo_In = 1; Thermo_In = 4'b1000;

        // INVALID
        Turbo_In = 0; Thermo_In = 4'b1111;
        Turbo_In = 1; Thermo_In = 4'b0111;

        $display("===============================================");
        $display("TEST END");
        $display("===============================================");
        $stop;
    end

endmodule
