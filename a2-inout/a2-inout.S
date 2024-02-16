#ifdef MACOS
    .global _my_inc
    printf: jmp _printf
    scanf: jmp _scanf
    #ifdef STANDALONE
        .global _main
    #endif
#else 
    .global my_inc
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

# int64_t my_inc(int64_t n)
_my_inc:
my_inc:
    # Implement me!
    ret
    
