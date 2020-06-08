#program knloader
#autostart
  10 ; knloader - Copyright (c) 2020 @kounch
  20 ; This program is free software, you can redistribute
  30 ; it and/or modify it under the terms of the
  40 ; GNU General Public License

  50 LET %s=%REG 7&3:RUN AT 3
  60 ON ERROR PRINT "ERROR":ERROR TO e,l:PRINT e,l:PAUSE 0:RUN AT %s:FOR %a=0 TO 15:CLOSE # %a:NEXT %a:ERASE:ON ERROR
  70 GO SUB %7000:; Load Defaults
  80 LAYER CLEAR:SPRITE CLEAR:PALETTE CLEAR:PAPER tinta:BORDER tinta:INK papel:CLS
  90 PRINT AT 5,14;"> knloader  v0.4 <":PRINT AT 8,16;"© kounch  2020":PRINT AT 15,15;"Press H for help"

  95 ; Load Menu Items
 100 GO SUB %5000:; Load Cache
 110 GO SUB %5100:; Load Options
 120 LET pos=1

 195 ; Draw Menu Text
 200 PAPER tinta:BORDER tinta:INK papel:CLS:OPEN # 6,"w>0,0,24,12,4"
 210 PRINT #6;INK tinta;PAPER papel;CHR$ 14:REM Clear Widow
 250 FOR %c=1 TO 22:LET c=%c:PRINT #6;INVERSE 0;OVER 0;AT c,1;z$(c):NEXT %c
 295 ; Menu Input Control and Delay Logic


 300 LET prv=1:LET %k=0:LET J=0:LET K$="":LET %d=1
 310 PRINT #6;AT prv,0;OVER 1;"                        ":PRINT #6;AT pos,0;OVER 1;INVERSE 1;"                        "
 320 LET J=IN 31:LET K$=INKEY$:IF J<>0 OR K$<>"" THEN LET %d=1:GO TO %360
 330 LET %k=0:IF %d=0 THEN GO TO %320
 340 GO SUB %4000:LET %d=0
 360 IF J=0 AND K$="" THEN GO TO %320
 370 IF J=IN 31 OR K$=INKEY$ THEN IF %k=1 THEN GO TO %440
 380 IF J<>IN 31 AND K$<>INKEY$ THEN LET %k=0:GO TO %430
 390 IF K$<>"6" AND K$<>CHR$(10) AND J<>4 AND K$<>"7" AND K$<>CHR$(11) AND J<>8 THEN GO TO %430
 400 LET %t=PEEK 23672:LET kr=1
 410 LET %r=256+PEEK 23672:LET %r=%(r-t) MOD 255
 420 IF %r<p THEN GO TO %410
 430 IF J=IN 31 OR K$=INKEY$ THEN LET %k=1
 440 BEEP 0.008,-20

 495 ; Menu Control Input
 500 IF K$="0" OR K$=CHR$(13) OR J=16 THEN GO TO %895
 510 IF K$="5" OR K$=CHR$(8) OR J=2 THEN GO TO %695
 520 IF K$="8" OR K$=CHR$(9) OR J=1 THEN GO TO %755
 530 IF K$="6" OR K$=CHR$(10) OR J=4 THEN GO TO %795
 540 IF K$="7" OR K$=CHR$(11) OR J=8 THEN GO TO %845
 550 IF K$="R" OR K$="r" THEN CLOSE # 6:CLS:PRINT AT 10,12;"ERASING...":ERASE "/tmp/knloader/*.*":RUN AT %s:CLEAR:RUN
 560 IF K$="X" OR K$="x" THEN FOR %a=0 TO 15:CLOSE # %a:NEXT %a:RUN AT %s:ERASE
 570 IF K$="C" OR K$="c" OR J=32 THEN LET prev=pos:LET covers=1-covers:GO TO %1400
 580 IF K$="O" OR K$="o" THEN REM Save Options>>>NOT IMPLEMENTED<<<
 590 IF K$="E" OR K$="e" THEN REM Edit Options>>>NOT IMPLEMENTED<<<
 600 IF K$="H" OR K$="h" THEN LET prev=pos:GO TO %1500
 690 GO TO %320

 695 ; Input LEFT
 700 LET prv=pos:IF pag>0 THEN LET pag=pag-1:LET pos=1:GO SUB %5000:GO TO %210
 750 GO TO %320
 755 ; Input RIGHT
 760 LET prv=pos:IF pag<maxpag THEN LET pag=pag+1:LET pos=1:GO SUB %5000:GO TO %210
 790 GO TO %320
 795 ; Input DOWN
 800 LET prv=pos
 810 IF pag<maxpag AND pos=22 THEN LET pag=pag+1:LET pos=1:GO SUB %5000:GO TO %210
 820 IF pag<maxpag AND pos<22 THEN LET pos=pos+1
 830 IF pag=maxpag AND pos<maxpos THEN LET pos=pos+1
 840 GO TO %310
 845 ; Input UP
 850 LET prv=pos
 860 IF pag>0 AND pos=1 THEN LET pag=pag-1:LET pos=22:GO SUB %5000:GO TO %210
 870 IF pos>1 THEN LET pos=pos-1
 880 GO TO %310

 895 ; Prepare to Launch Program
 900 CLOSE # 6:CLS:BORDER 1:ON ERROR GO TO %1300:ON ERROR
 910 PRINT AT 4,13;"> knloader <":PRINT AT 6,12;"© kounch 2020"
 920 PRINT AT 10,1;z$(pos):PRINT AT 12,0;"Mode: ";o(pos);" - ";m$
 930 PRINT AT 14,0;"Dir:":PRINT AT 15,1;w$(pos):PRINT AT 17,0;"File:":PRINT AT 18,1;x$(pos)
 940 LET a$=x$(pos):GO SUB %5300:LET l$=a$:LET a$=w$(pos):GO SUB %5300
 950 IF a$(LEN a$ TO LEN a$)="/" THEN LET a$=a$(1 TO LEN a$-1)
 960 LET c$=y$:IF a$<>" " THEN LET c$=y$+"/"+a$
 970 LET a$=l$:GO SUB %5400:CD c$:DIM d$(255):OPEN # 2,"v>d$":CAT a$:CLOSE # 2:LOAD q$:CD p$
 980 IF d$(1 TO 14)="No files found" THEN GO TO %1300
 990 REM PAUSE 0

 995 ; Save Loader Options
1000 LET mode=o(pos)
1010 LET a$=w$(pos):GO SUB %5300:IF a$(LEN a$ TO LEN a$)="/" THEN LET a$=a$(1 TO LEN a$-1)
1020 LET c$=a$
1030 LET a$=x$(pos):GO SUB %5300

1050 DIM o(1):DIM o$(3,maxpath)
1060 LET o(1)=mode
1070 LET o$(1)=y$
1080 LET o$(2)=c$
1090 LET o$(3)=a$
1100 SAVE "m:klo.tmp"DATA o()
1110 SAVE "m:kls.tmp"DATA o$()
1145 ; Launch Program

1150 BORDER tinta:RUN AT %s:CLEAR:LOAD "knlauncher"
1190 STOP

1295 ; File to load not found
1300 ON ERROR
1310 PRINT AT 7,5;INK 6;PAPER 2;"                      "
1320 PRINT AT 8,5;INK 6;PAPER 2;" ERROR:File Not Found "
1330 PRINT AT 9,5;INK 6;PAPER 2;"                      "
1340 LET J=IN 31:LET K$=INKEY$:IF J<>0 OR K$<>"" THEN GO TO %1340
1350 LET J=IN 31:LET K$=INKEY$:IF J=0 AND K$="" THEN GO TO %1350
1360 LET prev=pos:CLS:GO TO %200

1395 ; Show Cover Status
1400 LET a$="ON ":IF covers=0 THEN LET a$="OFF"
1410 PRINT AT 6,16;"             "
1420 PRINT AT 7,16;" Covers: ";a$;" "
1430 PRINT AT 8,16;"             "
1440 PAUSE 30:GO TO %210

1495 ; Help Window
1500 OPEN # 5,"w>1,1,22,30,4":PRINT #5;INK papel;PAPER tinta;CHR$ 14:CLOSE # 5
1510 OPEN # 5,"w>2,2,20,28,4":PRINT #5;INK tinta;PAPER papel;CHR$ 14
1520 PRINT #5;AT 1,23;"- HELP -"
1530 PRINT #5;AT 3,1;"Use cursor keys or joystick (kempston) to move"
1540 PRINT #5;AT 5,1;"ENTER, 0 or joystick button to launch selected program"
1550 PRINT #5;AT 7,1;"Press R to rebuild the cache from DBT file"
1560 PRINT #5;AT 9,1;"Press C or joystick secondary to hide/show images"
1570 PRINT #5;AT 13,1;"Press X to exit"
1580 PRINT #5;AT 15,1;"Press H to show this help"
1590 PRINT #5;AT 19,5;"Press any key or button to close this window"
1600 LET J=IN 31:LET K$=INKEY$:IF J<>0 OR K$<>"" THEN GO TO %1600
1610 LET J=IN 31:LET K$=INKEY$:IF J=0 AND K$="" THEN GO TO %1610
1620 CLOSE # 5:GO TO %210

3095 ; SUBROUTINES
3096 ;-------------

3995 ; Cover Data
4000 LET mode=o(pos):LET a$=b$(pos):GO SUB %5300
4010 IF mode=0 THEN LET m$="3DOS (Next)"
4020 IF mode=1 THEN LET m$="TAP"
4030 IF mode=2 THEN LET m$="TZX (fast)"
4040 IF mode=3 THEN LET m$="DSK (AUTOBOOT)"
4050 IF mode=4 THEN LET m$="TAP (USR 0)"
4060 IF mode=5 THEN LET m$="TZX (USR0 - Fast)"
4070 IF mode=6 THEN LET m$="TAP (Next)"
4080 IF mode=7 THEN LET m$="TZX (Next - Fast)"
4090 IF mode=8 THEN LET m$="DSK (Custom Boot)"
4100 IF mode=9 THEN LET m$="TAP (PI Audio)"
4110 IF mode=10 THEN LET m$="TZX"
4120 IF mode=11 THEN LET m$="TAP (USR 0 - PI Audio)"
4130 IF mode=12 THEN LET m$="TZX (USR 0)"
4140 IF mode=13 THEN LET m$="TAP (PI Audio - Next)"
4150 IF mode=14 THEN LET m$="TZX (Next)"
4160 IF mode=15 THEN LET m$="NEX"
4170 IF mode=16 THEN LET m$="Snapshot"
4180 IF mode=17 THEN LET m$="Z-Machine Program"
4190 IF mode=18 THEN LET m$="3DOS (128K)"
4390 IF a$<>" " AND covers=1 THEN GO TO %4500

4395 ; Text Data
4400 LAYER 2,0:LAYER 0
4420 OPEN # 5,"w>0,12,24,20,4":PRINT #5;INK papel;PAPER tinta;CHR$ 14:CLOSE # 5
4430 OPEN # 5,"w>1,13,22,18,4":PRINT #5;INK papel;PAPER tinta;CHR$ 14
4440 PRINT #5;AT 3,1;"NAME: ";z$(pos)
4450 PRINT #5;AT 5,1;"MODE: ";m$
4460 PRINT #5; AT 9,1;"FILE: "
4470 PRINT #5;AT 11,0;x$(pos)
4490 CLOSE # 5:RETURN

4495 ; Image Data (Cover)
4500 LET l$=a$:LET a$=w$(pos):GO SUB %5300
4510 IF a$(LEN a$ TO LEN a$)="/" THEN LET a$=a$(1 TO LEN a$-1)
4520 LET c$=y$+"/"+a$+"/"+l$:LET l$=l$((LEN l$-2) TO LEN l$):LET a$=c$
4530 IF l$="BMP" OR l$="bmp" THEN PRINT #6;CHR$ 2;:LAYER 2,0:.$ bmpload a$:LAYER 2,1:LAYER 0:PRINT #6;CHR$ 3;
4540 IF l$="SCR" OR l$="scr" THEN PRINT #6; CHR$ 2;:LAYER 2,0:LAYER 0:LOAD a$ SCREEN$:PRINT #6; CHR$ 3;
4550 IF l$="SLR" OR l$="slr" THEN PRINT #6;CHR$ 2;:LAYER 2,0:LAYER 1,0:LOAD a$ LAYER:LAYER 0:PRINT #6;CHR$ 3;
4560 IF l$="SHR" OR l$="shr" THEN PRINT #6;CHR$ 2;:LAYER 2,0:LAYER 1,1:LOAD a$ LAYER:LAYER 0:PRINT #6;CHR$ 3;
4570 IF l$="SHC" OR l$="shc" THEN PRINT #6;CHR$ 2;:LAYER 2,0:LAYER 1,2:LOAD a$ LAYER:LAYER 0:PRINT #6;CHR$ 3;
4580 IF l$="SL2" OR l$="sl2" THEN PRINT #6;CHR$ 2;:LAYER 2,0:LOAD a$ LAYER:LAYER 2,1:LAYER 0:PRINT #6;CHR$ 3;
4590 RETURN

4995 ; Load Cache
5000 ON ERROR GO SUB %6000:ON ERROR
5010 DIM z$(22,22):DIM o(22):DIM w$(22,maxpath):DIM x$(22,maxpath):DIM b$(22,maxpath)
5020 LOAD "/tmp/knloader/zcch"+STR$ pag+".tmp"DATA z$():LOAD "/tmp/knloader/occh"+STR$ pag+".tmp"DATA o()
5030 LOAD "/tmp/knloader/wcch"+STR$ pag+".tmp"DATA w$():LOAD "/tmp/knloader/xcch"+STR$ pag+".tmp"DATA x$()
5040 LOAD "/tmp/knloader/bcch"+STR$ pag+".tmp"DATA b$()
5050 DIM p(2):LOAD "/tmp/knloader/cache.tmp"DATA p():LET maxpag=p(1):LET maxpos=p(2)
5060 DIM o$(1,maxpath*2):LOAD "/tmp/knloader/ycch.tmp" DATA o$():LET a$=o$(1):GO SUB %5300:LET y$=a$
5070 IF y$(LEN y$ TO LEN y$)="/" AND LEN y$>1 THEN LET y$=y$(1 TO LEN y$-1)
5090 RETURN

5095 ; Load Options
5100 ON ERROR GO SUB %5200:ON ERROR
5110 DIM p(4)
5120 LOAD "opts.tmp"DATA p()
5130 LET tinta=p(1):LET papel=p(2):LET %p=p(3):covers=p(4)
5150 RETURN

5195 ; Save Options
5200 ON ERROR PRINT "Error saving options!!":ERROR  TO e:PRINT e:PAUSE 0:ON ERROR:STOP
5210 DIM p(4)
5220 LET p(1)=tinta:LET p(2)=papel:LET p(3)=%p:LET p(4)=covers
5230 SAVE "opts.tmp"DATA p()
5240 RETURN

5295 ; Strip Spaces from a$
5300 LET m=1:FOR p=1 TO LEN (a$):IF a$(p TO p)<>" " THEN LET m=p
5310 NEXT p
5320 LET a$=a$(1 TO m)
5330 RETURN

5395 ; Split a$ into a$ and l$, using ":"
5400 LET v=1:FOR x=1 TO LEN a$:IF a$(x TO x)=":" THEN LET v=x
5410 NEXT x:LET l$=""
5420 IF a$(v TO v)<>":" THEN GO TO %5490
5430 IF v=LEN a$ THEN GO TO %5450
5440 LET l$=a$(v+1 TO LEN a$):IF v=1 THEN LET a$="":GO TO %5490
5450 LET a$=a$(1 TO v-1)
5490 RETURN

5995 ; Build Cache
6000 DIM d$(40):OPEN # 2,"v>d$":CAT "knloader.bdt":CLOSE # 2
6010 IF d$(1 TO 14)="No files found" THEN GO TO 6500
6020 ON ERROR GO TO 6040:ON ERROR
6030 MKDIR "/tmp/knloader"
6040 ON ERROR PRINT "Cache Build Error!!":ERROR  TO e,l:PRINT e,l:PAUSE 0:ON ERROR:STOP
6050 LET n=0:LET f=0:LET %f=0:LET pag=0:PRINT AT 20,12;"BUILDING CACHE: 0%"
6060 OPEN # 4,"knloader.bdt":DIM #4 TO %g:CLOSE # 4:BANK 12 ERASE 10:LOAD "knloader.bdt" BANK 12

6080 DIM z$(22,22):DIM o(22):DIM w$(22,maxpath):DIM x$(22,maxpath):DIM b$(22,maxpath)
6090 LET lp=1:LET cn=1:IF n>0 THEN LET z$(n)="":LET o(n)=0:LET x$(n)="":LET b$(n)=""
6100 LET m$=BANK 12 PEEK$(%f,~10):LET %c=LEN m$:LET %f=%f+c+1:IF %c=0 THEN LET n=n-1:GO TO 6240
6110 IF n=0 THEN LET y$=m$:GO TO 6240
6120 FOR %a=1 TO %c:LET ln=%a:LET c$=m$(ln TO ln):LET %b=CODE c$
6130 IF %b=13 THEN GO TO 6210
6140 IF c$<>"," THEN GO TO 6210
6150 LET l$="":IF ln>cn THEN LET l$=m$(cn TO ln-1):LET cn=ln+1
6160 IF lp=1 THEN LET z$(n)=l$:IF l$="" THEN IF %f<=g THEN GO TO 6100
6170 IF lp=2 THEN LET o(n)=VAL(l$)
6180 IF lp=3 THEN LET w$(n)=l$
6190 IF lp=4 THEN LET x$(n)=l$
6200 LET lp=lp+1
6210 NEXT %a:IF ln<=cn THEN GO TO 6240
6220 LET l$=m$(cn TO ln):IF lp=4 THEN LET x$(n)=l$
6230 IF lp=5 THEN LET b$(n)=l$
6240 IF %f>=g THEN GO TO 6300
6250 LET n=n+1:IF n<23 THEN GO TO 6090

6295 ;Save cache
6300 IF n<23 THEN LET a$=z$(n):GO SUB 5300:IF a$=" " THEN LET n=n-1
6320 SAVE "/tmp/knloader/zcch"+STR$ pag+".tmp"DATA z$():SAVE "/tmp/knloader/occh"+STR$ pag+".tmp"DATA o()
6330 SAVE "/tmp/knloader/wcch"+STR$ pag+".tmp"DATA w$():SAVE "/tmp/knloader/xcch"+STR$ pag+".tmp"DATA x$()
6340 SAVE "/tmp/knloader/bcch"+STR$ pag+".tmp"DATA b$()
6350 PRINT AT 20,12;"BUILDING CACHE:";%(10*f/g*10);"%"
6360 IF %f<g THEN LET pag=pag+1:LET n=1:GO TO 6080
6380 PRINT AT 20,12;"                       ":LET maxpag=pag:LET maxpos=n:IF maxpos=23 THEN LET maxpos=22
6390 DIM p(2):LET p(1)=maxpag:LET p(2)=maxpos
6400 SAVE "/tmp/knloader/cache.tmp"DATA p()
6410 DIM o$(1,maxpath*2):LET o$(1)=y$:SAVE "/tmp/knloader/ycch.tmp" DATA o$() 
6490 LET pag=0:LET pos=0:BANK 12 CLEAR:RETURN

6495 ; Database Not Found
6500 CLS:PRINT AT 2,2;INK 6;PAPER 2;" ERROR:  Database Not Found "
6510 PRINT AT 5,1;"A file named ";INK 6;"knloader.bdt";INK papel;" must"
6520 PRINT AT 6,0;"exist in the same folder where"
6530 PRINT AT 7,0;"knloader.bas and knlauncher are"
6540 PRINT AT 8,0;"installed."
6550 PRINT AT 12,1;" Please read the installation"
6560 PRINT AT 13,0;"guide for more information."
6590 PAUSE 0:STOP

6995 ; Default Config
7000 ON ERROR ERASE
7010 LET tinta=0:LET papel=7:LET %p=8:LET pag=0:LET maxpag=0:LET maxpos=1:LET maxpath=64
7020 LET covers=1:DIM d$(255):OPEN # 2,"v>d$":PWD #2:CLOSE # 2
7030 LET a$=d$:GO SUB %5300:LET p$=a$(3 TO LEN a$-1):LET q$=a$(1 TO 2):;My Path
7040 DIM d$(255):OPEN # 2,"v>d$":.NEXTVER -v:CLOSE # 2:LET a=VAL(d$):GO SUB %5300:PRINT a
7050 IF a>2.05 THEN RETURN
7060 CLS:PRINT AT 5,3;INK 6;PAPER 2;" ERROR:  NextZXOS Too Old "
7070 PRINT AT 8,1;"Please upgrade the distribution"
7080 PRINT AT 9,0;"in your SD Card to version ";BRIGHT 1;"1.3.2"
7090 PRINT AT 10,0;"or later."
7100 PAUSE 0:STOP
