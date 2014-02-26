; strlen_v3_x86.s - third implementation of strlen_v1_x86

section .text

global SYM_NAME

SYM_NAME:
	; Save the current reference frame pointer and create a new one
	push ebp
	mov ebp, esp

	; Store pointer to the base of the string
	mov edx, [ebp+8]

	; XOR xmm0 with itself == 0
	pxor xmm0, xmm0
	mov eax, -16

again:
	add eax, 16

	; SSE4.2 pcmpistri format:
	; 
	; Great reference at:
	; http://www.strchr.com/strcmp_and_strlen_using_sse_4.2
	;
	; pcmpistri <reg> <arg1> <arg2>
	; 	reg - any xmm register
	; 	arg1 - xmm register or memory
	;	arg2 - 8-bit control value
	;
	;	arg2 = [0-1] = 00 - Source is unisgned bytes
	;		   [3:2] = 10 - Each Each Aggregation
	;		   [5:4] = 00 - Positive Polarity
	;		   [6] = ECX will contain the least significat bit
	pcmpistri xmm0, [edx + eax], 00001000b
	jnz again

	; ecx contains the offset from edx+eax where first null was
	; found
	add eax, ecx

	pop ebp
	ret
	
