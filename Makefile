CC=arm-none-eabi-gcc
AR=arm-none-eabi-ar

DEFS := -DSTM32F10X_HD -DVECT_TAB_FLASH -D"assert_param(expr)=((void)0)"
TARGET := libSTM32F10x_StdPeriph.a

MCU := cortex-m3
MCFLAGS := -mcpu=$(MCU) -mthumb -std=c11 -mfloat-abi=soft -nostdlib \
		-fno-exceptions -mlittle-endian -mthumb-interwork -fomit-frame-pointer \
		-falign-functions=16 -fsingle-precision-constant -ffunction-sections \
		-fdata-sections -flto -u _printf_float -Wall -pedantic -Wextra -fno-builtin

STM32_INCLUDES :=-ILibraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/ \
	-ILibraries/CMSIS/CM3/CoreSupport/ \
	-ILibraries/STM32F10x_StdPeriph_Driver/inc/

CFLAGS := $(MCFLAGS) -O0 $(DEFS) $(STM32_INCLUDES)

SRC = $(wildcard ./Libraries/STM32F10x_StdPeriph_Driver/src/*.c) \
	./Libraries/CMSIS/CM3/CoreSupport/core_cm3.c \
	./Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c

OBJ := $(SRC:%.c=%.o)

all: $(TARGET)

$(TARGET): $(OBJ)
	$(AR) rcs $@ $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(TARGET) $(OBJ)
