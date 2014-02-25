; strlen_v1_x86.s - first implementation of strlen_v1_x86

section .text

global SYM_NAME

SYM_NAME:
	; Save the current reference frame pointer and create a new one
	push ebp
	mov ebp, esp

	; Load the address of the first byte of the string
	mov eax, [ebp+8]
	mov ecx, eax

again:
	mov dl, [eax]
	inc eax
	cmp dl, 0
	jne again

	; Calculate the length of the string
	dec eax
	sub eax, ecx

	; Restore old base frame pointer and return
	mov esp, ebp
	pop ebp
	ret
	