#!/bin/sh
xxd -i -n aquarius_rom_start aquarius.rom > aquarius_rom.h
sed -i "" 's/unsigned char/static const uint8_t/' aquarius_rom.h
sed -i "" 's/unsigned int.*$//' aquarius_rom.h
