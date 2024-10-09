#include "address_map_arm.h"

int main(void) {

    volatile int * audio_ptr = (int *)AUDIO_BASE;

    /* Передача даних з входу на вихід */
    while (1) {
        int fifospace = *(audio_ptr + 1); // Зчитуємо регістр стану буфера аудіо
        if ((fifospace & 0x000000FF) > 0) { // Перевіряємо чи є дані в регістрі аудіо входу
            // Передача даних з входу на вихід
            *(audio_ptr + 2) = *(audio_ptr + 2); // Лівий канал
            *(audio_ptr + 3) = *(audio_ptr + 3); // Правий канал
        }
    }

}
