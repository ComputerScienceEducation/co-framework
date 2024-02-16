ifeq ($(shell uname -m), arm64)
	F_ARCH = -arch x86_64
endif

ifeq ($(shell uname), Darwin)
	MACOS = -DMACOS
endif 

ifeq ($(SANITIZE), 1)
	F_SANITIZE = -fsanitize=address
endif

AS = clang
CC = clang
ASFLAGS = -gdwarf-4 -fPIE -Wall $(F_ARCH) $(MACOS) $(STANDALONE)
CFLAGS = -O0 -gdwarf-4 -fPIE -Wall $(F_ARCH) $(F_SANITIZE) $(MACOS)
LDFLAGS = $(F_ARCH) $(F_SANITIZE)
STANDALONE = -DSTANDALONE

LINK = $(CC) $(LDFLAGS) $^ -o $@
COMPILE = $(CC) $(CFLAGS) -c $^ -o $@
ASSEMBLE = $(AS) $(ASFLAGS) -c $< -o $@

BINARY_FILES = find . -type f | grep -E "^\./a[0-9](plus)?-[a-zA-Z]*/.+$$" | grep -E -v '^\./.+/.*\..+$$'
# 1. only files in folders that start with "a[0-9](plus)-"
# 2. exclude all files that have an extension

ifdef STREAM_ARRAY_SIZE
 	SET_STREAM_ARRAY_SIZE = -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)
endif

ifdef NTIMES
 	SET_NTIMES = -DNTIMES=$(NTIMES)
endif

.DEFAULT_GOAL := usage

# TARGETS:
.PRECIOUS: %.o
.SUFFIXES:

%: %.o
	$(LINK)

%.o: %.S
	$(ASSEMBLE)

.PHONY: a4plus-fib/a4plus-fib-main

a4plus-fib/a4plus-fib-main:
	@printf "[ERROR] Ivalid Target: Cannot link the fib-main file without providing a my_fib() implementation.\n"
	@printf "\tuse either the [...]-fib-iter or the [...]-fib-rec target\n"

a4plus-fib/a4plus-fib-iter: a4plus-fib/a4plus-fib-main.o a4plus-fib/a4plus-fib-iter.o
	$(LINK)

a4plus-fib/a4plus-fib-rec: a4plus-fib/a4plus-fib-main.o a4plus-fib/a4plus-fib-rec.o
	$(LINK)

a5-diff/a5-diff a5-diff/a5-diff-frame: a5-diff/a5-diff.o a5-diff/a5-diff-frame.o 
	$(LINK)

a5-diff/a5-diff-frame.o: a5-diff/a5-diff-frame.c 
	$(COMPILE)

.PHONY: a6-printf/a6-printf.o 
# Switch between standalone/frame requries re-preprocessing

a6-printf/a6-printf.o: a6-printf/a6-printf.S
	$(ASSEMBLE)
# explicit target needed for PHONY declaration

a6-printf/a6-printf-frame.o: a6-printf/a6-printf-frame.c
	$(COMPILE)

a6-printf/a6-printf-frame: a6-printf/a6-printf-frame.o a6-printf/a6-printf.S
	$(AS) $(CFLAGS) -c -o a6-printf/a6-printf.o a6-printf/a6-printf.S 
	$(CC) $(CFLAGS) -o a6-printf/a6-printf-frame a6-printf/a6-printf.o $<

a7-bmp/a7-bmp-encode: a7-bmp/a7-bmp-encode.o a7-bmp/a7-bmp-shared.o
	$(LINK)

a7-bmp/a7-bmp-decode: a7-bmp/a7-bmp-decode.o a7-bmp/a7-bmp-shared.o
	$(LINK)

a8-hpc/a8-hpc.o: a8-hpc/a8-hpc.S
	$(ASSEMBLE) $(SET_STREAM_ARRAY_SIZE) $(SET_NTIMES)

a8-hpc/stream: a8-hpc/stream.c
	$(CC) $(CFLAGS) $^ -o $@ $(SET_STREAM_ARRAY_SIZE) $(SET_NTIMES)

# SHORTCUT TARGETS:
all: a1-hello/a1-hello a2-inout/a2-inout a3-power/a3-power a4-fac/a4-fac a4plus-fib/a4plus-fib-iter a4plus-fib/a4plus-fib-rec a4plus-fib/a4plus-fib-repl a5-diff/a5-diff-frame a6-printf/a6-printf a6-printf/a6-printf-frame a7-bmp/a7-bmp-encode a7-bmp/a7-bmp-decode a8-hpc/a8-hpc

.PHONY: all a0-sandbox a0-sieve a0 a1 a2 a3 a4 a4plus-iter a4plus-rec a4plus-repl a4-plus a5 a6 a6-frame a6-frame-bonus a7-encode a7-decode a8 stream

a0-sandbox: a0-playground/a0-sandbox
	./$<

a0-sieve: a0-playground/a0-sieve
	./$<

a0: a0-sieve

a1: a1-hello/a1-hello
	./$<

a2: a2-inout/a2-inout
	./$<

a3: a3-power/a3-power
	./$<

a4: a4-fac/a4-fac
	./$<

a4plus-iter: a4plus-fib/a4plus-fib-iter
	./$<

a4plus-rec: a4plus-fib/a4plus-fib-rec
	./$<

a4plus-repl: a4plus-fib/a4plus-fib-repl
	./$<

a5: a5-diff/a5-diff-frame
	./$< a5-diff/test1/a.txt a5-diff/test1/b.txt || true

a6: a6-printf/a6-printf
	./$<
	
a6-frame: a6-printf/a6-printf-frame
	./$<

a6-frame-bonus: a6-printf/a6-printf-frame
	./$< bonus

a7-encode: a7-bmp/a7-bmp-encode
	./$< "Hello from the Makefile"

a7-decode: a7-bmp/a7-bmp-decode
	./$<

a8:	a8-hpc/a8-hpc
	./$<

stream: a8-hpc/stream
	./$<

# UTILITY TARGETS:
.PHONY: clean usage

clean:
	@echo "Removing .dSYM files"
	@rm -rf a*/*.dSYM
	@echo "Removing .o files"
	@rm -f a*/*.o
	@echo "Found the following (assignment) executables:"
	@if ${BINARY_FILES}; then printf "Delete all? [y/n]: "; read line; if [ $$line = "y" ]; then (${BINARY_FILES} | xargs rm) ; fi; else echo "no files found"; fi
	@rm -f a8-hpc/stream

usage:
	@printf "Makefile for the 2024 Computer Organization Lab Framework (⌐■_■)\n"
	@printf "\ntargets:\n"
	@printf "\t<path>\t\tbuild specified file/assignment\n"
	@printf "\ta<#>  \t\tbuild and run specified assignment\n"
	@printf "\tall   \t\tbuild all assignments\n"
	@printf "\tclean \t\tremove all object files, .dSYM directories, and executables \n\t\t\t(needs confirmation to avoid accidentally deleting unwanted files)"
	@printf "\noptions:\n"
	@printf "\tSANITIZE=1\tenable address sanitizer (should be combined with -B / make clean)\n"
