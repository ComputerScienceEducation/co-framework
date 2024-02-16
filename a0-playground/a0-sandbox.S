#ifdef MACOS
    .global _main
    calloc: jmp _calloc
    fclose: jmp _fclose
    fgets: jmp _fgets
    fopen: jmp _fopen
    fprintf: jmp _fprintf
    fread: jmp _fread
    free: jmp _free
    fscanf: jmp _fscanf
    fwrite: jmp _fwrite
    malloc: jmp _malloc
    memset: jmp _memset
    putchar: jmp _putchar
    realloc: jmp _realloc
    scanf: jmp _scanf
    strcasecmp: jmp _strcasecmp
    strcmp: jmp _strcmp
    strcpy: jmp _strcpy
    strlen: jmp _strlen
    strncasecmp: jmp _strncasecmp
    strncmp: jmp _strncmp
    strncpy: jmp _strncpy
    strnlen: jmp _strnlen
    printf: jmp _printf
#else 
    .global main
    _calloc: jmp calloc
    _fclose: jmp fclose
    _fgets: jmp fgets
    _fopen: jmp fopen
    _fprintf: jmp fprintf
    _fread: jmp fread
    _free: jmp free
    _fscanf: jmp fscanf
    _fwrite: jmp fwrite
    _malloc: jmp malloc
    _memset: jmp memset
    _putchar: jmp putchar
    _realloc: jmp realloc
    _scanf: jmp scanf
    _strcasecmp: jmp strcasecmp
    _strcmp: jmp strcmp
    _strcpy: jmp strcpy
    _strlen: jmp strlen
    _strncasecmp: jmp strncasecmp
    _strncmp: jmp strncmp
    _strncpy: jmp strncpy
    _strnlen: jmp strnlen
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

    ret
