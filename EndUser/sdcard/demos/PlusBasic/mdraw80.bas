1000 REM Mouse Draw 80 Column
1200 _INIT
1500 _SETUP
1501 REM Setup routines
1510 SET SPRITE * CLEAR
1520 SCREEN 3,,1,0,0
1530 CLS 15,7
1540 POKE PEEK($3801),32
1550 POKE $3001,"MouseDraw80"
1560 POKE $304A,"Q=Quit"
1570 SET TILE 511 TO $"FFF00000F77F0000F777F0000F777F0000F777F0000F777F0000F7F000000F00"
1580 DEF SPRITE M$ = 0,0,0
1590 DEF TILELIST T$=511
1600 SET SPRITE M$ TILE T$ POS 156,96 ON
2000 _MAIN
2001 REM Main Loop
2010 X=MOUSEX:Y=MOUSEY:B=MOUSEB
2020 SET SPRITE M$ POS X,Y
2030 IF Y<8 THEN GOTO _MAIN
2040 IF B=1 THEN PSET(X/2,(Y-8)*3/8)
2050 IF B=2 THEN PRESET(X/2,(Y-8)*3/8)
2060 IF INKEY$="q" OR INKEY$="Q" THEN GOTO _CLOSEOUT
2999 GOTO _MAIN
9000 _CLOSEOUT
9001 REM Closeout program
9010 CLS
9020 SCREEN 1,,0,0,0
9999 END
