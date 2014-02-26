; memset_v1_x86 - first version of memset

section .text

global SYM_NAME

SYM_NAME:
	; Create a new stack frame
	push ebp
	mov ebp, esp

	; First, extract each of parameters we've been passed, right to left.
	mov eax, [ebp+8]		; Array address
	mov cl, [ebp+12]		; Value to set
	mov edx, [ebp+16]		; Number of values to write

	; Zero based array so max value to write is edx - 1
	dec edx

memset_loop:
	mov byte [eax+edx], cl
	dec edx
	cmp edx, 0
	jge memset_loop

	; Delete local variables
	mov esp, ebp

	; Restore old stack frame
	pop ebp
	ret