#include <stdio.h>
#include <mach/clock.h>
#include <mach/mach.h>

const char *str1 = "A C String that We're going to count!";
const char *str2 = "Hello World!";
const char *str3 = "My Name is Dan";

const char *filePath = "/usr/share/dict/words";

extern unsigned long strlen_asm(const char* string);

int main(int argc, char **argv)
{	
	FILE *f = fopen(filePath, "r");
	char line[250];
	unsigned long value = 0;

	if(argc == 2)
	{
		printf("ASM TEST\n");
		while(fgets(line, 250, f) != NULL)
		{
			value += strlen_asm(line);
		}
	}
	else
	{
		printf("C TEST\n");
		while(fgets(line, 250, f) != NULL)
		{
			value += strlen(line);
		}
	}

	/* Prevent the compiler from discarding the value from the function under test
	 */
	printf("Length of all strings %lu\n", value);
	
	return 0;
}
