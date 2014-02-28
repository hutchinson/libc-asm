#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int atoi_asm_v1(const char* string);

const char numbers[10][2] = {
	{'0', '\0'},
	{'1', '\0'},
	{'2', '\0'},
	{'3', '\0'},
	{'4', '\0'},
	{'5', '\0'},
	{'6', '\0'},
	{'7', '\0'},
	{'8', '\0'},
	{'9', '\0'}
};

int main(int argc, char **argv)
{
	if( argc != 2 )
	{
		printf("Specify [C | v1 | v2 | v3]\n");
		return -1;
	} 

	if ( strcmp(argv[1], "C" ) == 0)
	{
		printf("C TEST\n");
		int str_index = 0;
		for(; str_index < 10; ++str_index)
		{
			printf("%d\n", atoi(numbers[str_index]));
		}

	}
	else if( strcmp(argv[1], "v1") == 0 )
	{
		printf("ASM v1 TEST\n");
		int str_index = 0;
		for(; str_index < 10; ++str_index)
		{
			printf("%d\n", atoi_asm_v1(numbers[str_index]));
		}
	}
	
	return 0;
}
