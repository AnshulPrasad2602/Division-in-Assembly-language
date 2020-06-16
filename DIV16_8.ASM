mess macro msg
mov ah, 09h
LEA dx, msg
int 21h
endm

.model small

.data
msg1 db 0Ah,0dh, "Enter the 16 bit numerator : "
msg2 db 0Ah,0dh, "Enter the 8 bit denominator : $"
msg3 db 0Ah,0dh, "Quotient is : $"
msg4 db 0Ah,0dh, "Remainder is : $"

.code

mov ax,@data
mov ds,ax

mess msg1

call accept
ror al,04h
mov bl,al

call accept
add bl,al

mov ch, bl

call accept
ror al,04h
mov bl,al

call accept
add bl,al

mov cl, bl

mess msg2

call accept
ror al,04h
mov bl,al

call accept
add bl,al


mov ax, cx

div bl

mov bh,ah
mov ch,al

mess msg3

mov bl,ch

ror bl,04h
call disp

ror bl,04h
call disp

mess msg4

mov bl,bh

ror bl,04h
call disp

ror bl,04h
call disp

mov ah,4ch
int 21h

accept proc near

mov ah,01h
int 21h
cmp al,3ah
jc down1
sub al,07h
down1 : and al,0fh

ret
endp


disp proc near

mov cl,bl
and cl,0fh
cmp cl,0ah
jc down3
add cl,07h
down3 : add cl,30h
        mov dl,cl

mov ah,02h
int 21h

ret
endp

end
