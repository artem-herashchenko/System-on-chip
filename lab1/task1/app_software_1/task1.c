#define switches (volatile char *) 0x0002010
#define leds (char *) 0x0002000
volatile int i, j;

void delay(){
    for(i = 0; i <= 100000; i++){
        
    }
}

void wave_right(int val){
    *leds = val;
    delay();
    for(j = 0; j < 8; j++){
                val = val >> 1;
                *leds = val;
                delay();
            }
}

void wave_left(int val){
    *leds = val;
    delay();
    for(j = 0; j < 8; j++){
                val = val << 1;
                *leds = val;
                delay();
            }
}


void main()
{
    int val = 0;
    while (1) {  
        switch (*switches) {
        case 0x1:
            val = 0x1;
            wave_left(val);
            break;
        case 0x2:
            val = 0x2;
            wave_left(val);
            break;
        case 0x4:
            val = 0x4;
            wave_left(val);
            break;
        case 0x8:
            val = 0x8;
            wave_left(val);
            break;
        case 0x10:
            val = 0x10;
            wave_right(val);
            break;
        case 0x20:
            val = 0x20;
            wave_right(val);
            break;
        case 0x40:
            val = 0x40;
            wave_right(val);
            break;
        case 0x80:
            val = 0x80;
            wave_right(val);
            break;
        }

    }    
}