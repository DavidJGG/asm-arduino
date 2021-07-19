;.286
;stack segment
spila segment stack
	DB 32 DUP ('stack___')
spila ends

; data segment
sdatos segment 
       
	salir db "Adios$",00h
	numStr db 10 dup("$")
	saltoLinea db 0Ah,0Dh,"$"
	numero dw -5
	recibidoA db "recibido R", 0Ah, 0Dh, "$"
	recibidoB db "recibido display", 0Ah, 0Dh, "$"
	debug db 2 dup ('$')
	str db 50 dup("$")
	letraRecibida db 2 dup('$')

sdatos ends


scodigo segment 'CODE'
    
	ASSUME SS:spila, DS:sdatos, CS:scodigo         
	
	imprimir macro param 
		mov ah, 09
		lea dx, param
		int 21h
	endm

	enviar macro caracter
		mov dx, 3F8h
		mov al, caracter
		out dx, al
	endm

	ESCUCHAR proc 
	recibir:
		mov dx, 3FDh ;3FD -> se verifica el puerto
		in al, dx
		test al, 00000001b  ;Es un AND para validad que hay datos
		jz noHayDatos

		mov dx, 3F8h ;3F8 -> tiene el dato
		in al, dx
		cmp al, '-'
		je fin
		mov letraRecibida, al
		imprimir letraRecibida	

		noHayDatos:	
		jmp recibir
		
		fin:
		imprimir saltoLinea	
	ret
	ESCUCHAR endp


	main proc far 
	    
	    push ds
		mov ax,0
		push ax
		mov ax,sdatos
		mov ds,ax

		; xor ax, ax
		; mov al, 11100011b
		; mov dx, 00h
		; int 14h

		menu:
			xor ax, ax
			xor bx, bx
			xor dx, dx
			xor cx, cx
			pedirletra:
				mov ah, 01h
				int 21h
				enviar al
				cmp al, 0Dh
				je respuesta
			jmp pedirletra
			
			respuesta:
				call ESCUCHAR
			
			jmp menu

		ret
    main endp
	
scodigo ends
end main
