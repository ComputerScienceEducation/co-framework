#ifdef MACOS
    .global _my_printf
    putchar: jmp _putchar
    #ifdef STANDALONE
        .global _main
    #endif
#else 
    .global my_printf
    _putchar: jmp putchar
    #ifdef STANDALONE
        .global main
    #endif
#endif

.bss
# [unitialized static variables]

.data
# [initialized static variables]

.text
# [constants/strings]

_main:
main:
    # Implement some main function to locally test your printf.
    # The tests will only test my_printf() in isolation, not this main program.

# int my_printf(const char *fmt, ...)
_my_printf:
my_printf:
    # Implement me!
    ret
