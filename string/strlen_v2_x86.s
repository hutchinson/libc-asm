; strlen_v2_x86.s - second implementation of strlen_v1_x86

section .text

global SYM_NAME

SYM_NAME:
	; Save the current reference frame pointer and create a new one
	push ebp
	mov ebp, esp

	; Save edi
	push edi

	; Load the address of the first byte of the string
	mov eax, [ebp+8]
	mov ecx, eax

	; This uses the scasb which searches for the first occurence of a byte
	; that equals AL starting from EDI, each comparision decrases ECX and
	; increases EDI

	; Set ECX to max memory address
	sub ecx, ecx
	not ecx

	; Searching for '\0'
	sub al, al
	mov edi, [ebp+8]

	; Make the call
	cld
	repne scasb

	not ecx
	lea eax, [ecx-2]
	
	; Restore old base frame pointer and return
	pop edi
	
	mov esp, ebp
	pop ebp
	ret
	