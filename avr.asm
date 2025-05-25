.include"m328pbdef.inc"

.org 0x00 ;dyrektywa org nie jest konieczna

rjmp prog_start ;skok do programu głównego

seven_segment: .DB 0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x6f, 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71

prog_start:
    ldi R16, 0xff
    out DDRD, R16
    OUT PORTD, R16
    ldi R16, 0x0f
    out DDRB, R16
    OUT PORTB, R16
    ldi r16, 0b00001110
    out portb, r16
    ldi R28, 0
    ldi R29, 0
    ldi r16, 1
    mov r1, r16
    ldi r16, 0
    mov r0, r16
LOOP:
    ldi r20, 50
LOOP5:
    ldi r16, 0b00000111
    out portb, r16
    mov r16, r28
    andi r16, 0x0f
    rcall bcd_to_sevent_seg
    com R16
    out portd, r16
    rcall delay_10ms

    ldi r16, 0b00001011
    out portb, r16
    mov r16, r28
    swap r16
    andi r16, 0x0f
    rcall bcd_to_sevent_seg
    com R16
    out portd, r16
    rcall delay_10ms

    ldi r16, 0b00001101
    out portb, r16
    mov r16, r29
    andi r16, 0x0f
    rcall bcd_to_sevent_seg
    com R16
    out portd, r16
    rcall delay_10ms

    ldi r16, 0b00001110
    out portb, r16
    mov r16, r29
    swap r16
    andi r16, 0x0f
    rcall bcd_to_sevent_seg
    com R16
    out portd, r16
    rcall delay_10ms
    dec r20
    brne LOOP5
    clc
    add r28, r1
    adc r29, r0
JMP LOOP

; r16
bcd_to_sevent_seg:
    ldi r31, high(2 * seven_segment)
    ldi r30, low(2 * seven_segment)
    add r30, r16

    lpm r16, Z

    ret

delay_1s:
    push r18
    push r19
    push r20
    ldi  r18, 82
    ldi  r19, 43
    ldi  r20, 0
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    lpm
    nop
    pop r20
    pop r19
    pop r18
    ret

delay_10ms:
    push r18
    push r19
    push r20
    ldi  r18, 104
    ldi  r19, 229
L2: dec  r19
    brne L2
    dec  r18
    brne L2
    pop r20
    pop r19
    pop r18
    ret