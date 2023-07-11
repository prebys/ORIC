C$PROG ACCPRM    - Reads accel parms from tcisoc.car
C
      SUBROUTINE ACCPRM
C
C     THIS ROUTINE READS ACCELERATION PARAMETERS FROM FILE
C     TCISOC.CAR AND STORES RESULTS IN COMMON /ORBPRM/.
C
C     modified 5/7/06 to skip leading comment cards  -  jbb
C
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      COMMON /ORBPRM/A(4,2),LAB(4,2)
C
      CHARACTER LWDBUF*96      !create internal file
      EQUIVALENCE(LWD,LWDBUF)  !and align with data
C
      REWIND LGRED
C
Cjbb   - the acceleration parameters begin in line 21 of TCISOC.CAR
Cjbb     so, we need to skip 20 lines plus # of comment cards = NXT
      NSKIP=20+NXT
      DO 5 I=1,NSKIP
      READ(LGRED,2000)
    5 CONTINUE
C
      DO 20 I=1,2
      DO 10 J=1,4
  10  A(J,I)=0.0
      NF=0
      CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
      IF(NF.EQ.0) GO TO 20
Cjbb    - comment out DECODEs and replace with int file reads
C        DECODE(96,2000,LWD(1)) (LAB(J,I),A(J,I),J=1,4) 
 2000 FORMAT(2(2(A4,4X,F8.0),16X))  !leave active since used above
C        DECODE(48,2020,LWD(1)) NL
C  2020  FORMAT(40X,I8)
Cjbb
      READ(LWDBUF,'(2(2(A4,4X,F8.0),16X))') (LAB(J,I),A(J,I),J=1,4)
      READ(LWDBUF(1:48),'(40X,I8)') NL
C
      A(2,I)=A(2,I)*10.**NL
  20  CONTINUE
      RETURN
      END

C$PROG BAVERG
      FUNCTION BAVERG(RAD)
C
C        CALCULATES AVERAGE FIELD (A0) AT RADIUS=RAD FROM FIELD
C        PARAMETERIZATION FOR CURRENTS-CUR.
C
      COMMON /LIN/LDNP,NPOS,CUR(23)
      COMMON /FCD/CC(4)
      COMMON /COIL/COIL(99)
      DIMENSION P(66)
      DOUBLE PRECISION HH
C
      CALL TCREED(LDNP,P,132)
C
      IR=RAD+1.001
      P(1)=P(1)+COIL(IR)
  30  CD=CUR(1)
      CU=1.0/CD
      CX=CD*CD
      HH=0.0
C
C        MAIN COIL.
C
      DO 40 I=1,7
      CX=CX*CU
  40  HH=HH+P(I)*CX
      CC(1)=0.0
      DO 50 I=1,3
  50  CC(I+1)=CD*P(I+7)
      K=10
C
C        TRIM COIL.
C
      DO 60 JI=1,4
      DO 60 JK=2,11
      K=K+1
  60  CC(JI)=CC(JI)+P(K)*CUR(JK)/100.
C
C        HARMONIC AND VALLEY COILS.
C
      DO 70 JI=1,4
      DO 70 JK=12,23,3
      K=K+1
  70  CC(JI)=CC(JI)+P(K)*(CUR(JK)+CUR(JK+1)+CUR(JK+2))/100.
      AA=HH+CC(1)
      BAVERG=FILD(AA)
      RETURN
      END

C$PROB BAVF
      FUNCTION BAVF(A,CU,CUR)
C
C        CALCULATES THE AVERAGE FIELD IN THE FRINGE FIELD REGION.
C
      DIMENSION A(60),CUR(1)
      BAVF=0.0
      CX=CU*CU
      DO 10 I=1,4
      CX=CX/CU
  10  BAVF=BAVF+A(I)*CX
      AT=0.0
      DO 20 I=1,10
  20  AT=AT+A(I+50)*CUR(I+1)
      DO 30 I=44,49
  30  A(I)=A(I)*AT
      BAVF=BAVF+A(44)+A(45)/CU
      RETURN
      END

C$PROG BFOR
      SUBROUTINE BFOR(IH,BAV,BITM)
C
C        CALCULATES FOURIER COEF. A(IH-1) AND B(IH-1) FOR
C        CURRENTS-CUR.
C
      COMMON /LIN/LDNP,NPOS,CUR(23)
      COMMON /FCD/CC(4)
      DIMENSION BITM(1),P(66)
      DOUBLE PRECISION HH
      CALL TCREED(LDNP,P(1),66)
      CALL TCREED(LDNP,P(34),66)
      I=IH-1
      ICOF=1
      IF(I/3*3.EQ.I) ICOF=2
      CD=CUR(1)
      CU=1.0/CD
C
C        BITM(1)=A(IH-1)
C        BITM(2)=B(IH-1)
C
C        MAIN COIL.
C
      DO 80 ITM=1,2
      CX=CD*CD
      HH=0.0
      K=(ITM-1)*33
      DO 40 I=1,5
      CX=CX*CU
      K=K+1
  40  HH=HH+P(K)*CX
C
C        TRIM COILS.
C
      DO 50 I=1,2
      CC(I)=0.0
      DO 50 J=2,11
      K=K+1
  50  CC(I)=CC(I)+P(K)*CUR(J)/100.
      KTI=33*(2*ITM-3)
      FL=0.8660254*FLOAT((-1)**(IH+ITM+1+(IH-1)/3))
C
C        HARMONIC AND VALLEY COILS.
C
      DO 60 I=1,2
      DO 60 J=12,23,3
      K=K+1
      CC(I)=CC(I)+P(K)*(CUR(J)+CUR(J+1)+CUR(J+2))/100.
      GO TO (52,60),ICOF
  52  KTM=K-KTI
      IF(J.GE.21) GO TO 56
      CC(I)=CC(I)+(-1.5*P(K)*(CUR(J+1)+CUR(J+2))+FL
     * *P(KTM)*(CUR(J+1)-CUR(J+2)))/100.
      GO TO 60
  56  CC(I)=CC(I)+(-1.5*P(K)*(CUR(J+2)+CUR(J  ))+FL
     * *P(KTM)*(CUR(J+2)-CUR(J)))/100.
  60  CONTINUE
  80  BITM(ITM)=HH+CC(1)+CC(2)/BAV
      RETURN
      END

C$PROG BINTP3
      SUBROUTINE BINTP3(X,R,BZ)
C
C        CALCULATES FIELD AT LOCATION (X,R) BY INTERPOLATION
C        OVER RADIUS.
C
      DIMENSION IB(4)
      DATA XI,RI/0.0,0.0/
      AB=ABS(X-XI)+ABS(R-RI)
C
C        IF FIELD REQUIRED AT SAME POSITION AS PREVIOUS CALL, DO NOT
C        RECALCULATE IT.
C
      IF(AB.LT.0.1E-03) RETURN
      IR=R
      IDEL=(R-FLOAT(IR))*1000.
      IANG=X*100.
      IR1=IR-2
C
C        CALCULATE FIELD AT 4 RADIAL POINTS.
C
      DO 20 I=1,4
      II=IR1+I
      JJ=IABS(II)+1
      JANG=IANG
      IF(II.LT.0) JANG=-IANG
      IF(JJ.GT.150) GO TO 30
  20  IB(I)=KFIELD(JJ,JANG)/100
      BZ=IINTRP(IB,IDEL)
  25  RI=R
      XI=X
      RETURN
  30  BZ=0.0
      GO TO 25
      END

C$PROG CALFLD
      SUBROUTINE CALFLD
C
C        CALCULATES FIELD ON 2. DEGREE MESH FROM 0. TO 39. INCHES AND
C        WRITES MESH ON DEVICE LDF=10.
C
      COMMON /STOREB/LDF,JOFF
      COMMON /SCRAA/IBF(180,14),DUM(2)
      COMMON /TIMM/DAT(4),DTM(8)
      DIMENSION IB(180)
C
      IF(LDF.NE.10) RETURN
CX    REWIND LDF
C
      CALL SNAOS(LDF,0)
C
C        IF JOFF=10, FIELD MESH ALREADY EXISTS ON DISK -- DO NOT
C        RECALCULATE IT.
C
      IF(JOFF.EQ.10) GO TO 45
      CALL TCWRIT(LDF,DAT(1),8)
      DO 40 IR=1,40
      DO 30 J=1,180
      JANG=(J-1)*200
      IB(J)=IFIELD(IR,JANG)
      IF(IR.GT.37) GO TO 30
C
C        FLDEXT SUPPLIES THE EXTERNAL FIELD FROM THE LOWER CHANNEL.
C
      IB(J)=IB(J)+IFIX(100.*FLDEXT(FLOAT(IR),JANG))
  30  CONTINUE
  40  CALL TCWRIT(LDF,IB,360)
  45  JOFF=23
C
C        INPUT FIELD MESH FROM 23. TO 36. INCHES FROM DISK INTO FIELD
C        BUFFER -IBF.
C
      CALL SNAIS(LDF,JOFF*3+1)
      DO 50 I=1,14
  50  CALL TCREED(LDF,IBF(1,I),360)
      RETURN
      END

C$PROG CASEUP
      SUBROUTINE CASEUP(IBY)
C
      BYTE IBY(80)
C
      DO 20 I=1,80
      IT=IBY(I)
Cjbb      - the following is old version, but MS Fortran
Cjbb	    does not understand this notation for hex 
Cjbb     IF(IT.LT.'61'X.OR.IT.GT.'7A'X) GO TO 20
Cjbb     IBY(I)=IT-'20'X
Cjbb      - to get around different notations for hex numbers
Cjbb        lets just go to decimal representations
      IF(IT.LT.97.OR.IT.GT.122) GO TO 20
      IBY(I)=IT-32
Cjbb
   20 CONTINUE
      RETURN
      END

C$PROG CTCNIT    - Enables Ctrl/C interrupt (calls MSGHDL)
C
C     ******************************************************************
C     BY W.T. MILNER AT HRIBF - LAST MODIFIED 07/02/97
C     ******************************************************************
C
      SUBROUTINE CTCNIT
C
Cjbb   - may need this later, but for now just skip
Cjbb
Cjbb      IMPLICIT INTEGER*4 (A-Z)
C
Cjbb      EXTERNAL MSGHDL                       !CTRL/C HANDLER ROUTINE
C
C     **************************************************************
C     ROUTINE TO INIT AND RE-ENABLE CRTL/C TRAPS
C     **************************************************************
C
Cjbb      IR=SIGNAL(2,MSGHDL,-1)
      RETURN
      END

C$PROG DSWTCH
      SUBROUTINE DSWTCH(ISW,KSTAT)
C
C        RETURN STATUS OF DSWTCH ISW.
C
      COMMON /DSWTCHH/N(15)
      KSTAT=N(ISW)
      RETURN
      END

C$PROG EXTRAK
      SUBROUTINE EXTRAK(AMAIN,REN,REX,AIIN,AIOUT,BF)
C
C     CALCULATES FOURIER COEFFICIENTS FOR EXTERNAL FIELD OF LOWER
C     CHANNEL FOR ALL PROGRAMS BESIDES TCISOC
C     THESE COEFFICIENTS ARE USED IN SUBROUTINES ADEXFO, ZODDHM
C     AND FLDEXT WHICH ARE FOUND IN TCSETFOR.FTN.
C
      COMMON /COEB/BLCCOE(11,2,39)
      DIMENSION BF(1)
      CALL EXTRAU(AMAIN,REN,REX,AIIN,AIOUT,BF,BLCCOE,10)
      RETURN
      END

C$PROG EXTRAU
      SUBROUTINE EXTRAU(AMAIN,REN,REX,AIIN,AIOUT,BF,BLCCOE,NHARM)
C
C     CALCULATES FOURIER COEFFICIENTS FOR EXTERNAL FIELD OF LOWER
C     CHANNEL
C
C     AMAIN    - MAIN COIL CURRENT IN AMPS
C     REN      - LOWER CHANNEL ENTRANCE POSITION
C     REX      - LOWER CHANNEL EXIT POSITION
C     AIIN     - INNER COIL CURRENT
C     AIOUT    - OUTER COIL CURRENT
C     BF       - RECEIVES LOWER CHANNEL FIELD IN 2 DEGREE STEPS
C                AT 30 INCHES
C     BLCCOE   - FOURIER COEFFICIENTS FOR EXTERNAL FIELD OF LOWER
C                CHANNEL
C     NHARM    - NUMBER OF HARMONICS TO BE INCLUDED IN FOURIER
C                ANALYSIS
C
      COMMON /SCRAC/C1(11),C2(11),D1(11),D2(11),E1(4),F1(11),G1(11)
      DIMENSION BF(1),BEX(2,2,10),RR(4),A(4),BLCCOE(11,2,39)
      DOUBLE PRECISION RR,A,BEX
      SRP=30.
      RR(1)=40.11117123
      RR(2)=40.72
      RR(3)=37.336
      RR(4)=36.4739
      DO 10 I=1,10
      DO 10 J=1,2
      BEX(1,J,I)=0.0
  10  BEX(2,J,I)=0.0
      DO 11 I=1,39
      DO 11 J=1,11
      BLCCOE(J,1,I)=0.0
  11  BLCCOE(J,2,I)=0.0
      IF(AIOUT.EQ.0.0) GO TO 70
  20  NPTS=10
C
C     OBTAIN FOURIER COFFICIENTS IN LOWER CHANNEL REFERENCE SYSTEM
C
      CALL TRAC1(AIIN,AIOUT,AMAIN)
      CALL SLDB(REN,REX)
      CALL SETSLD
C
C     CALCULATE FIELD AT RADIUS SRP ABOUT CENTER OF CYCLOTRON
C
      DO 40 J=1,180
      PHI=FLOAT(J-1)*0.034907
C
C  INPUT:
C     PHI  - ANGLE IN CYCLOTRON COORDINATES
C     SRP  - RADIUS "     "         "
C  OUTPUT:
C     THETA- ANGLE IN LOWER CHANNEL REFERENCE COORDINATES
C     SR   - RADIUS "   "      "        "         "
C
      CALL SLD(PHI,SRP,THETA,SR)
      THETA=THETA-0.506145
C
C     CALCULATE FOURIER COEFFICIENTS IN CYCLOTRON COORDINATES
C
      DO 26 I=1,4
  26  E1(I)=(RR(I)-SR)**3
      DO 28 I=1,3
      F1(I)=C1(I)/E1(1)+C2(I)/E1(2)
  28  G1(I)=D1(I)/E1(3)+D2(I)/E1(4)
      DO 30 I=4,11
      F1(I)=C1(I)/E1(1)
  30  G1(I)=D1(I)/E1(1)
C
C     CALCULATE FIELD AT SRP IN CYCLOTRON COORDINATES
C
      BF(J)=F1(1)
      DO 40 I=1,NPTS
      ANG=FLOAT(I)*THETA
      AC=F1(I+1)*COS(ANG)+G1(I+1)*SIN(ANG)
  40  BF(J)=BF(J)+AC
      A1=0.0
      A2=0.0
      MANG=180
      MHARM=MIN0(9,NHARM)
C
C     FOURIER ANALYZE FIELD AT SRP RADIUS IN CYCLOTRON COORDINATES
C
      CALL FORIT(BF,MANG,MHARM,C1,C2,A1,A2,IERR)
      DO 55 K=1,10
      BEX(1,1,K)=C1(K)*1033.7235
  55  BEX(1,2,K)=C2(K)*394.80075
      BEX(2,1,1)=-98148.52
      BEX(2,1,2)=152155.2
      BEX(2,2,2)=10907.0
      BEX(2,1,3)=-106628.4
      BEX(2,2,3)=-17372.5
      DO 60 K=1,3
      BEX(1,1,K)=BEX(1,1,K)-BEX(2,1,K)*0.839112
  60  BEX(1,2,K)=BEX(1,2,K)-BEX(2,2,K)*1.455057
C
C     CALCULATE FOURIER COEFFICIENTS AS A FUNCTION OF RADIUS
C
C     BLCCOE(1,1,10)  - A0 AT 9 INCHES
C     BLCCOE(2,1,10)  - A1 "  "     "
C     BLCCOE(2,2,10)  - B1 "  "     "
C         ETC.
C  
Cjbb    DO 65 I=1,37   !this has been reduced to study effect of
Cjbb          eliminating large unphysical fields at 34 and 35 in.
Cjbb          The lower limit is now the default option (DSWTCH(14)=2)
Cjbb
      CALL DSWTCH(14,KLCR)
      IF(KLCR.EQ.2) THEN
       LCR=35
       WRITE(6,461)
  461  FORMAT(/'    [NOTE: EXTRAU uses JB limit to LC field coeff ',
     1   'of 33 inches]',/)
      ELSE
       LCR=37
       WRITE(6,462)
  462  FORMAT(/'    [NOTE: EXTRAU uses TC limit to LC field coeff ',
     1   'of 35 inches]',/)
      END IF
Cjbb
      DO 65 I=1,LCR
      R=I-1
      DO 62 J=1,4
  62  A(J)=(RR(J)-R)**3
      DO 65 J=1,10
      BLCCOE(J,1,I)=BEX(1,1,J)/A(1)
      IF(J.NE.1) BLCCOE(J,2,I)=BEX(1,2,J)/A(3)
      IF(J.GT.3) GO TO 65
      BLCCOE(J,1,I)=BLCCOE(J,1,I)+BEX(2,1,J)/A(2)
      IF(J.GT.1) BLCCOE(J,2,I)=BLCCOE(J,2,I)+BEX(2,2,J)/A(4)
  65  CONTINUE
  70  RETURN
      END

C$PROG FACCEL
      SUBROUTINE FACCEL(X,Y,YP)
C
C        ROUTINE EVALUATES DERIVATIVES YP(I)=DY(I)/DX.
C
      DIMENSION Y(5),YP(5)
      COMMON /TEM/BZ,DBZ
      COMMON /FEQOR/ALPHA,VV
      COMMON /ANGSTR/CO(181),SI(181)
      DOUBLE PRECISION VB,SV,Y,YP
      VB=VV
      SV=DSQRT(VB*VB-Y(2)*Y(2))
      YX=Y(1)
      CALL BINTP3(X,YX,BZ)
      YP(1)=Y(1)*Y(2)/SV
      YP(2)=SV-ALPHA*Y(1)*BZ
      YP(3)=-DSQRT(Y(1)*Y(1)+YP(1)*YP(1))/VB
      J=IFIX(X)/2+180
      J=MOD(J,180)+1
      YP(4)=-Y(1)*CO(J)/6.283185
      YP(5)=-Y(1)*SI(J)/6.283185
      RETURN
      END

C$PROB FDV5
      FUNCTION FDV5(A,I)
C
C        CALCULATES 1ST DERIVATIVE OF A AT I.
C
      DIMENSION A(1)
      FDV5=0.0
      IF(I.EQ.2) FDV5=-6.*A(I-1)-20.*A(I)+36.*A(I+1)-12.*A(I+2)+2.*
     *A(I+3)
      IF(I.EQ.38) FDV5=-2.*A(I-3)+12.*A(I-2)-36.*A(I-1)+20.*A(I)+6.*
     *A(I+1)
      IF(I.GT.2.AND.I.LT.38) FDV5=2.*(A(I-2)-A(I+2))+16.*(A(I+1)-
     *A(I-1))
      IF(I.EQ.39) FDV5=6.*A(I-4)-32.*A(I-3)+72.*A(I-2)-96.*A(I-1)
     *+50.*A(I)
      FDV5=FDV5/24.
      RETURN
      END

C$PROB FILD
      FUNCTION FILD(AA)
C
C        ITERATIVELY ACCOUNTS FOR INTERACTION OF VARIOUS COILS.
C
      COMMON /FCD/C1,C2,C3,C4
      FIELD(XX)=(C2+(C3+C4/XX)/XX)/XX
      AB=FIELD(AA)+AA
      DO 10 J=1,25
      HDELT=FIELD(AB)+AA
      IF(ABS(HDELT-AB).LT.0.1) GO TO 20
  10  AB=HDELT
  20  FILD=AB
      RETURN
      END

C$PROG FINPU1
      SUBROUTINE FINPU1(PHINIT,RTEMP,AK)
      DIMENSION ICON(6)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /LOWCH/REN,REX,AIIN,AIOUT
      COMMON /LCCURP/PLCCUR(7),STRCOF(3),STRNLC
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      LOGICAL IEND
      CHARACTER LWDBUF*32      !create internal file to replace encode
      EQUIVALENCE(LWDBUF,LWD)  !and align it with data
C
      DATA ICON/'D   ','P   ','H   ','F   ','E   ','L   '/
C
      READ(8,1000) REN,REX,AIIN,AIOUT
      READ(8,1000) PLCCUR
1000  FORMAT(10F8.0)
      READ(8,1000) STRCOF
      IF(AK.EQ.0.0) GO TO 5
      AIIN=PLCCUR(1)*AK+PLCCUR(2)
      AIOUT=PLCCUR(3)*AK+PLCCUR(4)
      IF(AIIN.LE.PLCCUR(7)) GO TO 5
      AIIN=PLCCUR(7)
      AIOUT=PLCCUR(5)*AK+PLCCUR(6)
C
   5  NF=0
  10  IF(IBUMP(NF).EQ.2) RETURN
C
      IN='    '
      CALL LODUP(LWD(IFDX),1,1,IN,1)
 4010 FORMAT(' ALPHANUMERIC VALUE OF IN,ICON(4)=',2A4)
C
      I=0
      DO 15 IK=1,6
      I=I+1
      IF(IN.EQ.ICON(IK)) GO TO 20
  15  CONTINUE
      GO TO 100
C
  20  IF(I.GT.5) GO TO 80
      IF(IBUMP(NF).EQ.2) RETURN
      IF(NSCRAM(ITYP(IWDX),LWD(IFDX),AM).EQ.2) GO TO 100
C
      GO TO (30,40,50,60,70),I
  30  VDEE=AM
      GO TO 10
  40  PHINIT=AM
      GO TO 10
  50  HA=AM
      GO TO 10
  60  FREQ=AM
      RTEMP=-AM
      GO TO 10
  70  RTEMP=AM
      RE=AM
      GO TO 10
  80  IF(LGRED.EQ.5) WRITE(6,2000)
2000  FORMAT(' LOWER CHANNEL: ENTRANCE,EXIT,I-IN,I-OUT')
      CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
      IF(IEND) GO TO 10
      IF(AK.EQ.0.0) GO TO 5
Cjbb    - comment out decode routine and replace with int file read
C        DECODE(32,3000,LWD(1)) REN,REX,AIIN,AIOUT
C  3000  FORMAT(4F8.0)
Cjbb
      READ(LWDBUF,'(4F8.0)') REN,REX,AIIN,AIOUT
C
      GO TO 5
 100  KF=IFDX+4
      WRITE(6,4000) (LWD(I),I=IFDX,KF)
4000  FORMAT(' ? ',5A4)
      GO TO 5
      END

C$PROG FINPUT
      SUBROUTINE FINPUT(RTEMP,PHINIT,JSYM,IA)
C
C     modified 5/7/06 to handle leading comment cards
C       and input parameter ID information  -  jbb
C     modified 4/8/07 to process the molecular ion H2+
C       with the symbol HH and mass number 2 and IZ=0 (see MASSYM)
C       (also corrected the atomic mass unit to 931.471) - jbb 
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      COMMON /SWTCH/NSWT(15)
      COMMON /TIMM/DAT(4),DTM(8)
      COMMON /VERS/VNUM,PRMID
      INTEGER*2 ISYM
      LOGICAL IEND
      CHARACTER VNUM*8,XFLAG*1,PRMID*32
      CHARACTER LWDBUF*52      !create internal file to replace encode
      EQUIVALENCE(LWDBUF,LWD)  !and align it with data
C
      DO 5 I=1,4
    5 DAT(I)='    '
      IF(LGRED.EQ.4) GO TO 30
      NF=0
   10 WRITE(6,2000)
 2000 FORMAT(' ENERGY,MASS#,ION,ION CHARGE,INJECTION ENERGY,',
     1  'INJECTION CHARGE')
   15 CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
      IF(IEND) STOP 'ROSGRED IEND ERROR IN FINPUT SUBROUTINE!!'
      IF(LWD(1).EQ.'CARD') GO TO 30
Cjbb
C        DECODE(52,2010,LWD(1)) EE,AM1,ISYM,Z1,EINJ,ZINJ,IUP
C  2010  FORMAT(2F8.0,A2,6X,3F8.0,A4)
Cjbb
      READ(LWDBUF,'(2F8.0,A2,6X,3F8.0,A4)')EE,AM1,ISYM,Z1,EINJ,ZINJ,IUP
      IF(IUP.EQ.'UPGR') NSWT(12)=1
Cjbb
C        DECODE(52,2010,LWD(1)) EA,AA,JSYM
Cjbb
      READ(LWDBUF,'(2F8.0,A2,6X,3F8.0,A4)')EA,AA,JSYM
      IA=AM1
      IZ=MASSYM(ISYM)
      IF(IZ.LT.0) GO TO 10
      CALL MASEX(IZ,IA,EX,ER,ISOR,IERR)
      AM1=931.478*FLOAT(IA)+EX/1000.-0.511*Z1
      AK=EE*AA/(Z1*Z1)   !this is the field constant for the particle
      IF(NSWT(12).EQ.1) AK=0
      CALL FINPU1(PHINIT,RTEMP,AK)
      RETURN
C
   30 LGRED=4
   40 NX=0       !set up to count the number of comment cards
   42 READ(4,4042)XFLAG
 4042 FORMAT(A1)
      IF(XFLAG.EQ.'!') THEN
      NX=NX+1
      GO TO 42
      END IF
      REWIND 4   !at this point the number of comment cards = NX
      NXT=NX
C
      IF(NX.EQ.0) GO TO 50  !i.e., there were no comment cards
   44 READ(4,4044)PRMID     !get the parameter set ID from
 4044 FORMAT(2X,A32)        !                     first comment card
   46 NX=NX-1
      IF(NX.EQ.0) GO TO 50  !file is now postioned at first data card
      READ(4,4042)XFLAG     !bypass extra comment cards
      GO TO 46
C
   50 READ(4,4050)DAT       !get date/time from first data card
 4050 FORMAT(50X,2A4,2X,2A4)
      REWIND 4
      GO TO 15
      END

C$PROG FLDEXT
      FUNCTION FLDEXT(RAD,IANG)
C
C        CALCULATES EXTERNAL FIELD OF LOWER CHANNEL AT RADIUS=RAD-1
C        AND ANGLE=IANG/100. FROM COEFS. GIVEN IN COMMON/COEB/.
C        THE VALUE OF RAD MUST BE IN INCHES.
C        BEWARE!!  THE FRACTIONAL PART OF RAD IS IGNORED!
C
      COMMON /COEB/BEX(11,2,39)
      COMMON /EXTFLD/BLC(78),KEXTRC
      DIMENSION A(4)
      DATA KWRT/0/
      FLDEXT=0.0
C
C        IF KEXTRC=1, SET EXTERNAL CHANNEL FIELD EQUAL TO 0.0.
C
      IF(KEXTRC.EQ.1) GO TO 50
      ANG=FLOAT(IANG)/100.
      ANG=AMOD(ANG+360.,360.)
      CALL DSWTCH(15,KLCTH)
C
C     THE FOLLOWING IF STATEMENT ASSURES THAT THE LOWER CHANNEL
C     FIELD IS ZERO OUTSIDE OF THE SPECIFIED ANGULAR RANGE
C
Cjbb  In an attempt to more realistically represent the lower channel
Cjbb  the angular extent has been reduced to a region corresponding
Cjbb  to the physical extent of the channel plus 10 degrees or so.
Cjbb  This will be used as the default option (DSWTCH(15)=2).
Cjbb
      IF(KLCTH.EQ.2) THEN    !use option of JB angle limits
       IF(ANG.GT.250.0.OR.ANG.LT.174.0) GO TO 50
Cjbb
       IF(KWRT.EQ.0) THEN
        WRITE(6,461)
  461   FORMAT('    [NOTE: FLDEXT uses JB limit on LC field of ',
     1         '174 to 250 deg.]',/)
        KWRT=1
       END IF
      ELSE
       IF(ANG.GT.270.0.OR.ANG.LT.120.0) GO TO 50
Cjbb
       IF(KWRT.EQ.0) THEN
        WRITE(6,462)
  462   FORMAT('    [NOTE: FLDEXT uses TC limit on LC field of ',
     1         '120 to 270 deg.]',/)
        KWRT=1
       END IF
      END IF
Cjbb
Cjbb
      IR=RAD+1.01
      FLDEXT=BEX(1,1,IR)
      ANG=0.017453*(ANG+9.0)
      DO 40 K=2,10
      A1=FLOAT(K-1)*ANG
  40  FLDEXT=FLDEXT+BEX(K,1,IR)*COS(A1)+BEX(K,2,IR)*SIN(A1)
  50  RETURN
      END

C$PROB FORI
      FUNCTION FORI(A,K,CU)
C
C        CALCULATES THE FOURIER COEF. IN THE FRINGE FIELD REGION.
C
      DIMENSION A(1)
      FORI=0.0
      CX=CU*CU
      DO 10 J=1,3
      JJ=K+J
      CX=CX/CU
  10  FORI=FORI+CX*A(JJ)
      FORI=FORI*100.
      RETURN
      END

C$PROG FORIT
      SUBROUTINE FORIT(FNT,N,M,A,B,CC,PHI,IER)
      DIMENSION A(1),B(1),FNT(1),CC(1),PHI(1)
      DATA EPS/1.E-8/
C
C       CHECK FOR PARAMETER ERRORS
C
      IER=0
  20  IF(M) 30,40,40
  30  IER=2
      RETURN
  40  IF(2*M+1-N) 60,60,50
  50  IER=1
      RETURN
C
C       COMPUTE AND PRESET CONSTANTS
C
  60  AN=N
      COEF=2.0/AN
      CONST=3.1415926536*COEF
      CONV=57.29577951
      KC=CC(1)
      IF(KC.NE.1) KC=2
      S1=SIN(CONST)
      C1=COS(CONST)
      C=1.0
      S=0.0
      J=1
      FNTZ=FNT(1)
  70  U2=0.0
      U1=0.0
      I=N
C
C       FORM FOURIER COEFFICIENTS RECURSIVELY
C
  75  U0=FNT(I)+2.0*C*U1-U2
      U2=U1
      U1=U0
      I=I-1
      IF(I-1) 80,80,75
  80  A(J)=COEF*(FNTZ+C*U1-U2)
      B(J)=COEF*S*U1
      GO TO (85,88),KC
C       FORM C,PHI
  85  CC(J)=A(J)*A(J)+B(J)*B(J)
      CC(J)=SQRT(CC(J))
      IF(J.EQ.1) GO TO 851
      IF(ABS(A(J)).LE.EPS.AND.ABS(B(J)).LE.EPS) GO TO 86
      PHI(J)=ATAN2(B(J),A(J))*CONV/FLOAT(J-1)
      GO TO 88
 851  CC(J)=CC(1)*0.5
      PHI(J)=ATAN2(B(J),A(J)*0.5)*CONV
      GO TO 88
C       IF A=B=0, LET PHI=0
  86  PHI(J)=0.
  88  IF(J-(M+1)) 90,100,100
  90  Q=C1*C-S1*S
      S=C1*S+S1*C
      C=Q
      J=J+1
      GO TO 70
 100  A(1)=A(1)*0.5
      RETURN
      END
C

C$PROG GORBPM    - Returns EST, R, DR, TO
C
      SUBROUTINE GORBPM(EST,R,DR,TO,EFI,I,PROG)
C
C     ROUTINE RETURNS EST,R,DR AND TO.
C    IF I=1, RETURNS ORBIT PARAMETERS NEAR EXTRACTION
C         2, RETURNS ORBIT PARAMETERS NEAR INJECTION.
C
      COMMON /ORBPRM/SA(4,2),LAB(4,2)
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      DIMENSION PROG(2)
C
      LGRED=4
      CALL ACCPRM
      IF(SA(1,I).EQ.0.0) GO TO 30
      R=SA(1,I)
      DR=SA(2,I)*3.0E+10/2.54
      EST=SA(3,I)
      TO=HA*SA(4,I)*1.0D-06/360./FREQ/HA
      IF(EFI.GT.0.0) RETURN
      EFI=SA(3,2)
      IF(EFI.GT.0.0) RETURN
      EFI=EINJ
      IF(EFI.EQ.0.0) EFI=3.*VDEE*Z1/1000.
      RETURN
  30  WRITE(6,1000) PROG
1000  FORMAT(' CALL TCEQORB TO INITIALIZE ORBIT PARAMETERS,'
     *  ,'THEN CALL ',2A4,' AGAIN.')
      STOP
      END

C$PROG IBUMP
      FUNCTION IBUMP(NF)
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      LOGICAL IEND
      IBUMP=1
      IF(NF.GT.0) GO TO 20
  10  CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
      IWDX=1
      IFDX=1
      IF(NF.EQ.0) IBUMP=2
      IF(IEND) IBUMP=2
      RETURN
  20  IWDX=IWDX+1
      IF(IWDX.GT.NF) GO TO 10
      IFDX=IFDX+2
      RETURN
      END

C$PROB IFIELD
      FUNCTION IFIELD(JJ,JANG)
C
C        CALCULATES FIELD AT RADIUS=(JJ-1) INCHES AND ANGLE=JANG/100
C        FROM FOURIER COEF.
C
      COMMON /SCRAA/IBAV(153),IBFR(22,39),IPHIR(22,39),IBFS(11,10),
     *IPHIS(11,10),IPHISS(9),IBFT(2,29),IPHIT(2,29),IHH(22),ACOF(286)
      IFIELD=IBAV(JJ)
      IF(JJ.GT.39) GO TO 15
      DO 10 I=1,22
      IFIELD=IFIELD+JFIELD(JANG,IHH(I)-1,IPHIR(I,JJ),IBFR(I,JJ))
  10  CONTINUE
      RETURN
  15  IF(JJ.GT.49) GO TO 35
      JT=JJ-39
      DO 20 I=1,2
  20  IFIELD=IFIELD+JFIELD(JANG,3*I,IPHIS(I,JT),IBFS(I,JT))
      DO 30 I=3,11
  30  IFIELD=IFIELD+JFIELD(JANG,3*I,IPHISS(I-2),IBFS(I,JT))
      RETURN
  35  IF(JJ.GT.78) RETURN
      JT=JJ-49
      DO 40 I=1,2
  40  IFIELD=IFIELD+JFIELD(JANG,3*I,IPHIT(I,JT),IBFT(I,JT))
      RETURN
      END

C$PROB IINTRP
      FUNCTION IINTRP(IY,IDEL)
C
C        FOUR POINT INTERPOLATION OF FIELD -- PERFORMED IN INTEGER
C        MODE FOR SPEED.
C
      DIMENSION IY(4)
      IS=((IDEL+1000)*((IY(4)-IY(1))/3+IY(2)-IY(3)))/2000
      IS=((IDEL-1000)*((IY(3)+IY(1))/2-IY(2)+IS))/1000
      IS=(IDEL*(IY(3)-IY(2)+IS))/1000
      IINTRP=IY(2)+IS
      RETURN
      END

C$PROG ILBYTE
      SUBROUTINE ILBYTE(IT,IBY,NB)
      BYTE IBY(1)
C
      IT=IBY(NB+1)
      RETURN
      END

C$PROG INPARM
C
      SUBROUTINE INPARM(COE,NS,ALIM)
C
C     ------------------------------------------------------------------
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
C
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
C
      DIMENSION COE(1),NS(1),OFS(4),ICON(4),JCON(6),ALIM(1),NT(12),
     &          COF(23),NN(2)
C
      DATA ICON/'M   ','T   ','H   ','V   '/
C
      DATA JCON/'A   ','B   ','C   ','OF  ','AM  ','PH  '/
C
      DATA OFS/90.,110.,126.,126./
C     ------------------------------------------------------------------
C
      CALL TRNHRM(COE,NS,COF,NT,2)
      IS=0
C
  15  IF(LGRED.EQ.5) WRITE(6,2010)
2010  FORMAT(' CURRENTS:')
C
  20  NF=0
  22  IF(IBUMP(NF).EQ.2) GO TO 80
C
  25  N='    '
      CALL LODUP(LWD(IFDX),1,1,N,1)
C
      I=0
      DO 30 IK=1,4
      I=I+1
      IF(N.EQ.ICON(IK)) GO TO 35
  30  CONTINUE
      GO TO 36
C
  35  IS=I
      IF(IBUMP(NF).EQ.2) GO TO 80
  36  JF=0
      IF(IS.EQ.0) GO TO 90
C
      N='    '
      CALL LODUP(LWD(IFDX),1,1,N,1)
      IF(N.NE.'F   ') GO TO 38
C
      JF=1
C
      N='    '
      CALL LODUP(LWD(IFDX),1,2,N,1)
C
      DO 37 II=1,6
      I=7-II
      JI=(II-1)/3+1
      IF(N.EQ.JCON(I)) GO TO 65
  37  CONTINUE
      IF(IBUMP(NF).EQ.2) GO TO 80
C
  38  GO TO (40,50,60,60),IS
C
  40  IF(NSCRAM(ITYP(IWDX),LWD(IFDX),COE(1)).EQ.2) GO TO 90
      NS(1)=JF
      GO TO 22
C
  50  IF(NSCRAM(ITYP(IWDX),LWD(IFDX),AM).EQ.2) GO TO 90
      IT=AM
      IF(AM.NE.FLOAT(IT)) GO TO 90
      IK=IT+1
      IF(IBUMP(NF).EQ.2) GO TO 80
      IF(NSCRAM(ITYP(IWDX),LWD(IFDX),COE(IK)).EQ.2) GO TO 90
      COE(IK)=ASIN(COE(IK)/ALIM(IK))
      NS(IK)=JF
      GO TO 22
C
  60  N='    '
      CALL LODUP(LWD(IFDX),1,2,N,1)
C
      DO 64 II=1,6
      I=7-II
      JI=(II-1)/3+1
      IF(N.EQ.JCON(I)) GO TO 65
  64  CONTINUE
      GO TO 90
C
  65  IF(IBUMP(NF).EQ.2) GO TO 80
      IF(NSCRAM(ITYP(IWDX),LWD(IFDX),AM).EQ.2) GO TO 90
      IT=AM
C
      IF(IS.EQ.4.AND.IT.NE.4) GO TO 66
      IF(IBUMP(NF).EQ.2) GO TO 80
C
  66  IF(NSCRAM(ITYP(IWDX),LWD(IFDX),AM).EQ.2) GO TO 90
      IF(IS.EQ.4) IT=4
      J=I-(I/4)*3
      J=(IT-1)*3+J
      IF(I.LE.3) GO TO 70
      NS(J+11)=JF
      IF(I.EQ.6) AM=(AM-OFS(IT))*0.01745329
      COE(J+11)=AM
      GO TO 22
C
  70  NT(J)=JF
      COF(J)=AM
      GO TO 22
C
  80  IF(LGRED.EQ.4) GO TO 95
C
      DO 82 I=1,12
      IF(NT(I).GE.0) GO TO 85
  82  CONTINUE
      RETURN
C
  85  CALL TRNHRM(COE,NS,COF,NT,1)
      RETURN
C
  90  KF=IFDX+4
      WRITE(6,2000) (LWD(I),I=IFDX,KF)
2000  FORMAT(' ? ',5A4)
C
  95  LGRED=5
      CALL SSWTCH(1,ISTAT)
      IF(ISTAT.NE.1) GO TO 80
      GO TO 15
      END

C$PROG INPCON
      SUBROUTINE INPCON(INWORD,NNWORD)
C
C     DECODE PARAMETERS GIVEN AS REAL TIME INPUT.
C
      DIMENSION NWD(20),INWORD(20)
      DO 10 I=1,20
   10 NWD(I)='    '
      DO 20 I=1,NNWORD
   20 NWD(I)=INWORD(I)
      CALL INTPM(NWD)
      RETURN
      END

C$PROG INTPM
      SUBROUTINE INTPM(NWD)
      DIMENSION NWD(20)
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      LOGICAL IEND
      DO 10 I=1,20
   10 IWD(I)=NWD(I)
      NF=-1
      CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
      IF(IEND) RETURN
C
      N='    '
      CALL LODUP(LWD(1),1,1,N,1)
      IF(N.EQ.'O   ') CALL SETSSW(15,2)
      IF(N.EQ.'S   ') CALL SETSSW(14,1)
      RETURN
      END

C$PROG ISBYTE
      SUBROUTINE ISBYTE(IT,IBY,NB)
      BYTE IBY(1),IT(4)
C
      IBY(NB+1)=IT(1)
      RETURN
      END

C$PROB JFIELD
      FUNCTION JFIELD(JANG,K,IPH,IBF)
C
C        CALCULATES IBF*COS(K*ANG-IPH).
C        THE 900 ACCOUNTS FOR THE 9. DEGREE SHIFT OF THE ORIGINAL
C        FIELD MEASUREMENTS FROM THE HORIZONTAL.
C
      ANG=FLOAT(K*(JANG+900)-IPH)*0.00017453
      JFIELD=FLOAT(IBF)*COS(ANG)
      RETURN
      END

C$PROB KFIELD
      FUNCTION KFIELD(JJ,JANG)
C
C        RETURNS FIELD AT RADIUS=(JJ-1) AND ANGLE=JANG/100.
C
      COMMON /SCRAA/IBF(180,14),DUM(2)
      COMMON /STOREB/LDF,JOFF
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      K=JJ-JOFF
      IF(JJ.GT.40) GO TO 30
      IF(K.GT.0.AND.K.LT.15) GO TO 25
C
C        IF REQUIRED FIELD POINT IS NOT IN BUFFER IBF, LOAD IN NEW
C        FIELD REGION INTO BUFFER.
C
      JOFF=MAX0(JJ-7,0)
      JOFF=MIN0(JOFF,26)
      CALL SNAIS(LDF,JOFF*3+1)
      DO 20 I=1,14
  20  CALL TCREED(LDF,IBF(1,I),360)
      K=JJ-JOFF
  25  J=JANG/200+180
      J=MOD(J,180)+1
      KFIELD=IBF(J,K)
      RETURN
  30  NSKIP=1
      KFIELD=0
      RETURN
      END

C$PROG KICK
      SUBROUTINE KICK(EET,T,TO,NORB)
C
C        KICK THE ENERGY OF THE PARTICLE AND OTHER APPROPRIATE PARA-
C        METERS FOR DEE-GAP CROSSING.
C
      COMMON /FEQOR/ALPHA,VV
      COMMON /PART/Q,AM2,S
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      DOUBLE PRECISION DB,V,VT,T,ARGJ
      DB=6.283185*((T-TO)*FREQ*HA*1.0D+06-FLOAT(NORB))/HA
      EET=EET+Q*VDEE*DCOS(DB)/1000.
      VT=AM1/(EET+AM1)
Cjbb
      ARGJ=1.0D+00-VT*VT
      IF(ARGJ.LT.0.0) STOP 'EXIT CALLED FROM SUBROUTINE KICK'
Cjbb
      V=DSQRT(ARGJ)
      ALPHA=8.987543D+06*Z1/AM1*VT
      VV=V*3.0D+10/2.54
      RETURN
      END

C$PROG KINDA
      FUNCTION KINDA(IWD)
C
C     FUNCTION TO DETERMINE BYTE "TYPE"
C
C     KINDA=1 SAYS NUMERIC (DIGITS 0 THRU 9 + - . )
C     KINDA=2 SAYS NON-NUMERIC BUT NOT A DELIMITER
C     KINDA=3 SAYS A DELIMITER (BLANK , = / ( )  )
Cjbb   - following hex notation is not compatible with MS Fortran
Cj      IF(IWD.GE.'30'X.AND.IWD.LE.'39'X) GO TO 10
Cj      IF(IWD.EQ.'2B'X.OR.IWD.EQ.'2D'X.OR.IWD.EQ.'2E'X) GO TO 10
Cj      IF(IWD.EQ.'20'X.OR.IWD.EQ.'2C'X.OR.IWD.EQ.'3D'X) GO TO 20
Cj      IF(IWD.EQ.'2F'X.OR.IWD.EQ.'28'X.OR.IWD.EQ.'29'X) GO TO 20
Cjbb   - instead of changing to MS hex, just use decimal equivalent
      IF(IWD.GE.48.AND.IWD.LE.57) GO TO 10
      IF(IWD.EQ.43.OR.IWD.EQ.45.OR.IWD.EQ.46) GO TO 10
      IF(IWD.EQ.32.OR.IWD.EQ.44.OR.IWD.EQ.61) GO TO 20
      IF(IWD.EQ.47.OR.IWD.EQ.40.OR.IWD.EQ.41) GO TO 20
      KIND=2
      GO TO 30
   10 KIND=1
      GO TO 30
   20 KIND=3
   30 KINDA=KIND
      RETURN
      END

C$PROG LODUP
      SUBROUTINE LODUP(IBY,IA,IB,JBY,JA)
      BYTE IBY(1),JBY(4)
C
C     LOADS BYTES IA THRU IB FROM IBY INTO JBY (STARTING AT JA IN JBY)
C
Cjbb
      DO 5 I=1,4
    5 JBY(I)=" "
Cjbb      
      J=JA
      DO 10 I=IA,IB
      JBY(J)=IBY(I)
      J=J+1
   10 CONTINUE
      RETURN
      END

C$PROG MASEX     - Interface to ORPHLIB's MASSEX
C
      SUBROUTINE MASEX(IZ,IA,EX,ER,ISOR,IERR)
C
Cjbb      REAL*8  EXX,ERR
C
Cjbb   - The subroutine MASSEX is a large and complicated program that
Cjbb     lists mass excess, with error, for all nuclei for which this
Cjbb     has been experimentally deterimined and uses several models to
Cjbb     calculate these values for other nuclei specified.  This is
Cjbb     much more than we need for JBACCEL, so we will comment out the
Cjbb     call and add the necessary information for the few light nuclei
Cjbb     of interest here.
Cjbb
Cjbb      CALL MASSEX(IZ,IA,EXX,ERR,ISOR,IERR)
Cjbb      EX=EXX
Cjbb      ER=ERR
C
C     modified 4/8/07 to process the molecular ion H2+
C       with the symbol HH and mass number 2 and IZ=0 (see MASSYM)
C
      ISOR=0
      IERR=0
C
      IF(IZ.EQ.0) THEN
        EX=2*7288.971    !this is molecular ion H2+
        ER=1.1E-04
        GO TO 100
      END IF
C
      IF(IZ.EQ.1) THEN
        IF(IA.EQ.1) THEN
          EX=7288.971    !this is a proton
          ER=1.1E-04
          GO TO 100
        END IF
        IF(IA.EQ.2) THEN
          EX=13135.72    !this is a deuteron
          ER=3.5E-04
          GO TO 100
        END IF
        GO TO 200
      END IF
      IF(IZ.EQ.2) THEN
        IF(IA.EQ.3) THEN
          EX=14931.21    !this is He-3
          ER=2.42E-03
          GO TO 100
        END IF
        IF(IA.EQ.4) THEN
          EX=2424.916    !this is an alpha particle
          ER=6.0E-05
          GO TO 100
        END IF
        GO TO 200
      END IF
      GO TO 200
C
  100 RETURN
C
  200 WRITE(6,4200)IZ,IA
 4200 FORMAT(1X,'Parameters for particle with Z=',I3,
     1  ' and A=',I4,' are not available!')
      STOP
      END

C$PROG MASSYM
C
      FUNCTION MASSYM(JSYM)
C
C     modified 4/8/07 to process the molecular ion H2+
C       with the symbol HH and mass number 2 and IZ=0
C
      INTEGER*2 ISYMB(103),JSYM,IKSYM
      CHARACTER*40 ISYMC(6)
      CHARACTER*2 KSYM
      EQUIVALENCE  (ISYMB,ISYMC)
      EQUIVALENCE (IKSYM,KSYM)
C
      DATA ISYMC/'H HELIBEB C N O F NENAMGALSIP S CLARK CA',
     *           'SCTIV CRMNFECONICUZNGAGEASSEBRKRRBSRY ZR',
     *           'NBMOTCRURHPDAGCDINSNSBTEI XECSBALACEPRND',
     *           'PMSMEUGDTBDYHOERTMYBLUHFTAW REOSIRPTAUHG',
     *           'TLPBBIPOATRNFRRAACTHPAU NPPUAMCMBKCKESFM',
     *           'MDNOLR                                  '/
      DATA KSYM/'HH'/
Cjbb
      IF(JSYM.EQ.IKSYM) THEN
        I=0
        GO TO 20
      END IF
Cjbb
      DO 10 I=1,103
      IF(JSYM.EQ.ISYMB(I)) GO TO 20
  10  CONTINUE
      WRITE(6,1000) JSYM
1000  FORMAT(' ? ',A2)
      MASSYM=-1
      RETURN
  20  MASSYM=I
      RETURN
      END

C$PROG NSCRAM
      FUNCTION NSCRAM(I,L,A)
C Not legal in modern fortran - EjP 20230706
C      DIMENSION L(2)
      CHARACTER*4 L(2)
      CHARACTER*8 LBUF
C
      LBUF(1:4)=L(1)
      LBUF(5:8)=L(2)
      NSCRAM=1
      IF(I.NE.2) GO TO 20
Cjbb
C        DECODE(8,1000,L(1)) A
C  1000  FORMAT(F8.0)
Cjbb
      READ(LBUF,'(F8.0)') A
      RETURN
  20  A=0.0
      NSCRAM=2
      RETURN
      END

C$PROG ORBRAD
      SUBROUTINE ORBRAD(EE,AM,FREQ,HA,RE,BETA,RSIG)
C
C        FOR A GIVEN ENERGY EE, CALCULATES ORBIT RADIUS -RE.
C
      DIMENSION RSIG(1)
      DOUBLE PRECISION ET
      ET=EE+AM
      BETA=DSQRT(ET*ET-AM*AM)/ET
      REF=1.8784673D+03*BETA/FREQ/HA
      RE=REF
      DO 20 I=1,3
      IR=RE
      RSG=RSIG(IR)+(RSIG(IR+1)-RSIG(IR))*(RE-FLOAT(IR))
  20  RE=REF/RSG
  22  RETURN
      END

C$PROG QKUTTA    - Runga Kutta integration routine
C
      SUBROUTINE QKUTTA(F,NE,X,NSTEP,W,Y)
C
C        QUARTIC RUNGA  -KUTTA INTEGRATION ROUTINE.
C            F     - SUBROUTINE WHICH EVALUATES DERIVATIVES
C            NE    - NUMBER OF EQUATIONS TO BE INTEGRATED
C            X     - INDEPENDENT VARIABLE
C            NSTEP - NUMBER OF INTEGRATION STEPS
C            W     - STEP SIZE
C            Y     - DEPENDENT VARIABLES.
C
      DIMENSION AK(4,14),Y(14),YI(14),A(4),YP(14)
      DOUBLE PRECISION AK,YI,Y,YP
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /TEM/BZ,DBZ
      DATA A/0.0,0.5,0.5,1.0/
C
      DO 80 L=1,NSTEP
      XI=X
      DO 10 I=1,NE
  10  YI(I)=Y(I)
      DO 60 J=1,4
      IF(J.EQ.1) GO TO 50
      DO 40 I=1,NE
  40  Y(I)=AK(J-1,I)*A(J)+YI(I)
  50  X=XI+A(J)*W
      CALL F(X,Y,YP)
      IF(NSKIP.NE.0) RETURN
      DO 60 I=1,NE
  60  AK(J,I)=0.17453292D-01*W*YP(I)
      DO 70 I=1,NE
  70  Y(I)=YI(I)+(AK(1,I)+2.*(AK(2,I)+AK(3,I))+AK(4,I))/6.0
C     IF(W.LT.10.0) WRITE(15,5000) X,Y(1),Y(2),Y(3),Y(4),BZ
5000  FORMAT(1H ,6E12.5)
  80  CONTINUE
      RETURN
      END

C$PROG ROSGRED
C
      SUBROUTINE ROSGRED(LWD,ITYP,NF,IEND,IWD)
C
      LOGICAL IEND
      CHARACTER XFLAG*4
C Eliminate illegal equivalence of integer and characters -EjP 20230706
C      DIMENSION IWD(20),JWD(80),KWD(320),LWD(1),ITYP(1)
      CHARACTER*4 IWD(20)
      DIMENSION JWD(80),KWD(320),LWD(1),ITYP(1)
C
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
C
      DATA JNUM,JALP,JDEL,MAXB,LF/1,2,3,320,8/
      IEND=.FALSE.
      NTER=0
C
C     NTER = # BYTES TRUNCATED (THIS IS BAD STUFF)
C
C
C     READ IN THE CARD IMAGE AND UNPACK BYTES INTO FULL WORDS
C
      IF(NF.LT.0) GO TO 11
C
      IF(LGRED.EQ.5) CALL PROMPT
C
    5 READ(LGRED,10,END=200)IWD
   10 FORMAT(20A4)
   11 CONTINUE
C
      CALL CASEUP(IWD)
C
Cjbb     - skip past any leading comment cards in TCISOC.CAR
      XFLAG=IWD(1)
      IF(XFLAG(1:1).EQ.'!') GO TO 5
C
      NF=0
      DO 12 I=1,MAXB
      KWD(I)='    '
   12 CONTINUE
      DO 20 I=1,80
      J=(I-1)/4+1
      JJ=MOD(I-1,4)
      CALL ILBYTE(JTEMP,IWD(J),JJ)
      JWD(I)=JTEMP
   20 CONTINUE
      NS=0
      JLO=1
      JHI=80
      KHI=0
   30 NS=NS+1
      KLO=KHI+1
      KHI=KLO+LF-1
C
C     STARTING AT JLO, FIND THE FIRST NON-DELIMITER
C
      IF(JLO.GT.JHI) GO TO 150
      DO 40 I=JLO,JHI
      IF(KINDA(JWD(I)).NE.JDEL) GO TO 45
   40 CONTINUE
      GO TO 150
C
C     LEFT JUSTIFY FIELDS STARTING WITH A NON-NUMERIC
C     RIGHT JUSTIFY FIELDS STARTING WITH A NUMERIC CHARACTER
C
   45 JLO=I
      IF(KINDA(JWD(I)).EQ.JNUM) GO TO 100
      K=KLO
      NF=NS
      ITYP(NF)=1
      DO 50 I=JLO,JHI
      IF(KINDA(JWD(I)).EQ.JDEL) GO TO 55
      IF(KINDA(JWD(I)).EQ.JNUM) GO TO 60
      IF(K.LE.KHI) GO TO 48
      NTER=NTER+1
      GO TO 50
   48 KWD(K)=JWD(I)
      K=K+1
   50 CONTINUE
      GO TO 150
   55 JLO=I+1
      GO TO 30
  60  JLO=I
      NS=NS+1
      KLO=KHI+1
      KHI=KLO+LF-1
      IF(JLO.GT.JHI) GO TO 150
      GO TO 45
C
C     RIGHT JUSTIFY NUMERIC FIELDS
C
C
C     FIND NEXT DELIMITER
C
C     IF(JLO.GT.JHI) GO TO 115
  100 DO 110 I=JLO,JHI
      IF(KINDA(JWD(I)).EQ.JDEL) GO TO 120
      IF(KINDA(JWD(I)).EQ.JALP) GO TO 120
  110 CONTINUE
  115 I=JHI+1
  120 JUP=I-1
      NDO=JUP-JLO+1
      IF(NDO.LT.1) GO TO 30
      IF(NDO.LE.LF) GO TO 125
      NTER=NTER+(NDO-LF)
      NDO=LF
  125 K=KHI
      J=JUP
      NF=NS
      ITYP(NF)=2
      DO 130 N=1,NDO
      KWD(K)=JWD(J)
      J=J-1
      K=K-1
  130 CONTINUE
      IF(KINDA(JWD(I)).EQ.JALP) GO TO 60
      JLO=JUP+2
      GO TO 30
C
C     NOW LOAD IT ALL INTO LWD
C
  150 DO 160 I=1,MAXB
      JTEMP=KWD(I)
      J=(I-1)/4+1
      JJ=MOD(I-1,4)
      CALL ISBYTE(JTEMP,LWD(J),JJ)
  160 CONTINUE
      RETURN
  200 IEND=.TRUE.
      RETURN
      END

C$PROG SETFOR    - Set up Fourier coefficients describing field
C
      SUBROUTINE SETFOR
C
C     ------------------------------------------------------------------
C     SET UP FOURIER COEFFICIENTS DESCRIBING FIELD FOR CURRENTS -CUR.
C     ------------------------------------------------------------------
C
      COMMON /LIN/LDNB,NPOS,CUR(23)
      COMMON /SCRAA/IBAV(153),IBFR(22,39),IPHIR(22,39),IBFS(11,10),
     *IPHIS(11,10),IPHISS(9),IBFT(2,29),IPHIT(2,29),IHH(22),SIG(46),
     *GAMMA(39),DUM(84),ACOF(117)
      COMMON /COIL/COIL(99)
      DIMENSION IPAR(4),AA(9),AT(2),AB(21)
      EQUIVALENCE (AT(1),AT1),(AT(2),AT2)
      DATA AA(1),AA(2),AA(3),AA(4),AA(5),AA(6),AA(7),AA(8),AA(9)/0.,
     *197.,-104.,-40.,162.,-128.,-62.,210.,-85./
      DATA AB(1),AB(2),AB(3),AB(4),AB(5),AB(6),AB(7),AB(8),AB(9),AB(10),
     *AB(11),AB(12),AB(13),AB(14),AB(15),AB(16),AB(17),AB(18),AB(19),
     *AB(20),AB(21)/0.11466,0.11706,0.1194,0.11996,0.1206,0.1208,
     *0.12062,0.12012,0.11932,0.1183,0.11706,0.11564,0.1141,0.11244,
     *0.11068,0.10884,0.10694,0.10502,0.10304,0.10106,0.09906/
C
      FCOIL(XX,YY)=XX/(FLOAT(I)+YY)**3
      LDNB=9
      CALL SSWTCH(12,KCOIL)
C
C     ------------------------------------------------------------------
C     IF SSWTCH 12 EQUALS 1, USE UPGRADE PARAMETERIZATION FOR
C     CALCULATING FIELD.
C     ------------------------------------------------------------------
C
      IF(KCOIL.EQ.2) LDNB=9
      IF(KCOIL.EQ.1) LDNB=10
Cjbb                       since ISTAT is not passed to this subroutine
Cjbb      IF(ISTAT.GT.0) THEN   ! it is not clear why this statement is
Cjbb        STOP 'ISTAT ERR0R!!'   ! here unless it is to test if all
Cjbb      END IF               ! values are initialized to zero at start
Cjbb                              so for now will just ignore
      DO 3 J=1,99
   3  COIL(J)=0.0
C
C     ------------------------------------------------------------------
C     IF SSWTCH 12 EQUALS 1, READ IN COIL CORRECTIONS FOR
C     SUPERCONDUCTING COILS.
C     ------------------------------------------------------------------
C
      IF(KCOIL.EQ.1) READ(12,2000) COIL
2000  FORMAT(8F10.0)
      DO 5 J=1,9
   5  IHH(J)=J+1
      DO 10 J=10,22
  10  IHH(J)=(J-10)*3+13
      DO 15 I=1,9
  15  IPHISS(I)=AA(I)*100.
      CSAV=CUR(1)
      CU=CUR(1)/1000.
C
C     ------------------------------------------------------------------
C     CORRECTION OF CURRENT FOR PRESENCE OF TRANSITION PIECE.
C     ------------------------------------------------------------------
C
      CUR(1)=-0.010711+CU*(1.010412-0.000614*CU)
      NSEC=-29
C
C     ------------------------------------------------------------------
C     CALCULATES FOURIER COEF. FOR 0. TO 38. INCHES.
C     ------------------------------------------------------------------
C
      DO 30 I=1,39
      NSEC=NSEC+29
      CALL SNAIS(LDNB,NSEC)
      RAD=I-1
      BAV=BAVERG(RAD)
      IBAV(I)=100.*BAV
      IF(I.NE.1) GO TO 18
      DO 16 J=1,22
      DO 16 JJ=1,39
      IBFR(J,JJ)=0
  16  IPHIR(J,JJ)=0
      GO TO 30
  18  CALL SNAIS(LDNB,NSEC+2)
      DO 20 J=1,13
      IH=IHH(J)
      CALL BFOR(IH,BAV,AT)
      IF(J.NE.1) GO TO 19
      AT1=AT1+(0.15144*CUR(1)-0.090865)*FLOAT(I-1)
      AT2=AT2+(0.023986*CUR(1)-0.014392)*FLOAT(I-1)
 19   IBFR(J,I)=DSQRT(DBLE(AT1*AT1)+DBLE(AT2*AT2))*100.
      IF(IBFR(J,I).EQ.0) GO TO20
      IPHIR(J,I)=ATAN2(AT2,AT1)*5729.578
  20  CONTINUE
      CALL SNAIS(LDNB,NSEC+28)
      CALL TCREED(LDNB,ACOF,128)
      DO 25 J=1,9
      JJ=(J-1)*4+1
      AT1=ACOF(JJ)*CUR(1)+ACOF(JJ+1)
      AT2=ACOF(JJ+2)*CUR(1)+ACOF(JJ+3)
      IBFR(J+13,I)=DSQRT(DBLE(AT1*AT1)+DBLE(AT2*AT2))*100.
      IF(IBFR(J+13,I).EQ.0) GO TO 25
      IPHIR(J+13,I)=ATAN2(AT2,AT1)*5729.578
  25  CONTINUE
  30  CONTINUE
      K=0
      DO 35 J=1,3
      DO 35 I=1,39
      K=K+1
  35  ACOF(K)=FLOAT(IBFR(3*J,I))/FLOAT(IBAV(I))
      DO 40 I=1,39
      RO=I-1
      GAMMA(I)=0.0
      SIG(I)=1.0
      DO 40 J=1,3
      JJ=I+(J-1)*39
      AT1=ACOF(JJ)
      JJ=J*J
      AT2=RO*FDV5(ACOF(39*J-38),I)
      SIG(I)=SIG(I)-0.5*(AT1+AT2)*AT1/FLOAT(9*JJ-1)
      AT1=(FLOAT(27*JJ-2)*AT1/FLOAT(9*JJ-1)+AT2*2.0)*AT1
  40  GAMMA(I)=GAMMA(I)-0.25*AT1/FLOAT(9*JJ-1)
      CU=CUR(1)*1000.
      NSEC=1131
C
C     ------------------------------------------------------------------
C     CALCULATE FOURIER COEF. FOR 39. TO 77. INCHES.
C     ------------------------------------------------------------------
C
      DO 70 I=39,77
      CALL SNAIS(LDNB,NSEC+(I-39))
      CALL TCREED(LDNB,ACOF,128)
      ACOF(1)=ACOF(1)+COIL(I+1)/1000.
      IBAV(I+1)=BAVF(ACOF,CU,CUR)*100.
      AT1=(ACOF(46)+ACOF(47)/CU)*100.
      AT2=(ACOF(48)+ACOF(49)/CU)*100.
      IF(I.GT.48) GO TO 60
      KK=I-38
      IPHIS(1,KK)=FORI(ACOF,4,CU)
      IPHIS(2,KK)=FORI(ACOF,7,CU)
      DO 50 J=3,33,3
      JJK=J/3
  50  IBFS(JJK,KK)=FORI(ACOF,J+7,CU)
      IBFS(1,KK)=IBFS(1,KK)+IFIX(AT1)
      IBFS(2,KK)=IBFS(2,KK)+IFIX(AT2)
      GO TO 70
  60  KK=I-48
      IPHIT(1,KK)=FORI(ACOF,4,CU)
      IPHIT(2,KK)=FORI(ACOF,7,CU)
      IBFT(1,KK)=FORI(ACOF,10,CU)+AT1
      IBFT(2,KK)=FORI(ACOF,13,CU)+AT2
  70  CONTINUE
      CUR(1)=CSAV
C
C     ------------------------------------------------------------------
C     CALCULATES FOURIER COEF. FOR 78. TO 152. INCHES.
C     ------------------------------------------------------------------
C
      DO 76 I=1,75
      AT2=FLOAT(I)+77.
      AT1=6.46667E+07-9.333E+03*CSAV
      IBAV(I+78)=(AT1/AT2**3)*100.
      IF(I.GT.21) GO TO 72
      AT2=-AB(I)+COIL(I+78)/1000.
      GO TO 76
  72  IF(I.GT.52) GO TO 74
      AT2=FCOIL(-1.72608E+05,99.1547)
      IF(KCOIL.EQ.1) AT2=FCOIL(-1.39008E+05,79.53154)
      GO TO 76
  74  AT2=FCOIL(-1.1586E+05,80.3465)
      IF(KCOIL.EQ.1) AT2=FCOIL(-1.21757E+05,73.8237)
  76  IBAV(I+78)=IBAV(I+78)+IFIX(CSAV*AT2*100.)
      CLOSE(UNIT=LDNB)
      LDNB=19-LDNB
      CLOSE(UNIT=LDNB)
      RETURN
      END

C$PROG SETSLD
      SUBROUTINE SETSLD
      COMMON /SHFSLD/R,RP,THETAP,RB,RB2,GP,PHP,SIG
      RB=0.0
      RB2=0.0
      BETA=1.570796
      GAMMA=1.570796
      SIG=SIGN(1.0,THETAP)
      IF(THETAP.EQ.0.0) GO TO 20
      R2=R*R
      RP2=RP*RP
      RB2=R2+RP2-2.*R*RP*COS(THETAP)
      RB=SQRT(RB2)
      BETA=SIG*ACOS((RP2+RB2-R2)/(2.*RP*RB))
      GAMMA=SIG*3.141593-THETAP-BETA
  20  GP=GAMMA
      PHP=BETA
      RETURN
      END

C$PROG SETSSW
      SUBROUTINE SETSSW(ISW,KSTAT)
C
C        SET SSWTCH ISW TO KSTAT.
C
      COMMON /SWTCH/N(15)
      N(ISW)=KSTAT
      RETURN
      END

C$PROG SETSWT
      SUBROUTINE SETSWT
C
C        READ IN STAUS OF DSWTCHES AND SSWTCHES FROM INITIALIZATION
C        FILE.
C
      COMMON /SWTCH/NSS(15)
      COMMON /DSWTCHH/NDS(15)
      READ(8,4000) NDS,NSS
 4000 FORMAT(30I1)
      RETURN
      END

C$PROG SETUP
      SUBROUTINE SETUP(PHINIT,JSYM,IA,JHARM)
C
C        EXAMINES FILE TCISOC.CAR AND EXTRACTS ALL INFORMATION- - ENERGY,
C        CURRENTS,ETC.
C
      COMMON /LIN/LDNB,NPOS,CUR(23)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      DIMENSION COF(12),NS(23),NT(12),ALIM(23)
      DATA ALIM/23*1000./
      CALL FINPUT(RTEMP,PHINIT,JSYM,IA)
      CALL INPARM(CUR,NS,ALIM)
      CALL TRNHRM(CUR,NS,COF,NT,2)
      JHARM=HA
      HA=1.0/HA
      K=11
      DO 1 I=1,12
      K=K+1
   1  CUR(K)=COF(I)
      DO 2 I=2,11
   2  CUR(I)=ALIM(I)*SIN(CUR(I))
      CALL SETFOR
      RETURN
      END

C$PROG SLD
      SUBROUTINE SLD(PHI,SRP,THETA,SR)
      COMMON /SHFSLD/R,RP,THETAP,RB,RB2,GP,PHP,SIG
      PHIT=(PHI+PHP)*SIG
      SRP2=SRP*SRP
      SR2=SRP2+RB2-2.*SRP*RB*COS(PHIT)
      SR=SQRT(SR2)
      IHIT=(PHIT+6.2831853)/3.141593
      ASIG=(-1)**(IHIT+1)
      GAMMAB=ASIG*SIG*ACOS((SR2+RB2-SRP2)/(2.*SR*RB))
      THETA=GP+GAMMAB
      RETURN
      END

C$PROG SLDB
      SUBROUTINE SLDB(REN,REX)
      COMMON /SHFSLD/R,RP,THETAP,RB,RB2,GP,PHP,SIG
      R=35.725
      RP=0.5*(REN+REX)
C
C     196.0 = (28.0/2.0)**2
C
      CTE=(196.0+RP*RP-REN*REN)/(28.0*RP)
      TCTE=ACOS(CTE)
      THETAP=TCTE-1.27779
      RETURN
      END

C$PROG SNAIS     - Sets record no. to be read by next call to TCREED
C
C     ******************************************************************
C     BY W.T. MILNER AT HRIBF - LAST MODIFIED 07/11/97
C     ******************************************************************
C
      SUBROUTINE SNAIS(LU,NSEC)
C
      IMPLICIT NONE
C
C     ------------------------------------------------------------------
      COMMON/DXIO/ NXREC(100)
      INTEGER*4    NXREC
C     ------------------------------------------------------------------
C
      INTEGER*4    LU,NSEC
C
      NXREC(LU)=NSEC+1     !Convert to record#
C
      RETURN
      END

C$PROG SNAOS     - Sets record no. to be written by next call to TCWRIT
C
C     ******************************************************************
C     BY W.T. MILNER AT HRIBF - LAST MODIFIED 07/16/97
C     ******************************************************************
C
      SUBROUTINE SNAOS(LU,NSEC)
C
      IMPLICIT NONE
C
C     ------------------------------------------------------------------
      COMMON/DXIO/ NXREC(100)
      INTEGER*4    NXREC
C     ------------------------------------------------------------------
C
      INTEGER*4    LU,NSEC
C
      NXREC(LU)=NSEC+1     !Convert to record#
C
      RETURN
      END

C$PROG SSWTCH
      SUBROUTINE SSWTCH(ISW,KSTAT)
C
C        RETURN STATUS OF SSWTCH ISW.
C
      COMMON /SWTCH/N(15)
      KSTAT=N(ISW)
      RETURN
      END

C$PROG TCREED    - Direct access read of binary file
C
C     ******************************************************************
C     BY W.T. MILNER AT HRIBF - LAST MODIFIED 07/11/97
C     ******************************************************************
C
      SUBROUTINE TCREED(LU,A,NHW)
C
      IMPLICIT NONE
C
C     ------------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      INTEGER*4   MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      CHARACTER*112 CMSSG
      EQUIVALENCE (CMSSG,MSSG)
C     ------------------------------------------------------------------
      COMMON/DXIO/ NXREC(100)
      INTEGER*4    NXREC
C     ------------------------------------------------------------------
C
      INTEGER*4    LU,NHW,NW,II,N,IREC,IOS
C
      REAL*4       A(*),BUF(64)
C
      NW=NHW/2
      II=0
C
  100 IREC=NXREC(LU)
C
      READ(LU,REC=IREC,IOSTAT=IOS)BUF
C
      IF(IOS.NE.0) GO TO 200
C
      NXREC(LU)=NXREC(LU)+1
C
      DO 110 N=1,64
      II=II+1
      A(II)=BUF(N)
      IF(II.GE.NW) RETURN
  110 CONTINUE
      GO TO 100
C
  200 WRITE(CMSSG,4200)LU,IREC
 4200 FORMAT('Error in TCREAD - LU,IREC =')
C
      WRITE(LOGUP,4210)CMSSG,LU,IREC
 4210 FORMAT(1X,A27,2I6)
      WRITE(LOGUT,4210)CMSSG,LU,IREC
      STOP
      END

C$PROG TCWRIT    - Direct access write to binary file
C
C     ******************************************************************
C     BY W.T. MILNER AT HRIBF - LAST MODIFIED 07/16/97
C     ******************************************************************
C
      SUBROUTINE TCWRIT(LU,A,NHW)
C
      IMPLICIT NONE
C
C     ------------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      INTEGER*4   MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      CHARACTER*112 CMSSG
      EQUIVALENCE (CMSSG,MSSG)
C     ------------------------------------------------------------------
      COMMON/DXIO/ NXREC(100)
      INTEGER*4    NXREC
C     ------------------------------------------------------------------
C
      INTEGER*4    LU,NHW,NW,II,N,IREC,IOS,I
C
      INTEGER*4    A(*),BUF(64)
C
      NW=NHW/2
      II=0
C
  100 IREC=NXREC(LU)
C
      DO 110 I=1,64
      BUF(I)=0
  110 CONTINUE
C
      DO 120 I=1,64
      II=II+1
      IF(II.GT.NW) GO TO 150
      BUF(I)=A(II)
  120 CONTINUE
C
  150 WRITE(LU,REC=IREC,IOSTAT=IOS)BUF
C
      IF(IOS.NE.0) GO TO 200
C
      NXREC(LU)=NXREC(LU)+1
C
      IF(II.GE.NW) RETURN
C
      GO TO 100
C
  200 WRITE(CMSSG,4200)
 4200 FORMAT('File write error in routine TCWRIT')
C
      WRITE(LOGUP,4210)IOS,CMSSG
 4210 FORMAT(1X,'---'/1X,A34,10X,'Error #',I4)
      WRITE(LOGUT,4210)IOS,CMSSG
      STOP
      END

C$PROG TRAC1
      SUBROUTINE TRAC1(AIIN,AIOUT,AMAIN)
      COMMON /SCRAC/C1(11),C2(11),D1(11),D2(11),E1(4),
     *  F1(11),G1(11)
      DIMENSION A1(10),A2(10),A3(10),B1(10),B2(10),B3(10),A4(2)
      DATA A1
     *  /-1.291200E+01,8.501800E+00,-2.126503E+00,-4.649983E-01,
     *  2.136435E+00,-2.707997E+00,2.361851E+00,-1.510652E+00,
     *  1.014372E+00,-8.503868E-01/
      DATA A2
     * /-5.757800E+01,3.759000E+01,-1.668195E+01,1.143438E+00,
     *  9.196799E+00,-1.378825E+01,1.363234E+01,-1.078965E+01,
     *  7.830764E+00,-5.645618E+00/
      DATA A3
     * /1.521552E+05,-1.066284E+05,5.525414E+04,-2.001694E+04,
     *  -5.900601E+03,1.779830E+04,-1.965627E+04,1.732359E+04,
     *  -1.450896E+04,1.087723E+04/
      DATA B1
     * /-1.871600E+00,3.005000E+00,-9.156163E+00,7.230882E+00,
     *  -4.556994E+00,2.673273E+00,-1.331197E+00,4.317138E-01,
     *  -3.843774E-01,5.893746E-01/
      DATA B2
     * /-8.053000E+00,1.334200E+01,-3.967844E+01,3.488707E+01,
     *  -2.573805E+01,1.636406E+01,-8.573962E+00,3.435989E+00,
     *  -1.226578E+00,6.387102E-01/
      DATA B3
     * /1.090700E+04,-1.737250E+04,7.936221E+04,-7.506983E+04,
     *  5.944085E+04,-4.127064E+04,2.671655E+04,-1.703813E+04,
     *  1.108192E+04,-6.817652E+03/
      DATA A4(1),A4(2)/6.32147,-5.58493/
      C1(1)=6.9876*AIIN+32.181*AIOUT
      C2(1)=1.386888E+07/AMAIN-98148.52
      D1(1)=0.0
      D2(1)=0.0
      DO 20 I=1,2
      C1(I+1)=A1(I)*AIIN+A2(I)*AIOUT
      C2(I+1)=A4(I)*AMAIN+A3(I)
      D1(I+1)=B1(I)*AIIN+B2(I)*AIOUT
  20  D2(I+1)=B3(I)
      DO 30 I=3,10
      C1(I+1)=A1(I)*AIIN+A2(I)*AIOUT+A3(I)
  30  D1(I+1)=B1(I)*AIIN+B2(I)*AIOUT+B3(I)
      RETURN
      END

C$PROG TRNHRM
      SUBROUTINE TRNHRM(COE,NS,COF,NT,L)
      DIMENSION COE(1),NS(1),COF(1),NT(1)
      GO TO (10,50),L
  10  DO 40 J=1,4
      K=(J-1)*3
      DO 20 I=1,3
      K=K+1
      IF(NT(K).GE.0) GO TO 24
  20  CONTINUE
      GO TO 40
  24  K=(J-1)*3+1
      KT=K+11
      COE(KT)=(COF(K)+COF(K+1)+COF(K+2))/3.0
      COE(KT+2)=ATAN2(0.57735*(COF(K+2)-COF(K+1)),COF(K)-COE(KT))
      COE(KT+1)=0.0
      P=COS(COE(KT+2))
      A=COF(K)-COE(KT)
      IF(ABS(A).GT.0.1E-05) COE(KT+1)=A/P
      NTT=0
      K=(J-1)*3
      DO 26 I=1,3
      K=K+1
      IF(NT(K).LT.0) NT(K)=0
      NS(K+11)=0
  26  NTT=NTT+NT(K)
      IF(NTT.EQ.0) GO TO 40
      K=(J-1)*3+11
      DO 30 I=1,NTT
      K=K+1
  30  NS(K)=1
  40  CONTINUE
      RETURN
  50  K=0
      DO 60 J=12,23,3
      DO 60 I=1,3
      K=K+1
      DUM=COE(J+2)+FLOAT(I-1)*2.094395
  60  COF(K)=COE(J)+COE(J+1)*COS(DUM)
      DO 65 K=1,12
  65  NT(K)=-1
      RETURN
      END

C$PROG ZODDHM
      SUBROUTINE ZODDHM
C
C        IF DSWTCH 1 NOT EQUAL TO 2, FOURIER COEF. 1,2,4,5,7 AND 8
C        ARE SET EQUAL TO 0.0 AND HARMONIC CONTRIBUTIONS FROM LOWER
C        CHANNEL ARE SET EQUAL TO 0.0.
C
      COMMON /COEB/BEX(11,2,39)
      COMMON /SCRAA/IBAV(153),IBFR(22,39),DUM(1511)
      CALL DSWTCH(1,I)
      IF(I.EQ.2) GO TO 20
      DO 5 I=1,11
      DO 5 J=1,39
      BEX(I,1,J)=0.0
   5  BEX(I,2,J)=0.0
      DO 10 I=1,39
      DO 10 J=1,8,3
      IBFR(J,I)=0
  10  IBFR(J+1,I)=0
  20  RETURN
      END



