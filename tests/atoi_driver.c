#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int atoi_asm_v1(const char* string);

const char numbers[21][10] = {
	{"0"},
	{"1"},
	{"2"},
	{"3"},
	{"4"},
	{"5"},
	{"6"},
	{"7"},
	{"8"},
	{"9"},
	{"20"},
	{"130"},
	{"9543"},
	{"11"},
	{"-5"},
	{"-432"},
	{"-22"},
	{"afg"},		// this should return error
	{"32876"},
	{"-32876"},
	{"+43"},	
};

#define NUM_STRINGS sizeof(numbers)/10

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
		int value = 0;
		for(; str_index < NUM_STRINGS; ++str_index)
		{
			value = atoi(numbers[str_index]);
			printf("%d, *10 = %d\n", value, value * 10);
		}

	}
	else if( strcmp(argv[1], "v1") == 0 )
	{
		printf("ASM v1 TEST\n");
		int str_index = 0;
		int value = 0;
		for(; str_index < NUM_STRINGS; ++str_index)
		{
			value = atoi_asm_v1(numbers[str_index]);
			printf("%d, *10 = %d\n", value, value * 10);
		}
	}

	return 0;
}
