	AREA RESET,DATA,READONLY
	EXPORT __Vectors
	
__Vectors 
	DCD 0X10010000
	DCD Reset_Handler
	
	ALIGN
	AREA CODE_SEG, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=SRC1
	LDR R1,[R0]
	LDR R0,=SRC2
	LDR R2,[R0]
	SUBS R6,R1,R2
	LDR R0,=RES
	STR R6,[R0]
STOP B STOP
SRC1 DCD 0X741235FA
SRC2 DCD 0XA145ADFC
	AREA DATA_SEG,READWRITE
RES DCD 0
	END