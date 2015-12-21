CC=/opt/avr-tools/bin/avr-gcc
CFLAGS=-Wall -Wextra --pedantic -DF_CPU=$(F_CPU) -mmcu=$(MCU) -O2 -std=c99
MCU=atmega2560
F_CPU=16000000UL

OBJCOPY=/opt/avr-tools/bin/avr-objcopy
BIN_FORMAT=ihex

PORT=/dev/ttyACM0
BAUD=115200
PROTOCOL=wiring
PART=m2560
AVRDUDE=sudo /usr/bin/avrdude
CFILE=/usr/share/arduino/hardware/tools/avrdude.conf

BIN=blink
OBJS=blink.o

${BIN}.hex: ${BIN}.elf
	    ${OBJCOPY} -O ihex -R .eeprom $< $@

${BIN}.elf: ${OBJS}
	    ${CC} -mmcu=$(MCU) -o $@ $^

install: ${BIN}.hex
	    ${AVRDUDE} -c ${PROTOCOL} -p ${PART} -P ${PORT} -b ${BAUD} -U flash:w:$<:i -C $(CFILE) -D

clean:
	    rm -f ${BIN}.elf ${BIN}.hex ${OBJS}
