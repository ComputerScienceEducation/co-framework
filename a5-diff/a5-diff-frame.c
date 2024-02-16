#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "my_diff.h"

#define BOOL_TO_STR(b) b ? "true" : "false"

#define INDX_A 1
#define INDX_B 2

#define STR_E "[ERROR]"
#define STR_W "[WARNING]"

int main(int argc, char **argv)
{
	if (argc < 3) {
		fprintf(stderr, "Usage: a5-diff file1 file2 -flags\n");
		return -1;
	}

	int ret = 0;
	int option = -1;

	bool flag_i = false;
	bool flag_B = false;

    FILE *file_a = NULL;
    FILE *file_b = NULL;

    char *str_a = NULL;
	char *str_b = NULL;

	while ((option = getopt(argc - 2, argv + 2, "iB")) != -1) {
		switch (option) {
		case 'i':
			flag_i = true;
			break;
		case 'B':
			flag_B = true;
			break;
		default:
			break;
		}
	}

    /* open files to check existence */
	file_a = fopen(argv[INDX_A], "r");
	if (file_a == NULL) {
		fprintf(stderr, STR_E " could not open file \"%s\".\n", argv[INDX_A]);
		goto err_cleanup;
	}

    file_b = fopen(argv[INDX_B], "r");
	if (file_b == NULL) {
		fprintf(stderr, STR_E " could not open file \"%s\".\n", argv[INDX_B]);
		goto err_cleanup;
	}

    fclose(file_a);
    file_a = NULL;
    fclose(file_b);
    file_b = NULL;

	fprintf(stderr, "calling my_diff(%s, %s, i = %s, B = %s);\n", argv[INDX_A], argv[INDX_B],
		BOOL_TO_STR(flag_i), BOOL_TO_STR(flag_B));

	ret = my_diff(argv[INDX_A], argv[INDX_B], flag_i, flag_B);

cleanup:
    if (file_a)
        fclose(file_a);
    if (file_b)
        fclose(file_b);
	
    free(str_a);
    free(str_b);

	return ret;

err_cleanup:
	ret = -1;
	goto cleanup;
}
