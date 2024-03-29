; STANDARD HEADER FILE
	PROCESSOR		16F876A
;---REGISTER FILES 선언 ---
;  BANK 0
INDF	 EQU	00H
TMR0	 EQU	01H
PCL	 EQU	02H
STATUS	 EQU	03H
FSR	 EQU	04H	
PORTA	 EQU	05H
PORTB	 EQU	06H
PORTC	 EQU	07H
EEDATA	 EQU	08H
EEADR	 EQU	09H
PCLATH	 EQU	0AH
INTCON	 EQU	0BH
; BANK 1
OPTINOR	 EQU	81H
TRISA	 EQU	85H
TRISB	 EQU	86H
TRISC	 EQU	87H
EECON1	 EQU	88H
EECON2	 EQU	89H
ADCON1	 EQU	9FH
;---STATUS BITS 선언---
IRP	 EQU	7
RP1	 EQU	6
RP0	 EQU	5
NOT_TO 	 EQU	4
NOT_PD 	 EQU	3
ZF 	 EQU	2 ;ZERO FLAG BIT
DC 	 EQU	1 ;DIGIT CARRY/BORROW BIT
CF 	 EQU	0 ;CARRY BORROW FLAG BIT

; -- INTCON BITS 선언 --
; -- OPTION BITS 선언 --

W 	 EQU	B'0' ; W 변수를 0으로 선언
F 	 EQU	.1   ; F 변수를 1로 선언

; --USER
LED1	 EQU 	20H
DBUF1	 EQU  	21H
DBUF2	 EQU	22H
LED2	 EQU	23H

;MAIN PROBRAM

	ORG	0000
	BSF 	STATUS,RP0 ; BANK를 1로 변경함
	MOVLW	B'00000000'; 
	MOVWF	TRISA
	MOVWF	TRISC	 ; PORTA와C를 모두 OUTPUT설정
	MOVWF	ADCON1
	BCF	STATUS,RP0 ; BANK를 0으로 변경
LOOP3	CLRF	PORTA
	MOVLW	01
	ADDLW	00	 ; CF를 0으로 만듬
	MOVWF	LED1	 ; 초기값 01을 넣음
	MOVWF	LED2	 ; 초기값 01을 넣음
LOOP	MOVF 	LED1,W	
;	XORLW	B'11111111'; NOT시킴
	MOVWF	PORTC	 ; W 를 PORTC에 출력
	RLF	LED1,F	 ; rotate 시킴
	CALL	DELAY
	BTFSS	LED1,8
	GOTO	LOOP
LOOP2	MOVF 	LED2,W
	MOVWF	PORTA 	 ; W 를 PORTA에 출력
	RLF	LED2,F 
	CALL	DELAY
	BTFSS	LED2,4
	GOTO	LOOP2
	GOTO 	LOOP3
	
; SUBROUTINE
DELAY
	MOVLW	.125
	MOVWF	DBUF1	 ; 125번을 확인하기 위한 변수
LP1	MOVLW	.200
	MOVWF	DBUF2	 ; 200번을 확인하기 위한 변수
LP2	NOP
	DECFSZ	DBUF2,F
	GOTO	LP2
	DECFSZ	DBUF1,F	 ; 변수를 감소시켜 00이 되었나 확인
	GOTO	LP1	 ; ZERO가 아니면 여기에 들어옴
	RETURN
	
	END