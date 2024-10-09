#include "stdio.h"

int main(int argc, char const *argv[])
{
    int LED_bits = 0x00000100;
    int SW_value = 10;
    int shift_8, shift_16, shift_24;
    shift_8 = SW_value << 8;
    shift_16 = SW_value << 16;
    shift_24 = SW_value << 24;
    //LED_bits = SW_value | (SW_value << 8) | (SW_value << 16) | (SW_value << 24);
    printf("start %x, 8 %x, 16 %x, 24 %x, full %x", SW_value, shift_8, shift_16, shift_24, LED_bits);

    if (LED_bits & 0x80000000)
            LED_bits = (LED_bits << 1) | 1;
        else
            LED_bits = LED_bits << 1;

    printf("\n %x", LED_bits);

    return 0;
}
