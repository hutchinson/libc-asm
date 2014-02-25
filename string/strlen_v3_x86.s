; strlen_v2_x86.s - second implementation of strlen_v1_x86

section .text

global SYM_NAME

SYM_NAME:
	; Save the current reference frame pointer and create a new one
	push ebp
	mov ebp, esp

; IMPLEMENTATION 3
; 	TODO: Implement using MMX instruction set
; END IMPLEMENTATION 3

	mov esp, ebp
	pop ebp
	ret
	