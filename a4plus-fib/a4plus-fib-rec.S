#ifdef MACOS
    .global _my_fib
    printf: jmp _printf
    scanf: jmp _scanf
#else 
    .global my_fib
    _printf: jmp printf
    _scanf: jmp scanf
#endif

.bss
# [unitialized static variables]

.data
# [initialized static variables]

.text
# [constants/strings]

# uint64_t my_fib(uint64_t n)
_my_fib:
my_fib:
    # Implement me!
    ret