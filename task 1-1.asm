name "Intro to Emulator 8086"

; this example prints out  "NAME & ID"
; by writing directly to video memory.
; in vga memory: first byte is ascii character, byte that follows is character attribute.
; if you change the second byte, you can change the color of
; the character even after it is printed.
; character attribute is 8 bit value,
; high 4 bits set background color and low 4 bits set foreground color.

; hex    bin        color
; 
; 0      0000      black
; 1      0001      blue
; 2      0010      green
; 3      0011      cyan
; 4      0100      red
; 5      0101      magenta
; 6      0110      brown
; 7      0111      light gray
; 8      1000      dark gray
; 9      1001      light blue
; a      1010      light green
; b      1011      light cyan
; c      1100      light red
; d      1101      light magenta
; e      1110      yellow
; f      1111      white
 


org 100h

; set video mode    
mov ax, 3     ; text mode 80x25, 16 colors, 8 pages (ah=0, al=3)
int 10h       ; do it!

; cancel blinking and enable all 16 colors:
mov ax, 1003h
mov bx, 0
int 10h


; set segment register:
mov     ax, 0b800h
mov     ds, ax

; print "OMAR MOHAMED ARSLAN"
; first byte is ascii code, second byte is color code.

mov [02h], 'O'

mov [04h], 'M'

mov [06h], 'A'

mov [08h], 'R'

mov [0ah], ' '

mov [0ch], 'M'

mov [0eh], 'O'
 
mov [10h], 'H'

mov [12h], 'A'

mov [14h], 'M'

mov [16h], 'E'

mov [18h], 'D'

mov [1Ah], ' '

mov [1Ch], 'A'

mov [1Eh], 'R'

mov [20h], 'S'

mov [22h], 'L'

mov [24h], 'A'

mov [26h], 'N'



; color all characters:
mov cx, 19  ; number of characters.
mov di, 03h ; start from byte after 'h'

c:  mov [di], 11101100b   ; light red(1100) on yellow(1110)
    add di, 2 ; skip over next ascii code in vga memory.
    loop c
    
        
; print "SEAT NO.143"
; first byte is ascii code, second byte is color code.

mov [0a2h], 'S'

mov [0a4h], 'E'

mov [0a6h], 'A'

mov [0a8h], 'T'

mov [0aah], ' '

mov [0ach], 'N'

mov [0aeh], 'O'
 
mov [0b0h], '.'

mov [0b2h], '1'

mov [0b4h], '4'

mov [0b6h], '3'

; color all characters:
mov cx, 11  ; number of characters.
mov di, 0a3h ; start from byte after 'h'

c2:  mov [di], 11101100b   ; light red(1100) on yellow(1110)
    add di, 2 ; skip over next ascii code in vga memory.
    loop c2

; print "ACADEMIC NO.xxxxxx"
; first byte is ascii code, second byte is color code.

mov [0142h], 'A'

mov [0144h], 'C'

mov [0146h], 'A'

mov [0148h], 'D'

mov [014ah], 'E'

mov [014ch], 'M'

mov [014eh], 'I'
 
mov [0150h], 'C'

mov [0152h], ' '

mov [0154h], 'N'

mov [0156h], 'O'

mov [0158h], '.'

mov [015ah], 'x'

mov [015ch], 'x'

mov [015eh], 'x'

mov [0160h], 'x'

mov [0162h], 'x'

mov [0164h], 'x'



; color all characters:
mov cx, 18  ; number of characters.
mov di, 0143h ; start from byte after 'h'

c3:  mov [di], 11101100b   ; light red(1100) on yellow(1110)
    add di, 2 ; skip over next ascii code in vga memory.
    loop c3   

; wait for any key press:
mov ah, 0
int 16h

ret

