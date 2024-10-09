module my_pwm(
clk,
data,
led,
my_pwm
);

input clk;
input [31:0] data;
output led;           // output signal to LEDR[0]
output my_pwm;        // output signal to GPIO_0[1]

reg     [15:0] cnt_ff  = 0;                      // counter reg
reg     [15:0] duty_cyle_ff = 0;                 // duty cycle reg
reg     [15:0] period_ff = 0;                    // period reg
reg           out_ff  = 1'b0;                   // output signal reg

wire  [15:0] i_period;
wire  [15:0] i_duty_cyle;

// Input signals for registers
assign i_period = data [15:0];
assign i_duty_cyle = data [31:16];

always @(posedge clk) begin
    period_ff    <= i_period;
    duty_cyle_ff <= i_duty_cyle;
end

always @(posedge clk)
    if(cnt_ff == period_ff)
        cnt_ff <= 0;
    else 
        cnt_ff <= cnt_ff + 1'b1;

always @(posedge clk)
    out_ff <= (cnt_ff < duty_cyle_ff);

assign my_pwm = out_ff;
assign led = out_ff;

endmodule

