#include <avr/io.h>
#include <util/delay.h>

#define BLINK_DELAY_MS 1000

int main (void)
{
    DDRF |= 0xFF;
    PORTF = 0x00;
    while(1) {
        PORTF |= 0x80;
        _delay_ms(BLINK_DELAY_MS);

        PORTF &= ~0x80;
        _delay_ms(BLINK_DELAY_MS);
    }
}
