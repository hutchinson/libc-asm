#include <stdio.h>
#include <string.h>

#define ARRAY_SIZE 1024*1024
#define LOOP_TO 42

// dest is the destination memory
// ch should be converted to unsigned char
// count number of bytes to fill
// returns dest
extern void* memset_asm_v1(const void* dest, int ch, size_t count);
extern void* memset_asm_v2(const void* dest, int ch, size_t count);

int main(int argc, char **argv)
{	
	char array[ARRAY_SIZE];

	if( argc != 2 )
	{
		printf("Specify [C | v1]\n");
		return -1;
	} 

	if ( strcmp(argv[1], "C" ) == 0)
	{
		printf("C TEST\n");
		int i = 0;
		for(; i <= LOOP_TO; ++i)
		{
			void *returnVal = memset(array, i, ARRAY_SIZE);

			if(returnVal != array)
			{
				printf("Incorrect return address, sent %p, got %p\n", array, returnVal);
			}
		}

		for(i = 0; i < ARRAY_SIZE; ++i)
		{
			if(array[i] != (char)LOOP_TO)
			{
				printf("Failed to set %d to %d\n", i, LOOP_TO);
			}
		}		
	}
	else if( strcmp(argv[1], "v1") == 0 )
	{
		printf("ASM v1 TEST\n");
		int i = 0;
		for(; i <= LOOP_TO; ++i)
		{
			void *returnVal = memset_asm_v1(array, i, ARRAY_SIZE);
			if(returnVal != array)
			{
				printf("Incorrect return address, sent %p, got %p\n", array, returnVal);
			}
		}

		for(i = 0; i < ARRAY_SIZE; ++i)
		{
			if(array[i] != (char)LOOP_TO)
			{
				printf("Failed to set %d to %d\n", i, LOOP_TO);
			}
		}
	}
	else if( strcmp(argv[1], "v2" ) == 0 )
	{
		printf("ASM v2 TEST\n");

#ifdef DEBUG
		char array1[5] = {'D', 'D', 'D', 'D', '\0'};

		void *returnVal = memset_asm_v2(array1, 'A', 1);
		printf("Bytes: %p %d\n", returnVal, 1);
		printf("Bytes: %p %d %s\n", returnVal, 1, returnVal);

		returnVal = memset_asm_v2(array1, 'A', 2);
		printf("Bytes: %p %d\n", returnVal, 2);
		printf("Bytes: %p %d %s\n", returnVal, 2, returnVal);

		returnVal = memset_asm_v2(array1, 'A', 3);
		printf("Bytes: %p %d\n", returnVal, 3);		
		printf("Bytes: %p %d %s\n",returnVal, 3, returnVal);

		returnVal = memset_asm_v2(array1, 'A', 4);
		printf("Bytes: %p %d\n", returnVal, 4);		
		printf("Bytes: %p %d %s\n", returnVal, 4, returnVal);

		char array2[11] = {'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D', 'D', '\0'};
		returnVal = memset_asm_v2(array2, 'A', 5);
		printf("Bytes: %p %d\n", returnVal, 4);		
		printf("Bytes: %p %d %s\n", returnVal, 4, returnVal);
#endif

		int i = 0;
		for(; i <= LOOP_TO; ++i)
		{
			void *returnVal = memset_asm_v2(array, i, ARRAY_SIZE);
			if(returnVal != array)
			{
				printf("Incorrect return address, sent %p, got %p\n", array, returnVal);
			}
		}

		for(i = 0; i < ARRAY_SIZE; ++i)
		{
			if(array[i] != (char)LOOP_TO)
			{
				printf("Failed to set %d to %d\n", i, LOOP_TO);
			}
		}		
	}
	// else if( strcmp(argv[1], "v3" ) == 0)
	// {
	// 	printf("ASM v3 TEST\n");
	//
	// }
	
	return 0;
}
