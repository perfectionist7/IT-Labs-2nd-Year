disp macro num
	     mov dx,num
	     and dx,0f0h
	     mov cl,04h
	     shr dx,cl
	     add dl,30h
	     mov ah,02h
	     int 21h

	     mov dx,num
	     and dx,0fh
	     add dl,30h
	     mov ah,02h
	     int 21h

	     mov dl,10
	     mov ah,02h
	     int 21h
endm

data segment
	conv dw 0h
data ends

code segment
	        assume cs:code,ds:data
	start:  
	        mov    ax,data
	        mov    ds,ax
	        mov    ax,0h
	        mov    bx,0h
	        dec    bx
	        call   upc

	        mov    ah,4ch
	        int    21h

delay proc
	        push   si
	        push   di
	        mov    si,0013h
	up:     
	        mov    di,0ffffh
	up1:    
	        dec    di
	        jnz    up1
	        dec    si
	        jnz    up
	        pop    di
	        pop    si
	        ret
delay endp

convert proc
	        push   bx
	        mov    cx,0h
	        mov    ax,bx
	L1:     
	        mov    bh,0h
	        mov    bl,0ah
	        div    bl
	        cmp    al,bl
	        mov    dx,0h
	        mov    dl,ah
	        push   dx
	        inc    cx
	        mov    ah,0h
	        JAE    L1
	        mov    dx,0h
	        mov    dl,al
	        push   dx
	        inc    cx
	back1:  
	        mov    bx,cx
	        pop    dx
	        mov    cl,04h
	        shl    conv,cl
	        add    conv,dx
	        mov    cx,bx
	        loop   back1
	        pop    bx
	        ret
convert endp

downc proc
	        dec    bl
	        mov    cx,bx
	back:   
	        mov    conv,0h
	        push   cx
	        call   convert
	        disp   conv
	        dec    bl
	        call   delay
	        pop    cx
	        MOV    DL,0FFH
	        MOV    AH,06
	        INT    21H
	        JNZ    DOWN
	        jmp    l0
	DOWN:   
	        CMP    AL,13 ; multi counter
	        Jz     l0
	        cmp    al,30h
	        jne    exit
	        inc    bl
	        call   upc
	l0:     
	        loop   back

	exit:   
	        mov    ah,4ch
	        int    21h
	        ret
downc endp

upc proc
	        inc    bx
	        mov    cx,64h
	        sub    cx,bx
	        inc    bx
	back0:  
	        mov    conv,0h
	        push   cx
	        call   convert
	        disp   conv
	        inc    bl
	        call   delay
	        pop    cx
	        MOV    DL,0FFH
	        MOV    AH,06
	        INT    21H
	        JNZ    DOWN0
	        jmp    l
	DOWN0:  
	        CMP    AL,13
	        JZ     l
	        cmp    al,30h
	        jne    exit0
	        dec    bl
	        call   downc
	l:      
	        loop   back0

	exit0:  
	        mov    ah,4ch
	        int    21h
	        ret
upc endp

code ends
end start