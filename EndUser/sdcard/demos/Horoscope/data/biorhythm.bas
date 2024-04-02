1000 REM ----------------------------------------------
1001 REM                Biorhythm Module
1002 REM     by Sean P. Harrington, sph@1stage.com
1003 REM              Updated 02 APR 2024
1004 REM ----------------------------------------------
1005 REM     Based on the Horoscope Arcade Machine
1006 REM               (c) 1975 by Ramtek
1007 REM ----------------------------------------------
1008 REM      Biorhythm algorithms checked against 
1009 REM            DeGraeve.com's Biorhythm
1010 REM        https://www.degraeve.com/bio.php
1015 REM ----------------------------------------------

1100 _setup
1101 REM Setup Biorhythm components
1110 SET FAST ON
1120 USE CHRSET "data/horoscope.chr"
1130 mu = pt3status
1140 dd = 0

1159 REM Leap Year function
1160 DEF FN LY(YR)=ABS(SGN(YR MOD 4)-SGN(YR MOD 100)+SGN(YR MOD 400)-1)
1169 REM Day of Week function
1170 DEF FN DW(DY)=((DY+7000) mod 7)

1200 _init
1201 REM Initialize data structures
1210 dim dt(1,3)    : REM Datum array
1211 REM dt(0,x) is for Date of Birth
1212 REM dt(1,x) is for Report Date
1220 REM dt(x,0) is dayCount (uncalculated)
1221 REM dt(x,1) is theYear
1222 REM dt(x,2) is theMonth
1223 REM dt(x,3) is theDay
1230 fx = 0         : REM field index
1240 dim mc(1,12)   : REM Month days count array, precalculated
1245 load "data/mdCount.arry",*mc
1250 dim nm$(0)
1255 load "data/nmBio.arry",*nm$
1260 dim dl$(6)
1261 dl$(0)="S":dl$(1)="M":dl$(2)="T":dl$(3)="W"
1262 dl$(4)="T":dl$(5)="F":dl$(6)="S"
1270 dim b1(51):dim b2(51)
1271 load "data/bioInp.arry",*b1 : REM Number edit screenlet
1272 load "data/bioTxt.arry",*b2 : REM Text edit screenlet

1300 load "data/dtBio.arry",*dt
1301 dt(1,1) = val(left$(datetime$,4))
1302 dt(1,2) = val(mid$(datetime$,5,2))
1303 dt(1,3) = val(mid$(datetime$,7,2))
1310 gosub _checkFields
1320 sd = 0           : REM Set birth date Datum
1330 gosub _theDays
1340 sd = 1           : REM Set report date Datum
1350 gosub _theDays

1400 _resetInput
1410 LOAD SCREEN "data/bioInput.scr" 
1420 gosub _refreshFields

2000 _main
2001 REM Main loop
2010 if fx > 7 then fx = 0 
2020 if fx = 1 then goto _nameEdit
2030 if fx = 2 then goto _bYearEdit
2040 if fx = 3 then goto _bMonEdit
2050 if fx = 4 then goto _bDayEdit
2060 if fx = 5 then goto _rYearEdit
2070 if fx = 6 then goto _rMonEdit
2080 if fx = 7 then goto _rDayEdit
2100 mk$="" : mk$ = getkey$
2110 if mk$="q"     then goto _closeout  : REM q = Quit
2120 if mk$="a"     then gosub _about    : REM a = About
2130 if mk$="m"     then gosub _toggleMu : REM m = Toggle music
2140 if mk$="x"     then goto _horoscope : REM x = Horoscope menu
2150 if asc(mk$)=9  then fx = fx + 1     : REM TAB = Next field
2160 if asc(mk$)=13 then goto _chartBio  : REM RTN Run Bio chart
2199 goto _main

2200 _nameEdit
2210 put screen (3,19),*b2  : REM Remove TEXT edit commands
2220 poke color 20+(6*40),STRING$(14,183)
2230 _nameLoop
2240 tn$="" : tn$ = getkey$
2250 if asc(tn$)=9   then goto _exitName   : REM TAB = Next field
2260 if asc(tn$)=13  then goto _chartBio   : REM RTN Run Bio chart
2270 if asc(tn$)=8 or asc(tn$)=127 then goto _delNM  : REM Delete a char
2280 if tn$<>""  then goto _insNM          : REM Insert a char
2290 goto _nameLoop
2300 _insNM
2310 if len(nm$(0)) < 14 then nm$(0) = nm$(0) + tn$
2311 if len(nm$(0)) > 13 then SOUND(25,200)
2312 gosub _refName
2315 goto _nameLoop
2320 _delNM
2325 if len(nm$(0)) > 0  then nm$(0) = left$(nm$(0),len(nm$(0))-1)
2326 gosub _refName
2330 goto _nameLoop
2400 _exitName
2410 poke color 20+(6*40),STRING$(14,120)
2420 put screen (3,19),*b1  : REM Replace TEXT edit commands
2430 fx = fx + 1  : REM Increment field index
2440 gosub _chkName
2450 goto _resetInput

2500 _bYearEdit
2510 poke color 20+(10*40),STRING$(4,183)
2520 _BYLoop
2530 by$="" : by$ = getkey$
2540 if asc(by$)>47 and asc(by$)<58 then goto _insBY : REM Insert a num
2541 if asc(by$)=9  then goto _exitBY    : REM TAB = Next field
2542 if asc(by$)=13 then goto _runBYBio  : REM RTN Run Bio chart
2543 if asc(by$)=8 or asc(by$)=127 then goto _delBY  : REM Delete a num
2544 if by$="q"     then goto _closeout  : REM q = Quit
2545 if by$="a"     then gosub _about    : REM a = About
2546 if by$="m"     then gosub _toggleMu : REM m = Toggle music
2547 if by$="x"     then goto _horoscope : REM x = Horoscope menu
2550 goto _BYLoop
2600 _delBY
2610 IF (dt(0,1) > 0) THEN dt(0,1) = INT(dt(0,1)/10)
2620 gosub _refBY
2630 goto _BYLoop
2650 _insBY
2660 if (dt(0,1) > 999) THEN goto _BYthou
2661 if (dt(0,1) > 0) AND (DT(0,1) < 1000) THEN goto _BYlow
2662 if (dt(0,1) < 1) THEN dt(0,1) = VAL(by$)
2663 goto _endBY
2670 _BYthou
2671 dt(0,1) = ((dt(0,1) MOD 1000)*10) + VAL(by$)
2673 gosub _refBY
2674 goto _endBY
2680 _BYlow
2681 dt(0,1) = (dt(0,1)*10) + VAL(by$)
2682 gosub _refBY
2683 goto _endBY
2690 _endBY
2691 gosub _refBY
2692 goto _BYLoop
2700 _runBYBio
2710 gosub _chkBY
2720 goto _chartBio
2730 _exitBY
2740 poke color 20+(10*40),STRING$(4,120)
2750 fx = fx + 1  : REM Increment field index
2760 gosub _chkBY
2769 goto _resetInput

3000 _bMonEdit
3010 poke color 25+(10*40),STRING$(2,183)
3020 _BMLoop
3030 bm$="" : bm$ = getkey$
3040 if asc(bm$)>47 and asc(bm$)<58 then goto _insBM : REM Insert a num
3041 if asc(bm$)=9  then goto _exitBM    : REM TAB = Next field
3042 if asc(bm$)=13 then goto _runBMBio  : REM RTN Run Bio chart
3043 if asc(bm$)=8 or asc(bm$)=127 then goto _delBM  : REM Delete a num
3044 if bm$="q"     then goto _closeout  : REM q = Quit
3045 if bm$="a"     then gosub _about    : REM a = About
3046 if bm$="m"     then gosub _toggleMu : REM m = Toggle music
3047 if bm$="x"     then goto _horoscope : REM x = Horoscope menu
3050 goto _BMLoop
3100 _delBM
3110 IF (dt(0,2) > 0) THEN dt(0,2) = INT(dt(0,2)/10)
3120 gosub _refBM
3130 goto _BMLoop
3150 _insBM
3160 if (dt(0,2) > 9) THEN goto _BMten
3161 if (dt(0,2) > 0) AND (DT(0,2) < 10) THEN goto _BMlow
3162 if (dt(0,2) < 2) THEN dt(0,2) = VAL(bm$)
3163 goto _endBM
3170 _BMten
3171 dt(0,2) = ((dt(0,2) MOD 10)*10) + VAL(bm$)
3173 gosub _refBM
3174 goto _endBM
3180 _BMlow
3181 dt(0,2) = (dt(0,2)*10) + VAL(bm$)
3182 gosub _refBM
3183 goto _endBM
3190 _endBM
3191 gosub _refBM
3192 goto _BMLoop
3200 _runBMBio
3210 gosub _chkBM
3220 goto _chartBio
3399 _exitBM
3400 poke color 25+(10*40),STRING$(2,120)
3450 fx = fx + 1  : REM Increment field index
3460 gosub _chkBM
3469 goto _resetInput

3500 _bDayEdit
3510 poke color 28+(10*40),STRING$(2,183)
3520 _BDLoop
3530 bd$="" : bd$ = getkey$
3540 if asc(bd$)>47 and asc(bd$)<58 then goto _insBD : REM Insert a num
3541 if asc(bd$)=9  then goto _exitBD    : REM TAB = Next field
3542 if asc(bd$)=13 then goto _runBDBio  : REM RTN Run Bio chart
3543 if asc(bd$)=8 or asc(bd$)=127 then goto _delBD  : REM Delete a num
3544 if bd$="q"     then goto _closeout  : REM q = Quit
3545 if bd$="a"     then gosub _about    : REM a = About
3546 if bd$="m"     then gosub _toggleMu : REM m = Toggle music
3547 if bd$="x"     then goto _horoscope : REM x = Horoscope menu
3550 goto _BDLoop
3600 _delBD
3610 IF (dt(0,3) > 0) THEN dt(0,3) = INT(dt(0,3)/10)
3620 gosub _refBD
3630 goto _BDLoop
3650 _insBD
3660 if (dt(0,3) > 9) THEN goto _BDten
3661 if (dt(0,3) > 0) AND (DT(0,3) < 10) THEN goto _BDlow
3662 if (dt(0,3) < 2) THEN dt(0,3) = VAL(bd$)
3663 goto _endBD
3670 _BDten
3671 dt(0,3) = ((dt(0,3) MOD 10)*10) + VAL(bd$)
3673 gosub _refBD
3674 goto _endBD
3680 _BDlow
3681 dt(0,3) = (dt(0,3)*10) + VAL(bd$)
3682 gosub _refBD
3683 goto _endBD
3690 _endBD
3691 gosub _refBD
3692 goto _BDLoop
3700 _runBDBio
3710 gosub _chkBD
3720 goto _chartBio
3800 _exitBD
3900 poke color 28+(10*40),STRING$(2,120)
3950 fx = fx + 1  : REM Increment field index
3960 gosub _chkBD
3969 goto _resetInput

4000 _rYearEdit
4010 poke color 20+(14*40),STRING$(4,183)
4020 _RYLoop
4030 ry$="" : ry$ = getkey$
4040 if asc(ry$)>47 and asc(ry$)<58 then goto _insRY : REM Insert a num
4041 if asc(ry$)=9   then goto _exitRY    : REM TAB = Next field
4042 if asc(ry$)=13  then goto _runRYBio  : REM RTN Run Bio chart
4043 if asc(ry$)=8 or asc(ry$)=127 then goto _delRY  : REM Delete a num
4044 if ry$="q"      then goto _closeout  : REM q = Quit
4045 if ry$="a"      then gosub _about    : REM a = About
4046 if ry$="m"      then gosub _toggleMu : REM m = Toggle music
4047 if ry$="x"      then goto _horoscope : REM x = Horoscope menu
4050 goto _RYLoop
4100 _delRY
4110 IF (dt(1,1) > 0) THEN dt(1,1) = INT(dt(1,1)/10)
4120 gosub _refRY
4130 goto _RYLoop
4150 _insRY
4160 if (dt(1,1) > 999) THEN goto _RYthou
4161 if (dt(1,1) > 0) AND (dt(1,1) < 1000) THEN goto _RYlow
4162 if (dt(1,1) < 4) THEN dt(1,1) = VAL(ry$)
4163 goto _endRY
4170 _RYthou
4171 dt(1,1) = ((dt(1,1) MOD 1000)*10) + VAL(ry$)
4173 gosub _refRY
4174 goto _endRY
4180 _RYlow
4181 dt(1,1) = (dt(1,1)*10) + VAL(ry$)
4182 gosub _refRY
4183 goto _endRY
4190 _endRY
4191 gosub _refRY
4192 goto _RYLoop
4200 _runRYBio
4210 gosub _chkRY
4220 goto _chartBio
4300 _exitRY
4310 poke color 20+(14*40),STRING$(4,120)
4320 fx = fx + 1  : REM Increment field index
4460 gosub _chkRY
4469 goto _resetInput

4500 _rMonEdit
4510 poke color 25+(14*40),STRING$(2,183)
4520 _RMLoop
4530 rm$="" : rm$ = getkey$
4540 if asc(rm$)>47 and asc(rm$)<58 then goto _insRM : REM Insert a num
4541 if asc(rm$)=9  then goto _exitRM    : REM TAB = Next field
4542 if asc(rm$)=13 then goto _runRMBio  : REM RTN Run Bio chart
4543 if asc(rm$)=8 or asc(rm$)=127 then goto _delRM  : REM Delete a num
4544 if rm$="q"     then goto _closeout  : REM q = Quit
4545 if rm$="a"     then gosub _about    : REM a = About
4546 if rm$="m"     then gosub _toggleMu : REM m = Toggle music
4547 if rm$="x"     then goto _horoscope : REM x = Horoscope menu
4550 goto _RMLoop
4600 _delRM
4610 IF (dt(1,2) > 0) THEN dt(1,2) = INT(dt(1,2)/10)
4620 gosub _refRM
4630 goto _RMLoop
4650 _insRM
4660 if (dt(1,2) > 9) THEN goto _RMten
4661 if (dt(1,2) > 0) AND (dt(1,2) < 10) THEN goto _RMlow
4662 if (dt(1,2) < 2) THEN dt(1,2) = VAL(rm$)
4663 goto _endRM
4670 _RMten
4671 dt(1,2) = ((dt(1,2) MOD 10)*10) + VAL(rm$)
4673 gosub _refRM
4674 goto _endRM
4680 _RMlow
4681 dt(1,2) = (dt(1,2)*10) + VAL(rm$)
4682 gosub _refRM
4683 goto _endRM
4690 _endRM
4691 gosub _refRM
4692 goto _RMLoop
4700 _runRMBio
4710 gosub _chkRM
4720 goto _chartBio
4899 _exitRM
4900 poke color 25+(14*40),STRING$(2,120)
4950 fx = fx + 1  : REM Increment field index
4960 gosub _chkRM
4969 goto _resetInput

5000 _rDayEdit
5010 poke color 28+(14*40),STRING$(2,183)
5020 _RDLoop
5030 rd$="" : rd$ = getkey$
5040 if asc(rd$)>47 and asc(rd$)<58 then goto _insRD : REM Insert a num
5041 if asc(rd$)=9  then goto _exitRD    : REM TAB = Next field
5042 if asc(rd$)=13 then goto _runRDBio  : REM RTN Run Bio chart
5043 if asc(rd$)=8 or asc(rd$)=127 then goto _delRD  : REM Delete a num
5044 if rd$="q"     then goto _closeout  : REM q = Quit
5045 if rd$="a"     then gosub _about    : REM a = About
5046 if rd$="m"     then gosub _toggleMu : REM m = Toggle music
5047 if rd$="x"     then goto _horoscope : REM x = Horoscope menu
5050 goto _RDLoop
5100 _delRD
5110 IF (dt(1,3) > 0) THEN dt(1,3) = INT(dt(1,3)/10)
5120 gosub _refRD
5130 goto _RDLoop
5150 _insRD
5160 if (dt(1,3) > 9) THEN goto _RDten
5161 if (dt(1,3) > 0) AND (dt(1,3) < 10) THEN goto _RDlow
5162 if (dt(1,3) < 2) THEN dt(1,3) = VAL(rd$)
5163 goto _endRD
5170 _RDten
5171 dt(1,3) = ((dt(1,3) MOD 10)*10) + VAL(rd$)
5173 gosub _refRD
5174 goto _endRD
5180 _RDlow
5181 dt(1,3) = (dt(1,3)*10) + VAL(rd$)
5182 gosub _refRD
5183 goto _endRD
5190 _endRD
5191 gosub _refRD
5192 goto _RDLoop
5200 _runRDBio
5210 gosub _chkRD
5220 goto _chartBio
5300 _exitRD
5400 poke color 28+(14*40),STRING$(2,120)
5450 fx = fx + 1  : REM Increment field index
5460 gosub _chkRD
5469 goto _resetInput

6999 REM Chart Biorhythm
7000 _chartBio
7001 poke screen 11+(16*40),"Charting Biorhythm..."
7002 poke color  11+(16*40),STRING$(21,126)
7003 gosub _checkFields
7004 sd = 0         : REM Set birth date Datum
7005 gosub _theDays
7006 sd = 1         : REM Set report date Datum
7007 gosub _theDays
7008 bd = dt(1,0)-1 : REM startBigDay

7010 load screen "data/bioMatrix.scr"
7011 ye$ = right$(str$(dt(1,1)+10000),4)
7012 poke screen 45,ye$
7013 mo$ = right$(str$(dt(1,2) + 100),2)
7014 poke screen 50,mo$
7015 da$ = right$(str$(dt(1,3) + 100),2)
7016 poke screen 53,da$

7020 ye$ = right$(str$(dt(0,1)+10000),4)
7021 poke screen 85,ye$
7022 mo$ = right$(str$(dt(0,2) + 100),2)
7023 poke screen 90,mo$
7024 da$ = right$(str$(dt(0,3) + 100),2)
7025 poke screen 93,da$
7030 poke screen (14-len(nm$(0)))+1, nm$(0)

7100 gosub _dayDiff  : REM Calc diff between DOB and Rpt Date
7110 for j=0 to 39
7120 if (j mod 2 = 0) then POKE SCREEN ((4*40)+j),DL$(FN DW(bd+(j*0.5)))
7130 ip=int(8-((sin(((dd/23.0)*(2.0*3.14159)))*8.1))+3)
7140 ie=int(8-((sin(((dd/28.0)*(2.0*3.14159)))*8.1))+3)
7150 ii=int(8-((sin(((dd/33.0)*(2.0*3.14159)))*8.1))+3)

7200 REM Chart Physical
7210 cp$ = CHR$(163)  : REM Top row bloxels char
7220 pc  = 31         : REM Red on dark grey
7230 poke screen ((4+(ip))*40)+j,cp$
7240 poke color  ((4+(ip))*40)+j,pc

7300 REM Chart Emotional
7310 ce$ = CHR$(172)  : REM Middle row bloxels char
7320 ec  = 47         : REM Green on dark grey
7330 if peek screen$(((4+ie)*40)+j,1) = CHR$(163) then ce$ = CHR$(175)
7340 if peek screen$(((4+ie)*40)+j,1) = CHR$(163) then ec  = 63
7350 poke screen ((4+(ie))*40)+j,ce$
7360 poke color  ((4+(ie))*40)+j,ec

7400 REM Chart Intellectual
7410 ci$ = CHR$(240)  : REM Bottom row bloxels char
7420 ic  = 79         : REM Blue on dark grey
7430 if peek screen$(((4+ii)*40)+j,1) = CHR$(163) then ci$ = CHR$(243)
7440 if peek screen$(((4+ii)*40)+j,1) = CHR$(163) then ic  = 95
7450 if peek screen$(((4+ii)*40)+j,1) = CHR$(172) then ci$ = CHR$(252)
7460 if peek screen$(((4+ii)*40)+j,1) = CHR$(172) then ic  = 111
7470 if peek screen$(((4+ii)*40)+j,1) = CHR$(175) then ci$ = CHR$(255)
7480 if peek screen$(((4+ii)*40)+j,1) = CHR$(175) then ic  = 127
7490 poke screen ((4+(ii))*40)+j,ci$
7500 poke color  ((4+(ii))*40)+j,ic
7510 dd = dd + 0.5

7599 next j
7600 poke screen 964,"Press any key to return to edit."
7610 for i = 964 to 995
7620 poke color  i,127
7630 next i
7640 pause

7700 LOAD SCREEN "data/bioInput.scr"
7710 gosub _refreshFields

7999 goto _main

8000 _about
8001 REM Show About... pages
8010 STASH SCREEN
8020 LOAD SCREEN "data/bioAbout.scr"
8040 PAUSE
8050 RESTORE SCREEN
8060 return

8100 _toggleMu
8101 REM Toggle Music
8110 mu = NOT mu
8120 if     mu then RESUME PT3
8130 if not mu then PAUSE  PT3
8140 RETURN

8200 _refreshFields
8201 REM Refresh ALL fields on input screen
8210 gosub _refName
8220 gosub _refBY     
8230 gosub _refBM      
8240 gosub _refBD    
8250 gosub _refRY
8260 gosub _refRM
8270 gosub _refRD
8299 RETURN

8300 _refName
8301 REM Refresh name field
8302 POKE SCREEN 20+(6*40), nm$(0)
8303 REM Pad spaces
8304 FOR i = LEN(nm$(0)) to 13
8305 POKE SCREEN (20+i)+(6*40), " "
8306 NEXT i
8307 return

8310 _refBY
8311 POKE SCREEN 19+(10*40), "     "
8312 POKE SCREEN 19+(10*40), STR$(dt(0,1))
8313 return

8315 _refBM
8316 POKE SCREEN 24+(10*40), "   "
8317 POKE SCREEN 25+(10*40), STR$(dt(0,2) MOD 10)
8318 POKE SCREEN 24+(10*40), STR$(INT((dt(0,2)+0.5)/10))
8319 return

8320 _refBD
8321 POKE SCREEN 27+(10*40), "   "
8322 POKE SCREEN 28+(10*40), STR$(dt(0,3) MOD 10)
8323 POKE SCREEN 27+(10*40), STR$(INT((dt(0,3)+0.5)/10))
8324 return

8325 _refRY
8326 POKE SCREEN 19+(14*40), "     "
8327 POKE SCREEN 19+(14*40), STR$(dt(1,1))
8328 return

8330 _refRM
8331 POKE SCREEN 24+(14*40), "   "
8332 POKE SCREEN 25+(14*40), STR$(dt(1,2) MOD 10)
8333 POKE SCREEN 24+(14*40), STR$(INT((dt(1,2)+0.5)/10))
8334 return

8335 _refRD
8336 POKE SCREEN 27+(14*40), "   "
8337 POKE SCREEN 28+(14*40), STR$(dt(1,3) MOD 10)
8338 POKE SCREEN 27+(14*40), STR$(INT((dt(1,3)+0.5)/10))
8339 return

8400 _checkFields
8401 REM Validate ALL field entries
8410 gosub _chkName  : REM Check Name
8420 gosub _chkBY    : REM Check birth year
8430 gosub _chkBM    : REM Check birth month
8440 gosub _chkBD    : REM Check birth day
8450 gosub _chkRY    : REM Check report year
8460 gosub _chkRM    : REM Check report month
8470 gosub _chkRD    : REM Check report day
8480 save "data/dtBio.arry",*dt
8490 save "data/nmBio.arry",*nm$
8499 RETURN

8500 _chkBY
8501 IF (dt(0,1) < 1900) THEN dt(0,1) = 1900
8502 IF (dt(0,1) > 2099) THEN dt(0,1) = val(left$(datetime$,4))
8503 return

8505 _chkBM
8506 IF (dt(0,2) < 1   ) THEN dt(0,2) = 1
8507 IF (dt(0,2) > 12  ) THEN dt(0,2) = 12
8508 return

8510 _chkBD
8511 IF (dt(0,3) < 1   ) THEN dt(0,3) = 1
8512 IF (dt(0,3) > 31  ) THEN dt(0,3) = 31
8513 IF (dt(0,2) = 2) and (dt(0,3) > 28) THEN dt(0,3) = 28
8514 IF ((dt(0,2) = 4) OR (dt(0,2) = 6) OR (dt(0,2) = 9) OR (dt(0,2) = 11)) AND (dt(0,2) > 30) THEN dt(0,3) = 30
8515 IF (dt(0,2) = 2) and (FN LY(dt(0,1))) and (dt(0,3) > 29) THEN dt(0,3) = 29
8516 return

8520 _chkRY
8521 IF (dt(1,1) < 1900) THEN dt(1,1) = 1900
8522 IF (dt(1,1) > 2100) THEN dt(1,1) = val(left$(datetime$,4))
8523 return

8525 _chkRM
8526 IF (dt(1,2) < 1   ) THEN dt(1,2) = 1
8527 IF (dt(1,2) > 12  ) THEN dt(1,2) = 12
8528 return

8530 _chkRD
8531 IF (dt(1,3) < 1   ) THEN dt(1,3) = 1
8532 IF (dt(1,3) > 31  ) THEN dt(1,3) = 31
8533 IF ((dt(1,2) = 4) OR (dt(1,2) = 6) OR (dt(1,2) = 9) OR (dt(1,2) = 11)) AND (dt(1,2) > 30) THEN dt(1,3) = 30
8534 IF (dt(1,2) = 2) and (dt(1,3) > 28) THEN dt(1,3) = 28
8535 IF (dt(1,2) = 2) and (FN LY(dt(1,1))) and (dt(1,3) > 29) THEN dt(1,3) = 29
8536 return

8540 _chkName
8541 if len(nm$(0)) = 0  then nm$(0) = "Aquarius+"
8542 if len(nm$(0)) > 14 then nm$(0) = left$(nm$(0),14)
8543 return

8800 _theDays
8801 REM Calculates the days since 1/1/1900
8802 REM sd determines which Datum
8803 dt(sd,0) = 0  : REM Reset the day counter
8810 for i=1900 to (dt(sd,1)-1)
8820 dt(sd,0) = dt(sd,0) + 365 + FN LY(i)
8830 next i
8840 dt(sd,0) = dt(sd,0) + mc(FN LY(dt(sd,1)),dt(sd,2))
8850 dt(sd,0) = dt(sd,0) + dt(sd,3)
8860 if (dt(sd,1)=1900) AND (dt(sd,2)<3) THEN dt(sd,0) = dt(sd,0) - 1
8870 return

8900 _dayDiff
8901 REM Difference in days between Datum 0 and 1
8910 dd = abs(dt(1,0)-dt(0,0))
8920 return

9700 _horoscope
9701 REM Return to Horoscope main program
9710 save "data/dtBio.arry",*dt
9720 save "data/nmBio.arry",*nm$
9730 RUN "data/horoscope.bas"
9799 END

9800 _closeout
9801 REM Closeout system and reset
9810 save "data/dtBio.arry",*dt
9820 save "data/nmBio.arry",*nm$
9830 STOP PT3
9840 SET FAST OFF
9850 USE CHRSET 0

9900 _quit
9901 REM Finish out
9910 CLS
9920 PRINT "    We hope you enjoyed Horoscope!"
9930 PRINT
9999 END