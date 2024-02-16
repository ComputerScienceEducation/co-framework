#ifdef MACOS
    my_fib: jmp _my_fib
    printf: jmp _printf
    scanf: jmp _scanf
    .global _main
#else
    _my_fib: jmp my_fib
    _printf: jmp printf
    _scanf: jmp scanf
    .global main
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
