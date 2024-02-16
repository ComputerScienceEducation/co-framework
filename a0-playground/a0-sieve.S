#ifdef MACOS
    .global _main
    printf: jmp _printf
#else
    .global main
    _printf: jmp printf
#endif

.equ SIZE, 1000

.bss
numbers:
    .skip SIZE                      # space for `numbers` table

.text
int_fmt: 
    .asciz "%d\n"                   # format string for printing an integer and a newline

_main:
main:
    pushq   %rbp                    # save previous base pointer
    movq    %rsp, %rbp              # set base pointer for new stack frame

    movq    $0, %rcx                # init `i` to 0
    leaq    numbers(%rip), %rax     # load address of `numbers`
init_loop:
    cmpq    $SIZE, %rcx              
    jge     after_init_loop         # exit the `for` loop once `i >= SIZE`
    movb    $1, (%rax, %rcx)        # `numbers[i] = 1`
    incq    %rcx                    # `i++`
    jmp     init_loop               # jump to condition check

after_init_loop:
    pushq   $2                      # initialize `current` to 2 (on the stack at rbp - 8)
    subq    $8, %rsp                # keep stack 16-byte aligned
    movq    -8(%rbp), %rcx          # load `current` into rcx

main_loop:
    cmpq    $SIZE, %rcx             # compare `number` to SIZE
    jge     after_main_loop
    leaq    numbers(%rip), %rax     # load address of `numbers`
    cmpb    $1, (%rax, %rcx)        # compare `numbers[current]` to true (1)
    jne     main_loop_end           # jump to `main_loop_end` if `numbers[current] != true`
    leaq    int_fmt(%rip), %rdi     # load the format string as first argument
    movq    %rcx, %rsi              # load `current` as second argument
    movb    $0, %al                 # 0 vector registers used for printf
    call    printf                  # print current number

    movq    -8(%rbp), %rcx          # `multiple = current`
    shlq    $1, %rcx                # `multiple *= 2`
nested_loop:
    cmpq    $SIZE, %rcx             # compare `multiple` with SIZE
    jge     main_loop_end           # jump to `main_loop_end` if `multiple >= SIZE`
    leaq    numbers(%rip), %rax     # load address of `numbers`
    movb    $0, (%rax, %rcx)        # `numbers[multiple] = false`
    addq    -8(%rbp), %rcx          # `multiple += number`
    jmp     nested_loop             # jump to condition check

main_loop_end:
    movq    -8(%rbp), %rcx          # load `number` into rcx
    incq    %rcx                    # increment number
    movq    %rcx, -8(%rbp)          # save incremented `number`
    jmp     main_loop                 

after_main_loop:
    movq    $0, %rax                # return code 0
    movq    %rbp, %rsp              # reset stack pointer (-> reset stack)
    popq    %rbp                    # restore previous base pointer
    ret
