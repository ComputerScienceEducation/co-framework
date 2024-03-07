#ifdef MACOS
    printf: jmp _printf
    malloc: jmp _malloc
    calloc: jmp _calloc
    realloc: jmp _realloc
    free: jmp _free
    fopen: jmp _fopen
    fread: jmp _fread
    fwrite: jmp _fwrite
    fclose: jmp _fclose
    strcpy: jmp _strcpy
    strlen: jmp _strlen
    strncpy: jmp _strncpy
    strnlen: jmp _strnlen
    memset: jmp _memset
    memcpy: jmp _memcpy
#else 
    _printf: jmp printf
    _malloc: jmp malloc
    _calloc: jmp calloc
    _realloc: jmp realloc
    _free: jmp free
    _fopen: jmp fopen
    _fread: jmp fread
    _fwrite: jmp fwrite
    _fclose: jmp fclose
    _strcpy: jmp strcpy
    _strlen: jmp strlen
    _strncpy: jmp strncpy
    _strnlen: jmp strnlen
    _memset: jmp memset
    _memcpy: jmp memcpy
#endif

.global example_subroutine

.bss
# [unitialized static variables]

.data
# [initialized static variables]

.text
# [constants/strings]

example_subroutine:
    ret
