#include "address_map_arm.h"

/* глобальные переменные */
#define BUF_SIZE 80000  // около 10 секунд буфера (@ 8K сэмплов/сек)
#define BUF_THRESHOLD 96 // 75% от 128 слов в буфере

/* прототипы функций */
void check_KEYs(int *, int *, int *);

/*******************************************************************************
 * Эта программа выполняет следующее:
 * 	1. записывает аудио в течение 10 секунд при нажатии KEY[0]. LEDR[0] загорается
 *	   во время записи.
 * 	2. проигрывает записанное аудио при нажатии KEY[1]. LEDR[1] загорается во
 *	   время воспроизведения.
 ******************************************************************************/
int main(void) {
    /* Объявление вольтажных указателей на регистры ввода/вывода (volatile означает,
       что для доступа к этим указателям будут использоваться инструкции ввода/вывода,
       а не обычные инструкции загрузки и сохранения в память) */
    volatile int * red_LED_ptr = (int *)LED_BASE;
    volatile int * audio_ptr   = (int *)AUDIO_BASE;

    /* используется для записи/воспроизведения аудио */
    int fifospace;
    int record = 0, play = 0, buffer_index = 0;
    int left_buffer[BUF_SIZE];
    int right_buffer[BUF_SIZE];

    /* читаем и выводим аудио данные */
    record = 0;
    play   = 0;

    while (1) {
        check_KEYs(&record, &play, &buffer_index);
        if (record) {
            *(red_LED_ptr) = 0x1; // включаем LEDR[0]
            fifospace =
                *(audio_ptr + 1); // читаем регистр состояния буфера аудио
            if ((fifospace & 0x000000FF) > BUF_THRESHOLD) // проверяем RARC
            {
                // сохраняем данные, пока буфер аудио-входа не пуст или буфер
                // не заполнен
                while ((fifospace & 0x000000FF) && (buffer_index < BUF_SIZE)) {
                    left_buffer[buffer_index]  = *(audio_ptr + 2);
                    right_buffer[buffer_index] = *(audio_ptr + 3);
                    ++buffer_index;

                    if (buffer_index == BUF_SIZE) {
                        // завершена запись
                        record         = 0;
                        *(red_LED_ptr) = 0x0; // выключаем LEDR
                    }
                    fifospace = *(audio_ptr +
                                  1); // читаем регистр состояния буфера аудио
                }
            }
        } else if (play) {
            *(red_LED_ptr) = 0x2; // включаем LEDR[1]
            fifospace =
                *(audio_ptr + 1); // читаем регистр состояния буфера аудио
            if ((fifospace & 0x00FF0000) > BUF_THRESHOLD) // проверяем WSRC
            {
                // выводим данные, пока буфер не пуст или буфер аудио-выхода не
                // заполнен
                while ((fifospace & 0x00FF0000) && (buffer_index < BUF_SIZE)) {
                    *(audio_ptr + 2) = left_buffer[buffer_index];
                    *(audio_ptr + 3) = right_buffer[buffer_index];
                    ++buffer_index;

                    if (buffer_index == BUF_SIZE) {
                        // завершено воспроизведение
                        play           = 0;
                        *(red_LED_ptr) = 0x0; // выключаем LEDR
                    }
                    fifospace = *(audio_ptr +
                                  1); // читаем регистр состояния буфера аудио
                }
            }
        }
    }
}

/****************************************************************************************
 * Подпрограмма для чтения кнопок KEYs
****************************************************************************************/
void check_KEYs(int * KEY0, int * KEY1, int * counter) {
    volatile int * KEY_ptr   = (int *)KEY_BASE;
    volatile int * audio_ptr = (int *)AUDIO_BASE;
    int            KEY_value;

    KEY_value = *(KEY_ptr); // читаем значения кнопок KEY
    while (*KEY_ptr)
        ; // ждем отпускания кнопок

    if (KEY_value == 0x1) // проверяем KEY0
    {
        // сбрасываем счетчик для начала записи
        *counter = 0;
        // очищаем буфер аудио-входа
        *(audio_ptr) = 0x4;
        *(audio_ptr) = 0x0;

        *KEY0 = 1;
    } else if (KEY_value == 0x2) // проверяем KEY1
    {
        // сбрасываем счетчик для начала воспроизведения
        *counter = 0;
        // очищаем буфер аудио-выхода
        *(audio_ptr) = 0x8;
        *(audio_ptr) = 0x0;

        *KEY1 = 1;
    }
}
