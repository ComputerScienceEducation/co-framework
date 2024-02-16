#ifdef MACOS
    .global _main
    printf: jmp _printf
#else 
    .global main
    _printf: jmp printf
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