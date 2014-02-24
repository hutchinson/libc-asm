; strlen_asm.asm is an implementation of strlen.

section .text

global _strlen_asm

_strlen_asm:
	; Save the current reference frame pointer and create a new one
	push ebp
	mov ebp, esp

	; Save edi
	push edi

; IMPLEMENTATION 1
;	; Load the address of the first byte of the string
;	mov eax, [ebp+8]
;	mov ecx, eax
;
;again:
;	mov dl, [eax]
;	inc eax
;	cmp dl, 0
;	jne again
;
;	; Calculate the length of the string
;	dec eax
;	sub eax, ecx
; END IMPLEMENTATION 1

; IMPLEMENTATION 2
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
; END IMPLEMENTATION 2

; IMPLEMENTATION 3
; TODO: Implement using MMX instruction set
; END IMPLEMENTATION 3

	; Restore old base frame pointer and return
	pop edi
	mov esp, ebp
	pop ebp
	ret	