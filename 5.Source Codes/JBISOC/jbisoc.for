C$PROG ISOCM
C
C     JBISOC   -   a modification of TCFIELD for MS Fortran on the PC
C
C     This version has replaced subroutine GSTRING with JSTRING so that
C     command line options are now offered during run time.  This
C     eliminates the need to run this program from a DOS prompt.
C
      DIMENSION BAV(39),COR(12),CSIG(12),SIGMAA(180),A(180),D(78
     *  ),SIGMAB(23),BHV(78),SIGMAC(78),
     * MS(23),PROG(2),TPROG(8),INWORD(20)
      COMMON /LIN/LDNI,NPOS,CUR(23)
      COMMON /COEF/A0(66,39),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      COMMON /SCRAA/YFIT(1404)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /COEG/NPTS,NTERMS,IR,BISOC(39),PHINIT,IB1,IB2,TSIG(39),ACTE
      COMMON /MGCONE/DNU(16),ENU(16)
      COMMON /VERS/VNUM,PRMID
      DOUBLE PRECISION ET
C MSGHDL appears to have been related to a CNTL-C handling routine, but it's been
C commented out in ACCLIB and causes a link error, so I'm getting rid of it.
C EjP 20230712
C      EXTERNAL PURRT,PCURRT,DURRT,DDURRT,MSGHDL
      EXTERNAL PURRT,PCURRT,DURRT,DDURRT
C
      CHARACTER*8  CPROG,VNUM,PRMID*32
      CHARACTER*32 CTPROG
      EQUIVALENCE (CPROG,PROG),(CTPROG,TPROG)
      DATA CPROG/'JBISOC  '/
      DATA CTPROG/'FIELD ISOCHRONIZATION PROGRAM   '/
      DATA VNUM/'v.021307'/     !version number (date) for this program
C
   10 WRITE(6,*)' *** Begin Program JBISOC ***'
      WRITE(6,*)' '
C      
      CALL JSTRING(INWORD,INNUMC)
      CALL ISOCINIT
      CALL INSWTC(INWORD,INNUMC)
C
      PRMID='                                '
      ISTAT=0
      NFOD=7
      NYOD=3
      NTOD=4
      ICOF=2
      IH=1
      ITM=1
      NQOD=1
      CHISQR=0.0
      CHISQS=0.0
      DO 15 I=1,23
  15  ALIM(I)=1.0
      READ(8,1005) RTEMP,VDEE,PHINIT,HA,RI,RF,FREQLM,PHIN3
1005  FORMAT((8F10.0))
      READ(8,1005) (ALIM(I),I=2,11),(ALIM(I),I=13,23,3)
      LDNI=9
      LLT=0
      PHINT=0
      CALL FINPUT(RTEMP,PHINT,ISYM,IAM1)
      IF(HA.LT.0.00001) HA=1.0
      J=HA
      HA=1.0/HA
      CALL SSWTCH(12,JSTAT)
      IF(JSTAT.EQ.2) LDNI=9
      IF(JSTAT.EQ.1) LDNI=10
      IF(ISTAT.GT.0) STOP ' EXIT CALLED FROM MAIN WITH ISTAT > 0'
      IF(EINJ.NE.0.0) PHINIT=0.0
      CALL GETA0(A0)
      RSIG=1.0
      DO 20 I=1,2
      CALL KINEM(EE,AM1,Z1,RTEMP,RE,FREQ,HA,IR,BO,BF,FREQLM,
     * BLAMDA,RSIG)
  20  CALL FDCURT(CURM,BF,A0(1,IR),IR,GAM,AI1,BI1,RSIG)
      J=(1.0/HA)+0.001
      JHARM=J
      IF(PHINT.EQ.0.0.AND.J.EQ.1) GO TO22
      PHINIT=PHINT
      IF(J.EQ.3.AND.PHINT.EQ.0.0) PHINIT=PHIN3
  22  PHIN=PHINIT
      DO 25 I=1,39
  25  BAV(I)=BAVG2(CURM,A0(1,I))
      CALL FDSIG(CURM,BAV,BISOC,BO,BLAMDA)
      CALL HEADER(PROG,TPROG,PHINIT,ISYM,IAM1,JHARM)
      ET=EINJ+AM1
      ET=AM1/ET
      RINJ=1.8784673E+03*DSQRT(1.0D0-ET*ET)/FREQ/HA
      ACTE=RI
      IF(RI.EQ.0.0) ACTE=IFIX(RINJ-2.)
      ACTE=IFIX(RINJ-2.)
      RI=AMAX1(0.0,ACTE)
      IF(RF.EQ.0.0) RF=IFIX(RE+0.999)
      CALL EXTRAC(A,CURM*1000.)
      ACTE=HA*FREQ
      ACTE=-8.89067E-04*ACTE*ACTE*AM1/(VDEE*Z1*BO*HA)
C
C        INITIALIZE PARAMETERS TO BE VARIED
C
      DO 44 I=1,23
  44  SIGMAB(I)=0.0
      DO 45 I=13,23,3
      IF(ALIM(I).EQ.0.0) ALIM(I)=1.0
  45  CONTINUE
      CALL DEFINT(A,NS,JHARM)
      A(1)=CURM*1000.
      DO 50 I=2,11
   50 A(I)=ASIN(A(I)/ALIM(I))
      DO 54 I=1,23
  54  COE(I)=A(I)
C
C        DETERMINE VALUES OF PARAMETERS TO BE HELD CONSTANT
C
      CALL INCOE(7,8)
      DO 55 I=13,22,3
      IF(ALIM(I).EQ.1.0) ALIM(I)=COE(I-1)
      WRITE(6,4055)I,COE(I),ALIM(I)
 4055 FORMAT(1X,'LOOP AT 55 I,COE,ALIM: ',I3,2F12.5)
  55  COE(I)=ASIN(COE(I)/(ALIM(I)+0.0001))
      K=1
      DO 60 I=1,23
      MS(I)=NS(I)
      IF(I.GT.11.AND.I.NE.21) NS(I)=1
      IF(NS(I)) 56,56,60
  56  A(K)=COE(I)
      NS(I)=0
  58  K=K+1
  60  CONTINUE
C
C        DETERMINE NUMBER OF PARAMETERS TO BE VARIED
C
      NTERMS=23
      DO 70 I=1,23
      SIGMAA(I)=0.0
  70  NTERMS=NTERMS-NS(I)
      CALL SSWTCH(6,KSTAT1)
      JITER=1
      IF(NS(21).EQ.0.AND.KSTAT1.EQ.2) JITER=3
      IR1=RI
      IR2=RF
      NPTS=IR2+1-IR1
      IOFF=IR1
C
C        SET UP FIELD TO BE FIT
C
  71  DO 72 I=1,39
      K=I+IOFF
  72  TSIG(I)=YFIT(I+234)+FLOAT(I-1)*FDV5(YFIT(235),I)
      IB1=1
      IB2=IR+1
      DO 74 I=1,39
      D(I)=0.0
  74  SIGMAC(I)=0.017
      IF(EINJ.NE.0.0) GO TO 78
      IB1=16
      DO 75 I=1,IB1
      SIGMAC(I)=4.E-04
      D(I)=ENU(I)
      IF(HA.EQ.1.0) D(I)=DNU(I)
  75  CONTINUE
      SIGMAC(IB1+1)=0.0872
      SIGMAC(IB1+2)=0.0872
      SIGMAC(IB1+3)=0.0872
  78  MODE=1
C
C        ENTER ROUTINES FOR FITTING AVERAGE FIELD
C
  100 CALL FIT(BAV,IOFF,D,YFIT,SIGMAC,NPTS,NTERMS,MODE,CHISQR,A,SIGMAA,
     * PURRT,PCURRT)
      DO 102 J=1,39
      BHV(J)=YFIT(J)
 102  BAV(J)=YFIT(J+39)
      CALL FFSIG(BAV,BISOC,BO,BLAMDA)
      CALL FSIGG(NS,SIGMAB,SIGMAA,COR,CSIG,ALIM,CUR)
      CALL SSWTCH(3,KSTAT1)
      GO TO (105,110),KSTAT1
C
C        IF SWITCH 3 ON, PRINT INTERMEDIATE RESULTS
C
 105  WRITE(15,1100) CHISQR
1100  FORMAT(3X,'INTERMEDIATE RESULTS - AVERAGE FIELD'/1H0,2X,
     * 'CHISQR=',F12.4)
      WRITE(15,1110)
1110  FORMAT(3X,'RADIUS',6X,'PROG',6X,'CALC',6X,'DIFF',21X,
     *  '.',20X,'CURRENT SETTINGS')
      DO 107 JJ=1,NPTS
 107  YFIT(JJ)=BHV(JJ)
      CALL CPOUT(NPTS,D,YFIT,BAV,IOFF,CUR,SIGMAA,COR,CSIG,1)
 110  IF(LLT.GE.JITER) GO TO 114
      LLT=LLT+1
      CALL SSWTCH(5,KSTAT1)
      GO TO (114,71),KSTAT1
C
C        IF SWITCH 5 ON, EXIT ITERATION CYCLE
C
 114  CALL SSWTCH(4,KSTAT1)
C
C        ENTER FIRST HARMONIC MINIMIZATION PHASE
C        IF SWITCH 4 ON, FIT FIRST HARMONIC
C
 116  K=1
      DO 117 I=13,22,3
 117  COE(I)=ALIM(I)*SIN(COE(I))
      DO 120 I=1,23
      IF(NS(I)) 118,118,120
 118  COE(I)=A(K)
      K=K+1
 120  CONTINUE
      CALL INCOE(9,10)
      DO 130 I=13,22,3
      WRITE(6,4130)I,A(I),ALIM(I)
 4130 FORMAT(1X,'LOOP AT 130 I,A,ALIM: ',I3,2F12.5)
 130  COE(I)=ASIN(COE(I)/(ALIM(I)+0.0001))
      K=1
      DO 136 I=1,23
      NS(I)=MS(I)
      IF(I.LT.12.OR.MOD(I-12,3).EQ.0) NS(I)=1
      IF(NS(I)) 132,132,136
 132  A(K)=COE(I)
      NS(I)=0
 134  K=K+1
 136  CONTINUE
      NTERMS=23
      DO 138 I=1,23
      SIGMAA(I)=0.0
 138  NTERMS=NTERMS-NS(I)
      DO 140 I=1,NPTS
 140  D(I)=0.0
      NFOD=5
      NYOD=0
      NTOD=2
      ICOF=1
      IH=2
      NQOD=2
      DO 142 I=1,39
      SIGMAC(I)=1.0
 142  YFIT(I+507)=BAV(I)
      CALL GETA1(A0,IH)
      MODE=2
      IF(KSTAT1.EQ.2) NTERMS=0
C
C        ENTER ROUTINES FOR FITTING FIRST HARMONIC
C
      CALL FIT(BHV,IOFF,D,YFIT,SIGMAC,NPTS,NTERMS,MODE,CHISQS,A,SIGMAA,
     * DURRT,DDURRT)
      CALL FSIGG(NS,SIGMAB,SIGMAA,COR,CSIG,ALIM,CUR)
      DO 155 JJ=1,NPTS
      J=JJ+IOFF
 155  YFIT(JJ)=BHV(J)
      IF(KSTAT1.EQ.2) GO TO 160
      WRITE(15,1120) CHISQS
1120  FORMAT(3X,'INTERMEDIATE RESULTS - FIRST HARMONIC'/3X,
     *  'CHISQS=',F10.4)
      WRITE(15,1130)
1130  FORMAT(3X,'RADIUS',2X,'1ST-HARM',5X,'CALC',6X,'DIFF',22X,
     *  '.',20X,'CURRENT SETTINGS')
      CALL CPOUT(NPTS,D,YFIT,BHV,IOFF,CUR,SIGMAA,COR,CSIG,2)
C
C        PRINT FINAL RESULTS
C
 160  WRITE(15,1140) IR1,IR2,CHISQR,CHISQS
1140  FORMAT(/3X,'REGION FIT:',2X,I2,'. TO ',I2,'. INCHES'/
     *  3X,'CHISQR= ',F12.4,5X,'CHISQS= ',F10.4)
      WRITE(15,1150)
1150  FORMAT(3X,'FINAL RESULTS ',98('-'))
      WRITE(15,1160)
1160  FORMAT(3X,'RADIUS',3X,'BISOC',5X,'B-CALC',6X,'DIFF',3X,
     *  '1ST-HARM',3X,'PHASE',3X,'.',20X,'CURRENT SETTINGS')
      CALL CPOUT(35,BISOC,BAV,BHV,0,CUR,SIGMAB,COR,CSIG,3)
      WRITE(15,1170)
1170  FORMAT(3X,111('-'))
      CALL PRMOUT(CUR,MS,PHIN,ISYM,IAM1)
      CALL HARMC(BHV,A,BAV)
      CALL BPOUT(ACTE,HA,PHINIT,BISOC,BAV,IOFF)
      WRITE(15,1170)
 200  WRITE(*,*)' '      !blank line for output formatting
      STOP ' *** End Program JBISOC ***'
      END

C$PROG BAVG2
      FUNCTION BAVG2(C,A)
      COMMON /FCD/C1,C2,C3,C4
      DIMENSION A(10)
      H=0.0
      CU=1.0/C
      CX=C*C
      DO 10 I=1,7
      CX=CX*CU
  10  H=H+A(I)*CX
      C2=C*A(8)
      C3=C*A(9)
      C4=C*A(10)
      BAVG2=FILD(H)
      RETURN
      END

C$PROB BINTP4
      SUBROUTINE BINTP4(X,R,BZ,DBZ)
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
      IB(I)=LFIELD(JJ,JANG)/100
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

C$PROB BPOUT
      SUBROUTINE BPOUT(AC,HA,PHINIT,BISOC,BAV,IOFF)
      COMMON /SCRAA/DAJ(39,3),DBJ(39,3),SIG(39),RSIG(39),ANUR(39),
     *  ANUZ2(39),GAMMA(39),DDAJ(39),DDBJ(39),ADUM(663),AJ(39,3),
     *  BJ(39,3)
      DIMENSION BISOC(1),BAV(1)
      WRITE(15,1000)
 1000 FORMAT(3X,'RADIUS',6X,'NUR',7X,'NUZ',6X,'PHASE',4X,
     *  '1ST-HARM.LIM.',1X,'TOT.HARM.  -PHASE',4X,'SIG')
      IF(VDEE.EQ.0.0) VDEE=71.
      DO 5 I=1,35
    5 RSIG(I)=SIG(I)+FLOAT(I-1)*FDV5(SIG,I)
      PHAT=SIN(PHINIT*0.017453293)
      PH1=0.0
      DO 10 I=1,35
      PHA=0.0
      IF(I.LE.IOFF+1) GO TO 8
      PH2=AC*(BAV(I)-BISOC(I))*RSIG(I)*FLOAT(I-1)
      PHAT=PHAT+0.5*(PH2+PH1)
      PH1=PH2
    8 IF(ABS(PHAT).LE.1.0) PHA=ASIN(PHAT)*57.2957
      RAD=I-1
      AF='    '
      IF(ANUZ2(I).LT.0.0) AF=1HI
      ANUZ=SQRT(ABS(ANUZ2(I)))
      WRITE(15,1010) RAD,ANUR(I),ANUZ,AF,PHA,DDAJ(I),DAJ(I,1),DAJ(I,2)
     *  ,SIG(I)
 1010 FORMAT(4X,F4.1,1X,2(4X,F6.4),A1,3X,F6.2,5X,3F10.2,F10.6)
   10 CONTINUE
      RETURN
      END

C$PROB CATHER
      SUBROUTINE CATHER(IT,A,HDEL)
      COMMON /COEF/CA(2574),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      COMMON /LIN/LDNI,NPOS,CUR(23)
      COMMON /FCD/CC(4)
      COMMON /COEB/BEX(11,2,39)
      DIMENSION A(1)
      DOUBLE PRECISION HH
      K=0
      KK=0
      KKK=(IT+IOFF-1)*66+(ITM-1)*33
      DO 10 J=1,23
  10  CUR(J)=PGETC(K,KK,A)
      CALL HARM34(CUR,J)
      CUR(23)=CUR(23)+2.094395
      CD=CUR(1)/1000.
      CD=-0.010711+CD*(1.010412-0.000614*CD)
      CU=1.0/CD
      CX=1.0/(CU*CU)
      HH=0.0D0
      DO 20 J=1,NFOD
      CX=CX*CU
      KKK=KKK+1
  20  HH=HH+CA(KKK)*CX
      DO 22 J=1,4
  22  CC(J)=0.0
      IF(NYOD.EQ.0) GO TO 28
      DO 25 J=1,NYOD
      KKK=KKK+1
  25  CC(J+1)=CA(KKK)*CD
  28  DO 30 JJ=1,NTOD
      DO 30 J=2,11
      KKK=KKK+1
  30  CC(JJ)=CC(JJ)+CA(KKK)*CUR(J)/100.
      KTI=33*(2*ITM-3)
      FL=FLOAT((-1)**(IH+ITM+1+(IH-1)/3))
      DO 50 JJ=1,NTOD
      DO 50 J=12,23,3
      KKK=KKK+1
      KTM=KKK-KTI
      IF(ICOF.EQ.2) CC(JJ)=CC(JJ)+3.*CA(KKK)*CUR(J)/100.
      IF(ICOF.EQ.1) CC(JJ)=CC(JJ)+1.5*CUR(J+1)*(CA(KKK)*COS(CUR(J+2))
     *  -CA(KTM)*FL*SIN(CUR(J+2)))/100.
  50  CONTINUE
      AA=HH+CC(1)
      IF(IH.GT.11) GO TO 60
C
C     INCLUDE EXTERNAL FIELD OF LOWER CHANNEL
C
      AA=AA+BEX(IH,ITM,IT+IOFF)
  60  IF(NQOD.EQ.1) HDEL=FILD(AA)
      IF(NQOD.EQ.2) HDEL=FELD(AA,IT)
      CUR(23)=CUR(23)-2.094395
      RETURN
      END

C$PROB CHSWTC    - Decodes "start string" and sets flags
C
      SUBROUTINE CHSWTC(NWD)
C
C     5/25/06  NR option added, U option deleted, 
C              description of selected options output to console
C
      IMPLICIT NONE
C
      COMMON /SWTCH/NSWT(15),NRPRN
      INTEGER*4     NSWT,NRPRN
      INTEGER*4  NWD(*),IWD(20),LWD(2,40),ITYP(40),NF,NTER,I,IT
C
      DO 10 I=1,20
      IWD(I)=NWD(I)
   10 CONTINUE
      NRPRN=0
C
      CALL CASEUP(IWD)
      CALL GREAD(IWD,LWD,NF)
C
      IF(NF.EQ.0) THEN
       WRITE(6,*) '   - no program options selected'
       GO TO 60
      END IF
C
      DO 50 I=1,NF
      IT=LWD(1,I)
C
      IF(IT.EQ.'PI  ') THEN
       NSWT(3)=1
       WRITE(6,*)'   - PI (Print Intermediate results) option selected'
       GO TO 50
      ENDIF
C
      IF(IT.EQ.'SH  ') THEN
       NSWT(4)=2
       WRITE(6,*)'   - SH (Skip Harmonic fit) option selected'
       GO TO 50
      ENDIF
C
      IF(IT.EQ.'SF  ') THEN
       NSWT(6)=1
       WRITE(6,*) '   - SF (Skip Fit) option selected'
       GO TO 50
      ENDIF
C
      IF(IT.EQ.'NR  ') THEN
       NRPRN=1
       WRITE(6,*)'   - NR (NuR calc. detail output) option selected'
       WRITE(6,*)'         Output for this option written to jbisoc.log'
       GO TO 50
      ENDIF
C
      IF(IT.EQ.'Q   ') THEN
       NSWT(13)=1
       WRITE(6,*)'   - Q  (Quick fit) option selected'
       GO TO 50
      ENDIF
C
      WRITE(6,20)IT
   20 FORMAT('    - ',A4,' is an unrecognized directive - ignored')
C
   50 CONTINUE
C
   60 WRITE(6,*)' '
      RETURN
      END

C$PROB CPOUT
      SUBROUTINE CPOUT(NTK,BISOC,BAV,BHV,IOFF,CUR,SIGMAA,COR,CSIG,NHS)
      COMMON /SCRAA/DUM(468),PHI(39),EUM(897)
      DIMENSION BISOC(1),BAV(1),CUR(1),SIGMAA(1),COR(1),CSIG(1),ITIT(35)
     *  ,BHV(1),IBUF(29),OFS(4)
      CHARACTER WBUF60*60,WBUF80*80,B1*1,B4*4
      EQUIVALENCE (IBUF(1),WBUF60),(IBUF(16),WBUF80)
C
      DATA ITIT(1),ITIT(2),ITIT(3),ITIT(4),ITIT(5),ITIT(6),ITIT(7),
     * ITIT(8),ITIT(9),ITIT(10),ITIT(11),ITIT(12),ITIT(13),ITIT(14),
     * ITIT(15),ITIT(16),ITIT(17),ITIT(18),ITIT(19),ITIT(20),ITIT(21),
     * ITIT(22),ITIT(23),ITIT(24),ITIT(25),ITIT(26),ITIT(27),ITIT(28),
     * ITIT(29),ITIT(30),ITIT(31),ITIT(32),ITIT(33),ITIT(34),ITIT(35)/
     *4HMAIN,4H T1 ,4H T2 ,4H T3 ,4H T4 ,4H T5 ,4H T6 ,4H T7 ,4H T8 ,
     *4H T9 ,4H T10,4HOFS1,4HAMP1,4H PH1,4HOFS2,4HAMP2,4H PH2,4HOFS3,
     *4HAMP3,4H PH3,4HOFS4,4HAMP4,4H PH4,4H AH1,4H BH1,4H CH1,4H AH2,
     *4H BH2,4H CH2,4H AH3,4H BH3,4H CH3,4H VA ,4H VB ,4H VC /
      DATA OFS/90.,110.,126.,126./
C      
      B1='.'
      B4=' +/-'
      NP=MAX0(23,NTK)
      K=0
      DO 2 J=14,23,3
      K=K+1
      SIGMAA(J)=SIGMAA(J)*57.29578
      CUR(J)=CUR(J)*57.29578+OFS(K)
    2 CUR(J)=AMOD(CUR(J),360.)
      DO 50 I=1,NP
      DO 3 J=1,29
    3 IBUF(J)='    '
      J=I-1+IOFF
      IF(I-NTK) 5,5,40
    5 DIFF=BISOC(I)-BAV(I)
      GO TO (10,10,30),NHS
Cjbb    
Cjbb     - replace encode statements with write to internal file
C   10 ENCODE(50,1050,IBUF(1)) J,BISOC(I),BAV(I),DIFF
C      GO TO 40
C   30 ENCODE(60,1060,IBUF(1)) J,BISOC(I),BAV(I),DIFF,BHV(I),PHI(I)
C 1050 FORMAT(1H ,4X,I2,'.',1X,4F10.4)
C 1060 FORMAT(1H ,4X,I2,'.',1X,4F10.2,F8.2)
Cjbb
   10 WRITE(WBUF60,'(5X,I2,A1,1X,4F10.4)')
     1  J,B1,BISOC(I),BAV(I),DIFF
      GO TO 40
   30 WRITE(WBUF60,'(5X,I2,A1,1X,4F10.2,F8.2)')
     1  J,B1,BISOC(I),BAV(I),DIFF,BHV(I),PHI(I)
C
   40 IF(I.GT.23) GO TO 45
C
Cjbb    - and also replace these
C      IF(I.LE.11) ENCODE(80,1070,IBUF(16)) ITIT(I),CUR(I),SIGMAA(I)
C      IF(I.GT.11) ENCODE(80,1070,IBUF(16)) ITIT(I),CUR(I),SIGMAA(I),
C     * ITIT(I+12), COR(I-11),CSIG(I-11)
C 1070 FORMAT('.',3X,2(A4,1X,F8.2,' +/-',F5.2,3X))
Cjbb
      IF(I.LE.11) WRITE(WBUF80,'(A1,3X,2(A4,1X,F8.2,A4,F5.2,3X))')
     1  B1,ITIT(I),CUR(I),B4,SIGMAA(I)
      IF(I.GT.11) WRITE(WBUF80,'(A1,3X,2(A4,1X,F8.2,A4,F5.2,3X))')
     1  B1,ITIT(I),CUR(I),B4,SIGMAA(I),ITIT(I+12),
     2  COR(I-11),B4,CSIG(I-11)
C
   45 WRITE(15,1080) IBUF
 1080 FORMAT(29A4)
   50 CONTINUE
      K=0
      DO 60 J=14,23,3
      K=K+1
      SIGMAA(J)=SIGMAA(J)*0.01745329
   60 CUR(J)=(CUR(J)-OFS(K))*0.01745329
      RETURN
      END

C$PROB CURFT3
      SUBROUTINE CURFT3(Y,YFIT,SIGMAC,NPTS,NTERMS,MODE,FLAMDA,CHISQR,
     *  A,SIGMAA,FUNCTN,FDERIV)
      DIMENSION ALPHA( 120),BETA(23),DERIV(23),B(23),A(1),Y(1),YFIT(1),
     *  SIGMAA(1),SIGMAC(1)
  11  NFREE=NPTS-NTERMS
      IF(NFREE) 13,13,20
  13  CHISQR=0.
      GO TO 110
C
C        EVALUATE ALPHA AND BETA MATRICES
C
  20  CONTINUE
   2  II=0
  31  DO 34 J=1,NTERMS
      BETA(J)=0.
      DO 34 K=1,J
      II=II+1
  34  ALPHA(II)=0.
  41  DO 50 I=1,NPTS
      CALL FDERIV(X,I,A,VALUE,DERIV)
C
C     VALUE=FUNCTN(X,I,A)
      YFIT(I)=VALUE
C     WEIGHT=1.0
C     ZTST=Y(I)
C     LAA ZTST
C     BAZ $42
      WEIGHT=1.0/(SIGMAC(I)*SIGMAC(I))
C     DIF=Y(I)-VALUE
C     WRITE(15,3000) I,DIF,Y(I),VALUE,(DERIV(JJJ),JJJ=1,NTERMS)
C3000  FORMAT(1H ,2X,I3,2X,6(E10.4,4X))
  42  LL=0
      DO 48 J=1,NTERMS
      LL=LL+J-1
      IF(DERIV(J).EQ.0.0) GO TO 48
      BETA(J)=BETA(J)+(Y(I)-VALUE)*DERIV(J)*WEIGHT
      DO 46 K=1,J
      II=LL+K
      ALPHA(II)=ALPHA(II)+DERIV(J)*DERIV(K)*WEIGHT
  46  CONTINUE
  48  CONTINUE
  50  CONTINUE
C     WRITE(15,2000)(BETA(J),J=1,NTERMS)
C2000  FORMAT(1H ,8E12.4)
C     WRITE(15,2000) (ALPHA(I),I=1,II)
C
C        EVALUATE CHI SQUARE AT STARTING POINT
C
  63  CHISQ1=FCHISQ(Y,SIGMAC,NPTS,NFREE,YFIT)
C
C        INVERT MODIFIED CURVATURE MATRIX TO FIND NEW PARAMETERS
C
      II=0
      DO 67 J=1,NTERMS
      II=J+II
      IF(ABS(ALPHA(II))-0.1E-30) 68,68,67
  67  CONTINUE
      GO TO 71
  68  CHISQR=0.0
      MODE=J
      RETURN
  71  CALL MATIN3(ALPHA,BETA,B,NTERMS,A,FLAMDA,SIGMAA)
C     WRITE(15,4000) (B(I),I=1,NTERMS)
C4000  FORMAT(1H ,F7.2,10F10.5)
C
C        IF CHI SQUARE INCREASED, INCREASE FLAMDA AND  TRY AGAIN
C
  91  DO 92 I=1,NPTS
  92  YFIT(I)=FUNCTN(X,I,B)
      IF(FLAMDA) 110,93,93
  93  CHISQR=FCHISQ(Y,SIGMAC,NPTS,NFREE,YFIT)
      CALL SSWTCH(6,ISTAT)
      IF(CHISQ1-CHISQR) 96,100,100
  96  FLAMDA=10.*FLAMDA
      GO TO (106,71),ISTAT
C
C        EVALUATE PARAMETERS AND UNCERTAINTIES
C
 100  FLAMDA=FLAMDA/10.
 101  DO 103 J=1,NTERMS
 103  A(J)=B(J)
      GO TO (108,110),ISTAT
 106  CHISQR=CHISQ1
 108  FLAMDA=0.0
 110  RETURN
      END

C$PROB CURRT
      FUNCTION CURRT(X,IT,A)
      DIMENSION A(1)
      CALL CATHER(IT,A,HDEL)
      CURRT=HDEL
      RETURN
      END

C$PROB DCURRT
      SUBROUTINE DCURRT(X,IT,A,HDEL,DERIV)
      COMMON /COEF/CA(2574),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      COMMON /LIN/LDNI,NPOS,CUR(23)
      COMMON /FCD/CC(4)
      DIMENSION A(1),DC(23),DERIV(1)
      EQUIVALENCE (CC(1),C1),(CC(2),C2),(CC(3),C3),(CC(4),C4)
      DOUBLE PRECISION HH
      CALL CATHER(IT,A,HDEL)
      GO TO (20,10),NQOD
  10  CB=C1
      C1=1.0
      GO TO 30
  20  AC=1.0+(C2+(2.*C3+3.*C4/HDEL)/HDEL)/HDEL/HDEL
      CB=HDEL
      C1=1.0/AC
  30  DO 32 J=1,23
  32  DC(J)=0.0
      K=0
      KK=0
      DO 34 J=1,23
  34  CUR(J)=PGETC(K,KK,A)
      CALL HARM34(CUR,KSTA9)
      CUR(23)=CUR(23)+2.094395
      CU=CUR(1)/1000.
      CU=-0.010711+CU*(1.010412-0.000614*CU)
      CU=1.0/CU
      CX=CU
      KKK=(IT+IOFF-1)*66+2+(ITM-1)*33
      HH=CA(KKK-1)
      DO 38 J=3,NFOD
      KKK=KKK+1
      CX=CX*CU
  38  HH=HH-CA(KKK)*FLOAT(J-2)*CX
      IF(NYOD.EQ.0) GO TO 44
      CT=1.0
      DO 42 J=1,NYOD
      KKK=KKK+1
      CT=CT/CB
  42  HH=HH+CA(KKK)*CT
  44  IF(NTOD.EQ.0) GO TO 56
      CT=CB
      DO 48 JJ=1,NTOD
      CT=CT/CB
      DO 48 J=2,11
      KKK=KKK+1
  48  DC(J)=DC(J)+CA(KKK)*CT
      FL=FLOAT((-1)**(IH+ITM+1+(IH-1)/3))
      KTI=33*(2*ITM-3)
      CT=CB
      DO 52 JJ=1,NTOD
      CT=CT/CB
      DO 52 J=12,23,3
      KKK=KKK+1
      KTM=KKK-KTI
      DC(J)=DC(J)+CT*3.*CA(KKK)/100.
      IF(ICOF.EQ.2) GO TO 52
      DC(J+1)=DC(J+1)+CT*1.5*(CA(KKK)*COS(CUR(J+2))-FL*CA(KTM)*
     *  SIN(CUR(J+2)))/100.
      DC(J+2)=DC(J+2)+CT*1.5*(-CA(KKK)*SIN(CUR(J+2))-FL*CA(KTM)*
     *  COS(CUR(J+2)))/100.*CUR(J+1)
  52  CONTINUE
      IF(KSTA9.EQ.2) GO TO 56
      DO 53 J=18,20
  53  DC(J)=DC(J)+DC(J+3)
  56  K=0
      KK=0
      DO 54 J=1,23
  54  CUR(J)=DGETC(K,KK,A)
      CALL HARM34(CUR,KSTA9)
      CUR(23)=CUR(23)+2.094395
      K=0
      KK=0
      DC(1)=HH/1000.
      DO 60 J=1,23
      CX=C1
      IF(J.GT.1.AND.J.LT.12) CX=CUR(J)*C1/100.
      IF(J.LT.13) GO TO 60
      IF(MOD(J-13,3).EQ.0) CX=CUR(J)
  60  CALL GDERV(K,KK,A,CX*DC(J),DERIV)
      CUR(23)=CUR(23)-2.094395
      RETURN
      END

C$PROB DDURRT
      SUBROUTINE DDURRT(X,IT,A,HDEL,DERIV)
      COMMON /COEF/IDUM(2649),ITM,IOFF
      COMMON /SCRAA/DUM(546),AHDEL(2),EERIV(23,2),EUM(810)
      DIMENSION A(1),DERIV(1)
      DO 10 ITM=1,2
  10  CALL DCURRT(X,IT,A,AHDEL(ITM),EERIV(1,ITM))
      HDEL=AHDEL(1)*AHDEL(1)+AHDEL(2)*AHDEL(2)
      HDEL=SQRT(HDEL)
      DO 20 J=1,23
  20  DERIV(J)=(AHDEL(1)*EERIV(J,1)+AHDEL(2)*EERIV(J,2))/HDEL
      RETURN
      END

C$PROB DEFINT
      SUBROUTINE DEFINT(A,NS,JHARM)
      COMMON /MGCONE/DNU(16),ENU(16)
      DIMENSION A(23),NS(23),OFS(4)
      DATA OFS/90.,110.,126.,126./
      READ(8,1000) NS
1000  FORMAT(23I1)
      READ(8,2000) A
      READ(8,2020) DNU
2000  FORMAT(8F10.0)
2020  FORMAT(10F8.0)
      IF(JHARM.EQ.1) GO TO 20
      READ(8,1000) NS
      READ(8,2000) A
      READ(8,2020) ENU
  20  K=0
      DO 30 I=14,23,3
      K=K+1
  30  A(I)=(A(I)-OFS(K))*0.01745329
      RETURN
      END

C$PROB DGETC
      FUNCTION DGETC(K,KK,A)
      COMMON /COEF/CA(2574),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      DIMENSION A(1)
      DGETC=GETC(K,KK,A)
      IF(K.GE.2.AND.K.LE.11) DGETC=ALIM(K)*COS(DGETC)
      IF(K.LT.13) RETURN
      IF(MOD(K-13,3).EQ.0) DGETC=ALIM(K)*COS(DGETC)
      RETURN
      END

C$PROB DURRT
      FUNCTION DURRT(X,IT,A)
      COMMON /SCRAA/DUM(468),PHI(39),B(39),DA(2),EUM(856)
      COMMON /COEF/IDUM(2649),ITM,IOFF
      DIMENSION A(1)
      DURRT=0.0
      DO 10 ITM=1,2
      CALL CATHER(IT,A,HDEL)
      DA(ITM)=HDEL
  10  DURRT=DURRT+HDEL*HDEL
      DURRT=SQRT(DURRT)
      I=IT+IOFF
      IF(DA(2).EQ.0.0.AND.DA(1).EQ.0.0) THEN
        PH=0.0
   15   WRITE(6,415)
  415   FORMAT(/' ** WARNING! ATAN2 error bypassed in functin DURRT',/)
      ELSE
        PH=ATAN2(DA(2),DA(1))*57.29578+351.
      END IF
      PHI(I)=AMOD(PH,360.)
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

C$PROB EXTRAC
      SUBROUTINE EXTRAC(BF,AMAIN)
C
C     CALCULATES EXTERNAL FIELD FOURIER COEFFICIENTS OF LOWER
C     CHANNEL FOR TCISOC
C     THESE COEFFICIENTS ARE USED IN SUBROUTINE CATHER WHICH IS
C     LOCATED IN TCISOC1.FTN
C
      COMMON /SCRAC/C1(11),C2(11),D1(11),D2(11),E1(4),F1(11),G1(11)
      COMMON /LOWCH/REN,REX,AIIN,AIOUT
      COMMON /COEB/BLCCOE(11,2,39)
      DIMENSION BF(1)
      DO 5 I=1,39
      DO 5 J=1,11
      BLCCOE(J,1,I)=0.0
   5  BLCCOE(J,2,I)=0.0
Cjbb
      IF((AIIN+AIOUT).EQ.0.0) WRITE(15,4111)
 4111 FORMAT(3X,'EXTRACTOR - NO LOWER CHANNEL')
Cjbb
      IF(AIIN+AIOUT) 10,70,10
  10  IF(AIOUT) 20,60,20
  20  WRITE(15,2000) AIIN,AIOUT,REN,REX
2000  FORMAT(3X,'EXTRACTOR - ',4X,'I-IN=',F7.1,6X,'I-OUT=',F7.1/
     *  1X,19X,' REN=',F6.2,6X,'  REX=',F6.2)
  60  CALL EXTRAU2(AMAIN,REN,REX,AIIN,AIOUT,BF,BLCCOE,1)
C
C     ZERO HARMONIC COEFFICIENTS ABOVE L=1
C
      DO 65 I=1,39
      DO 65 J=3,11
      BLCCOE(J,1,I)=0.0
  65  BLCCOE(J,2,I)=0.0
      WRITE(15,2050) C1(1),C1(2),C2(2)
2050  FORMAT(20X,'  A0=',F6.2,9X,'A1=',F6.2,9X,'B1=',F6.2)
  70  RETURN
      END

C$PROG EXTRAU2
      SUBROUTINE EXTRAU2(AMAIN,REN,REX,AIIN,AIOUT,BF,BLCCOE,NHARM)
C
Cjbb  This version of EXTRAU is for use with TCISOC only.  It does
Cjbb  the complete calculation even when AIOUT is zero.  This avoids
Cjbb  a divide-by-zero error otherwise generated by CATHER
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
Cjbb   IF(AIOUT.EQ.0.0) GO TO 70  !do the calculation anyway (see above)
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
      WRITE(6,461)
  461 FORMAT(/'    [NOTE: EXTRAU calculates LC field coeff only ',
     1  'to 33 inches]',/)
Cjbb
      DO 65 I=1,35
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

C$PROB FCHISQ
      FUNCTION FCHISQ(Y,SIGMAC,NPTS,NFREE,YFIT)
      DIMENSION Y(1),YFIT(1),SIGMAC(1)
      DOUBLE PRECISION CHISQ
      CHISQ=0.
C
C        ACCUMULATE CHI SQUARE
C
      DO 30 I=1,NPTS
      WEIGHT=1.0
      WEIGHT=1.0/(SIGMAC(I)*SIGMAC(I))
  30  CHISQ=CHISQ+WEIGHT*(Y(I)-YFIT(I))**2
C
C        DIVIDE BY NUMBER OF DEGREES OF FREEDOM
C
      FCHISQ=CHISQ/FLOAT(NFREE)
      RETURN
      END

C$PROB FDCURT
      SUBROUTINE FDCURT(C,BO,A,IR,GAM,A1,B1,RSIG)
      COMMON /SCRAA/AI(5,3,39),BI(5,3,39),AI1(117),BI1(117)
      DIMENSION A(10)
      C=(BO-A(2))/A(1)
      DO 10 I=1,20
      CN=(BO-A(2)-(A(3)+(A(4)+(A(5)+(A(6)+A(7)/C)/C)/C)/C)/C)/
     *  (A(1)+(A(8)+(A(9)+A(10)/BO)/BO)/BO)
      IF(ABS(C-CN).LT.0.0001) GO TO 20
      C=CN
  10  CONTINUE
  20  C=CN
      CU=1.0/C
      CX=C*C
      DO 25 J=1,3
      AI1(J)=0.0
  25  BI1(J)=0.0
      DO 30 I=1,5
      CX=CX*CU
      DO 30 J=1,3
      AI1(J)=AI1(J)+AI(I,J,IR)*CX/BO
  30  BI1(J)=BI1(J)+BI(I,J,IR)*CX/BO
      GAM=0.0
      RSIG=1.0
      DO 40 J=1,3
      AB=-0.25*FLOAT(27*J*J-2)/FLOAT((9*J*J-1)**2)
      AC=FLOAT(3*J)/FLOAT(9*J*J-1)
      AT=AI1(J)*AI1(J)+BI1(J)*BI1(J)
      RSIG=RSIG-0.25*AC*AC*AT
  40  GAM=GAM+AB*AT
      A1=AI1(1)/8.
      B1=BI1(1)/8.
      RETURN
      END

C$PROB FDSIG
      SUBROUTINE FDSIG(CURM,BAV,BISOC,BO,BLAMDA)
      DIMENSION BISOC(1),BAV(1)
      COMMON /SCRAA/AI(5,3,39),BI(5,3,39),AJ(39,3),BJ(39,3)
      COMMON /SWTCH/NSWT(15),NRPRN
      DO 10 J=1,39
      DO 10 I=1,3
      AJ(J,I)=0.0
  10  BJ(J,I)=0.0
      CU=1.0/CURM
      CX=CURM*CURM
      DO 15 J=1,5
      CX=CX*CU
      DO 15 I=1,3
      DO 15 K=1,39
      AJ(K,I)=AJ(K,I)+AI(J,I,K)*CX/BAV(K)
  15  BJ(K,I)=BJ(K,I)+BI(J,I,K)*CX/BAV(K)
      IF(NRPRN.EQ.1) NRPRN=2    !skip output on this call to SFDSIG
      CALL SFDSIG(BISOC,BO,BAV,BLAMDA)
      IF(NRPRN.EQ.2) NRPRN=1    !reset for next call to SFDSIG
      RETURN
      END

C$PROG FDDV5
      FUNCTION FDDV5(A,I)
      DIMENSION A(1)
      FDDV5=0.0
C     IF(I.EQ.2) FDDV5=11.*A(I-1)-20.*A(I)+6.*A(I+1)+4.*A(I+2)-A(I+3)
      IF(I.GT.2.AND.I.LT.38) FDDV5=-30.*A(I)+16.*(A(I+1)+A(I-1))-A(I+2)
     *  -A(I-2)
      IF(I.EQ.38) FDDV5=-A(I-3)+4.*A(I-2)+6.*A(I-1)-20.*A(I)+11.*A(I+1)
      IF(I.EQ.39) FDDV5=11.*A(I-4)-56.*A(I-3)+114.*A(I-2)-104.*A(I-2)
     *  +35.*A(I)
      FDDV5=FDDV5/12.
      RETURN
      END

C$PROB FELD
      FUNCTION FELD(AA,IT)
      COMMON /FCD/C1,C2,C3,C4
      COMMON /SCRAA/DUM(507),B(39),DUN(858)
      COMMON /COEF/IDUM(2650),IOFF
      I=IT+IOFF
      C1=B(I)
      FELD=AA+(C2+(C3+C4/C1)/C1)/C1
      RETURN
      END

C$PROB FFSIG
      SUBROUTINE FFSIG(BAV,BISOC,BO,BLAMDA)
      COMMON /LIN/LDNI,NPOS,CUR(23)
      COMMON /SCRAA/P(33),C(2),ADU(1135),CT(39,3,2)
      DIMENSION BAV(1),BISOC(1)
      CU=1.0/CUR(1)*1000.
      DO 50 I=1,39
      DO 50 J=3,9,3
      JJ=J/3
      LL=NPOS+(I-1)*29+J*2
      CALL SNAIS(LDNI,LL)
      DO 50 ITM=1,2
      CALL TCREED(LDNI,P(1),66)
      K=0
      H=0.0
      CX=CUR(1)*CUR(1)/1000000.
      DO 20 II=1,5
      CX=CX*CU
      K=K+1
  20  H=H+P(K)*CX
      DO 30 II=1,2
      C(II)=0.0
      DO 30 IJ=2,11
      K=K+1
  30  C(II)=C(II)+P(K)*CUR(IJ)/100.
      DO 40 II=1,2
      DO 40 IJ=12,23,3
      K=K+1
  40  C(II)=C(II)+P(K)*CUR(IJ)*3./100.
      CX=C(1)+C(2)/BAV(I)
  50  CT(I,JJ,ITM)=(H+CX)/BAV(I)
      CALL SFDSIG(BISOC,BO,BAV,BLAMDA)
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
      DO 60 N=1,NCOP                     !Copy LINO-1 lines to scratch
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

C$PROG FIT
      SUBROUTINE FIT(BAV,IOFF,D,YFIT,SIGMAC,NPTS,NTERMS,MODE,CHISQR,A,
     *  SIGMAA,FUNCTN,FDERIV)
      DIMENSION BAV(1),D(1),YFIT(1),A(1),SIGMAA(1),SIGMAC(1),X(1)
      EXTERNAL FUNCTN,FDERIV
C
C        INITIALIZE FITTING PARAMETERS
C
      FLAMDA=0.001
      CSQR=0.10E+25
      WRITE(6,1070)
 1070 FORMAT(1X,' FIT CHISQR=')
      IF(NTERMS.EQ.0) GO TO 98
      CALL SSWTCH(6,ISTAT5)
      GO TO (98,80),ISTAT5
C
C        ENTER FITTING ROUTINES
C
  80  CALL CURFT3(D,YFIT,SIGMAC,NPTS,NTERMS,MODE,FLAMDA,CHISQR,A,SIGMAA,
     *  FUNCTN,FDERIV)
      IF(FLAMDA+1.0) 82,98,82
  82  IF(FLAMDA) 90,98,84
  84  IF(CHISQR-0.01E-20) 96,86,86
  86  IF(ABS(CSQR-CHISQR)/CSQR-0.01) 92,88,88
  88  CSQR=CHISQR
      WRITE(6,1075) CHISQR
1075  FORMAT(1X,10X,E12.6)
      GO TO 80
  90  FLAMDA=-FLAMDA
      GO TO 80
  92  FLAMDA=-1.0
C     GO TO 80
      GO TO 98
  96  WRITE(15,1040) MODE
1040  FORMAT(1X,'PARAMETER ',I3,' GIVES NULL VALUE')
      GO TO 150
  98  DO 99 I=1,39
      JJ=I-IOFF
  99  BAV(I)=FUNCTN(X,JJ,A)
      DO 100 I=1,NPTS
      J=I+IOFF
 100  YFIT(I)=BAV(J)
      I=NPTS-NTERMS
      CHISQR=FCHISQ(D,SIGMAC,NPTS,I,YFIT)
      RETURN
 150  STOP ' EXIT CALLED FROM SUBROUTINE FIT'
      RETURN
      END

C$PROB FSIGG
      SUBROUTINE FSIGG(NS,SIGMAB,SIGMAA,COR,CSIG,ALIM,CUR)
      DIMENSION NS(1),SIGMAB(1),SIGMAA(1),COR(1),CSIG(1),ALIM(1),CUR(1)
      K=1
      DO 30 I=1,23
      IF(NS(I)) 25,25,30
  25  SIGMAB(I)=SIGMAA(K)
      K=K+1
      IF(I.GE.2.AND.I.LE.11) SIGMAB(I)=SQRT(ABS(ALIM(I)*ALIM(I)-
     *  CUR(I)*CUR(I)))*SIGMAB(I)
      IF(I.LT.13) GO TO 30
      IF(MOD(I-13,3).NE.0) GO TO 30
      SIGMAB(I)=SQRT(ABS(CUR(I-1)*CUR(I-1)-CUR(I)*CUR(I)))*
     *  SIGMAB(I)
  30  CONTINUE
      DO 35 I=1,23
      SIGMAA(I)=0.0
      IF(NS(I).EQ.0) SIGMAA(I)=SIGMAB(I)
  35  CONTINUE
      K=0
      DO 40 J=12,23,3
      IF(CUR(J+1).GE.0.0) GO TO 38
      CUR(J+1)=-CUR(J+1)
      CUR(J+2)=CUR(J+2)+3.1415927
 38   DO 40 I=1,3
      K=K+1
      DUM=CUR(J+2)+FLOAT(I-1)*2.094395
      COR(K)=CUR(J)+CUR(J+1)*COS(DUM)
      AC=SIGMAB(J+1)*COS(DUM)-CUR(J+1)*SIN(DUM)*SIGMAB(J+2)
  40  CSIG(K)=SIGMAB(J)+AC
      RETURN
      END

C$PROB GDERV
      SUBROUTINE GDERV(K,KK,A,C,DERIV)
      DIMENSION A(1),DERIV(1)
      IF(IGETH(K,KK,A).EQ.1) DERIV(KK)=C
      RETURN
      END

C$PROB GETA0
C
      SUBROUTINE GETA0(A0)
C
      COMMON /LIN/LDNI,NHOLD,CUR(23)
      COMMON /SCRAA/AI(5,3,39),BI(5,3,39),COIL(40),IDIRE(194)
      DIMENSION A0(66,39),IC(1)
      NPOS=-29
      NHOLD=NPOS+29
      NRAD=39
      CALL SSWTCH(12,KSTAT)
      IF(KSTAT.EQ.1) READ(12,1000) COIL
1000  FORMAT(8F10.0)
      DO 50 I=1,NRAD
      NPOS=NPOS+29
      CALL SNAIS(LDNI,NPOS)
      CALL TCREED(LDNI,A0(1,I),132)
      IF(KSTAT.EQ.1) A0(1,I)=A0(1,I)+COIL(I)
      DO 50 J=3,9,3
      JJ=J/3
      NP=NPOS+J*2
      CALL SNAIS(LDNI,NP)
      CALL TCREED(LDNI,AI(1,JJ,I),10)
  50  CALL TCREED(LDNI,BI(1,JJ,I),10)
      RETURN
      END

C$PROB GETA1
C
      SUBROUTINE GETA1(A0,IH)
C
      COMMON /LIN/LDNI,NPOS,CUR(23)
      DIMENSION A0(66,39)
      DO 20 I=1,39
      LL=NPOS+(I-1)*29+2*(IH-1)
      CALL SNAIS(LDNI,LL)
      CALL TCREED(LDNI,A0(1,I),66)
  20  CALL TCREED(LDNI,A0(34,I),66)
      IF(IH.NE.2) RETURN
      DO 30 I=1,39
      R=I-1
      A0(1,I)=A0(1,I)+0.15144*R
      A0(2,I)=A0(2,I)-0.090865*R
      A0(34,I)=A0(34,I)+0.023986*R
 30   A0(35,I)=A0(35,I)-0.014392*R
      RETURN
      END

C$PROB GETC
      FUNCTION GETC(K,KK,A)
      COMMON /COEF/CA(2574),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      DIMENSION A(1)
      K=K+1
      IF(NS(K)) 20,10,20
  10  KK=KK+1
      IF(K.EQ.1.OR.K.EQ.21) GO TO 15
      A(KK)=AMOD(A(KK),6.283185)
  15  GETC=A(KK)
      RETURN
  20  GETC=COE(K)
      RETURN
      END

C$PROG GREAD
C
      SUBROUTINE GREAD(IWD,LWD,NF)
C
C     This replaces what must have been a Perkin-Elmer routine
C     in the same class as GSTRING.  It takes the elements from
C     the command line as prepared by GSTRING and returns them
C     as individual elements of an array.
C
C      J. Ball      5/19/06
C
      IMPLICIT NONE
C
      INTEGER*4 IWD(20),LWD(2,40),NF,IB,IW,NCHAR,NBUF(20)
      CHARACTER CBUF*80,A1*4,A4*4
      EQUIVALENCE (NBUF(1),CBUF)
C Make equivalences for A1 and A4 to get around CHARACTER/INTEGER problems
C EjP 20230712
	  INTEGER*4 IA1,IA4
	  EQUIVALENCE (IA1,A1)
	  EQUIVALENCE (IA4,A4)
C
      DO 5 IB=1,20
    5 NBUF(IB)=IWD(IB)
      NCHAR=LEN_TRIM(CBUF)+1    !need one place past last character
      NF=0
      IB=0
   10 NF=NF+1
      IW=0
      A4='    '
   20 IB=IB+1
C
      IF(IB.GT.NCHAR) GO TO 30
      A1=CBUF(IB:IB)
C Use Integer equivalence of A1. 20230712 EjP
C      IF(A1.GT.64.AND.A1.LT.91) THEN   !its a capital letter
      IF(IA1.GT.64.AND.IA1.LT.91) THEN   !its a capital letter
        IW=IW+1
        A4(IW:IW)=A1
        GO TO 20
      ELSE
        IF(IW.GT.0) THEN    !anything else becomes a delimiter
C Use Integer equivalence of A4. 20230712 EjP
C          LWD(1,NF)=A4
          LWD(1,NF)=IA4
          GO TO 10
        ELSE             !its just something to skip
          GO TO 20
        END IF
      END IF
C
   30 NF=NF-1       !since the last try was blank
      RETURN
      END

C$PROG JSTRING   - Replaces Perkin-Elmer routine GSTRING
C
C     Moves command-line option selection inside program
C       thus eliminating need to run JBISOC from a DOS prompt
C        J. Ball        12-Oct-2006
C  
      SUBROUTINE JSTRING(IWD,NUMC)
C
      IMPLICIT NONE
C
      INTEGER*4 IWD(20),IBUF(20),NUMC,I
      CHARACTER*80 ARGS,CBUF
      EQUIVALENCE (IBUF,CBUF)
C
      CBUF=' '
C
  100 WRITE(6,4100)
 4100 FORMAT(/3X,'JBISOC OPTIONS: ',
     1  'Q   - Quick fit, uses algorithms instead of detailed ',
     2    'calculation'/19X,
     3  'NR  - outputs details of NuR calculation'/19X,
     4  'PI  - Prints Intermediate for fitting calculation'/19X,
     5  'SF  - Skips Fitting procedure'/19X,
     6  'SH  - Skips fitting to cancel first Harmonic'//3X,
     7  'SELECT OPTIONS: ',$)
C
  110 READ(5,4110) CBUF
 4110 FORMAT(A)
C
      NUMC=LEN_TRIM(CBUF)
C
      DO 200 I=1,20
      IWD(I)=IBUF(I)
  200 CONTINUE
      RETURN
      END

C$PROG HARM34
      SUBROUTINE HARM34(A,KSTA9)
      DIMENSION A(23)
      CALL SSWTCH(9,KSTA9)
      IF(KSTA9.EQ.2) RETURN
      DO 10 I=18,20
  10  A(I+3)=A(I)
      RETURN
      END

C$PROG HARMC
      SUBROUTINE HARMC(BHV,A,BAV)
      DIMENSION BHV(1),A(1),BAV(1)
      COMMON /COEF/A0(66,39),IDUM(74),IH,ITM,IOFF
      COMMON /SCRAA/DAJ(39,3),DBJ(39,3),SIG(39),RSIG(39),ANUR(39),
     *  ANUZ2(39),GAMMA(39),AFUM(39),PHI(39),AEUM(39),AODD(39,2),
     *  ADUM(546),AJ(39,3),BJ(39,3)
      K=0
      DO 30 IH=3,5,2
      K=K+1
      CALL GETA1(A0,IH)
      DO 25 ITM=1,2
      DO 25 I=1,39
      JJ=I-IOFF
  25  AODD(I,ITM)=CURRT(X,JJ,A)/BAV(I)
      DO 28 I=1,35
      RO=I-1
      DAJ(I,K)=RO*FDV5(AODD(1,1),I)
  28  DBJ(I,K)=RO*FDV5(AODD(1,2),I)
  30  CONTINUE
      DO 40 I=1,35
      PHT=PHI(I)*0.017453
      A1=BHV(I)*COS(PHT)+0.0625*(AJ(I,1)*(DAJ(I,1)+DAJ(I,2))+BJ(I,1)*
     *  (DBJ(I,1)+DBJ(I,2)))*BAV(I)
      A2=BHV(I)*SIN(PHT)+0.0625*(-AJ(I,1)*(DBJ(I,1)-DBJ(I,2))+BJ(I,1)*
     *  (DAJ(I,1)-DAJ(I,2)))*BAV(I)
      DAJ(I,1)=SQRT(A1*A1+A2*A2)
      IF(DAJ(I,1).EQ.0.0) THEN
        A1=0.0
   35   WRITE(6,435)
  435   FORMAT(/' ** WARNING! ATAN2 error bypassed in functin HARMC',/)
      ELSE
        A1=ATAN2(A2,A1)*57.29578+360.
      END IF
  40  DAJ(I,2)=AMOD(A1,360.)
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
      COMMON /SWTCH/NSWT(15),NRPRN
      DIMENSION PROG(2),A(8)
      INTEGER DTM,DTM1
      CHARACTER DUM*12,PRMID*32,DTFIL*16,CC*1,CS*1,VNUM*8,ET*8
C Declare DAT a CHARACTER*4.  EjP 20230712
      CHARACTER*4 DAT
C
Cjbb    - use new time and date subroutine
Cjbb  CALL DATE_AND_TIME(DUM,DUM,DUM,DTM)
Cjbb    - this is for DEC Fortran.  For MS Fortran use as follows:
C     CALL GETDAT(DTM(1),DTM(2),DTM(3))
C     CALL GETTIM(DTM(5),DTM(6),DTM(7),DTM(8))
Cjbb    - these have now been moved to ISOCINIT subroutine
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
C       - if the NR command line option was selected, print out header info
C         to the jbisoc.log file
      IF(NRPRN.EQ.1) THEN
      WRITE(14,*)'  DETAILS OF NuR CALCULATION FOR PARAMETER SET ',PRMID
      WRITE(14,341)
  341 FORMAT(1X,'  I    BAV(I)        BB   ANUR(I)')
      WRITE(14,342)
  342 FORMAT(1X,' I  J AJ(I,JJ) BJ(I,JJ)     AR      AT',
     1'      AS      AU      AV ANUR(I)')
      END IF      
C
  400 RETURN
      END

C$PROB IGETH
      FUNCTION IGETH(K,KK,A)
      COMMON /COEF/CA(2574),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      DIMENSION A(1)
      IGETH=0
      K=K+1
      IF(NS(K)) 20,10,20
  10  KK=KK+1
      IGETH=1
  20  RETURN
      END

C$PROB INCOE
      SUBROUTINE INCOE(ISW1,ISW2)
      COMMON /COEF/A0(66,39),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      CALL SSWTCH(ISW2,KSTAT)
      IF(KSTAT.EQ.2) RETURN
      CALL INPARM(COE,NS,ALIM)
      RETURN
      END

C$PROB INSWTC
      SUBROUTINE INSWTC(IWORD,NUM)
      COMMON /SWTCH/NSWT(15)
      COMMON /RIP1/LTERM,LASTER,LGRED
      DIMENSION IWORD(20)
      READ(8,1000) NSWT
 1000 FORMAT(15I1)
      LGRED=5
      CALL CHSWTC(IWORD)
      RETURN
      END

C$PROB INTERP
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

C$PROB ISOC
      SUBROUTINE ISOC(BISOC)
      DIMENSION BISOC(39),YI(8),Y(8),Y1(39),Y2(39)
      COMMON /SCRAA/RSTOR(39),FSTOR(39),YTT(156),
     *  SIG(39),BF(39),DUM(351),CO(181),SI(181),DUN(379)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      DOUBLE PRECISION YT,ANG
      DATA IJUMP/0/
      YT=1.0D-06/FREQ/HA
      NEN=33
      CALL SSWTCH(13,I)
      IF(I.EQ.1) GO TO 65
      IF(IJUMP.EQ.2) RETURN
      DO 5 I=1,181
      ANG=FLOAT(I-1)*3.490659D-02
      CO(I)=DCOS(ANG)
   5  SI(I)=DSIN(ANG)
      IF(IJUMP.EQ.0) GO TO 20
      DO 10 I=1,39
  10  BF(I)=BISOC(I)
  20  W=4.0
      IJUMP=IJUMP+1
      NSTEP=90
      NE=8
      EPS=0.1E-02
      EPSISO=0.3E-02
      DO 60 J=1,10
      TFAC=0.0
      NSKIP=0
      RSC=1.0
      VSC=1.0E-06
      RSTOR(1)=0.0
      FSTOR(1)=1.0
      DO 40 I=2,NEN
C     IF(J.EQ.1) WRITE(15,1000) I,BF(I)
      RF=I-1
      CALL ENISOC(RF,EF,VT,VV)
      CALL SISOC(YI,RF,VV,RSC,VSC)
      IF(J.EQ.1.AND.IJUMP.EQ.1) GO TO 30
      YI(1)=Y1(I)
      YI(2)=Y2(I)
  30  NTP=0
      CALL OPTEQU(YI,Y,EPS,NE,W,XI,NSTEP,NTP)
C     TP=NTP
C     WRITE(6,1000) I,BF(I),TP
      IF(NSKIP.EQ.0) GO TO 35
      NEN=I-1
      GO TO 45
  35  RSC=Y(1)/RF
      VSC=Y(2)/VV
      Y1(I)=Y(1)
      Y2(I)=Y(2)
      RSTOR(I)=ABS(Y(8))
      Y(7)=ABS(Y(7))
      FSTOR(I)=1.0+((Y(7)-YT)/YT)/VT/VT
C     WRITE(15,1000) I,RSTOR(I),FSTOR(I)
      TFAC=TFAC+ABS(1.0-FSTOR(I))
  40  CONTINUE
  45  DO 50 I=1,35
      R=I-1
      CALL INTERP(RSTOR,FSTOR,NEN,4,R,FAC)
      BF(I)=FAC*BF(I)
C     WRITE(15,1000) I,BF(I),FAC
  50  CONTINUE
C     WRITE(6,1000) J,TFAC
1000  FORMAT(1H ,I4,4X,2E12.6)
      IF(TFAC.LT.EPSISO) GO TO 65
  60  CONTINUE
  65  DO 70 I=1,39
  70  BISOC(I)=BF(I)
      I=NEN-1
      IF(NEN.LT.32) WRITE(15,2020) I
2020  FORMAT(1H0,'*** ISOCHRONIZATION STOPPED AT ',I2)
      RETURN
      END

C$PROG ISOCINIT  - Opens files, etc for TCISOC
C
C      - modified for PC file handling and date and time routines
C
      SUBROUTINE ISOCINIT
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
      NAMPROG(1)='JBIS'
      NAMPROG(2)='OC  '
      MSGF='    '
      LISFLG='LON '
      LOGUT=6
      LOGUP=14
C
      OPEN(UNIT       = 14,
     &     FILE       = 'jbisoc.log',
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
     &     FILE       = 'jbisoc.int',
     &     STATUS     = 'OLD',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 110
C
      OPEN(UNIT       = 9,
     &     FILE       = 'tcmagprm.bin',
     &     STATUS     = 'OLD',
     &     ACCESS     = 'DIRECT',
     &     RECL       = 256,           !this version for MS Fortran
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 120
C
      OPEN(UNIT       = 15,
     &     FILE       = 'jbisoc.prn',
     &     STATUS     = 'UNKNOWN',
     &     IOSTAT     = IOS)
C
      CLOSE(UNIT      = 15,
     &      STATUS    = 'DELETE')
C
      OPEN(UNIT       = 15,
     &     FILE       = 'jbisoc.prn',
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
  115 FORMAT('attempting to open - tcisoc.int')
      GO TO 200
C
  120 WRITE(CMSSG,125)
  125 FORMAT('attempting to open - tcmagprm.bin')
      GO TO 200
C
  200 WRITE(LOGUP,4200)IOS,CMSSG
 4200 FORMAT(1X,'---'/1X,'File opening error in subroutine ISOCINIT',
     1  10X,'Error #',I4/1X,'Failed while ',A40)
      WRITE(LOGUT,4200)IOS,CMSSG
      STOP 'EXIT CALLED FROM SUBROUTINE ISOCINIT'
      END

C$PROB KINEM
      SUBROUTINE KINEM(EE,AM,Z,RTEMP,RE,FREQ,HA,IR,BO,BF,FREQLM,
     * BLAMDA,RSIG)
      DOUBLE PRECISION ET,G,RF,BETA
      ET=EE+AM
      G=AM/ET
      BETA=DSQRT(1.0D0-G*G)
      IF(RTEMP.LT.0.0) GO TO 10
      RE=RTEMP
      REF=RE*RSIG
      FREQ=1.8784673E+03*BETA/REF/HA
      IF(FREQ.GE.FREQLM) GO TO 5
      FREQ=FREQ*3.0
      HA=1.0/3.0
   5  IR=IFIX(FREQ*100.)
      FREQ=FLOAT(IR)/100.
      GO TO 15
  10  FREQ=-RTEMP
  15  REF=1.8784673E+03*BETA/FREQ/HA
      RE=REF/RSIG
  20  BLAMDA=1.8784673E+03/FREQ/HA
      BO=AM*FREQ*HA*0.699105/Z
      IR=RE+0.5
      RF=IR
      BF=BO/DSQRT(1.0D0-(RF*RSIG/BLAMDA)**2)
      RETURN
      END

C$PROB LFIELD
      FUNCTION LFIELD(JJ,JANG)
      COMMON /SCRAA/DUM(273),BF(39),DUMM(351),CO(181),SI(181),
     *  DUMMM(145),AJ(39,3),BJ(39,3)
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      IF(JJ.GT.39) GO TO 30
      JT=JANG/200
      B=1.0
      DO 20 I=1,3
      J=3*I*JT+180
      J=MOD(J,180)+1
  20  B=B+AJ(JJ,I)*CO(J)+BJ(JJ,I)*SI(J)
      LFIELD=100.*B*BF(JJ)
      RETURN
  30  LFIELD=0
      NSKIP=1
      RETURN
      END

C$PROB MATIN3
      SUBROUTINE MATIN3(ALPHA,BETA,B,NTERMS,A,FLAMDA,SIGMAA)
      DIMENSION ALPHA(1),BETA(1),B(1),A(1),SIGMAA(1)
      COMMON /SCRAA/ARRAY(702)
      DOUBLE PRECISION ARRAY
      NOCAL=0
      IF(FLAMDA) 70,71,71
  70  NOCAL=1
      FLAMDA=0.0
  71  SLAMDA=FLAMDA
      II=0
      JJ=0
      DO 74 J=1,NTERMS
      JJ=JJ+J
      KK=0
      DO 73 K=1,J
      II=II+1
      KK=KK+K
      ARRAY(II)=ALPHA(II)/SQRT(ALPHA(JJ))/SQRT(ALPHA(KK))
  73  CONTINUE
  74  ARRAY(II)=1.+SLAMDA
C     WRITE(15,2000) SLAMDA
C     WRITE(15,2000) (ARRAY(I),I=1,II)
C2000  FORMAT(1H ,8E12.4)
C
      CALL SINV(ARRAY,NTERMS,0.000001,IER)
C
C     WRITE(15,2000) (ARRAY(I),I=1,II)
      IF(IER.EQ.0) GO TO 80
      WRITE(15,1000) IER
1000  FORMAT(1H ,4HIER=,I3,41H LOSS OF SIGNIFICANCE IN MATRIX INVERSION)
      FLAMDA=FLAMDA*10.
      IF(FLAMDA.EQ.0.) FLAMDA=0.1E-07
      GO TO 71
  80  JJ=0
      DO 86 J=1,NTERMS
      B(J)=A(J)
      JJ=JJ+J
      SIGMAA(J)=DSQRT(ARRAY(JJ)/ALPHA(JJ))
      KK=0
      DO 86 K=1,NTERMS
      KK=KK+K
      II=MAX0(KK,JJ)-IABS(J-K)
      B(J)=B(J)+BETA(K)*ARRAY(II)/SQRT(ALPHA(JJ))/SQRT(ALPHA(KK))
  86  CONTINUE
      IF(NOCAL-1) 6,5,6
   5  FLAMDA=-1.0
   6  RETURN
      END

C$PROB MFSD
      SUBROUTINE MFSD(A,N,EPS,IER)
C                                                                       00000100
C     ..................................................................00000200
C                                                                       00000300
C        SUBROUTINE MFSD                                                00000400
C                                                                       00000500
C        PURPOSE                                                        00000600
C           FACTOR A GIVEN SYMMETRIC POSITIVE DEFINITE MATRIX           00000700
C                                                                       00000800
C        USAGE                                                          00000900
C           CALL MFSD(A,N,EPS,IER)                                      00001000
C                                                                       00001100
C        DESCRIPTION OF PARAMETERS                                      00001200
C           A      - UPPER TRIANGULAR PART OF THE GIVEN SYMMETRIC       00001300
C                    POSITIVE DEFINITE N BY N COEFFICIENT MATRIX.       00001400
C                    ON RETURN A CONTAINS THE RESULTANT UPPER           00001500
C                    TRIANGULAR MATRIX.                                 00001600
C           N      - THE NUMBER OF ROWS (COLUMNS) IN GIVEN MATRIX.      00001700
C           EPS    - AN INPUT CONSTANT WHICH IS USED AS RELATIVE        00001800
C                    TOLERANCE FOR TEST ON LOSS OF SIGNIFICANCE.        00001900
C           IER    - RESULTING ERROR PARAMETER CODED AS FOLLOWS         00002000
C                    IER=0  - NO ERROR                                  00002100
C                    IER=-1 - NO RESULT BECAUSE OF WRONG INPUT PARAME-  00002200
C                             TER N OR BECAUSE SOME RADICAND IS NON-    00002300
C                             POSITIVE (MATRIX A IS NOT POSITIVE        00002400
C                             DEFINITE, POSSIBLY DUE TO LOSS OF SIGNI-  00002500
C                             FICANCE)                                  00002600
C                    IER=K  - WARNING WHICH INDICATES LOSS OF SIGNIFI-  00002700
C                             CANCE. THE RADICAND FORMED AT FACTORIZA-  00002800
C                             TION STEP K+1 WAS STILL POSITIVE BUT NO   00002900
C                             LONGER GREATER THAN ABS(EPS*A(K+1,K+1)).  00003000
C                                                                       00003100
C        REMARKS                                                        00003200
C           THE UPPER TRIANGULAR PART OF GIVEN MATRIX IS ASSUMED TO BE  00003300
C           STORED COLUMNWISE IN N*(N+1)/2 SUCCESSIVE STORAGE LOCATIONS.00003400
C           IN THE SAME STORAGE LOCATIONS THE RESULTING UPPER TRIANGU-  00003500
C           LAR MATRIX IS STORED COLUMNWISE TOO.                        00003600
C           THE PROCEDURE GIVES RESULTS IF N IS GREATER THAN 0 AND ALL  00003700
C           CALCULATED RADICANDS ARE POSITIVE.                          00003800
C           THE PRODUCT OF RETURNED DIAGONAL TERMS IS EQUAL TO THE      00003900
C           SQUARE-ROOT OF THE DETERMINANT OF THE GIVEN MATRIX.         00004000
C                                                                       00004100
C        SUBROUTINES AND FUNCTION SUBPROGRAMS REQUIRED                  00004200
C           NONE                                                        00004300
C                                                                       00004400
C        METHOD                                                         00004500
C           SOLUTION IS DONE USING THE SQUARE-ROOT METHOD OF CHOLESKY.  00004600
C           THE GIVEN MATRIX IS REPRESENTED AS PRODUCT OF TWO TRIANGULAR00004700
C           MATRICES, WHERE THE LEFT HAND FACTOR IS THE TRANSPOSE OF    00004800
C           THE RETURNED RIGHT HAND FACTOR.                             00004900
C                                                                       00005000
C     ..................................................................00005100
C                                                                       00005200
C                                                                       00005400
C                                                                       00005500
      DIMENSION A(1)
      DOUBLE PRECISION DPIV,DSUM,A
C                                                                       00005800
C        TEST ON WRONG INPUT PARAMETER N                                00005900
      IF(N-1) 120,10,10
   10 IER=0
C                                                                       00006200
C        INITIALIZE DIAGONAL-LOOP                                       00006300
      KPIV=0
      DO 110 K=1,N
      KPIV=KPIV+K
      IND=KPIV
      LEND=K-1
C                                                                       00006900
C        CALCULATE TOLERANCE                                            00007000
      TOL=DABS(EPS*A(KPIV))
C                                                                       00007200
C        START FACTORIZATION-LOOP OVER K-TH ROW                         00007300
      DO 110 I=K,N
      DSUM=0.0
      IF(LEND) 40,40,20
C                                                                       00007700
C        START INNER LOOP                                               00007800
   20 DO 30 L=1,LEND
      LANF=KPIV-L
      LIND=IND-L
      DSUM=DSUM+A(LANF)*A(LIND)
  30  CONTINUE
C        END OF INNER LOOP                                              00008300
C                                                                       00008400
C        TRANSFORM ELEMENT A(IND)                                       00008500
   40 DSUM=A(IND)-DSUM
      IF(I-K) 100,50,100
C                                                                       00008800
C        TEST FOR NEGATIVE PIVOT ELEMENT AND FOR LOSS OF SIGNIFICANCE   00008900
   50 IF(DSUM-TOL) 60,60,90
   60 IF(DSUM) 120,120,70
  70  IF(IER) 80,80,90
   80 IER=K-1
C                                                                       00009400
C        COMPUTE PIVOT ELEMENT                                          00009500
  90  DPIV=DSQRT(DSUM)
      A(KPIV)=DPIV
      DPIV=1.0/DPIV
      GO TO 110
C                                                                       00010000
C        CALCULATE TERMS IN ROW                                         00010100
  100 A(IND)=DSUM*DPIV
  110 IND=IND+I
C                                                                       00010400
C        END OF DIAGONAL-LOOP                                           00010500
      RETURN
  120 IER=-1
      RETURN
      END

C$PROG OPTEQU
      SUBROUTINE OPTEQU(YI,Y,EPS,NE,W,X,NSTEP,NTP)
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /FEQOR/ALPHA,VV
      DIMENSION YI(8),Y(8)
      DOUBLE PRECISION AJ11,AJ21,AJ12,AJ22,DX,DVX,EP1,EP2
      EXTERNAL TEQORB
      DX=YI(3)
      DVX=YI(6)
  10  X=0.0
      DO 15 I=1,NE
  15  Y(I)=YI(I)
      CALL QKUTTAI(TEQORB,NE,X,NSTEP,W,Y)
      IF(NSKIP.NE.0) GO TO 30
      AJ11=Y(3)/DX-1.0
      AJ21=Y(4)/DX/1.0D+07
      AJ12=Y(5)/DVX/1.0D-07
      AJ22=Y(6)/DVX-1.0
      EP1=Y(1)-YI(1)
      EP2=(Y(2)-YI(2))/1.0D+07
      AJ=AJ11*AJ22-AJ12*AJ21
      EP=DABS(EP1/YI(1))+DABS(EP2/VV)*1.0D+07
      NTP=NTP+1
      IF(NTP.GT.8) GO TO 30
      IF(EP.LT.EPS) GO TO 30
      IF(ABS(AJ).LT.0.3E-03) AJ=SIGN(0.5E-03,AJ)
      YI(1)=YI(1)-(EP1*AJ22-EP2*AJ12)/AJ
      YI(2)=YI(2)-(EP2*AJ11-EP1*AJ21)/AJ/1.0D-07
      GO TO 10
  30  RETURN
      END

C$PROG PCURRT
      SUBROUTINE PCURRT(X,IT,A,HDEL,DERIV)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /SCRAA/ASP(39),CH(39),DDEV(39,23),DEV(429)
      COMMON /COEG/NPTS,NTERMS,IR,BISOC(39),PHINIT,IB1,IB2,RSIG(39),AC
      COMMON /COEF/IDUM(2650),IOFF
      DIMENSION A(1),DERIV(1)
      JT=IT+IOFF
      IF(IT.GT.1) GO TO 15
      IOFF=0
      DO 10 I=1,39
      CALL DCURRT(X,I,A,CH(I),DEV)
      DO 10 J=1,23
  10  DDEV(I,J)=DEV(J)
      IOFF=JT-IT
      HDEL=0.0
      DO 12 J=1,23
      DEV(J)=0.0
  12  DERIV(J)=0.0
      PHAT=SIN(PHINIT*0.017453293)
      RETURN
  15  HDEL=SPHASE(JT,PHAT)
      AT=AC*RSIG(JT)*FLOAT(JT-1)
      DO 40 J=1,NTERMS
      DEV(J)=DEV(J)+AT*DDEV(JT,J)
  40  DERIV(J)=DEV(J)-0.5*AT*DDEV(JT,J)
      IF(IT.GT.IB1) RETURN
      HDEL=-FLOAT(JT-1)*FDV5(CH,JT)/CH(JT)
      DO 60 J=1,NTERMS
  60  DERIV(J)=(-HDEL*DDEV(JT,J)-FLOAT(JT-1)*FDV5(DDEV(1,J),JT))/
     *  CH(JT)
      RETURN
      END

C$PROG PGETC
      FUNCTION PGETC(K,KK,A)
      COMMON /COEF/CA(2574),COE(23),NS(23),ALIM(23),NFOD,NYOD,NTOD,
     *  NQOD,ICOF,IH,ITM,IOFF
      DIMENSION A(1)
      PGETC=GETC(K,KK,A)
      IF(K.GE.2.AND.K.LE.11) PGETC=ALIM(K)*SIN(PGETC)
      IF(K.LT.13) RETURN
      IF(MOD(K-13,3).EQ.0) PGETC=ALIM(K)*SIN(PGETC)
      RETURN
      END

C$PROG PRMOUT    - Replaces data in tcisoc.car
C
C     - minor changes for compatability with revised SCRATNIT
C       j. ball       5/22/06
C
      SUBROUTINE PRMOUT(CUR,MS,PHINIT,ISYM,IA)
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /LOWCH/REN,REX,AIIN,AIOUT
      COMMON /LCCURP/PLCCUR(7),STRCOF(3),STRNLC
      COMMON/TIMM/DAT(4),DTM(8)
      INTEGER*4 IWD(20)
      CHARACTER*80 CIWD
      EQUIVALENCE (CIWD,IWD)
      DOUBLE PRECISION ET
      DIMENSION CUR(1),MS(1),LP(23),LA(3),OF(4),KA(12)
      DATA LA/'OF  ','AM  ','PH  '/,OF/90.,110.,126.,126./
C
      CALL SCRATNIT(19)          !Init scratch file
      CALL SSWTCH(12,KSTAT)
      ET='        '
      IF(KSTAT.EQ.1) ET=8H UPGRADE
C
      WRITE(19,20) EE,IA,ISYM,Z1,EINJ,ZINJ,ET,DAT
   20 FORMAT(F8.3,2X,I3,A2,2X,F3.0,2X,F8.3,2X,F3.0,2X,A8,
     &  5X,2A4,2X,2A4)
C
      HJA=IFIX(1.0/HA+0.001)
      WRITE(19,40) FREQ,VDEE,PHINIT,HJA,REN,REX,AIIN,AIOUT
   40 FORMAT('FREQ=',F5.2,2X,'DEEV=',F4.1,2X,'PHINIT=',F4.1,2X,'HA=',
     &  F3.0,5X,'LC'/2F8.3,2F8.1/20('    '))
C
      DO 60 I=1,23
      LP(I)='    '
      IF(MS(I).EQ.1) LP(I)='F'
   60 CONTINUE
C
      K=0
      DO 80 I=14,23,3
      K=K+1
      CUR(I)=CUR(I)*57.29578+OF(K)
      CUR(I)=AMOD(CUR(I),360.)
   80 CONTINUE
C
      WRITE(19,100) LP(1),CUR(1),(LP(I+1),I,CUR(I+1),I=1,10)
  100 FORMAT('MAIN=',A1,1X,F7.1/'TRIM=',5(A1,I1,2X,F8.2,',')/
     &  4X,5(A1,I2,1X,F8.2,','))
C
      IS='HAR='
      L=0
      DO 140 K=1,4
      DO 120 J=1,3
      L=L+1
      KA(L)=LA(J)
  120 CONTINUE
C
      K1=12+(K-1)*3
      K2=K1+2
      WRITE(19,160) IS,(LP(I),KA(I-11),K,CUR(I),I=K1,K2)
  160 FORMAT(A4,3(A1,1X,A2,I1,1X,F8.2,','))
      IS='    '
  140 CONTINUE
C
      WRITE(19,160) IS
C
      CALL FILSERT(19,4,1)       !Insert into tcisoc.car @ line-1
      CLOSE(19)                  !close scratch file and then
      CALL SCRATNIT(19)          !re-init scratch file
C
      STRNLC=(STRCOF(1)+STRCOF(2)*AIIN+STRCOF(3)*AIOUT)/1000.
      WRITE(19,220) AIIN,REN,STRNLC,AIOUT,REX !Write 2 recs to scratch
  220 FORMAT('LOWCHAN',5X,'INNER=',F6.1,4X,'ENT=',F6.3,
     &       3X,'STRENGTH=',F6.3/
     &       'LOWCHAN',5X,'OUTER=',F6.1,3X,'EXIT=',F6.3)
C
      CALL FILSERT(19,4,15)      !Insert into tcisoc.car @ line-15
      CLOSE(19)
      CALL SCRATNIT(19)          !Re-init scratch file
C
      DO 260 I=1,16              !Write 16 blank lines
      WRITE(19,255)IS
  255 FORMAT(A4)
  260 CONTINUE
C
      CALL FILSERT(19,4,20)      !Insert into tcisoc.car @ line-20
C
      CLOSE(UNIT=19)
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
   10 FORMAT(' JBISOC->',$)
C
      RETURN
      END

C$PROG PURRT
      FUNCTION PURRT(X,IT,A)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /SCRAA/ASP(39),CH(39),DDEV(39,23),DUM(429)
      COMMON /COEG/NPTS,NTERMS,IR,BISOC(39),PHINIT,IB1,IB2,RSIG(39),AC
      COMMON /COEF/IDUM(2650),IOFF
      DIMENSION A(1)
      JT=IT+IOFF
      IF(IT.GT.1) GO TO 15
      IOFF=0
      DO 10 I=1,39
  10  CALL CATHER(I,A,CH(I))
      PURRT=0.0
      PHAT=SIN(PHINIT*0.017453293)
      IOFF=JT-IT
      RETURN
  15  PURRT=SPHASE(JT,PHAT)
      IF(IT.GT.IB1) RETURN
      PURRT=-FLOAT(JT-1)*FDV5(CH,JT)/CH(JT)
      RETURN
      END

C$PROG QKUTTAI
C
      SUBROUTINE QKUTTAI(F,NE,X,NSTEP,W,Y)
C
C        QUARTIC RUNGA  -KUTTA INTEGRATION ROUTINE.
C            F     - SUBROUTINE WHICH EVALUATES DERIVATIVES
C            NE    - NUMBER OF EQUATIONS TO BE INTEGRATED
C            X     - INDEPENDENT VARIABLE
C            NSTEP - NUMBER OF INTEGRATION STEPS
C            W     - STEP SIZE
C            Y     - DEPENDENT VARIABLES.
C
C        Note: This is a version of QKUTTA to use with the ISOC program.
C              It differs only in assignment of double-precision variables.
C              QKUTTA should be used with all other orbit programs.
C
      DIMENSION AK(4,8),Y(8),YI(8),A(4),YP(8)
      DOUBLE PRECISION AK
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      DATA A/0.0,0.5,0.5,1.0/
      DO 80 L=1,NSTEP
      XI=X
      DO 10 I=1,NE
  10  YI(I)=Y(I)
      DO 60 J=1,4
      IF(J.EQ.1) GO TO 50
      DO 40 I=1,NE
  40  Y(I)=YI(I)+A(J)*AK(J-1,I)
  50  X=XI+A(J)*W
      CALL F(X,Y,YP)
      IF(NSKIP.NE.0) RETURN
      DO 60 I=1,NE
  60  AK(J,I)=W*YP(I)*0.017453
      DO 70 I=1,NE
  70  Y(I)=YI(I)+(AK(1,I)+2.*(AK(2,I)+AK(3,I))+AK(4,I))/6.0
  80  CONTINUE
      RETURN
      END

C$PROG SCRATNIT  - Initializes scratch-file
C
      SUBROUTINE SCRATNIT(LU)
C
      OPEN(UNIT       = LU,
     &     STATUS     = 'SCRATCH',
     &     IOSTAT     = IOS)
C
      RETURN
      END

C$PROG SFDSIG
      SUBROUTINE SFDSIG(BISOC,BO,BAV,BLAMDA)
      DIMENSION BISOC(1),BAV(1)
      COMMON /SCRAA/DAJ(39,3),DBJ(39,3),SIG(39),RSIG(39),ANUR(39),
     *  ANUZ2(39),GAMMA(39),DDAJ(39,3),DDBJ(39,3),ADUM(507),AJ(39,3),
     *  BJ(39,3)
      COMMON /SWTCH/NSWT(15),NRPRN
      INTEGER*4     NSWT,NRPRN
C
      DO 20 I=1,39
      RO=I-1
      DO 20 J=1,3
      DDAJ(I,J)=RO*RO*FDDV5(AJ(1,J),I)
      DDBJ(I,J)=RO*RO*FDDV5(BJ(1,J),I)
      DAJ(I,J)=RO*FDV5(AJ(1,J),I)
  20  DBJ(I,J)=RO*FDV5(BJ(1,J),I)
      DO 35 I=1,39
      RO=I-1
      BB=RO*FDV5(BAV,I)/BAV(I)
      BC=RO*RO*FDDV5(BAV,I)/BAV(I)
      ANUZ2(I)=-BB
      ANUR(I)=1.0+0.5*BB
C
      IF(NRPRN.EQ.1) WRITE(14,441)I,BAV(I),BB,ANUR(I)
  441 FORMAT(1X,I3,3F10.3)
C
      GAMMA(I)=0.0
      SIG(I)=1.0
      DO 30 J=3,9,3
      JJ=J/3
      CJ=J
      CJ2=J*J
      AW=CJ2-(1.D+00+BB)
      AQ=(CJ2*(2.0D+00-BB)-2.0D+00+BC)/AW
      AR=1.0/AW
      AT=AJ(I,JJ)*AJ(I,JJ)+BJ(I,JJ)*BJ(I,JJ)
      AS=AJ(I,JJ)*DAJ(I,JJ)+BJ(I,JJ)*DBJ(I,JJ)
      AU=DAJ(I,JJ)*DAJ(I,JJ)+DBJ(I,JJ)*DBJ(I,JJ)
      AV=AJ(I,JJ)*DDAJ(I,JJ)+BJ(I,JJ)*DDBJ(I,JJ)
      GAMMA(I)=GAMMA(I)-0.25*AR*((3.*CJ2-2.0)*AT*AR+2.0*AS)
      ANUR(I)=ANUR(I)+0.25*AR/(CJ2-4.0)*(3.*CJ2*AT+(5.*CJ2-8.)*AS+
     *  (CJ2-4.0)*AV+(CJ2-1.0)*AU)
C
      IF(NRPRN.EQ.1) WRITE(14,443)I,J,AJ(I,JJ),BJ(I,JJ),
     1  AR,AT,AS,AU,AV,ANUR(I)
  443 FORMAT(1X,2I3,8F8.3)
C
      ANUZ2(I)=ANUZ2(I)+0.5*AR*(CJ2*AT-AS-AV)+0.5*AU/CJ2
  30  SIG(I)=SIG(I)-0.25/(1.0D+00+BB)*AR*(AQ*AT+2.0D+00*AS)
      AR=ANUR(I)-1.0
      AC=5.*DAJ(I,1)+DDAJ(I,1)
      DDAJ(I,1)=3.*AJ(I,1)+AC
      AC=5.*DBJ(I,1)+DDBJ(I,1)
      DDBJ(I,1)=3.*BJ(I,1)+AC
      DDAJ(I,1)=DDAJ(I,1)*DDAJ(I,1)+DDBJ(I,1)*DDBJ(I,1)
      IF(DDAJ(I,1).GT.0.1E-30) DDAJ(I,1)=8.0*AR*AR/SQRT(DDAJ(I,1))
     *  *BAV(I)
  35  CONTINUE
      DO 40 I=1,39
      AB=FLOAT(I-1)*SIG(I)/BLAMDA
  40  RSIG(I)=BO*SIG(I)/SQRT(1.0-AB*AB)
      CALL ISOC(BISOC)
      DO 50 I=1,39
      AB=FLOAT(I-1)/BLAMDA
  50  SIG(I)=1.0/SQRT((BO/BISOC(I))**2+AB*AB)
      RETURN
      END

C$PROG SINV
      SUBROUTINE SINV(A,N,EPS,IER)
C                                                                       00000100
C     ..................................................................00000200
C                                                                       00000300
C        SUBROUTINE SINV                                                00000400
C                                                                       00000500
C        PURPOSE                                                        00000600
C           INVERT A GIVEN SYMMETRIC POSITIVE DEFINITE MATRIX           00000700
C                                                                       00000800
C        USAGE                                                          00000900
C           CALL SINV(A,N,EPS,IER)                                      00001000
C                                                                       00001100
C        DESCRIPTION OF PARAMETERS                                      00001200
C           A      - UPPER TRIANGULAR PART OF THE GIVEN SYMMETRIC       00001300
C                    POSITIVE DEFINITE N BY N COEFFICIENT MATRIX.       00001400
C                    ON RETURN A CONTAINS THE RESULTANT UPPER           00001500
C                    TRIANGULAR MATRIX.                                 00001600
C           N      - THE NUMBER OF ROWS (COLUMNS) IN GIVEN MATRIX.      00001700
C           EPS    - AN INPUT CONSTANT WHICH IS USED AS RELATIVE        00001800
C                    TOLERANCE FOR TEST ON LOSS OF SIGNIFICANCE.        00001900
C           IER    - RESULTING ERROR PARAMETER CODED AS FOLLOWS         00002000
C                    IER=0  - NO ERROR                                  00002100
C                    IER=-1 - NO RESULT BECAUSE OF WRONG INPUT PARAME-  00002200
C                             TER N OR BECAUSE SOME RADICAND IS NON-    00002300
C                             POSITIVE (MATRIX A IS NOT POSITIVE        00002400
C                             DEFINITE, POSSIBLY DUE TO LOSS OF SIGNI-  00002500
C                             FICANCE)                                  00002600
C                    IER=K  - WARNING WHICH INDICATES LOSS OF SIGNIFI-  00002700
C                             CANCE. THE RADICAND FORMED AT FACTORIZA-  00002800
C                             TION STEP K+1 WAS STILL POSITIVE BUT NO   00002900
C                             LONGER GREATER THAN ABS(EPS*A(K+1,K+1)).  00003000
C                                                                       00003100
C        REMARKS                                                        00003200
C           THE UPPER TRIANGULAR PART OF GIVEN MATRIX IS ASSUMED TO BE  00003300
C           STORED COLUMNWISE IN N*(N+1)/2 SUCCESSIVE STORAGE LOCATIONS.00003400
C           IN THE SAME STORAGE LOCATIONS THE RESULTING UPPER TRIANGU-  00003500
C           LAR MATRIX IS STORED COLUMNWISE TOO.                        00003600
C           THE PROCEDURE GIVES RESULTS IF N IS GREATER THAN 0 AND ALL  00003700
C           CALCULATED RADICANDS ARE POSITIVE.                          00003800
C                                                                       00003900
C        SUBROUTINES AND FUNCTION SUBPROGRAMS REQUIRED                  00004000
C           MFSD                                                        00004100
C
C        METHOD
C           SOLUTION IS DONE USING THE FACTORIZATION BY SUBROUTINE MFSD.00004400
C                                                                       00004500
C     ..................................................................00004600
C                                                                       00004700
C                                                                       00004900
C                                                                       00005000
      DIMENSION A(1)
      DOUBLE PRECISION DIN,WORK,A
C                                                                       00005300
C        FACTORIZE GIVEN MATRIX BY MEANS OF SUBROUTINE MFSD             00005400
C        A = TRANSPOSE(T) * T                                           00005500
      CALL MFSD(A,N,EPS,IER)
      IF(IER) 90,10,10
C                                                                       00005800
C        INVERT UPPER TRIANGULAR MATRIX T                               00005900
C        PREPARE INVERSION-LOOP                                         00006000
   10 IPIV=N*(N+1)/2
      IND=IPIV
C                                                                       00006300
C        INITIALIZE INVERSION-LOOP                                      00006400
      DO 60 I=1,N
      DIN=1.0/A(IPIV)
      A(IPIV)=DIN
      MIN=N
      KEND=I-1
      LANF=N-KEND
      IF(KEND) 50,50,20
   20 J=IND
C                                                                       00007300
C        INITIALIZE ROW-LOOP                                            00007400
      DO 40 K=1,KEND
      WORK=0.0
      MIN=MIN-1
      LHOR=IPIV
      LVER=J
C                                                                       00008000
C        START INNER LOOP                                               00008100
      DO 30 L=LANF,MIN
      LVER=LVER+1
      LHOR=LHOR+L
      WORK=WORK+A(LVER)*A(LHOR)
  30  CONTINUE
C        END OF INNER LOOP                                              00008600
C                                                                       00008700
      A(J)=-WORK*DIN
   40 J=J-MIN
C        END OF ROW-LOOP                                                00009000
C                                                                       00009100
   50 IPIV=IPIV-MIN
   60 IND=IND-1
C        END OF INVERSION-LOOP                                          00009400
C                                                                       00009500
C        CALCULATE INVERSE(A) BY MEANS OF INVERSE(T)                    00009600
C        INVERSE(A) = INVERSE(T) * TRANSPOSE(INVERSE(T))                00009700
C        INITIALIZE MULTIPLICATION-LOOP                                 00009800
      DO 80 I=1,N
      IPIV=IPIV+I
      J=IPIV
C                                                                       00010200
C        INITIALIZE ROW-LOOP                                            00010300
      DO 80 K=I,N
      WORK=0.0
      LHOR=J
C                                                                       00010700
C        START INNER LOOP                                               00010800
      DO 70 L=K,N
      LVER=LHOR+K-I
      WORK=WORK+A(LHOR)*A(LVER)
   70 LHOR=LHOR+L
C        END OF INNER LOOP                                              00011300
C                                                                       00011400
      A(J)=WORK
   80 J=J+K
C        END OF ROW- AND MULTIPLICATION-LOOP                            00011700
C                                                                       00011800
   90 RETURN
      END

C$PROG SISOC
      SUBROUTINE SISOC(YI,RF,VV,RSC,VSC)
      DIMENSION YI(8)
      DO 10 I=1,8
   10 YI(I)=0.0
      YI(1)=RF*RSC
      YI(2)=VV*VSC
      YI(3)=0.02
      YI(6)=VV*0.01
      RETURN
      END

C$PROG SPHASE
      FUNCTION SPHASE(JT,PHAT)
      COMMON /SCRAA/ASP(39),CH(39),DDEV(39,23),DEV(429)
      COMMON /COEG/NPTS,NTERMS,IR,BISOC(39),PHINIT,IB1,IB2,RSIG(39),AC
      PH1=AC*RSIG(JT)*FLOAT(JT-1)*(CH(JT)-BISOC(JT))
      PHAT=PHAT+PH1
      SPHASE=PHAT-0.5*PH1
      RETURN
      END

C$PROG TEQORB
      SUBROUTINE TEQORB(X,Y,YP)
      DOUBLE PRECISION AV,SV,SBZ,VB
      DIMENSION Y(8),YP(8)
      COMMON /FEQOR/ALPHA,VV
      VB=VV
      SV=Y(2)
      SV=DSQRT(VB*VB-SV*SV)
      CALL BINTP4(X,Y(1),BZ,DBZ)
      YP(1)=Y(1)*Y(2)/SV
      YP(2)=SV-ALPHA*Y(1)*BZ
      SBZ=(BZ+Y(1)*DBZ)*ALPHA
      AV=VB*VB*Y(1)/SV/SV/SV
      DO 20 J=3,5,2
      YP(J)=Y(2)*Y(J)/SV+AV*Y(J+1)
  20  YP(J+1)=-Y(2)*Y(J+1)/SV-Y(J)*SBZ
      SV=Y(1)
      AV=YP(1)
      YP(7)=DSQRT(SV*SV+AV*AV)/VB
      YP(8)=Y(1)/6.283185
      RETURN
      END

