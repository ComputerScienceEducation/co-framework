#ifdef MACOS
    .global _my_diff
    printf: jmp _printf
    malloc: jmp _malloc
    calloc: jmp _calloc
    realloc: jmp _realloc
    free: jmp _free
    fopen: jmp _fopen
    fclose: jmp _fclose
    fgets: jmp _fgets
    fread: jmp _fread
    fprintf: jmp _fprintf
    fscanf: jmp _fscanf
    strcasecmp: jmp _strcasecmp
    strcmp: jmp _strcmp
    strcpy: jmp _strcpy
    strlen: jmp _strlen
    strncasecmp: jmp _strncasecmp
    strncmp: jmp _strncmp
    strncpy: jmp _strncpy
    strnlen: jmp _strnlen
    memset: jmp _memset
#else 
    .global my_diff
    _printf: jmp printf
    _malloc: jmp malloc
    _calloc: jmp calloc
    _realloc: jmp realloc
    _free: jmp free
    _fopen: jmp fopen
    _fclose: jmp fclose
    _fgets: jmp fgets
    _fread: jmp fread
    _fprintf: jmp fprintf
    _fscanf: jmp fscanf
    _strcasecmp: jmp strcasecmp
    _strcmp: jmp strcmp
    _strcpy: jmp strcpy
    _strlen: jmp strlen
    _strncasecmp: jmp strncasecmp
    _strncmp: jmp strncmp
    _strncpy: jmp strncpy
    _strnlen: jmp strnlen
    _memset: jmp memset
#endif

.bss
# [unitialized static variables]

.data
# [initialized static variables]

.text
changestring:
    .ascii "%dc%d\n"
    .ascii "< %s\n"
    .ascii "---\n"
    .asciz "> %s\n"
# [constants/strings]

# int my_diff(const char *a, const char *b, bool flag_i, bool flag_B)
_my_diff:
my_diff:
    # Implement me!
    ret
