#ifdef MACOS
    .global _my_pow
    printf: jmp _printf
    scanf: jmp _scanf
    #ifdef STANDALONE
        .global _main
    #endif
#else 
    .global my_pow
    _printf: jmp printf
    _scanf: jmp scanf
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
    # Implement me!
    ret

# int64_t my_pow(int64_t base, uint64_t exponent)
_my_pow:
my_pow:
    # Implement me!
    ret