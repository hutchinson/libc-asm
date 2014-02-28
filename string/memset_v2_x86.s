; memset_v2_x86 - a poor man's SIMD =P
; In this approach we try to memset as much in our 4 byte register
; as possible to save on memory acceses.

global SYM_NAME

SYM_NAME:
	; Save and create a new stack frame
	push ebp
	mov ebp, esp

	; Save ebx, we're going to put the double word to apply in there
	push ebx
	; Save the edi register, we're going to put our mask in there
	push edi
	; Save the edi register, it's going to hold the value of MASK & VALUE
	push esi

	xor ebx, ebx
	xor edi, edi
	not edi
	xor esi, esi

	; Get the parameters that have been passed in.
	mov eax, [ebp+8]		; Destination
	mov edx, [ebp+12]		; Value
	mov ecx, [ebp+16]		; Count

	; Set up the double word to apply ontop of each memory location
	mov ebx, edx
	shl ebx, 8
	mov bl, dl
	shl ebx, 8
	mov bl, dl
	shl ebx, 8
	mov bl, dl

	; 128 64 32 16 8 4 2 1
	;		         |   
	; Set up the mask
	; Multiply the count by 8 (Shift right 3) to get number of bits to shift
	shl ecx, 3
	
	; TODO: Find better way to prepare the mask
	cmp cl, 32
	jne not_32
if_32:
	not edi
	jmp end_if_32
not_32:
	shl edi, cl

end_if_32:
	; Move the first 4 bytes into esi
	mov esi, [eax]
	; Zero out the bits we want to set
	and esi, edi

	; Set the esi's zero'd out bits to the destination
	not edi
	and edi, ebx
	or esi, edi

	; Store the result
	mov eax, esi

	; Restore the registers we used.
	pop esi
	pop edi
	pop ebx

	mov esp, ebp
	pop ebp
	ret