#ifndef _BMP_H
#define _BMP_H

#include <stdio.h>

int bmp_encode(const char *msg, const char *key, FILE *file);
int bmp_decode(char *buf, const char *key, FILE *file);

#endif