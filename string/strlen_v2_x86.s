; strlen_v2_x86.s - second implementation of strlen_v1_x86

section .text

global SYM_NAME

SYM_NAME:
	; Save the current reference frame pointer and create a new one
	push ebp
	mov ebp, esp

	; This uses the scasb which searches for the first occurence of a byte
	; that equals AL starting from EDI, each comparision decrases ECX and
	; increases EDI

	; Save edi
	push edi

	; Load the address of the first byte of the string
	mov eax, [ebp+8]

	; Set ECX to max memory address and EDI to our base
	sub ecx, ecx
	not ecx

	mov edi, [ebp+8]

	; Searching for '\0'
	sub al, al
	
	; Make the call to search till we find al
	cld
	repne scasb

	not ecx
	pop edi

	lea eax, [ecx-1]
	
	; Restore old base frame pointer and return
	mov esp, ebp
	pop ebp
	ret
	