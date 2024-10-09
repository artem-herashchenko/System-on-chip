
/*

  Author:  Artem Herashchenko
  Date:  02/01/2024

*/


module my_pwm(
// signals to connect to an Avalon clock source interface
clk,
reset,
// signals to connect to an Avalon-MM slave interface
slave_address,
slave_read,
slave_write,
slave_readdata,
slave_writedata,
slave_byteenable,
// Non-Avalon Interface IO
led,
my_pwm
);

//*******************************************************************
// Module Interface
//*******************************************************************
input clk;
input reset;
  
// slave interface
input [4:0] slave_address;        // Подмножество местоположения FPGA на карте памяти A9 (младшие 5 бит)
input slave_read;                 // если 1 операция чтения
input slave_write;                // если 1 операция записи
output wire [31:0] slave_readdata; // если 1 перефирийное устройство передаёт данные по этой шине которая определяется адресной. Когда 0 устройство в tri-state 
input [31:0] slave_writedata;      // если 1 периферийное устройство возьмёт данные, найденые на шине данных записи, и сохранит их в регистр, указанный адресной шиной
input [3:0] slave_byteenable;      // используется для указания типа транзакции байт (8 бит), полуслово (16 бит), слово (32 бита)

//-------------------------------------------------------------------
output led;           // сигнал для вывода на диод LEDR[0]
output my_pwm;        // сигнал для вывода шим на GPIO_1[1]
//-------------------------------------------------------------------

//*******************************************************************
// Register Addresses
//*******************************************************************
localparam	GPIO_OUT_ADDR	= 5'b0000;
  
  
//*******************************************************************
// Register Set
//*******************************************************************
reg     [31:0] gpio_out_r;
reg     [4:0] cnt_ff  = 0;                      // регистр счётчика
reg     [4:0] duty_cyle_ff = 0;                 // регистр скважности
reg     [4:0] period_ff = 0;                    // регистр периода
reg           out_ff  = 1'b0;                   // регистр выходного сигнала

//*******************************************************************
// Wires/Reg
//*******************************************************************
//wire  [31:0] gpio_in;
wire  [31:0] gpio_out;
wire  [15:0] i_period;
wire  [15:0] i_duty_cyle;

//*******************************************************************
// Output Assignments
//*******************************************************************
  
// Input signals for registers
assign gpio_out       = ( (slave_address == GPIO_OUT_ADDR )   && slave_write ) ? slave_writedata : gpio_out_r;
assign i_period = gpio_out [15:0];
assign i_duty_cyle = gpio_out [31:16];

always @(posedge clk) begin
    gpio_out_r  <= gpio_out;
end

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

