transcript on

if { [file exists "work"] } {
    vdel -all
}
vlib work
vlog  my_pwm.v my_pwm_tb.v 
vsim -t 1ns -voptargs="+acc" my_pwm_tb

add wave /*

onbreak resume

configure wave -timelineunits ns
run -all

wave zoom full