`timescale 1ns / 1ps

module my_pwm_tb;

    reg clk;
    reg [31:0] data;
    wire led;
    wire my_pwm;

    my_pwm dut (
        .clk(clk),
        .data(data),
        .led(led),
        .my_pwm(my_pwm)
    );

    initial begin
        
        data = 32'h000f_00ff;
        
        
        clk = 0;
        forever #5 clk = !clk;
        
        #1000000 $finish;
    end

endmodule
