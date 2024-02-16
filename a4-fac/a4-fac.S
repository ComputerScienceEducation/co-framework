#ifdef MACOS
    .global _my_factorial
    printf: jmp _printf
    scanf: jmp _scanf
    #ifdef STANDALONE
        .global _main
    #endif
#else 
    .global my_factorial
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

# uint64_t my_factorial(uint64_t n)
_my_factorial:
my_factorial:
    # Implement me!
    ret
