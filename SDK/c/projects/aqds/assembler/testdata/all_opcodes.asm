    org $1000

    ADC A,(HL)
    ADC A,(IX+$42)
    ADC A,(IY+$42)
    ADC A,A
    ADC A,B
    ADC A,C
    ADC A,D
    ADC A,E
    ADC A,H
    ADC A,IXh
    ADC A,IXl
    ADC A,IYh
    ADC A,IYl
    ADC A,L
    ADC A,$42
    ADC HL,BC
    ADC HL,DE
    ADC HL,HL
    ADC HL,SP
    ADD A,(HL)
    ADD A,(IX+$42)
    ADD A,(IY+$42)
    ADD A,A
    ADD A,B
    ADD A,C
    ADD A,D
    ADD A,E
    ADD A,H
    ADD A,IXh
    ADD A,IXl
    ADD A,IYh
    ADD A,IYl
    ADD A,L
    ADD A,$42
    ADD HL,BC
    ADD HL,DE
    ADD HL,HL
    ADD HL,SP
    ADD IX,BC
    ADD IX,DE
    ADD IX,IX
    ADD IX,SP
    ADD IY,BC
    ADD IY,DE
    ADD IY,IY
    ADD IY,SP
    AND (HL)
    AND (IX+$42)
    AND (IY+$42)
    AND A
    AND B
    AND C
    AND D
    AND E
    AND H
    AND IXh
    AND IXl
    AND IYh
    AND IYl
    AND L
    AND $42
    BIT 0,(HL)
    BIT 0,(IX+$42)
    BIT 0,(IY+$42)
    BIT 0,A
    BIT 0,B
    BIT 0,C
    BIT 0,D
    BIT 0,E
    BIT 0,H
    BIT 0,L
    BIT 1,(HL)
    BIT 1,(IX+$42)
    BIT 1,(IY+$42)
    BIT 1,A
    BIT 1,B
    BIT 1,C
    BIT 1,D
    BIT 1,E
    BIT 1,H
    BIT 1,L
    BIT 2,(HL)
    BIT 2,(IX+$42)
    BIT 2,(IY+$42)
    BIT 2,A
    BIT 2,B
    BIT 2,C
    BIT 2,D
    BIT 2,E
    BIT 2,H
    BIT 2,L
    BIT 3,(HL)
    BIT 3,(IX+$42)
    BIT 3,(IY+$42)
    BIT 3,A
    BIT 3,B
    BIT 3,C
    BIT 3,D
    BIT 3,E
    BIT 3,H
    BIT 3,L
    BIT 4,(HL)
    BIT 4,(IX+$42)
    BIT 4,(IY+$42)
    BIT 4,A
    BIT 4,B
    BIT 4,C
    BIT 4,D
    BIT 4,E
    BIT 4,H
    BIT 4,L
    BIT 5,(HL)
    BIT 5,(IX+$42)
    BIT 5,(IY+$42)
    BIT 5,A
    BIT 5,B
    BIT 5,C
    BIT 5,D
    BIT 5,E
    BIT 5,H
    BIT 5,L
    BIT 6,(HL)
    BIT 6,(IX+$42)
    BIT 6,(IY+$42)
    BIT 6,A
    BIT 6,B
    BIT 6,C
    BIT 6,D
    BIT 6,E
    BIT 6,H
    BIT 6,L
    BIT 7,(HL)
    BIT 7,(IX+$42)
    BIT 7,(IY+$42)
    BIT 7,A
    BIT 7,B
    BIT 7,C
    BIT 7,D
    BIT 7,E
    BIT 7,H
    BIT 7,L
    CALL nn
    CALL C,nn
    CALL M,nn
    CALL NC,nn
    CALL NZ,nn
    CALL P,nn
    CALL PE,nn
    CALL PO,nn
    CALL Z,nn
    CCF
    CP (HL)
    CP (IX+$42)
    CP (IY+$42)
    CP A
    CP B
    CP C
    CP D
    CP E
    CP H
    CP IXh
    CP IXl
    CP IYh
    CP IYl
    CP L
    CP $42
    CPD
    CPDR
    CPI
    CPIR
    CPL
    DAA
    DEC (HL)
    DEC (IX+$42)
    DEC (IY+$42)
    DEC A
    DEC B
    DEC BC
    DEC C
    DEC D
    DEC DE
    DEC E
    DEC H
    DEC HL
    DEC IX
    DEC IXh
    DEC IXl
    DEC IY
    DEC IYh
    DEC IYl
    DEC L
    DEC SP
    DI
.1: DJNZ .1
    EI
    EX (SP),HL
    EX (SP),IX
    EX (SP),IY
    EX AF,AF'
    EX DE,HL
    EXX
    HALT
    IM 0
    IM 1
    IM 2
    IN A,(C)
    IN A,($42)
    IN B,(C)
    IN C,(C)
    IN D,(C)
    IN E,(C)
    IN F,(C)
    IN H,(C)
    IN L,(C)
    INC (HL)
    INC (IX+$42)
    INC (IY+$42)
    INC A
    INC B
    INC BC
    INC C
    INC D
    INC DE
    INC E
    INC H
    INC HL
    INC IX
    INC IXh
    INC IXl
    INC IY
    INC IYh
    INC IYl
    INC L
    INC SP
    IND
    INDR
    INI
    INIR
    JP (HL)
    JP (IX)
    JP (IY)
    JP nn
    JP C,nn
    JP M,nn
    JP NC,nn
    JP NZ,nn
    JP P,nn
    JP PE,nn
    JP PO,nn
    JP Z,nn
.2: JR .2
.3: JR C,.3
.4: JR NC,.4
.5: JR NZ,.5
.6: JR Z,.6
    LD (BC),A
    LD (DE),A
    LD (HL),A
    LD (HL),B
    LD (HL),C
    LD (HL),D
    LD (HL),E
    LD (HL),H
    LD (HL),L
    LD (HL),$42
    LD (IX+$42),A
    LD (IX+$42),B
    LD (IX+$42),C
    LD (IX+$42),D
    LD (IX+$42),E
    LD (IX+$42),H
    LD (IX+$42),L
    LD (IX+$42),$42
    LD (IY+$42),A
    LD (IY+$42),B
    LD (IY+$42),C
    LD (IY+$42),D
    LD (IY+$42),E
    LD (IY+$42),H
    LD (IY+$42),L
    LD (IY+$42),$42
    LD (nn),A
    LD (nn),BC
    LD (nn),DE
    LD (nn),HL
    LD (nn),IX
    LD (nn),IY
    LD (nn),SP
    LD A,(BC)
    LD A,(DE)
    LD A,(HL)
    LD A,(IX+$42)
    LD A,(IY+$42)
    LD A,(nn)
    LD A,A
    LD A,B
    LD A,C
    LD A,D
    LD A,E
    LD A,H
    LD A,I
    LD A,IXh
    LD A,IXl
    LD A,IYh
    LD A,IYl
    LD A,L
    LD A,$42
    LD A,R
    LD B,(HL)
    LD B,(IX+$42)
    LD B,(IY+$42)
    LD B,A
    LD B,B
    LD B,C
    LD B,D
    LD B,E
    LD B,H
    LD B,IXh
    LD B,IXl
    LD B,IYh
    LD B,IYl
    LD B,L
    LD B,$42
    LD BC,(nn)
    LD BC,nn
    LD C,(HL)
    LD C,(IX+$42)
    LD C,(IY+$42)
    LD C,A
    LD C,B
    LD C,C
    LD C,D
    LD C,E
    LD C,H
    LD C,IXh
    LD C,IXl
    LD C,IYh
    LD C,IYl
    LD C,L
    LD C,$42
    LD D,(HL)
    LD D,(IX+$42)
    LD D,(IY+$42)
    LD D,A
    LD D,B
    LD D,C
    LD D,D
    LD D,E
    LD D,H
    LD D,IXh
    LD D,IXl
    LD D,IYh
    LD D,IYl
    LD D,L
    LD D,$42
    LD DE,(nn)
    LD DE,nn
    LD E,(HL)
    LD E,(IX+$42)
    LD E,(IY+$42)
    LD E,A
    LD E,B
    LD E,C
    LD E,D
    LD E,E
    LD E,H
    LD E,IXh
    LD E,IXl
    LD E,IYh
    LD E,IYl
    LD E,L
    LD E,$42
    LD H,(HL)
    LD H,(IX+$42)
    LD H,(IY+$42)
    LD H,A
    LD H,B
    LD H,C
    LD H,D
    LD H,E
    LD H,H
    LD H,L
    LD H,$42
    LD HL,(nn)
    LD HL,nn
    LD I,A
    LD IX,(nn)
    LD IX,nn
    LD IXh,A
    LD IXh,B
    LD IXh,C
    LD IXh,D
    LD IXh,E
    LD IXh,IXh
    LD IXh,IXl
    LD IXh,$42
    LD IXl,A
    LD IXl,B
    LD IXl,C
    LD IXl,D
    LD IXl,E
    LD IXl,IXh
    LD IXl,IXl
    LD IXl,$42
    LD IY,(nn)
    LD IY,nn
    LD IYh,A
    LD IYh,B
    LD IYh,C
    LD IYh,D
    LD IYh,E
    LD IYh,IYh
    LD IYh,IYl
    LD IYh,$42
    LD IYl,A
    LD IYl,B
    LD IYl,C
    LD IYl,D
    LD IYl,E
    LD IYl,IYh
    LD IYl,IYl
    LD IYl,$42
    LD L,(HL)
    LD L,(IX+$42)
    LD L,(IY+$42)
    LD L,A
    LD L,B
    LD L,C
    LD L,D
    LD L,E
    LD L,H
    LD L,L
    LD L,$42
    LD R,A
    LD SP,(nn)
    LD SP,HL
    LD SP,IX
    LD SP,IY
    LD SP,nn
    LDD
    LDDR
    LDI
    LDIR
    NEG
    NOP
    OR (HL)
    OR (IX+$42)
    OR (IY+$42)
    OR A
    OR B
    OR C
    OR D
    OR E
    OR H
    OR IXh
    OR IXl
    OR IYh
    OR IYl
    OR L
    OR $42
    OTDR
    OTIR
    OUT (C),0
    OUT (C),A
    OUT (C),B
    OUT (C),C
    OUT (C),D
    OUT (C),E
    OUT (C),H
    OUT (C),L
    OUT ($42),A
    OUTD
    OUTI
    POP AF
    POP BC
    POP DE
    POP HL
    POP IX
    POP IY
    PUSH AF
    PUSH BC
    PUSH DE
    PUSH HL
    PUSH IX
    PUSH IY
    RES 0,(HL)
    RES 0,(IX+$42)
    RES 0,(IY+$42)
    RES 0,A
    RES 0,B
    RES 0,C
    RES 0,D
    RES 0,E
    RES 0,H
    RES 0,L
    RES 1,(HL)
    RES 1,(IX+$42)
    RES 1,(IY+$42)
    RES 1,A
    RES 1,B
    RES 1,C
    RES 1,D
    RES 1,E
    RES 1,H
    RES 1,L
    RES 2,(HL)
    RES 2,(IX+$42)
    RES 2,(IY+$42)
    RES 2,A
    RES 2,B
    RES 2,C
    RES 2,D
    RES 2,E
    RES 2,H
    RES 2,L
    RES 3,(HL)
    RES 3,(IX+$42)
    RES 3,(IY+$42)
    RES 3,A
    RES 3,B
    RES 3,C
    RES 3,D
    RES 3,E
    RES 3,H
    RES 3,L
    RES 4,(HL)
    RES 4,(IX+$42)
    RES 4,(IY+$42)
    RES 4,A
    RES 4,B
    RES 4,C
    RES 4,D
    RES 4,E
    RES 4,H
    RES 4,L
    RES 5,(HL)
    RES 5,(IX+$42)
    RES 5,(IY+$42)
    RES 5,A
    RES 5,B
    RES 5,C
    RES 5,D
    RES 5,E
    RES 5,H
    RES 5,L
    RES 6,(HL)
    RES 6,(IX+$42)
    RES 6,(IY+$42)
    RES 6,A
    RES 6,B
    RES 6,C
    RES 6,D
    RES 6,E
    RES 6,H
    RES 6,L
    RES 7,(HL)
    RES 7,(IX+$42)
    RES 7,(IY+$42)
    RES 7,A
    RES 7,B
    RES 7,C
    RES 7,D
    RES 7,E
    RES 7,H
    RES 7,L
    RET
    RET C
    RET M
    RET NC
    RET NZ
    RET P
    RET PE
    RET PO
    RET Z
    RETI
    RETN
    RL (HL)
    RL (IX+$42)
    RL (IY+$42)
    RL A
    RL B
    RL C
    RL D
    RL E
    RL H
    RL L
    RLA
    RLC (HL)
    RLC (IX+$42)
    RLC (IY+$42)
    RLC A
    RLC B
    RLC C
    RLC D
    RLC E
    RLC H
    RLC L
    RLCA
    RLD
    RR (HL)
    RR (IX+$42)
    RR (IY+$42)
    RR A
    RR B
    RR C
    RR D
    RR E
    RR H
    RR L
    RRA
    RRC (HL)
    RRC (IX+$42)
    RRC (IY+$42)
    RRC A
    RRC B
    RRC C
    RRC D
    RRC E
    RRC H
    RRC L
    RRCA
    RRD
    RST 0H
    RST 10H
    RST 18H
    RST 20H
    RST 28H
    RST 30H
    RST 38H
    RST 8H
    SBC A,(HL)
    SBC A,(IX+$42)
    SBC A,(IY+$42)
    SBC A,A
    SBC A,B
    SBC A,C
    SBC A,D
    SBC A,E
    SBC A,H
    SBC A,IXh
    SBC A,IXl
    SBC A,IYh
    SBC A,IYl
    SBC A,L
    SBC A,$42
    SBC HL,BC
    SBC HL,DE
    SBC HL,HL
    SBC HL,SP
    SCF
    SET 0,(HL)
    SET 0,(IX+$42)
    SET 0,(IY+$42)
    SET 0,A
    SET 0,B
    SET 0,C
    SET 0,D
    SET 0,E
    SET 0,H
    SET 0,L
    SET 1,(HL)
    SET 1,(IX+$42)
    SET 1,(IY+$42)
    SET 1,A
    SET 1,B
    SET 1,C
    SET 1,D
    SET 1,E
    SET 1,H
    SET 1,L
    SET 2,(HL)
    SET 2,(IX+$42)
    SET 2,(IY+$42)
    SET 2,A
    SET 2,B
    SET 2,C
    SET 2,D
    SET 2,E
    SET 2,H
    SET 2,L
    SET 3,(HL)
    SET 3,(IX+$42)
    SET 3,(IY+$42)
    SET 3,A
    SET 3,B
    SET 3,C
    SET 3,D
    SET 3,E
    SET 3,H
    SET 3,L
    SET 4,(HL)
    SET 4,(IX+$42)
    SET 4,(IY+$42)
    SET 4,A
    SET 4,B
    SET 4,C
    SET 4,D
    SET 4,E
    SET 4,H
    SET 4,L
    SET 5,(HL)
    SET 5,(IX+$42)
    SET 5,(IY+$42)
    SET 5,A
    SET 5,B
    SET 5,C
    SET 5,D
    SET 5,E
    SET 5,H
    SET 5,L
    SET 6,(HL)
    SET 6,(IX+$42)
    SET 6,(IY+$42)
    SET 6,A
    SET 6,B
    SET 6,C
    SET 6,D
    SET 6,E
    SET 6,H
    SET 6,L
    SET 7,(HL)
    SET 7,(IX+$42)
    SET 7,(IY+$42)
    SET 7,A
    SET 7,B
    SET 7,C
    SET 7,D
    SET 7,E
    SET 7,H
    SET 7,L
    SLA (HL)
    SLA (IX+$42)
    SLA (IY+$42)
    SLA A
    SLA B
    SLA C
    SLA D
    SLA E
    SLA H
    SLA L
    SLL (HL)
    SLL (IX+$42)
    SLL (IY+$42)
    SLL A
    SLL B
    SLL C
    SLL D
    SLL E
    SLL H
    SLL L
    SRA (HL)
    SRA (IX+$42)
    SRA (IY+$42)
    SRA A
    SRA B
    SRA C
    SRA D
    SRA E
    SRA H
    SRA L
    SRL (HL)
    SRL (IX+$42)
    SRL (IY+$42)
    SRL A
    SRL B
    SRL C
    SRL D
    SRL E
    SRL H
    SRL L
    SUB A,(HL)
    SUB A,(IX+$42)
    SUB A,(IY+$42)
    SUB A,A
    SUB A,B
    SUB A,C
    SUB A,D
    SUB A,E
    SUB A,H
    SUB A,IXh
    SUB A,IXl
    SUB A,IYh
    SUB A,IYl
    SUB A,L
    SUB A,$42
    XOR (HL)
    XOR (IX+$42)
    XOR (IY+$42)
    XOR A
    XOR B
    XOR C
    XOR D
    XOR E
    XOR H
    XOR IXh
    XOR IXl
    XOR IYh
    XOR IYl
    XOR L
    XOR $42

nn:
