#include "address_map_arm.h"

#define ALPHA 0.1 // Коефіцієнт згладжування

int main(void) {
    volatile int *audio_ptr = (int *)AUDIO_BASE;

    float prev_left = 0.0;
    float prev_right = 0.0;

    /* Передача даних з входу на вихід */
    while (1) {
        int fifospace = *(audio_ptr + 1); // Зчитуємо регістр стану буфера аудіо
        if ((fifospace & 0x000000FF) > 0) { // Перевіряємо чи є дані в регістрі аудіо входу
            // Отримуємо вхідні дані
            float input_left = (float)(*(audio_ptr + 2));
            float input_right = (float)(*(audio_ptr + 3));

            // Застосовуємо фільтр низьких частот до лівого та правого каналів
            float output_left = prev_left + ALPHA * (input_left - prev_left);
            float output_right = prev_right + ALPHA * (input_right - prev_right);

            // Зберігаємо відфільтровані значення для наступної ітерації
            prev_left = output_left;
            prev_right = output_right;

            // Передача відфільтрованих даних на вихід
            *(audio_ptr + 2) = (int)output_left; // Лівий канал
            *(audio_ptr + 3) = (int)output_right; // Правий канал
        }
    }

    return 0;
}
