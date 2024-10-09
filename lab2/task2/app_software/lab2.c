#define switches (volatile char *) 0x0000020
#define reg32 (char *) 0x0000000
void main()
{ 
    while (1)
        *reg32 = *switches;
}