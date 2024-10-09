# Created by the Intel FPGA Monitor Program
# DO NOT MODIFY

############################################
# Global Defines
DEFINE_COMMA	:= ,

############################################
# Compilation Targets

# Programs
AS		:= nios2-elf-as
CC		:= nios2-elf-gcc
LD		:= nios2-elf-ld
OC		:= nios2-elf-objcopy
RM		:= rm -f

# Flags
USERCCFLAGS	:= -g -O1 -ffunction-sections -fverbose-asm -fno-inline -mno-cache-volatile
ARCHASFLAGS	:= --gstabs -I "C:/quartus18/nios2eds/components/altera_nios2/sdk/inc/"
ARCHCCFLAGS	:= -mhw-mul -mno-hw-div -I "C:/quartus18/nios2eds/components/altera_nios2/HAL/inc/" -DSYSTEM_BUS_WIDTH=32 -DALT_SINGLE_THREADED
ARCHLDFLAGS	:= --defsym nasys_stack_top=0x3000 --defsym nasys_program_mem=0x2000 --defsym nasys_data_mem=0x2000
ARCHLDSCRIPT	:= --script="C:/quartus18/University_Program/Monitor_Program/build/nios_cpp_build.ld"
ASFLAGS		:= $(ARCHASFLAGS)
CCFLAGS		:= -Wall -c $(USERCCFLAGS) $(ARCHCCFLAGS)
LDFLAGS		:= $(patsubst %, -Wl$(DEFINE_COMMA)%, $(ARCHLDFLAGS)) $(patsubst %, -Wl$(DEFINE_COMMA)%, $(ARCHLDSCRIPT))
OCFLAGS		:= -O srec

# Files
HDRS		:=
SRCS		:= lab2.c
OBJS		:= $(patsubst %, %.o, $(SRCS))

# Targets
COMPILE: lab2.srec

lab2.srec: lab2.elf
	$(RM) $@
	$(OC) $(OCFLAGS) $< $@

lab2.elf: $(OBJS)
	$(RM) $@
	$(CC) $(LDFLAGS) $(OBJS) -o $@

%.c.o: %.c $(HDRS)
	$(RM) $@
	$(CC) $(CCFLAGS) $< -o $@

%.s.o: %.s $(HDRS)
	$(RM) $@
	$(AS) $(ASFLAGS) $< -o $@

CLEAN: 
	$(RM) lab2.srec lab2.elf $(OBJS)

