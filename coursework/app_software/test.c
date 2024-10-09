#include <stdio.h>
#include <stdlib.h>
#define PWM_BASE               0xFF200000

int main(void){
    
    volatile unsigned int *address = (volatile unsigned int *)PWM_BASE;

    unsigned int duty_cyle = 0x1;     // duty cycle
    unsigned int period = 0xFFFF;   //period
    unsigned int data_to_write;
    
    printf("Period pwm in hex:\n");
    scanf("%x", &period);
    
    printf("Duty cycle pwm in hex:\n");
    scanf("%x", &duty_cyle);
    
    if (period < 0 || period > 0xFFFF || duty_cyle < 0 || duty_cyle > 0xFFFF)
    {
        printf("The period and duty cycle values must be non-negative and no more than 0xFFFF!");
        return -1;
    }
    
    data_to_write = (duty_cyle << 16) | period;

    printf("!!!ENTERING THE LOOP!!!");

    while(1){
        
        *address = data_to_write;

        printf("DATA: 0x%X\n", data_to_write);
    }
    
    return 0;
}