mess macro msg
mov ah, 09h
LEA dx, msg
int 21h
endm

.model small

.data
n1 dw 0000h												;declaring user define varialbes
n2 dw 0000h												
n3 dw 0000h
msg1 db 0Ah,0dh, "Enter the 32 bit numerator : $"		;storing string in data segment
msg2 db 0Ah,0dh, "Enter the 16 bit denominator : $"
msg3 db 0Ah,0dh, "Quotient is : $"
msg4 db 0Ah,0dh, "Remainder is : $"

.code													;starting of the code

mov ax,@data
mov ds,ax

mess msg1												;printing msg1

call accept												;accepting a single digit
ror al,04h												;rotating the it by 4 bit
mov bl,al												;moving single digit to bl

call accept												;accepting a single digit
add bl,al												;adding content to bl with new al to make 2 digit no.

mov ch, bl												;moving content of bl to ch

call accept												;accepting next 2 digit in cl
ror al,04h
mov bl,al

call accept
add bl,al

mov cl, bl

mov n1,cx												;saving the higher bit of 32bit in n1

call accept												;accepting next 2 digit in ch
ror al,04h
mov bl,al

call accept
add bl,al

mov ch, bl

call accept												;accepting next 2 digit in cl
ror al,04h
mov bl,al

call accept
add bl,al

mov cl, bl

mov n2,cx												;saving the lower bit of 32bit in n2, numerator saved

mess msg2												;displayig msg2

call accept												;accepting next 2 digit in ch
ror al,04h
mov bl,al

call accept
add bl,al

mov ch, bl

call accept												;accepting next 2 digit in cl
ror al,04h
mov bl,al

call accept
add bl,al

mov cl, bl

mov n3,cx												;moving denominator in n3

mov dx,n1												;higher bit of 32bit storing in dx
mov ax,n2												;lower bit of 32bit storing in ax, prerequisite for division

div n3													;division will take place (dx:ax)/n3

mov n1,ax												;qutiont stored in ax and moved to n1
mov n2,dx												;reminder stored in dx and moved to n2

mess msg3												;displayig msg3

mov cx,n1												;moving qutiont to cx

mov bl,ch

ror bl,04h												;rotating by 4 bit so tens place will be in ones
call disp												;displaying 1 digit

ror bl,04h												;rotating bl by 4bit to again get original value
call disp												;displaying another digit

mov cx,n1												;again moving cx to n1 as cl is changing during diaplay

mov bl,cl												;displaying lower bit of cx

ror bl,04h
call disp

ror bl,04h
call disp

mess msg4												;displaying msg4

mov cx,n2												;moving reminder to cx

mov bl,ch												;displaying higher bits of cx

ror bl,04h
call disp

ror bl,04h
call disp

mov cx,n2												;again moving cx to n2 as cl is changing during diaplay

mov bl,cl

ror bl,04h
call disp

ror bl,04h
call disp

mov ah,4ch												;end of the program
int 21h

accept proc near

mov ah,01h												;instruction to input a single key press and storing hexa ascii in al
int 21h
cmp al,3ah												;comparing with 3ah to determine alpha or number 
jc down1
sub al,07h												;if alpha sub with 07h
down1 : and al,0fh										;then/else and with 0fh to get actual value not hexa ascii 

ret
endp


disp proc near

mov cl,bl												;moving bl to cl
and cl,0fh												;to get the units place
cmp cl,0ah												;comparing eith 0ah to determine no. or alpha
jc down3
add cl,07h												;if alpha add 07h
down3 : add cl,30h										;else/then add 30h to get hexa ascii
        mov dl,cl										;moving cl to dl: prerequisite for diaplay

mov ah,02h												;instruction to print content of dl
int 21h

ret
endp

end
