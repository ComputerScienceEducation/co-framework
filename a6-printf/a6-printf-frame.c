#include <string.h>
#include <stdio.h>
#include <stdint.h>

#include "my_printf.h"

void test_simple(void) {
    my_printf("Hello, World!\n");
    // Hello World
    my_printf("Good");
    my_printf("");
    my_printf(" Bye");
    my_printf("\n");
    // Good Bye
}

void test_single_formats(void) {

    my_printf("Unsigned Value: %u\n", (uint32_t)95);
    // Unsigned Value: 95
    my_printf("Value: %d\n", (int32_t)42);
    // Value: 42
    my_printf("Negative Value: %d\n", (int32_t)-42);
    // Negative Value: -42
    my_printf("String: %s\n", "Computer Organization");
    // String: Computer Organization
    my_printf("100%% Complete\n");
    // 100% Complete
}

void test_mixed(void) {
    my_printf("You need to collect %u points to get a %d for the %s course.\n", (uint32_t)9750, (int32_t)10, "Computer Organization");
    // You need to collect 9750 points to get a 10 for the Computer Organization course.
    my_printf("%u%% of computers think that %s is a nice language!\n", (uint32_t)99, "Assembly");
    // 99% of computers think that Assembly is a nice language!
    my_printf("%u ECTS (%s) credits correspond to %d hours of work.\n", (uint32_t)6, "European Credit Transfer and Accumulation System", (int32_t)168);
    // 6 ECTS (European Credit Transfer and Accumulation System) credits correspond to 168 hours of work.
}

void test_edge(void) {
    my_printf("Max: %d, Min: %d\n", (int32_t)INT32_MAX, (int32_t)INT32_MIN);
    // Max: 2147483647, Min -2147483648
    my_printf("Overflow: %d, Underflow: %d\n", (int64_t)INT32_MAX + 1, (int64_t)INT32_MIN - 1);
    // Overflow: -2147483648, Underflow: 2147483647
    my_printf("Max Unsigned: %u\n", (uint32_t)UINT32_MAX);
    // Max Unsigned: 4294967295
    my_printf("Overflow Unsigned: %u\n", (uint64_t)UINT32_MAX + 1);
    // Overflow Unsigned: 0
    my_printf("Empty String: %s\n", "");
    // Empty String: 
    my_printf("Raw Format Specifiers: %s\n", "%d %u %s %%");
    // Raw Format Specifiers: %d %u %s %%
    my_printf("Specifier after percentage sign %%d\n");
    // Specifier after percentage sign %d
    my_printf("Float: %f\n");
    // Float: %f
    my_printf("%d", 42);
    // 42
    my_printf("\n");
}

void test_long(void) {
    my_printf("Pioneering computers like %s, %s, and %s were built in %d, %d, and %d, featuring memory sizes of %u KB, %u KB, and %u KB.\n", "ENIAC", "UNIVAC", "IBM 701", (int32_t)1945, (int32_t)1951, (int32_t)1952, (uint32_t)20, (uint32_t)1000, (uint32_t)2048);
    // Pioneering computers like ENIAC, UNIVAC, and IBM 701 were built in 1945, 1951, and 1952, featuring memory sizes of 20 KB, 1000 KB, and 2048 KB.
    my_printf("The x86_64 architecture, also known as %s, was introduced by AMD in %d as an extension to the %u-bit x86, increasing the word size to %u bits and supporting up to %u EB of memory.\n", "AMD64", (int32_t)2000, (uint32_t)32, (uint32_t)64, (uint32_t)16);
    // The x86_64 architecture, also known as AMD64, was introduced by AMD in 2000 as an extension to the 32-bit x86, increasing the word size to 64 bits and supporting up to 16 EB of memory.
}

void test_bonus_width(void) {
    my_printf("|%5d|\n", (int32_t)0);
    my_printf("|%*d|\n", 5, (int32_t)10);
    my_printf("|%5d|\n", (int32_t)-3210);
    my_printf("|%5u|\n", (uint32_t)43210);
    my_printf("|%5d|\n", (int32_t)-43210);
    my_printf("|%5u|\n", (uint32_t)543210);
    my_printf("|%0d|\n", (int32_t)5);
    my_printf("|%5s|\n", "hey");
    my_printf("|%*s|\n", 10, "i'mma break these walls");
}

void test_bonus_minus(void) {
    my_printf("|%-5d|\n", (int32_t)4);
    my_printf("|%-*d|\n", 5, (int32_t)43);
    my_printf("|%-5u|\n", (uint32_t)432100);
    my_printf("|%-5d|\n", (int32_t)-3210);
    my_printf("|%-5u|\n", (uint32_t)43210);
    my_printf("|%-5d|\n", (int32_t)-32100);
    my_printf("|%-5s|\n", "sup?");
    my_printf("|%-*s|\n", 10, "i'mma break these walls again");
}

void test_bonus_plus(void) {
    // plus flag only effective for signed
    my_printf("|%+5d|\n", (int32_t)0);
    my_printf("|%+5d|\n", (int32_t)10);
    my_printf("|%+5d|\n", (int32_t)-10);
    my_printf("|%+5d|\n", (int32_t)3210);
    my_printf("|%+5d|\n", (int32_t)-3210);
    my_printf("|%+5d|\n", (int32_t)43210);
    my_printf("|%+5d|\n", (int32_t)-43210);
}

void test_bonus_space(void) {
    my_printf("|% 3d|\n", (int32_t)1);
    my_printf("|% 3u|\n", (uint32_t)12);
    my_printf("|% 3d|\n", (int32_t)123);
}

void test_bonus_zero(void) {
    my_printf("|%05u|\n", (uint32_t)1);
    my_printf("|%05d|\n", (int32_t)123);
    my_printf("|%05d|\n", (int32_t)12340);
    my_printf("|%05u|\n", (uint32_t)123450);
}

void test_bonus_mixed(void) {
    // plus minus
    my_printf("|%-+5d|\n", (int32_t)0);
    my_printf("|%+-5d|\n", (int32_t)10);
    my_printf("|%-+5d|\n", (int32_t)-10);

    // space minus
    my_printf("|% -5d|\n", (int32_t)1);
    my_printf("|%- 5u|\n", (uint32_t)1);
    my_printf("|% -5d|\n", (int32_t)12);
    my_printf("|%- 5u|\n", (uint32_t)123);
    my_printf("|%- 5d|\n", (int32_t)12345);

    // space plus
    my_printf("|% +5d|\n", (int32_t)12);
    my_printf("|% +5d|\n", (int32_t)123);

    // space plus minus
    my_printf("|%- +5d|\n", (int32_t)12);
    my_printf("|%- +5d|\n", (int32_t)123);
    
    my_printf("|%-05u|\n", (uint32_t)1);
    my_printf("|%+05d|\n", (int32_t)-1);
    my_printf("|%0+5d|\n", (int32_t)1);
    my_printf("|%0+5d|\n", (int32_t)-1010);
    my_printf("|%+05d|\n", (int32_t)1010);

    my_printf("|%0 5d|\n", (int32_t)1);
    my_printf("|% 05u|\n", (uint32_t)10101);
    my_printf("|%0 5d|\n", (int32_t)-10101);
    my_printf("\n");

    my_printf("A single %1s has %u %7s. The value %+0*d is encoded as [%0*u] while %+0*d is simply [%-0*u].\n", "byte", (uint32_t)8, "bits", 4, (int32_t)16, 8, (uint32_t)10000, 4, (int32_t)256, 8, (uint32_t)10000000);
}

void print_usage(void) {
    printf("usage:\n\t./a6-printf-frame [\"all\", \"simple\", \"single\", \"mixed\", \"edge\", \"long\", \"bonus\", \"bonus-width\", \"bonus-minus\", \"bonus-plus\", \"bonus-space\", \"bonus-zero\", \"bonus-mixed\"]\n");
    printf("\t(\"all\" does not include bonus tests)\n");
}

int main(int argc, char *argv[]) {

    if (argc < 2 || strcmp(argv[1], "all") == 0) {
        test_simple();
        my_printf("\n");
        test_single_formats();
        my_printf("\n");
        test_mixed();
        my_printf("\n");
        test_edge();
        my_printf("\n");
        test_long();
    }
    else if (strcmp(argv[1], "bonus") == 0) {
        test_bonus_width();
        my_printf("\n");
        test_bonus_minus();
        my_printf("\n");
        test_bonus_plus();
        my_printf("\n");
        test_bonus_space();
        my_printf("\n");
        test_bonus_zero();
        my_printf("\n");
        test_bonus_mixed();
    }
    else if (argc >= 2) {
        if (strcmp(argv[1], "simple") == 0)
            test_simple();
        else if (strcmp(argv[1], "single") == 0)
            test_single_formats();
        else if (strcmp(argv[1], "mixed") == 0)
            test_mixed();
        else if (strcmp(argv[1], "edge") == 0)
            test_edge();
        else if (strcmp(argv[1], "long") == 0)
            test_long();
        else if (strcmp(argv[1], "bonus-width") == 0)
            test_bonus_width();
        else if (strcmp(argv[1], "bonus-minus") == 0)
            test_bonus_minus();
        else if (strcmp(argv[1], "bonus-plus") == 0)
            test_bonus_plus();
        else if (strcmp(argv[1], "bonus-space") == 0)
            test_bonus_space();
        else if (strcmp(argv[1], "bonus-zero") == 0)
            test_bonus_zero();
        else if (strcmp(argv[1], "bonus-mixed") == 0)
            test_bonus_mixed();
        else 
            print_usage();
    }
    else {
        print_usage();
    }
}