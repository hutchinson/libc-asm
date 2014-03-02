; atoi_v1_asm.s - Anything to integer

; ASCII codes for minus, 0 and 9
%define ASCII_MINUS 45
%define ASCII_PLUS 43
%define ASCII_ZERO 48
%define ASCII_NINE 58

global SYM_NAME

SYM_NAME:
	push ebp
	mov ebp, esp

	; ecx will contain the address of the string
	; ebx will contain the power of 10
	; eax will contain the value
	; edi will contain a 'strach' area

nav_to_start:
	; Step 1, we need to find the start of the string, here we know
	; 10^0.
	; Use scasb for this...
	; edi is compared to al and ecx is decremented each time.
	push edi
	mov edi, [ebp+8]

	; ecx is the max count, i.e. where to stop (which is 2^32)
	xor ecx, ecx
	not ecx

	; al is compared, so set to 0
	xor al, al

	cld
	repne scasb

	; TODO: clean this up.
	; ecx has been decremented each time through the loop, so now we're
	; one past the end of the array so figure out the offset from the
	; start of the array.
	not ecx
	lea ecx, [ecx-2]

	mov edi, [ebp+8]
	add edi, ecx
	mov ecx, edi

	; Save ebx (our pow 10, and 0 out the variables)
	push ebx
	mov ebx, 1

	xor eax, eax
atoi_loop:
	mov edi, [ecx]
	and edi, 0x000000FF

	; Conditions
	; 1). is edi == '-'
	cmp edi, ASCII_MINUS
	je is_minus

	; 2). is edi == '+'
	cmp edi, ASCII_PLUS
	je finish

	; 3). < 48
	cmp edi, ASCII_ZERO
	jl on_error

	; 4). > 58
	cmp edi, ASCII_NINE
	jg on_error

	; Normalise the value
	sub edi, ASCII_ZERO
	; Increase to approrpiate power
	imul edi, ebx
	; Increment the power
	imul ebx, 10
	add eax, edi

	dec ecx
	cmp ecx, [ebp+8]
	jge atoi_loop
	jmp finish

on_error:
	mov eax, -1
	jmp finish

is_minus:
	neg eax
	jmp finish
	
finish:
	pop ebx
	pop edi
	pop ebp

	ret