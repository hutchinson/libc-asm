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
	; Save the esi register, it's going to hold the value of MASK & VALUE
	push esi

	xor ebx, ebx

	xor edi, edi
	not edi

	xor esi, esi

	; Get the parameters that have been passed in.
	mov eax, [ebp+8]		; Destination
	mov edx, [ebp+12]		; Value
	mov ecx, [ebp+16]		; Count

	; Use ebp too, keeping stuff in the registers rather than having to
	; visit memory, not safe to reference caller's parameters via ebp from
	; here on!!!
	; ebp will store our current offset.
	push ebp
	xor ebp, ebp
	sub ebp, 4

	; Set up the double word to apply ontop of each memory location
	mov ebx, edx
	shl ebx, 8
	mov bl, dl
	shl ebx, 8
	mov bl, dl
	shl ebx, 8
	mov bl, dl

	; Load the next word to modify
	; Determine how much of the word needs to be set (This can be
	; optimised later for the double word aligned case)
	; Set up the mask
	; Set the bits
	; Push to memory
	; repeat while count not 0.
memset_loop:
	; Increment our offset
	add ebp, 4
	; Move 4 bytes into esi
	mov esi, [eax+ebp]

	; Set up the mask
	xor edi, edi

	; Determine the number of bytes we need to set.
	cmp ecx, 4
	jl if_count_less4

if_count_gt4:
	; We want to set everything
	xor esi, esi
	or esi, ebx
	jmp end_if_count4
if_count_less4:
	not edi
	; Multiply by 8
	shl ecx, 3
	; Mask
	shl edi, cl
	; Divide
	shr ecx, 3
	; Zero out the bits we want to set
	and esi, edi
	; Set the esi's zero'd out bits to the destination
	not edi
	and edi, ebx
	or esi, edi	
end_if_count4:

	; Shift the data back into memory
	mov [eax+ebp], esi
	
	; Decrement the count
	sub ecx, 4
	cmp ecx, 0
	jg memset_loop

	; Restore the registers we used.
	pop ebp
	pop esi
	pop edi
	pop ebx

	mov esp, ebp
	pop ebp
	ret