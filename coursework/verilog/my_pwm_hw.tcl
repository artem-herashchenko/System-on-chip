# TCL File Generated by Component Editor 18.1
# Tue Jan 02 18:26:59 EET 2024
# DO NOT MODIFY


# 
# my_pwm "my_pwm" v1.0
# Artem Herashchenko 2024.01.02.18:26:59
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module my_pwm
# 
set_module_property DESCRIPTION ""
set_module_property NAME my_pwm
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "Artem Herashchenko"
set_module_property DISPLAY_NAME my_pwm
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL my_pwm
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file my_pwm.v VERILOG PATH my_pwm.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL my_pwm
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file my_pwm.v VERILOG PATH my_pwm.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 slave_address address Input 5
add_interface_port avalon_slave_0 slave_byteenable byteenable Input 4
add_interface_port avalon_slave_0 slave_read read Input 1
add_interface_port avalon_slave_0 slave_readdata readdata Output 32
add_interface_port avalon_slave_0 slave_write write Input 1
add_interface_port avalon_slave_0 slave_writedata writedata Input 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point pwm_out
# 
add_interface pwm_out conduit end
set_interface_property pwm_out associatedClock clock
set_interface_property pwm_out associatedReset ""
set_interface_property pwm_out ENABLED true
set_interface_property pwm_out EXPORT_OF ""
set_interface_property pwm_out PORT_NAME_MAP ""
set_interface_property pwm_out CMSIS_SVD_VARIABLES ""
set_interface_property pwm_out SVD_ADDRESS_GROUP ""

add_interface_port pwm_out my_pwm export Output 1


# 
# connection point led_out
# 
add_interface led_out conduit end
set_interface_property led_out associatedClock clock
set_interface_property led_out associatedReset ""
set_interface_property led_out ENABLED true
set_interface_property led_out EXPORT_OF ""
set_interface_property led_out PORT_NAME_MAP ""
set_interface_property led_out CMSIS_SVD_VARIABLES ""
set_interface_property led_out SVD_ADDRESS_GROUP ""

add_interface_port led_out led export Bidir 1
