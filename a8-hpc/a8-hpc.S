#ifdef MACOS
    .global _main
    printf: jmp _printf
    malloc: jmp _malloc
    calloc: jmp _calloc
    realloc: jmp _realloc
    free: jmp _free
    clock_gettime: jmp _clock_gettime
#else 
    .global main
    _printf: jmp printf
    _malloc: jmp malloc
    _calloc: jmp calloc
    _realloc: jmp realloc
    _free: jmp free
    _clock_gettime: jmp clock_gettime
#endif

#ifndef STREAM_ARRAY_SIZE
    #define STREAM_ARRAY_SIZE 75000000
#endif

#ifndef NTIMES
    #define NTIMES 20
#endif

# Use custom values:        $ make a8-hpc/a8-hpc -B STREAM_ARRAY_SIZE=<custom_size> NTIMES=<custom_reps>
# Revert to default values: $ make a8-hpc/a8-hpc -B

.bss
# [unitialized static variables]

.data
# [initialized static variables]

.text
# Strings for formatted output:
fmt_info: 
    .asciz "Array size = %lu (elements).\nEach kernel will be executed %u times.\n"
    # printf(fmt_info, STREAM_ARRAY_SIZE, NTIMES)
fmt_div: 
    .asciz "-------------------------------------------------------------\n"
fmt_title: 
    .asciz "%-8s  %13s  %11s  %11s  %11s\n"
    # printf(fmt_title, col_title_function, ...)
fmt_row: 
    .asciz "%-10s  %12.1f  %11.6f  %11.6f  %11.6f\n"
    # printf(fmt_row, row_title_copy, 13029.0, ...)
col_title_function: .asciz "Function"
col_title_rate: .asciz "Best Rate MB/s"
col_title_avg: .asciz "Avg time"
col_title_min: .asciz "Min time"
col_title_max: .asciz "Max time"
row_title_copy: .asciz "Copy:"
row_title_scale: .asciz "Scale:"
row_title_add: .asciz "Add:"
row_title_triad: .asciz "Triad:"

_main:
main:
    # Implement me!
    ret