
ifdef SystemRoot
   RM = del /Q
   FixPath = $(subst /,\,$1)
else
   ifeq ($(shell uname), Linux)
      RM = rm -f
      FixPath = $1
   endif
endif

	CC= sdcc
	LD= sdld
	AS= sdas311
	H2B= hex2bin
	WAV= sweep.bin

all: libampdemo.bin


libampdemo.bin: demoamprec.bin spidata.bin
	cat  demoamprec.bin  zero64k.bi1 > zz.bin
	head -c 4096 zz.bin > zz.bi1
	cat zz.bi1  spidata.bin > libampdemo.bin
	$(RM) zz.bin 


demoamprec.bin: demoamprec.ihx
	$(H2B) demoamprec.ihx

demoamprec.ihx: demoamprec.rel 
	$(LD) -u -m -i -y demoamprec demoamprec -l ms311sdcc.lib -l ms311sph.lib

demoamprec.rel: demoamprec.asm 
	$(AS) -l -o -s -y demoamprec.asm

demoamprec.asm: demoamprec.c Makefile spidata.h
	$(CC) -pMS311 -OB -OF demoamprec.c

clean:
	$(RM) libampdemo.bin
	$(RM) demoamprec.rel
	$(RM) demoamprec.asm
