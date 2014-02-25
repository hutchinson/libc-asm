#include <stdio.h>
#include <mach/clock.h>
#include <mach/mach.h>

const char *str1 = "A C String that We're going to count!";
const char *str2 = "Hello World!";
const char *str3 = "My Name is Dan";

const char *filePath = "/usr/share/dict/words";

extern unsigned long strlen_asm_v1(const char* string);
extern unsigned long strlen_asm_v2(const char* string);
extern unsigned long strlen_asm_v3(const char* string);

int main(int argc, char **argv)
{	
	FILE *f = fopen(filePath, "r");
	char line[250];
	unsigned long value = 0;

	if( argc != 2)
		return -1;

	if ( strcmp(argv[1], "C" ) == 0)
	{
		printf("C TEST\n");
		while(fgets(line, 250, f) != NULL)
		{
			value += strlen(line);
		}		
	}
	else if( strcmp(argv[1], "v1") == 0 )
	{
		printf("ASM v1 TEST\n");
		while(fgets(line, 250, f) != NULL)
		{
			value += strlen_asm_v1(line);
		}
	}
	else if( strcmp(argv[1], "v2" ) == 0 )
	{
		printf("ASM v2 TEST\n");
		while(fgets(line, 250, f) != NULL)
		{
			value += strlen_asm_v2(line);
		}
	}
	else if( strcmp(argv[1], "v3" ) == 0)
	{
		printf("ASM v3 TEST\n");
		while(fgets(line, 250, f) != NULL)
		{
			value += strlen_asm_v3(line);
		}
	}

	/* Prevent the compiler from discarding the value from the function under test
	 */
	printf("Length of all strings %lu\n", value);
	
	return 0;
}
