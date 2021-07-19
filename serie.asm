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

	imprimir_num8 macro num
		xor bx, bx
		mov bl, num
		mov numero, bx
		call MOSTRAR_NUMERO
		imprimir saltoLinea
	endm

	imprimir_num16 macro num
		xor bx, bx
		mov bx, num
		mov numero, bx
		call MOSTRAR_NUMERO
		imprimir saltoLinea
	endm

	MOSTRAR_NUMERO proc
		xor ax, ax
		xor dx, dx
		xor bx, bx
		xor cx, cx

		lea si, numStr		
		mov ax, numero
		shl ax, 1
		jnc positivo
			mov [si], '-'
			inc si
			neg numero
		positivo:
		ciclo1:
			cmp numero, 10d
			jl fin_ciclo1
			xor ax, ax
			xor dx, dx
			mov ax, numero
			mov bx, 10d
			div bx
			push dx
			mov numero, ax
			inc cx
			jmp ciclo1
		fin_ciclo1:
			mov ax, numero
			add ax, 30h
			mov [si], al
			inc si

		ciclo2:
			cmp cx, 0
			je fin_ciclo2
			pop dx
			add dx, 30h
			mov [si], dl
			inc si
			dec cx
			jmp ciclo2
		fin_ciclo2:

		imprimir numStr

		mov si, offset numStr
		mov [si], '$'
		mov [si+1], '$'
		mov [si+2], '$'
		mov [si+3], '$'
		mov [si+4], '$'
		mov [si+5], '$'

		ret
	MOSTRAR_NUMERO endp
	

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

		;ESCRITURA
		;========================================================	
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


;
;   mov <mem, reg>, <mem, reg, imediato>
;   mov mem, mem
;
;
;  Abrir archivo
;  Cerrar archivo
;  Leer archivo
;  Escribir archivo
;  Conversion numeros
;  Negativos
;