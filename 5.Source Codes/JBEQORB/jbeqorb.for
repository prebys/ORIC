C$PROG EQORBM
      COMMON /LIN/LDNB,NPOS,CUR(23)
      COMMON /FEQOR/ALPHA,VV
      COMMON /STOREB/LDF,JOFF
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      COMMON /EXTFLD/BLC(73),BCOAX,BFV1,BFV2,BFV3,DEFLV,KEXTRC
      COMMON /PART/Q,AM2,S
      COMMON /CONT/FUDGE,BPOINT,IEQUA,NSKIP,NORDER,IFCALL
      COMMON /SCRAA/YFIT(2522)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /LOWCH/REN,REX,AIIN,AIOUT
      COMMON /DPLOT/LDPLT,NWDS,NTKP
      COMMON /STAPLT/XS,YS,SC,XOT,YOT,XIO,YIO
      COMMON /ANGSTR/CO(181),SI(181)
      COMMON /ORBPRM/SA(4,2),LAB(4,2)
      COMMON /VERS/VNUM,PRMID
C
      DIMENSION ENER(39),REQ(39),VEQ(39),PERIOD(39),TNUR(39),
     *  TNUZ(39),ARA(39,8),ASTOR(8),RAD(39),PROG(2),TPROG(8),IDTEMP(3),
     *  IDPLT(3),CX(39),CY(39),NLAB(4,2),MLAB(3,2)
      INTEGER*4    KWD(20)
      CHARACTER*8  CPROG,VNUM
      CHARACTER*32 CTPROG
      CHARACTER*12 CIDTEMP
      CHARACTER*12 CIDPLT
      CHARACTER*32 CNLAB
      CHARACTER*24 CMLAB
      CHARACTER CKWD*80,LWDBUF*48,PRMID*32
      LOGICAL IEND
C
      EQUIVALENCE (ENER(1),ARA(1,1)),(REQ(1),ARA(1,2)),
     *  (VEQ(1),ARA(1,3)),(PERIOD(1),ARA(1,4)),(TNUR(1),ARA(1,5)),
     *  (TNUZ(1),ARA(1,6)),(CX(1),ARA(1,7)),(CY(1),ARA(1,8))
      EQUIVALENCE (CKWD,KWD),(LWD(1),LWDBUF)
      EQUIVALENCE (CPROG,PROG),(CTPROG,TPROG),(CIDTEMP,IDTEMP)
      EQUIVALENCE (CIDPLT,IDPLT),(CNLAB,NLAB),(CMLAB,MLAB)
      DATA CPROG/'JBEQORB '/
      DATA CTPROG/'EQUILIBRIUM ORBIT PROGRAM       '/
      DATA CIDTEMP/'TCTEMP.BIN  '/
      DATA CIDPLT/'TCPLOT.BIN  '/
      DATA CNLAB/'RFBCBFBCEFBCTFBCRIBCBIBCEIBCTIBC'/
      DATA CMLAB/'EXTRACTION: NEAR CENTER:'/
      DATA VNUM/'v.051507'/     !version number (date) for this program
C
   10 WRITE(6,*)' *** Begin Program JBEQORB ***'

      PRMID='                                '
C
      CALL EQORBNIT
C
      IEQUA=0
      IFCALL=0
      NORDER=4
      NEQ=0
C
      CALL SETSWT
C
      NSK=0
      LDF=10
      LGRED=4
C
      CALL SETUP(PHINIT,JSYM,IA,JHARM)
C
      CALL ORBRAD(EE,AM1,FREQ,HA,RE,BETA,YFIT(2237))
C
      CALL HEADER(PROG,TPROG,PHINIT,JSYM,IA,JHARM)
C
      CALL CFIELD
C
C     WRITE(6,20)
   20 FORMAT('INITIAL RADIUS, FINAL RADIUS, STEP SIZE')
C
      LGRED=8
      NF=0
      CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
   30 IF(IEND) STOP 'EXIT CALLED FROM STATEMENT 30 IN MAIN PROGRAM'
Cjbb
Cjbb
Cjbb      DECODE(48,40,LWD(1)) RIN,RFIN,RSTEP,RBC
Cjbb   40 FORMAT(6F8.0)
Cjbb
      READ(LWDBUF, '(6F8.0)')RIN,RFIN,RSTEP,RBC
      IRBC=RBC+1.0001
      IF(RBC.EQ.0.0) IRBC=29
C
      CALL ZODDHM
C
      IF(RIN.NE.0.0) GO TO 60
C
      RIN=1.0
      IF(EINJ.NE.0.0) CALL ORBRAD(EINJ,AM1,FREQ,HA,RIN,BETA,YFIT(2237))
      RIN=IFIX(RIN)
      RFIN=30.0
      RSTEP=1.0
C
   60 NSTAR=RIN+1.0001
      NEN=RFIN+1.0001
      NSTEP=RSTEP
      IF(NSTEP.EQ.0) NSTEP=1
      NPTS=(NEN-NSTAR)/NSTEP+1
      YT=1.0D-06/FREQ/HA
      RSC=1.0
      VSC=1.0E-06
      IF(RIN.LT.5.0) GO TO 80
      RHO=RE
      RE=RIN
C
      CALL JNJORB(RIN)
C
      CALL ORBEN(RIN,AM1,FREQ,HA,EST)
C
      VR=AM1/(DBLE(EST)+AM1)
      VR=DSQRT(1.0D+00-VR*VR)
      TANG=90.0
C
      CALL ORBIT(TANG,R,DR)
C
      VR=VR*3.0E+10/2.54
      DR=DORBIT(TANG)
      DR=DR*VR/SQRT(R*R+DR*DR)
      RSC=R/RIN
      VSC=DR/VR
      RE=RHO
C
   80 CALL EXTRAK(CUR(1),REN,REX,AIIN,AIOUT,ENER)
C
      CALL ZODDHM
C
      KEXTRC=2
      CALL CALFLD
C
      DO 100 I=1,181
      AN=FLOAT(I-1)*0.03490659
      CO(I)=DCOS(DBLE(AN))
      SI(I)=DSIN(DBLE(AN))
  100 CONTINUE
C
      JJ=1
      DO 120 I=NSTAR,NEN,NSTEP
      RF=I-1
      NSKIP=0
      CALL FOCORB(RF,RSC,VSC,YT,ENER(JJ),REQ(JJ),VEQ(JJ),PERIOD(JJ),
     *  TNUR(JJ),TNUZ(JJ),CX(JJ),CY(JJ),EPSF)
      RAD(JJ)=RF
      IF(I.EQ.IRBC) NEQ=JJ
      IF(NSKIP.EQ.0) JJ=JJ+1
  120 CONTINUE
C
      NPTT=JJ-1
      WRITE(15,180)
      WRITE(15,140)
  140 FORMAT(5X,'RADIUS',5X,'ENERGY',4X,'REQ',8X,'VEQ',9X,
     * 'PERIOD',3X,'TRACE R',5X,'NUR',3X,'TRACE Z',5X,'NUZ',
     *  5X,'R-CEN',3X,'THET-CEN')
C
      DO 200 I=NSTAR,NEN,NSTEP
      R=I-1
C
      DO 160 J=1,8
      CALL INTERP(RAD,ARA(1,J),NPTT,4,R,ASTOR(J))
  160 CONTINUE
C
      CREN=SQRT(ASTOR(7)*ASTOR(7)+ASTOR(8)*ASTOR(8))
      CANGC=ATAN2(ASTOR(8),ASTOR(7))*57.29578
      ANUR=0.0
      ANUZ=0.0
      ASTOR(3)=ASTOR(3)*2.54/3.0E+10
      IF(ABS(ASTOR(5)).LE.2.0) ANUR=1.0+ACOS(ASTOR(5)/2.0)/6.283185
      IF(ABS(ASTOR(6)).LE.2.0) ANUZ=ACOS(ASTOR(6)/2.0)/6.283185
C
      WRITE(15,170) R,(ASTOR(K),K=1,5),ANUR,ASTOR(6),ANUZ
     &  ,CREN,CANGC
C
  170 FORMAT(5X,F6.2,1X,2F9.3,3X,E12.6,F10.5,1X,4F9.4,F9.3,F10.2)
  180 FORMAT(1X,113('-'))
C
  200 CONTINUE
C
      WRITE(15,180)
      IF(NEQ.EQ.0) GO TO 550
C
      LGRED=4
      CALL ACCPRM
C
      IF(SA(1,1).NE.0.0.AND.SA(1,2).NE.0.0) GO TO 550
C
      IRBC=IRBC-1
      WRITE(15,220) IRBC
  220 FORMAT(5X,'ORBIT PARAMETERS FOR THETA=90 DEG FROM BEST',
     &  ' CENTERED ORBITS NEAR R=',I2,'.0')
C
      EST=ENER(NEQ)
      R=REQ(NEQ)
      DR=VEQ(NEQ)
      SR=DR*2.54/3.0E+10
C
      WRITE(6,240) EST,R,SR
  240 FORMAT(1X,3E12.5)
C
      CALL BESTCT(EST,R,DR)
      SR=DR*2.54/3.0E+10
C
      WRITE(6,240) EST,R,SR
C
      CALL SCRATNIT(19)
C
      DO 360 J=1,2
      IF(SA(1,J).NE.0.0) GO TO 360
      NDIR=3-2*J
      CALL RACE(EST,R,DR,SA(1,J),SA(2,J),SA(3,J),SA(4,J),NDIR,NORB)
      SA(2,J)=SA(2,J)*2.54/3.0E+10
      WRITE(6,240) SA(3,J),SA(1,J),SA(2,J)
C
      DO 300 I=1,4
      LAB(I,J)=NLAB(I,J)
  300 CONTINUE
C
      WRITE(19,320) (LAB(I,J),SA(I,J),I=1,4)
  320 FORMAT(A4,'=',F8.3,4X,A4,'=',E12.6,4X,2(A4,'=',F8.3,4X))
C
      WRITE(15,340) (MLAB(I,J),I=1,3),(LAB(I,J),SA(I,J),I=1,4),NORB
  340 FORMAT(5X,3A4,5X,A4,'=',F8.3,4X,A4,'=',E12.6,4X,
     &  2(A4,'=',F8.3,4X),'NORB=',I4)
C
  360 CONTINUE     !continue here and move FILSERT call outside DO loop
C
      CALL FILSERT(19,4,21)
C
  500 WRITE(15,180)
C
      CLOSE(UNIT=19)
C
  550 CLOSE(UNIT=LDF)
      WRITE(6,*)' '        !just a blank line before ending
      STOP ' *** End Program JBEQORB ***' 
      END

C$PROG AEQORB
      SUBROUTINE AEQORB(X,Y,YP)
      DIMENSION Y(7),YP(7)
      COMMON /FEQOR/ALPHA,VV
      DOUBLE PRECISION Y,YP
      CALL FEQORB(X,Y,YP)
      YP(7)=-DSQRT(Y(1)*Y(1)+YP(1)*YP(1))/DBLE(VV)
      RETURN
      END

C$PROG BESTCT
      SUBROUTINE BESTCT(EST,R,DR)
C
C        STARTING WITH ENERGY=EST AND ORBIT PARAMETERS R AND DR, FIND
C        THE BEST CENTERED ORBITS AND ADJUST R AND DR ACCORDINGLY.
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /PART/Q,AM2,S
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /FEQOR/ALPHA,VV
      DIMENSION AID(2,2),AJT(2,2),AJH(2,2),AJ(2,2),AJS(2,2),TAJS(2,2),
     *  COL(2),SJA(2),Y(7),YI(7),YE(7),XO(2),AI(2),YIT(4)
      DOUBLE PRECISION Y,YI,YE
      EXTERNAL AEQORB
      DATA AID,AJT,AJH,SJA,COL,YIT/1.0,0.0,0.0,1.0,16*0.0/
      DATA NA,NE,W,NSTEP,MSTEP,TO,NORB,EPS/7,6,-4.,45,90,0.,0,.1E-04/
C
C        NCYC IS THE NUMBER OF ORBITS OVER WHICH TO PERFORM THE BEST
C        CENTERING.
C
      READ(8,4040) NCYC
4040  FORMAT(I3)
      IF(NCYC.EQ.0) RETURN
      CALL SMAT(AJT,AID,+1.0)
      EET=EST
      ALPHAS=ALPHA
      VVS=VV
      VDEES=VDEE
      VDEE=-VDEE
      YIT(1)=R*0.001
      YIT(4)=DR*0.01
      Y(7)=0.0
      Y(1)=R
      Y(2)=DR
      Q=-Z1
      NSKIP=0
C     WRITE(15,4000) R,DR
4000  FORMAT(1X,2E12.5)
      DO 80 JJ=1,NCYC
      XI=90.0
      DO 25 I=3,6
  25  Y(I)=YIT(I-2)
C
C        CALCULATES EQS. OF MOTION FOR AN ORBIT CYCLE.
C
      DO 30 I=1,2
      VDEE=-VDEE
      CALL KICK(EET,Y(7),TO,NORB)
      CALL QKUTTA(AEQORB,NA,XI,NSTEP,W,Y)
      IF(NSKIP.NE.0) GO TO 100
  30  CONTINUE
      NORB=NORB+1
      AJ(1,1)=Y(3)/YIT(1)
      AJ(2,1)=Y(4)/YIT(1)/1.0E+07
      AJ(1,2)=Y(5)/YIT(4)/1.0E-07
      AJ(2,2)=Y(6)/YIT(4)
      DO 40 I=3,6
  40  YI(I)=YIT(I-2)
      YI(1)=Y(1)
      YI(2)=Y(2)
      XI=90.0
      NTP=0
C
C        CALCULATES CORRESPONDING EQUIL. ORBIT.
C
      CALL OPTEQU(YI,YE,EPS,NE,W,XI,MSTEP,NTP)
      IF(NSKIP.NE.0) GO TO 100
C
C        XO(1) AND XO(2) ARE DEVIATIONS BETWEEN ACTUAL ORBIT AND
C        EQUIL. ORBIT.
C
      XO(1)=Y(1)-YI(1)
      XO(2)=(Y(2)-YI(2))/1.0E+07
C     WRITE(15,4020) JJ,Y(1),Y(2),YI(1),YI(2),XO(1),XO(2)
4020  FORMAT(1X,I2,2X,8E12.5)
C     WRITE(15,4020) JJ,AJ(1,1),AJ(1,2),AJ(2,1),AJ(2,2)
      CALL SMAT(AJ,AID,-1.0)
      CALL MMAT(AJ,AJT,AJS)
      CALL SMAT(AJ,AID,+1.0)
      CALL MMBT(AJ,AJT)
C     WRITE(15,4020) JJ,AJT(1,1),AJT(1,2),AJT(2,1),AJT(2,2)
      DO 70 L=1,2
  70  AI(L)=XO(L)-SJA(L)
      DO 75 L=1,2
      COL(L)=COL(L)+AJS(1,L)*AI(1)+AJS(2,L)*AI(2)
  75  SJA(L)=XO(L)
      CALL MMAT(AJS,AID,TAJS)
      TAJS(1,2)=AJS(2,1)
      TAJS(2,1)=AJS(1,2)
      CALL MMBT(TAJS,AJS)
      CALL SMAT(AJH,AJS,+1.0)
C     WRITE(15,4020) JJ,COL(1),COL(2),AJH(1,1),AJH(1,2),AJH(2,1),
C    *  AJH(2,2),SJA(1),SJA(2)
  80  CONTINUE
      DET=AJH(1,1)*AJH(2,2)-AJH(1,2)*AJH(2,1)
      XO(1)=(-AJH(2,2)*COL(1)+AJH(1,2)*COL(2))/DET
      XO(2)=(AJH(2,1)*COL(1)-AJH(1,1)*COL(2))/DET/1.0E-07
C
C        XO(1) AND XO(2) ARE THE REQUIRED ADJUSTMENTS FOR R AND DR
C        RESPECTIVELY.
C
      R=R+XO(1)
      DR=DR+XO(2)
C     WRITE(15,4020) I,R,DR,XO(1),XO(2),DET
      ALPHA=ALPHAS
      VV=VVS
      VDEE=VDEES
      RETURN
 100  WRITE(15,2020) NTP,XI,Y(1),Y(2)
2020  FORMAT(1H0,'*** PARTICLE ORBIT OUT OF CYCLOTRON--',I4,3E12.5)
      STOP 'EXIT CALLED FROM SUBROUTINE BESTCT'
      RETURN
      END

C$PROG BINTP2
      SUBROUTINE BINTP2(X,R,BZ,DBZ)
C
C        CALCULATES FIELD AND DB/DZ AT LOCATION (X,R) BY INTERPOLATION
C        OVER RADIUS.
C
      COMMON /STOREB/LDF,JOFF
      DIMENSION IB(4)
      DATA XI,RI/0.0,0.0/
      AB=ABS(X-XI)+ABS(R-RI)
      IF(AB.LT.0.1E-03) RETURN
      IR=R
      IDEL=(R-FLOAT(IR))*1000.
      IANG=X*100.
      IR1=IR-2
      DO 20 I=1,4
      II=IR1+I
      JJ=IABS(II)+1
      JANG=IANG
      IF(II.LT.0) JANG=-IANG
      IF(JJ.GT.150) GO TO 30
      IF(LDF.EQ.10) IB(I)=KFIELD(JJ,JANG)/100
      IF(LDF.NE.10) IB(I)=IFIELD(JJ,JANG)/100
  20  CONTINUE
      BZ=IINTRP(IB,IDEL)
      DBZ=((IB(4)-IB(2))*IDEL+(IB(3)-IB(1))*(1000-IDEL))/2000
  25  RI=R
      XI=X
      RETURN
  30  BZ=0.0
      DBZ=0.0
      GO TO 25
      END

C$PROG BINTP5
      SUBROUTINE BINTP5(X,R,BZ,DBZ,DBT)
C
C        CALCULATE BY INTERPOLATION FIELD, DB/DZ AND DB/DTHETA AT
C        POINT (X,R).
C
      COMMON /STOREB/LDF,JOFF
      DIMENSION IB(4,3),BZZ(3)
      DATA XI,RI/0.0,0.0/
      AB=ABS(X-XI)+ABS(R-RI)
      IF(AB.LT.0.1E-03) RETURN
      IR=R
      IDEL=(R-FLOAT(IR))*1000.
      IANG=X*100.
      IR1=IR-2
      DO 20 J=1,3
      DO 20 I=1,4
      II=IR1+I
      JJ=IABS(II)+1
      JANG=IANG+200*(J-2)
      IF(II.LT.0) JANG=-JANG
      IF(JJ.GT.150) GO TO 30
      IF(LDF.EQ.10) IB(I,J)=KFIELD(JJ,JANG)/100
      IF(LDF.NE.10) IB(I,J)=IFIELD(JJ,JANG)/100
  20  CONTINUE
      DO 22 J=1,3
  22  BZZ(J)=IINTRP(IB(1,J),IDEL)
      BZ=BZZ(2)
      DBZ=((IB(4,2)-IB(2,2))*IDEL+(IB(3,2)-IB(1,2))*(1000-IDEL))
     * /2000
      DBT=(BZZ(3)-BZZ(1))*14.323945
  25  RI=R
      XI=X
      RETURN
  30  BZ=0.0
      DBT=0.0
      DBZ=0.0
      GO TO 25
      END

C$PROG CFIELD    - Creates file on disk to hold field mesh
C
C     9/28/05  -  Modified by JBB to allow override and force using 
C           existing file field even though identifiers don't match.  
C           For use with the JBACCEL program.
C
C     4/09/06  -  output of error message rewritten
C
C     3/26/07  -  activated option to generate new field if desired
C 
      SUBROUTINE CFIELD
C
C     ------------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      INTEGER*4   MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      CHARACTER*112 CMSSG
      CHARACTER*1 AKSEL
      EQUIVALENCE (CMSSG,MSSG)
C     ------------------------------------------------------------------
      COMMON /TIMM/DAT(4),DTM(8)
      COMMON /STOREB/LDF,JOFF
      INTEGER*4 IFT(3),IOS,JOFF,I
      REAL*4    DAT,SAT(4)
C     ------------------------------------------------------------------
C
      MSSG='    '
      LDF=10
      JOFF=0
C
      OPEN(UNIT       = LDF,
     &     FILE       = 'tcfield.bin',
     &     STATUS     = 'OLD',
     &     ACCESS     = 'DIRECT',
     &     RECL       = 256,   !this version for MS Fortran
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.EQ.0) GO TO 100
C
      OPEN(UNIT       = LDF,
     &     FILE       = 'tcfield.bin',
     &     STATUS     = 'NEW',
     &     ACCESS     = 'DIRECT',
     &     RECL       = 256,   !this version for MS Fortran
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.EQ.0) RETURN    !file doesn't yet exist so must calculate
      GO TO 200
C
C     ------------------------------------------------------------------
C     If file already exits, check field identifier against present
C     identifier from TCISOC.CAR. If different, set JOFF=0, setting
C     flag to calculate new field mesh.  Then, offer option to bypass
C     calculation of new field by setting JOFF=10.  If the same, then 
C     set JOFF=10, but offer option to recalculate the field (JOFF=0).
C     ------------------------------------------------------------------
C
  100 JOFF=10
      CALL SNAIS(LDF,0)
      CALL TCREED(LDF,SAT(1),8)
C
C     Before comparing identifiers, print out values on console for
C       user reference
C
  104 WRITE(6,4104) (DAT(I), I=1,4)
 4104 FORMAT(/'    COMPARISON OF DATE/TIME STAMPS:'/
     1  '      DAT(1:4): ',2A4,2X,2A4,'    (tcisoc.car)')
  106 WRITE(6,4106) (SAT(I), I=1,4)
 4106 FORMAT('      SAT(1:4): ',2A4,2X,2A4,'    (tcfield.bin)'/)
C
      DO 110 I=1,4
      IF(DAT(I).NE.SAT(I)) JOFF=0
  110 CONTINUE
C
      IF(JOFF.EQ.0) THEN
C
  120 WRITE(6,4120)
 4120 FORMAT(/'  *** TCFIELD.BIN DATE DOES NOT MATCH TCISOC.CAR ***'//,
     1  '  OPTIONS: 1) Generate new tcfield.bin file (default)'/9X,
     2  '  2) Override default and use existing tcfield.bin file',/
     3  '  SELECT OPTION: ',$)
  122 READ(5,4122) AKSEL
 4122 FORMAT(A1)
      IF(AKSEL.EQ."2") THEN   
        JOFF=10   !this forces use of existing field data
      ELSE
        JOFF=0    !this forces calculating new field data
      END IF
C
      ELSE
  130 WRITE(6,4130)
 4130 FORMAT(/'  *** TCFIELD.BIN DATE MATCHES TCISOC.CAR ***'//,
     1  '  OPTIONS: 1) Use existing tcfield.bin file (default)'/9X,
     2  '  2) Override default and generate new tcfield.bin file',/
     3  '  SELECT OPTION: ',$)
  132 READ(5,4122) AKSEL
      IF(AKSEL.EQ."2") THEN
        JOFF=0    !this forces calculating new field data
      ELSE
        JOFF=10   !this forces use of existing field data
      END IF
      END IF
C
      IF(JOFF.EQ.0) WRITE(6,4140)
 4140 FORMAT(/'      New field will be calculated')
      WRITE(*,*)'  '    !blank line for output formatting
C
  150 RETURN
C
C     ******************************************************************
C     Output error message and terminate run
C     ******************************************************************
C
  200 WRITE(CMSSG,4200)
 4200 FORMAT('attempting to open - tcfield.bin')
C
  210 WRITE(LOGUP,4210)IOS,CMSSG
 4210 FORMAT(1X,'---'/1X,'File opening error in subroutine CFIELD',
     1  10X,'Error #',I4/1X,'Failed while ',A40)
      WRITE(LOGUT,4210)IOS,CMSSG
      STOP
      END

C$PROG DORBIT
      FUNCTION DORBIT(ANG)
C
C        RETURNS DERIVATIVE OF ANALYTIC EQUIL. ORBIT WITH
C        RESPECT TO ANGLE AT ANGLE=ANG.
C
      DIMENSION AR(2)
      BANG=ANG+0.01
      CALL ORBIT(BANG,AR(1),DR)
      BANG=ANG-0.01
      CALL ORBIT(BANG,AR(2),DR)
      DORBIT=(DBLE(AR(1))-AR(2))*2864.789
      RETURN
      END

C$PROG EEQORB
      SUBROUTINE EEQORB(X,Y,YP)
C
C        ROUTINE EVALUATES DERIVATIVES DY(I)/DX.
C        INCLUDES EQS. NECESSARY FOR DETERMINING BOTH R
C        AND Z FOCUSING.
C
      COMMON /ANGSTR/CO(181),SI(181)
      DOUBLE PRECISION AV,SV,SBZ,VB,Y,YP
      DIMENSION Y(14),YP(14)
      COMMON /FEQOR/ALPHA,VV
      VB=VV
      SV=DSQRT(VB*VB-Y(2)*Y(2))
      YX=Y(1)
      CALL BINTP5(X,YX,BZ,DBZ,DBT)
      YP(1)=Y(1)*Y(2)/SV
      YP(2)=SV-ALPHA*Y(1)*BZ
      SBZ=(BZ+Y(1)*DBZ)*ALPHA
      AV=VB*VB*Y(1)/SV/SV/SV
      DO 20 J=3,5,2
      YP(J)=Y(2)*Y(J)/SV+AV*Y(J+1)
  20  YP(J+1)=-Y(2)*Y(J+1)/SV-Y(J)*SBZ
      SBZ=(Y(1)*DBZ-Y(2)*DBT/SV)*ALPHA
      DO 30 J=7,9,2
      YP(J)=Y(1)*Y(J+1)/SV
  30  YP(J+1)=Y(J)*SBZ
      YP(11)=DSQRT(Y(1)*Y(1)+YP(1)*YP(1))/VB
      YP(12)=Y(1)/6.283185
      J=IFIX(X)/2+180
      J=MOD(J,180)+1
      YP(13)=YP(12)*CO(J)
      YP(14)=YP(12)*SI(J)
      RETURN
      END

C$PROG ENISOC
      SUBROUTINE ENISOC(RF,EF,VT,VR)
C
C        SET KINEMATIC PARAMETERS FOR SOLVING EQS. OF MOTION.
C
      COMMON /FEQOR/ALPHA,VV
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      BETA=RF*FREQ*HA/1.8784673D+03
      EF=AM1*(1.0/SQRT(1.0-BETA*BETA)-1.0)
      VT=AM1/(EF+AM1)
      VV=3.0E+10/2.54*DSQRT(1.0D+00-VT*VT)
      ALPHA=8.987543E+06*Z1/AM1*VT
      VR=VV
      RETURN
      END

C$PROG EQORB     - Calls equ orbit finder routine
C
      SUBROUTINE EQORB(Y1,Y2,Y3,Y6,R,V)
C
C     CALL EQUIL. ORBIT FINDER ROUTINE.  THEN CALLS INTERGRATION
C     ROUTINE TO CALCULATE ORBIT IN FINE STEPS.
C     -RETURNS ORBIT AND DR/DTHETA IN 2. DEGREE STEPS IN
C      ARRAYS R AND V, RESPECTIVELY.
C
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /FEQOR/ALPHA,VV
      DIMENSION YI(6),Y(6),R(1),V(1)
      DOUBLE PRECISION YI,Y
      EXTERNAL FEQORB
C
      EPS=0.1E-04
      NE=6
      YI(1)=Y1
      YI(2)=Y2
      YI(3)=Y3
      YI(6)=Y6
      YI(4)=0.0
      YI(5)=0.0
      W=4.0
      XI=90.0
      NSTEP=90
      NTP=0
      NSKIP=0
      CALL DSWTCH(8,KWRT)
      IF(KWRT.EQ.1) WRITE(15,1000) (YI(I),I=1,6)
1000  FORMAT(1H ,6E12.5)
      CALL OPTEQU(YI,Y,EPS,NE,W,XI,NSTEP,NTP)
      IF(NSKIP.NE.0) GO TO 80
      DO 40 I=1,NE
  40  Y(I)=YI(I)
      XI=90.0
      W=4.0
      R(1)=Y(1)
      V(1)=Y(2)
      NSTEP=1
      DO 50 J=1,180,2
      CALL QKUTTA(FEQORB,NE,XI,NSTEP,W,Y)
      R(J+2)=Y(1)
  50  V(J+2)=Y(2)
      DO 55 J=2,180,2
      R(J)=(R(J+1)+R(J-1))/2.0
  55  V(J)=(V(J+1)+V(J-1))/2.0
      EP=DABS(Y(1)/YI(1)-1.0)+DABS((Y(2)-YI(2))/VV)
      IF(NTP.GT.15) GO TO 60
      RETURN
  60  WRITE(15,2000) NTP,EP
2000  FORMAT(1H0,'**** EQUILIBRIUM ORBIT DID NOT CONVERGE IN ',I2,
     *  ' ITERATIONS'/1H ,'     EPS=',E12.5)
      RETURN
  80  IF(NSKIP.EQ.1) WRITE(15,2020) NTP,XI,Y(1),Y(2)
2020  FORMAT(1H0,'*** PARTICLE ORBIT OUT OF CYCLOTRON--',
     *  I4,3E12.5)
      STOP 'EXIT CALLED FROM SUBROUTINE EQORB'
      END

C$PROG EQORBNIT  - Opens files, etc for TCEQORB
C
      SUBROUTINE EQORBNIT
C
      IMPLICIT NONE
C
C     ------------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      COMMON/TIMM/DAT(4),DTM(8)
      INTEGER*4 IOS,I,DTM,DAT
      INTEGER*4   MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      CHARACTER*112 CMSSG
      EQUIVALENCE (CMSSG,MSSG)
C     ------------------------------------------------------------------
C
      DO 10 I=1,28
      MSSG(I)='    '
   10 CONTINUE
      NAMPROG(1)='JBEQ'
      NAMPROG(2)='ORB '
      MSGF='    '
      LISFLG='LON '
      LOGUT=6
      LOGUP=14
C
      OPEN(UNIT       = 14,
     &     FILE       = 'jbeqorb.log',
     &     STATUS     = 'UNKNOWN',
     &     ACCESS     = 'APPEND')
C
Cjbb
C      - get date and time and write to log file
C          this info will also be used by subroutine HEADER
C
      CALL GETDAT(DTM(1),DTM(2),DTM(3))
      CALL GETTIM(DTM(5),DTM(6),DTM(7),DTM(8))
   20 WRITE(14,4020)DTM(2),DTM(3),DTM(1),DTM(5),DTM(6),DTM(7),
     1  DTM(8)/100
 4020 FORMAT(///70('-')/2X,2(I2.2,'/'),I4,'    Log file opened at ',
     1  2(I2.2,':'),I2.2,'.',I1/45('-'))
Cjbb
      OPEN(UNIT       = 4,
     &     FILE       = 'tcisoc.car',
     &     STATUS     = 'OLD',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 100
C
      OPEN(UNIT       = 8,
     &     FILE       = 'jbeqorb.int',
     &     STATUS     = 'OLD',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 110
C
      OPEN(UNIT       = 9,
     &     FILE       = 'tcmagprm.bin',
     &     STATUS     = 'OLD',
     &     ACCESS     = 'DIRECT',
     &     RECL       = 256,      !this version for MS Fortran
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 120
C
      OPEN(UNIT       = 15,
     &     FILE       = 'jbeqorb.prn',
     &     STATUS     = 'UNKNOWN',
     &     IOSTAT     = IOS)
C
      CLOSE(UNIT      = 15, 
     &      STATUS    = 'DELETE')
C
      OPEN(UNIT       = 15,
     &     FILE       = 'jbeqorb.prn',
     &     STATUS     = 'NEW',
     &     IOSTAT     = IOS)
C
C
      RETURN
C
C     ******************************************************************
C     Return error messages and EXIT
C     ******************************************************************
C
  100 WRITE(CMSSG,105)
  105 FORMAT('attempting to open - tcisoc.car')
      GO TO 200
C
  110 WRITE(CMSSG,115)
  115 FORMAT('attempting to open - tceqorb.int')
      GO TO 200
C
  120 WRITE(CMSSG,125)
  125 FORMAT('attempting to open - tcmagprm.bin')
      GO TO 200
C
  200 WRITE(LOGUP,4200)IOS,CMSSG
 4200 FORMAT(1X,'---'/1X,'File opening error in subroutine EQORBNIT',
     1  10X,'Error #',I4/1X,'Failed while ',A40)
      WRITE(LOGUT,4200)IOS,CMSSG
      STOP 'EXIT CALLED FROM SUBROUTINE EQORBNIT'
      END

C$PROG FDDV5
      FUNCTION FDDV5(A,I)
C
C        CALCULATES 2ND DERIVATIVE OF A AT I.
C
      DIMENSION A(1)
      FDDV5=-30.*A(I)+16.*(A(I+1)+A(I-1))-A(I+2)-A(I-2)
      FDDV5=FDDV5/12.
      RETURN
      END

C$PROG FEQORB
      SUBROUTINE FEQORB(X,Y,YP)
C
C        ROUTINE EVALUATES DERIVATIVES YP(I)=DY(I)/DX.
C
      COMMON /TEM/BZ,DBZ
      DOUBLE PRECISION AV,SV,SBZ,VB,Y,YP
      DIMENSION Y(6),YP(6)
      COMMON /FEQOR/ALPHA,VV
      VB=VV
Cjbb    ad hoc patch for bypassing negative square root problem
      IF(VB*VB.GE.Y(2)*Y(2)) THEN
        SV=DSQRT(VB*VB-Y(2)*Y(2))
      ELSE
        SV=0.79*VB
        WRITE(6,4000) SV
 4000   FORMAT(/' ***KLUDGE BYPASS FOR NEGATIVE ROOT IN FEQORB',E14.6)
      END IF
C
      YX=Y(1)
      CALL BINTP2(X,YX,BZ,DBZ)
      YP(1)=Y(1)*Y(2)/SV
      YP(2)=SV-ALPHA*Y(1)*BZ
      SBZ=(BZ+Y(1)*DBZ)*ALPHA
      AV=VB*VB*Y(1)/SV/SV/SV
      DO 20 J=3,5,2
      YP(J)=Y(2)*Y(J)/SV+AV*Y(J+1)
  20  YP(J+1)=-Y(2)*Y(J+1)/SV-Y(J)*SBZ
      RETURN
      END

C$PROG FILSERT   - Inserts contents of one file into another
C
      SUBROUTINE FILSERT(LUI,LUO,LINUM)
C
C     - minor changes for file handling
C       j ball      5/22/06
C
C     5/25/06 - added NXT to value of NCOP to include X-cards
C               in line count for tcisoc.car file
C
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
C
      INTEGER*4 IWD(20)
      CHARACTER*80 CIWD
      EQUIVALENCE (CIWD,IWD)
C
      DATA LSC/37/                    !Init scratch file
C
      OPEN(UNIT       = LSC,
     &     STATUS     = 'SCRATCH',
     &     IOSTAT     = IOS)
C
      REWIND LUI
      REWIND LUO
C
      NOUT=0
   10 READ(LUO,15,END=50) IDUM           !Count #lines on output
   15 FORMAT(20A4)
      NOUT=NOUT+1
      GO TO 10
C
   50 REWIND LUO
C
      NCOP=LINUM-1+NXT                   !add X-cards to line count
      NDUN=0
      NL=0
C
      DO 60 N=1,NCOP                     !Copy LINUM-1 lines to scratch
      READ(LUO,15,END=100)IWD
      WRITE(LSC,15)IWD
      NDUN=NDUN+1
      NL=NL+1
   60 CONTINUE
C
  100 IF(NDUN.GE.NCOP) GO TO 200         !Did we get as many as requested
C
      DO 110 I=1,20                      !If not, blank remaining request
      IWD(I)='    '
  110 CONTINUE
C
      NDO=NCOP-NDUN
C
      DO 120 N=1,NDO                     !Blank out remaining request
      WRITE(LSC,15)IWD
  120 CONTINUE
C
  200 READ(LUI,15,END=300)IWD            !Copy all input lines to scratch
      WRITE(LSC,15)IWD
      IF(NL.LT.NOUT) READ(LUO,15)IDUM    !Skip over those lines on output
      NL=NL+1
      GO TO 200
C
  300 IF(NL.GE.NOUT) GO TO 400
C
  320 READ(LUO,15,END=400)IWD            !Copy remaining output to scratch
      WRITE(LSC,15)IWD
      NL=NL+1
      GO TO 320
C
  400 REWIND LUO
      REWIND LSC
C
  410 READ(LSC,15,END=500)IWD            !Copy all scratch to output
      WRITE(LUO,415)CIWD(1:LEN(CIWD))
  415 FORMAT(A)
      GO TO 410
C
  500 CLOSE(LSC)
      RETURN
      END

C$PROG FINTRP
      FUNCTION FINTRP(Y,DEL)
C
C        INTERPOLATION ROUTINE.
C
      DIMENSION Y(4)
      YT=Y(1)+(Y(2)-Y(1))*DEL
      YS=Y(3)-2.*Y(2)
      YT=YT+0.5*(YS+Y(1))*DEL*(DEL-1.0)
      YS=3.*(Y(3)-Y(2))
      YS=Y(4)-YS
      YT=YT+(YS-Y(1))*DEL*(DEL-1.0)*(DEL-2.)/6.
      FINTRP=YT
      RETURN
      END

C$PROG FOCORB
      SUBROUTINE FOCORB(RF,RSC,VSC,YT,EF,REQ,VEQ,PERIOD,TNUR,
     *  TNUZ,CXC,CYC,EPSS)
C
C        ROUTINE DETERMINES EQUIL. ORBIT PARAMETERS AND
C        FOCUSING PROPERTIES.
C
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      DIMENSION YI(14),Y(14)
      DOUBLE PRECISION YI,Y
      EXTERNAL EEQORB
      XI=90.0
      W=4.0
      NSTEP=90
      NTP=0
      CALL ENISOC(RF,EF,VT,VV)
      CALL SISOC(YI,RF,VV,RSC,VSC)
      NE=6
      EPS=0.1E-04
      CALL OPTEQU(YI,Y,EPS,NE,W,XI,NSTEP,NTP)
      IF(NSKIP.NE.0) GO TO 50
      RSC=Y(1)/RF
      VSC=Y(2)/VV
      XI=90.
      NE=14
      DO 20 I=1,NE
  20  Y(I)=YI(I)
      CALL QKUTTA(EEQORB,NE,XI,NSTEP,W,Y)
      IF(NSKIP.NE.0) GO TO 50
      TNUR=Y(3)/YI(3)+Y(6)/YI(6)
      TNUZ=Y(7)/YI(7)+Y(10)/YI(10)
      PERIOD=Y(11)/YT
      RF=DABS(Y(12))
      REQ=YI(1)
      VEQ=YI(2)
      CXC=Y(13)
      CYC=Y(14)
      RETURN
  50  WRITE(15,3000) RF
3000  FORMAT(1X,'*** OUT OF CYCLOTRON--',4X,F10.2)
      RETURN
      END

C$PROG HEADER
C
      SUBROUTINE HEADER(PROG,A,PHINIT,ISYM,IAM1,JHARM)
C
C     OUTPUTS HEADER INFORMATION TO PRINTER
C       (This version modified by JBB for output to console)
C
C     Modified to include a parameter set ID, and to replace the
C      old IDATE and TIME subs with the newer DATE_AND_TIME subroutine
C         J. Ball     27-Apr-2005      
C
C     Additional modifications made for transition to MS Fortran:
C      DEC Fortran DATE_AND_TIME subroutine replaced with GETDAT and
C       GETTIM subroutine calls
C      ENCODE routine replaced with write to internal file
C      Program version number added to header output
C         J. Ball     3-Apr-2006       Date of latest mod: 06-May-2006
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /TIMM/DAT(4),DTM(8)
      COMMON /VERS/VNUM,PRMID
      DIMENSION PROG(2),A(8)
      INTEGER DTM,DTM1
      CHARACTER DUM*12,PRMID*32,DTFIL*16,CC*1,CS*1,VNUM*8,ET*8
C Declare DAT(4) a character string, which it's clearly supposed to be
C EjP 20230712
      CHARACTER*4 DAT
C
Cjbb    - use new time and date subroutine
Cjbb  CALL DATE_AND_TIME(DUM,DUM,DUM,DTM)
Cjbb    - this is for DEC Fortran.  For MS Fortran use as follows:
C     CALL GETDAT(DTM(1),DTM(2),DTM(3))
C     CALL GETTIM(DTM(5),DTM(6),DTM(7),DTM(8))
Cjbb    - as of 4/27/06 these have been moved to ACCELNIT subroutine
Cjbb      so that the info is available earlier in the program
      ET='        '
Cjbb    - have no interest in upgrade so comment out following 2 lines
C      CALL SSWTCH(12,KSTAT1)
C      IF(KSTAT1.EQ.1) ET=8H UPGRADE
Cjbb    - so let's use it instead for program version number
      ET=VNUM
Cjbb    - now get ID for parameter set for header
C  100 WRITE(6,4100)
C 4100 FORMAT(/'    INPUT PARAMETER SET ID FOR HEADER: ',$)
C  120 READ(5,4120) PARAMID
C 4120 FORMAT(A12)
Cjbb
  200 WRITE(15,4200) PROG,ET,PRMID,DTM(2),DTM(3),DTM(1),A,
     *  DTM(5),DTM(6),DTM(7),DTM(8)/100
Cjbb
 4200 FORMAT(1X,113('-')/1X,': ',2A4,':',1X,A8,
     *  14X, 'PARAMETER SET: ',A32,15X,
     *  'DATE:',2(I2.2,'/'),I4,' :'/1X,': ',8A4,62X,'TIME:',
     *  2(I2.2,':'),I2.2,'.',I1,' :'/ 1X,113('-'))
      IZT=Z1
  220 WRITE(15,4220) IAM1,ISYM,IZT,EE,AM1,EINJ,DAT,RE,FREQ,VDEE,PHINIT,
     *  JHARM
 4220 FORMAT(/1X,I3,A2,1X,I2,'+',4X,'ENERGY=',F7.2,4X,'MASS=',F10.2
     *  ,4X,'INJECTION ENERGY=',F8.3,30X,2A4/1X,105X,2A4/1X,
     *  'EXTRACTION RADIUS=',F7.3,3X,'FREQUENCY=',F8.5,' MHZ',
     *  3X,'DEE VOLTAGE=',F5.1,' KV',3X,'PHI0=',F6.2,' DEG',3X,
     *  'HARMONIC=',I1)
      IF(PROG(2).EQ.'OC  ') DAT(1)='    '
      IF(DAT(1).NE.'    ') GO TO 400
Cjbb            - change encode for new time and date output
Cjbb    300 ENCODE(16,4300,DAT(1)) DTM(2),DTM(3),DTM(1),DTM(5),DTM(6),DTM(7)
Cjbb   4300 FORMAT(I2,2('/',I2), 2(I2,':'),I2)
Cjbb       - this will be replaced with a write to and internal file
  300 DTFIL='                '
      CC=':'
      CS='/'
      DTM1=DTM(1)-2000    !get 2-digit year
      WRITE(DTFIL,'(I2.2,A1,I2.2,A1,I2.2,I2.2,A1,I2.2,A1,I2.2)')
     1  DTM(2),CS,DTM(3),CS,DTM1,DTM(5),CC,DTM(6),CC,DTM(7)
      DO 320 I=1,4
  320 DAT(I)=DTFIL(4*I-3:4*I)
C
  400 RETURN
      END

C$PROG INTERP
      SUBROUTINE INTERP(X,Y,NPTS,NTERM,XIN,YOUT)
C        GENERAL INTERPOLLATION PROGRAM.
      DIMENSION X(1),Y(1),DELTA(10),A(10)
      NTERMS=NTERM
  11  DO 19 I=1,NPTS
      IF(XIN-X(I)) 13,17,19
  13  I1=I-NTERMS/2
      IF(I1) 15,15,21
  15  I1=1
      GO TO 21
  17  YOUT=Y(I)
  18  GO TO 61
  19  CONTINUE
      I1=NPTS-NTERMS+1
  21  I2=I1+NTERMS-1
      IF(NPTS-I2) 23,31,31
  23  I2=NPTS
      I1=I2-NTERMS+1
  25  IF(I1) 26,26,31
  26  I1=1
  27  NTERMS=I2-I1+1
  31  DENOM=X(I1+1)-X(I1)
      DELTAX=(XIN-X(I1))/DENOM
      DO 35 I=1,NTERMS
      IX=I1+I-1
  35  DELTA(I)=(X(IX)-X(I1))/DENOM
  40  A(1)=Y(I1)
  41  DO 50 K=2,NTERMS
      PROD=1.
      SUM=0.
      IMAX=K-1
      IXMAX=I1+IMAX
      DO 49 I=1,IMAX
      J=K-I
      PROD=PROD*(DELTA(K)-DELTA(J))
  49  SUM=SUM-A(J)/PROD
  50  A(K)=SUM+Y(IXMAX)/PROD
  51  SUM=A(1)
      DO 57 J=2,NTERMS
      PROD=1.
      IMAX=J-1
      DO 56 I=1,IMAX
  56  PROD=PROD*(DELTAX-DELTA(I))
  57  SUM=SUM+A(J)*PROD
  60  YOUT=SUM
  61  RETURN
      END

C$PROG JNJORB
      SUBROUTINE JNJORB(RET)
C
C        CALCULATE COEFS. NECESSARY FOR CONSTRUCTING EQUIL. ORBIT AT
C        RADIUS=RET FROM ANALYTIC FORMALISM.
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /SCRAA/IBAV(153),IBFR(22,39),IPHIR(22,39),IDUM(345),
     *IHH(22),SIG(85),AP(136),AA(4),BB(4),CC(8),DD(4),A(22),B(22),GAM
      IL=RET
      DEL=RET-FLOAT(IL)+1.0
      IL=IL+1
      II=3
      DO 8 I=1,8
      JK=IL+I-4
   8  CC(I)=FLOAT(IBAV(JK))/100.
      DO 10 I=1,4
      RO=IL+I-3
      DD(I)=RO*RO*FDDV5(CC(I),II)/CC(I+2)
  10  AA(I)=RO*FDV5(CC(I),II)/CC(I+2)
      UPRIM=FINTRP(AA,DEL)
      UPPRIM=FINTRP(DD,DEL)
      GAM=0.0
      DO 25 J=1,22
      KK=IHH(J)-1
      AC=FLOAT(KK*KK-1)-UPRIM
      IF(AC.EQ.0.0) AC=1.0
      DO 16 I=1,8
      JK=IL+I-4
  16  CC(I)=FLOAT(IBFR(J,JK))/FLOAT(IBAV(JK))
      DO 18 I=1,4
      JK=IL+I-4
  18  CC(I)=FLOAT(JK+1)*FDV5(CC(I),II)
      AP(J)=FINTRP(CC,DEL)
      DO 20 I=1,4
      JK=IL+I-2
      AA(I)=FLOAT(IBFR(J,JK))/FLOAT(IBAV(JK))
  20  BB(I)=FLOAT(IPHIR(J,JK))/100.
      A(J)=FINTRP(AA,DEL)/AC
      IF(KK.LT.3) GO TO 25
      CDERIV=-0.25*A(J)*((FLOAT(3*KK*KK-2)+UPPRIM)*A(J)+2.*AP(J))/
     *(1.0+UPRIM)
      GAM=GAM+CDERIV
  25  B(J)=FINTRP(BB,DEL)
      RETURN
      END

C$PROG MMAT
      SUBROUTINE MMAT(A,B,C)
C
C        MATRIX MULTIPLICATION ROUTINE -- C=A*B.
C
      DIMENSION A(2,2),B(2,2),C(2,2)
      C(1,1)=A(1,1)*B(1,1)+A(1,2)*B(2,1)
      C(1,2)=A(1,1)*B(1,2)+A(1,2)*B(2,2)
      C(2,1)=A(2,1)*B(1,1)+A(2,2)*B(2,1)
      C(2,2)=A(2,1)*B(1,2)+A(2,2)*B(2,2)
      RETURN
      END


C$PROG MMBT
      SUBROUTINE MMBT(A,B)
C
C        MATRIX MULTIPLICATION ROUTINE -- B=A*B.
C
      DIMENSION A(4),B(4),C(4)
      CALL MMAT(A,B,C)
      DO 10 I=1,4
  10  B(I)=C(I)
      RETURN
      END


C$PROG OPTEQU    - Finds equil orbit
C
      SUBROUTINE OPTEQU(YI,Y,EPS,NE,W,XI,NSTEP,NTP)
C
C        ROUTINE FINDS EQUIL. ORBIT STARTING WITH INITIAL VALUES
C        GIVEN IN YI. RESULTS RETURNED IN Y AND YI.
C             EPS   - CONVERGENCE CRITERION
C             NTP   - NUMBER OF ITERATIONS REQUIRED FOR CONVERGENCE.
C                     (WILL STOP AT 15)
C
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /FEQOR/ALPHA,VV
      DIMENSION YI(6),Y(6)
      DOUBLE PRECISION Y,YI
      DOUBLE PRECISION AJ11,AJ21,AJ12,AJ22,DX,DVX,EP1,EP2
      EXTERNAL FEQORB
C
C     IF DSWTCH 8 EQUALS 1, WILL PRINT OUT EACH ITERATION ABOVE 10.
C
      CALL DSWTCH(8,KWRT)
      DX=YI(3)
      DVX=YI(6)
  10  X=XI
      DO 15 I=1,NE
  15  Y(I)=YI(I)
      CALL QKUTTA(FEQORB,NE,X,NSTEP,W,Y)
      IF(NSKIP.NE.0) GO TO 30
      AJ11=Y(3)/DX-1.0
      AJ21=Y(4)/DX/1.0D+07
      AJ12=Y(5)/DVX/1.0D-07
      AJ22=Y(6)/DVX-1.0
      EP1=Y(1)-YI(1)
      EP2=(Y(2)-YI(2))/1.0D+07
      AJ=AJ11*AJ22-AJ12*AJ21
      EP=DABS(EP1/YI(1))+DABS(EP2/VV)*1.0D+07
      IF(NTP.LE.10) GO TO 25
      WRITE(6,1000) NTP,EP,Y(1),Y(2)
      IF(KWRT.EQ.2) GO TO 25
      WRITE(15,1000) NTP,EP,Y(1),Y(2),Y(3),Y(4),Y(5),Y(6),AJ
1000  FORMAT(1H ,I5,8E12.5)
C     WRITE(15,1000) NTP,EP1,EP2,YI(1),YI(2),AJ11,AJ21
  25  NTP=NTP+1
      IF(NTP.GT.15) GO TO 30
      IF(EP.LT.EPS) GO TO 30
      IF(ABS(AJ).LT.0.3E-03) AJ=SIGN(0.5E-03,AJ)
      YI(1)=YI(1)-(EP1*AJ22-EP2*AJ12)/AJ
      YI(2)=YI(2)-(EP2*AJ11-EP1*AJ21)/AJ/1.0D-07
C     WRITE(15,1000) NTP,AJ12,AJ22,YI(1),YI(2),AJ
      GO TO 10
  30  DO 35 I=1,NE
  35  Y(I)=YI(I)
      RETURN
      END
 
C$PROG ORBEN
      SUBROUTINE ORBEN(R,AM,FREQ,HA,EST)
C
C        FOR A GIVEN AVERAGE RADIUS AND FREQUENCY -- RETURNS
C        ENERGY=EST.
C
      BETA=R*FREQ*HA/1.8784673D+03
      EST=AM*(1.0/SQRT(1.0-BETA*BETA)-1.0)
      RETURN
      END
 
C$PROG ORBIT
      SUBROUTINE ORBIT(ANG,RR,DRR)
C
C        FOR A GIVEN ANGLE=ANG, CALCULATES ORBIT POSITION RR FROM
C        ANALYTIC FORMALISM.
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /SCRAA/G(2214),IHH(22),ACOF(241),A(22),B(22),GAM
      DOUBLE PRECISION R,DR
      R=RR
      DR=DRR
      ANG=ANG+9.0
      R=1.+GAM
      DR=0.0
      DO 30 J=1,22
      KK=IHH(J)-1
      KT=(KK/3)*3-KK
      IF(KT.NE.0) GO TO 30
      ANGT=(ANG*FLOAT(KK)-B(J))*0.017453
      R=R+A(J)*COS(ANGT)
      DR=DR-FLOAT(KK)*A(J)*SIN(ANGT)
  30  CONTINUE
      R=RE*R
      DR=RE*DR
      RR=R
      DRR=DR
      ANG=ANG-9.0
      RETURN
      END

C$PROG PROMPT    - Displays "prompt" for keyboard input
C
C     ******************************************************************
C     BY W.T. MILNER AT HRIBF - LAST MODIFIED 07/12/97
C     ******************************************************************
C
      SUBROUTINE PROMPT
C
      IMPLICIT NONE
C
      WRITE(6,10)
C
   10 FORMAT(' EQORB->',$)
C
      RETURN
      END

C$PROG RACCEL
      SUBROUTINE RACCEL(X,Y,YP)
C
C        ROUTINE EVALUATES DY(I)/DX FOR R-KUTTA INTEGRATION CALLED
C        FOR BY RACE.
C
      DIMENSION Y(3),YP(3)
      COMMON /FEQOR/ALPHA,VV
      DOUBLE PRECISION VB,SV,Y,YP
C ARGSV was not originally DOUBLE PRECISION, which appears to have been a mistake.
C EjP 20230712
      DOUBLE PRECISION ARGSV
      VB=VV
Cjbb
      ARGSV=VB*VB-Y(2)*Y(2)
      IF(ARGSV.LE.0.0) STOP 'EXIT CALLED FROM SUBROUTINE RACCEL'
Cjbb
      SV=DSQRT(ARGSV)
      YX=Y(1)
      CALL BINTP3(X,YX,BZ)
      YP(1)=Y(1)*Y(2)/SV
      YP(2)=SV-ALPHA*Y(1)*BZ
      YP(3)=-DSQRT(Y(1)*Y(1)+YP(1)*YP(1))/VB
      RETURN
      END

C$PROG RACE
      SUBROUTINE RACE(EST,R,DR,REND,DREND,EEND,TOEND,NDIREC,NORB)
C
C        THIS ROUTINE CALCULATES ORBIT TRAJECTORY INORDER TO DETERMINE
C        AT END POINT AT 90 DEGREES:
C            REND   - RADIUS
C            DREND  - DR/DTHETA
C            EEND   - ENERGY
C            TOEND  - PHASE WITH RESPECT TO RF.
C        IF NDIREC=+1, CALCULATION IS OUTWARD TO EXTRACTION
C                  -1, CALCULATION IS INWARD TO INJECTION.
C
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /PART/Q,AM2,S
      COMMON /FEQOR/ALPHA,VV
      DIMENSION Y(3)
      DOUBLE PRECISION Y
      EXTERNAL RACCEL
      DATA NE,NSTEP,TO/3,45,0.0/
      Y(1)=R
      Y(2)=DR
C
C        ROUTINE ASSUMES INITIAL PHASE IS 0.0 WITH RESPECT TO RF.
C
      Y(3)=0.0
      NORB=0
      NSKIP=0
      W=FLOAT(NDIREC)*4.0
      Q=FLOAT(NDIREC)*Z1
      ETARG=EINJ
      IF(EINJ.EQ.0.0) ETARG=3.*Z1*ABS(VDEE)/1000.
      VDEE=-VDEE
      EEND=EST
      IF(NDIREC.EQ.1) EEND=EEND+Z1*VDEE/1000.
  20  XI=90.0
      DO 30 I=1,2
      VDEE=-VDEE
      CALL KICK(EEND,Y(3),TO,-NDIREC*NORB)
      CALL QKUTTA(RACCEL,NE,XI,NSTEP,W,Y)
      IF(NSKIP.NE.0) GO TO 50
  30  CONTINUE
      NORB=NORB+1
      IF(NORB.GT.500) GO TO 40
      IF(NDIREC.EQ.-1.AND.EEND.GT.ETARG) GO TO 20
      IF(NDIREC.EQ.1.AND.(EEND-Z1*VDEE*0.001).LT.EE) GO TO 20
      VDEE=-VDEE
      IF(NDIREC.EQ.1) CALL KICK(EEND,Y(3),TO,-NDIREC*NORB)
  35  VDEE=ABS(VDEE)
      REND=Y(1)
      DREND=Y(2)
      TOEND=-(Y(3)-TO)*FREQ*1.0D+06*360.*HA+FLOAT(-NDIREC*NORB)*360.
      TOEND=TOEND/HA
      RETURN
  40  WRITE(15,3010) NDIREC,Y,EEND
3010  FORMAT(1X,'*** RACE EXCEEDED NORB=500--   ',I4,4E12.5)
      GO TO 35
  50  IF(NSKIP.EQ.1) WRITE(15,3020) NORB,XI,Y,EEND
3020  FORMAT(1X,'*** PARTICLE ORBIT OUT OF CYCLOTRON--',I4,5E12.5)
      STOP 'EXIT CALLED FROM SUBROUTINE RACE'
      END

C$PROG SCRATNIT  - Initializes scratch-file
      SUBROUTINE SCRATNIT(LU)
C
      OPEN(UNIT       = LU,
     &     STATUS     = 'SCRATCH',
     &     IOSTAT     = IOS)
C
      RETURN
      END

C$PROG SISOC
      SUBROUTINE SISOC(YI,RF,VV,RSC,VSC)
C
C        SET STARTING QUESSES FOR DETERMINATION OF EQUIL. ORBIT.
C
      DOUBLE PRECISION YI
      DIMENSION YI(14)
      DO 10 I=1,14
  10  YI(I)=0.0
      YI(1)=RF*RSC
      YI(2)=VV*VSC
      YI(3)=0.02
      YI(6)=YI(2)*0.1
      YI(7)=0.02
      YI(10)=YI(6)
      RETURN
      END

C$PROG SMAT
      SUBROUTINE SMAT(A,B,F)
C
C        MATRIX ADDITION ROUTINE -- A=A+F*B  , WHERE F IS A SCALER.
C
      DIMENSION A(4),B(4)
      DO 10 I=1,4
  10  A(I)=A(I)+F*B(I)
      RETURN
      END

