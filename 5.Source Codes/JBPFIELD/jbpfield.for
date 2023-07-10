C$PROG JBPFIELD  - Lists ORIC field as specified by tcisoc.car data
C
C     ********************************************************************
C     This is a much modified version of Terry Cleary's TCPFIELD program
C       that was last revised by Bill Milner on 06/21/99.
C     This version for the PC differs mainly from TCPFIELD in that the
C       output format has been restructured to provide convenient copy
C       and paste of the azimuthal data into an Excel spreadsheet.
C     Also, all magnet fields are now listed in kilogauss.
C
C     In 2005, added option to output complete field matrix as a
C       space-delimited text file to use in plotting programs.
C
C     The program options are now:
C        OPT = 0 or blank:  outputs average field vs. R on console and a
C                           print file for complete angular field data
C        OPT = 1:  same as TC version - print 1st harmonic
C        OPT = 2:  same as TC version - print 2nd harmonic
C        OPT = 3:  outputs complete field matrix as formatted text file
C        OPT = 4:  outputs 1st harmonic field matrix as formatted text file
C        OPT = 5:  outputs 2nd harmonic field matrix as formatted text file
C
C     The plot files generated in options 3 through 5 are labeled as 
C     polar plots with data and formatting appropriate for input to 
C     the JBFLDMAN program.
C
C     1/4/07 Added check to keep from accidentally exceeding radii limit
C            and increased maximum radius allowed from 60 to 100
C
C     Jim Ball       05/15/04                 Date of latest rev: 01/14/07
C     ********************************************************************
C
      DIMENSION AN(400),BAV(13),PROG(2),R(101),TR(13),BJB(101,400)
C
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      COMMON /GRE/LWD(320),IWD(20),ITYP(160),IWDX,IFDX
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /VERS/VNUM,PRMID
C
      LOGICAL IEND
C
      CHARACTER*8  CPROG,VNUM,PRMID*32
      CHARACTER*32 CB
      CHARACTER*15 PFNAME
      CHARACTER LWDBUF*56       !create internal file to replace encode
      EQUIVALENCE (LWDBUF,LWD)  !and align it with data
      EQUIVALENCE (CPROG,PROG),(CB,B)
C
      DATA         CB/'FIELD DATA PRINTING PROGRAM     '/
      DATA         CPROG/'JBPFIELD'/
      DATA VNUM/'v.011407'/     !version number (date) for this program
C     ====================================================================
C
      WRITE(6,400)
  400 FORMAT(/' ********** BEGIN JBPFIELD **********'/)
C
      CALL JBFLDNIT
      CALL SETSWT
C
      PRMID='                                '
C
    4 WRITE(6,404)
  404 FORMAT(' OPTIONS:'/3X,
     1 '0 or blank: outputs average field vs. R on console and a'/15X,
     2             'print file for complete angular field data'/3X,
     3 '1: same as TC version - prints 1st harmonic'/3X,
     4 '2: same as TC version - prints 2nd harmonic'/3X,
     5 '3: outputs complete field matrix as formatted text file'/3X,
     6 '4: outputs 1st harmonic field matrix as formatted text file'/3X,
     7 '5: outputs 2nd harmonic field matrix as formatted text file'//1X,
     8 'SELECT OPTION: ',$)
    6 READ(6,406)IOPT
  406 FORMAT(I1)
      WRITE(*,*)' '     !blank line for output formatting
C
      IF(IPPT.GT.5) GO TO 4
      IF(IOPT.GT.2) GO TO 70
C
C     ======================== OPTIONS 0 TO 2 ============================
      LGRED=5
      NF=0
C
   10 WRITE(6,410)
  410 FORMAT(' RMIN RMAX RSTEP ANGMIN ANGMAX ANGSTEP')
C
      CALL ROSGRED(LWD,ITYP,NF,IEND,IWD)
   11 IF(IEND) STOP 'EXIT CALLED FROM MAIN PROGRAM AT STMNT #11'

C
Cjbb   12 DECODE(56,412,LWD(1)) R1,R2,DR,ANG1,ANG2,DANG
Cjbb  412 FORMAT(6F8.0)
Cjbb        !replace this decode with internal file read
Cjbb
   12 READ(LWDBUF,'(6F8.0)')R1,R2,DR,ANG1,ANG2,DANG
Cjbb
      NANG=(ANG2+0.001-ANG1)/DANG+1.0
      IF (NANG.GT.400) THEN
   14   WRITE (6,414)
  414   FORMAT(' RUN ABORTED: NUMBER OF ANGLES CANNOT EXCEED 400!'/)
        GO TO 10
      END IF
C
      IF (R2.GT.100.0) R2=100.0
      IF (DR.LT.1.0) DR=1.0
      NR=(R2+0.001-R1)/DR+1.0
C
      LGRED=4
C
      CALL SETUP(PHINIT,JSYM,IA,JHARM)
      CALL ADEXFO
C
      OPEN(UNIT   = 15,
     &     FILE   = 'jbpfield.prn',
     &     STATUS = 'UNKNOWN',
     &     ACCESS = 'SEQUENTIAL',
     &     IOSTAT = IOS)
      REWIND 15
C
      DO 16 K=1,13
   16 TR(K)='R='
C
      CALL HEADER(PROG,B,PHINIT,JSYM,IA,JHARM)
C
      WRITE(6,417)
  417 FORMAT(/' FIELD PROFILE SUMMARY'/'       R     BAV')
C
      IR1=R1
      NRREM=NR
   18 IF (NRREM.GE.13) THEN
        IR2=13
        NRREM=NRREM-13
      ELSE
        IR2=NRREM
        NRREM=0
        DO 19 K=IR2+1,13
   19   TR(K)='  '
      END IF
C
      DO 30 I=1,IR2
      R(I)=IR1+FLOAT(I-1)*DR
      IR=R(I)+1.0
      BSUM=0
      NINT=0
      INTANG=0
      IDANG=DANG+0.001
C
      DO 20 J=1,NANG
      AN(J)=ANG1+FLOAT(J-1)*DANG
      IAN=AN(J)*100.
      FIEL=IFIELD(IR,IAN)-LFIELD(IR,IAN,IOPT)
      A=FIEL/100.
      BJB(I,J)=A/1000.
C                             Only sum field for 360 degrees of azimuth
      INTANG=INTANG+IDANG    ! INTANG = IDANG for first angle. Stop at 360.
      IF (INTANG.LE.360) THEN
        BSUM=BSUM+BJB(I,J)
        NINT=NINT+1
      END IF
   20 CONTINUE
C
      BAV(I)=BSUM/FLOAT(NINT)
   22 WRITE(6,422) R(I),BAV(I)
  422 FORMAT(1H ,F8.1,F8.3)
C
   30 CONTINUE
C
   40 WRITE(15,440) (TR(N),R(N), N=1,IR2)
  440 FORMAT(1H /1H ,'  ANG',13('    ',A2,F3.0))
      DO 50 J=1,NANG
   42 WRITE(15,442) AN(J),(BJB(I,J),I=1,IR2)
  442 FORMAT(1H ,F5.0,13F9.3)
   50 CONTINUE
C
   60 WRITE(15,460) (BAV(N), N=1,IR2)
  460 FORMAT(1H ,' BAV ',13F9.3)
C
      IR1=IR1+13
      IF (NRREM.GT.0) GO TO 18
      CLOSE(15)
C
      GO TO 100
C
C     ======================== OPTIONS 3 TO 5 ============================
C
C     this version fixes matrix with R=0-NR, step=1 and ANG=0-360, with
C     the angular step requested as input - step not allowed to be less
C     than 1 degree.
C
   70 IOPT=IOPT-3    ! set IOPT back to correct value for call to FIEL
      LGRED=4
C
      CALL SETUP(PHINIT,JSYM,IA,JHARM)
      CALL ADEXFO
C
   71 WRITE(6,4071)
 4071 FORMAT(/1X,'  Input name for field data output file: ',$)
   72 READ(5,4072) PFNAME
 4072 FORMAT(A)
C
      OPEN(UNIT   = 15,
     &     FILE   = PFNAME,
     &     STATUS = 'UNKNOWN',
     &     ACCESS = 'SEQUENTIAL',
     &     IOSTAT = IOS)
      REWIND 15
C
      IF(IOS.EQ.0) GO TO 75
C
      IF(LEN_TRIM(PFNAME).EQ.0) THEN
        GO TO 100
      ELSE
   74   WRITE(6,4074) PFNAME,IOS
 4074   FORMAT(' ### CANNOT OPEN FILE: ',A,'    ERROR #'I4)
        GO TO 100
      END IF
C
   75 R1=0.0
      DR=1.0
      ANG1=0.0
      ANG2=360.0
C
   76 WRITE(6,4076)
 4076 FORMAT(/1X,'  Input maximum radius (default=59, max=100): ',$)
   77 READ(5,4077) IRT
 4077 FORMAT(I3)
C
      R2=IRT
      IF(R2.LT.1.0) R2=59.0
      IF(R2.GT.100.0) R2=100.0
      NR=((R2+0.001-R1)/DR)+1.0
C
   78 WRITE(6,4078)
 4078 FORMAT(/1X,'  Input angle step size (default=1, min=1): ',$)
   79 READ(5,4077) IDANG
      IF(IDANG.LT.1) THEN
        DANG=1
      ELSE
        DANG=IDANG
      END IF
C
      NANG=(ANG2+0.001-ANG1)/DANG+1.0
      IR1=R1
C
C       write file identification paramters and radius values
C
      PLTYP='P'
   80 WRITE(15,4080) PLTYP,NR,NANG,(IRAD,IRAD=0,NR-1)
 4080 FORMAT(A1,I4,I5,101I10)
C
C       now write radial field values at each angle
C
      DO 90 J=1,NANG
      AN(J)=ANG1+FLOAT(J-1)*DANG
      IAN=AN(J)*100.
C
      DO 82 I=1,NR
      R(I)=IR1+FLOAT(I-1)*DR
      IR=R(I)+1.0
      FIEL=IFIELD(IR,IAN)-LFIELD(IR,IAN,IOPT)
      A=FIEL/100.
   82 BJB(I,J)=A/1000.
C
      IANG=AN(J)
   84 WRITE(15,484) IANG,(BJB(I,J), I=1,NR)
  484 FORMAT(I10,101F10.3)
C
   90 CONTINUE
C
   95 WRITE(6,4095) PFNAME
 4095 FORMAT(/' FIELD DATA WRITTEN TO FILE ',A)
      CLOSE(15)
C
  100 WRITE(6,4100)
 4100 FORMAT(/' ********** END JBPFIELD **********'/)
C
      STOP
      END

C$PROG ADEXFO
C
      SUBROUTINE ADEXFO
C
C        THIS ROUTINE CALLS ROUTINE TO CALCULATE EXTERNAL FIELD OF
C        LOWER CHANNEL TO FOLD THE FOURIER COEFS. FOR THIS FIELD
C        INTO THE FOURIER COEFS. FOR THE MAIN FIELD.
C
      DIMENSION A(200)
      COMMON /LIN/LDNB,NPOS,CUR(23)
      COMMON /SCRAA/IBAV(153),IBFR(22,39),IPHIR(22,39),IBFS(11,10),
     *IPHIS(11,10),IPHISS(9),IBFT(2,29),IPHIT(2,29),IHH(22),SIG(46),
     *GAMMA(39),DUM(84),ACOF(117)
      COMMON /LOWCH/REN,REX,AIIN,AIOUT
      COMMON /COEB/BEX(11,2,39)
      DOUBLE PRECISION AA,BB
Cjbb
Cjbb  NOTE!! This version of ADEXFO checks the lower channel currents.
Cjbb         If both are zero, then ADEXFO returns without adding any 
Cjbb         field contributions from the lower channel.  
cjbb
      IF(AIIN.EQ.0.0.AND.AIOUT.EQ.0.0) THEN
      WRITE(6,4000)
 4000 FORMAT(1X,'  NOTE: NO LOWER CHANNEL FIELD CONTRIBUTIONS ARE ',
     1  'INCLUDED IN THIS CALCULATION')
      RETURN
      END IF
Cjbb
C
C     CALCULATE FOURIER COEFFICIENTS FOR EXTERNAL FIELD OF LOWER CHANNEL
C
      CALL EXTRAK(CUR(1),REN,REX,AIIN,AIOUT,A)
      CALL ZODDHM
Cjbb
Cjbb  In the following loop, Terry stops the lower channel contributions
Cjbb  at 31 inches since the values are becomming unphysical beyond this
Cjbb  radius and severely distort the field shape.  This whole business
Cjbb  of the LC contribution needs to be examined in detail and most
Cjbb  likely changed.  Or, for this program could simply be skipped.
Cjbb
      DO 40 I=1,32
      RAD=I-1
      IBAV(I)=IBAV(I)+IFIX(BEX(1,1,I)*100.)
      DO 40 K=1,9
      AN=FLOAT(IPHIR(K,I))*0.00017453
      AA=FLOAT(IBFR(K,I))*COS(AN)/100.+BEX(K+1,1,I)
      BB=FLOAT(IBFR(K,I))*SIN(AN)/100.+BEX(K+1,2,I)
  35  IBFR(K,I)=100.*DSQRT(AA*AA+BB*BB)
      IF(AA+BB.EQ.0.0D0) GO TO 40
      IPHIR(K,I)=ATAN2(BB,AA)*5729.578
  40  CONTINUE
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
C       J. Ball     27-Apr-2005
C
C     Additional modifications made for transition to MS Fortran:
C      DEC Fortran DATE_AND_TIME subroutine replaced with GETDAT and
C       GETTIM subroutine calls
C      ENCODE routine replaced with write to internal file
C      Program version number added to header output
C       J. Ball     07/01/2006
C
C     NOTE: This version is modified for JBPFIELD to work around
C       a problem with reading tcisoc.car files with no dates.
C       DO NOT USE THIS VERSION WITH OTHER ORBIT CODES!!
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /TIMM/DAT(4),DTM(8)
      COMMON /VERS/VNUM,PRMID
      DIMENSION PROG(2),A(8)
      INTEGER DTM
      CHARACTER DUM*12,PRMID*32,DTFIL*16,CC*1,CS*1,VNUM*8,ET*8
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
Cjbb
  200 WRITE(15,4200) PROG,ET,PRMID,DTM(2),DTM(3),DTM(1),A,
     *  DTM(5),DTM(6),DTM(7),DTM(8)/100
Cjbb
 4200 FORMAT(1X,113('-')/1X,': ',2A4,':',1X,A8,
     *  14X, 'PARAMETER SET: ',A32,15X,
     *  'DATE:',2(I2.2,'/'),I4,' :'/1X,': ',8A4,62X,'TIME:',
     *  2(I2.2,':'),I2,'.',I1,' :'/ 1X,113('-'))
      IZT=Z1
  220 WRITE(15,4220) IAM1,ISYM,IZT,EE,AM1,EINJ,DAT,RE,FREQ,VDEE,PHINIT,
     *  JHARM
 4220 FORMAT(/1X,I3,A2,1X,I2,'+',4X,'ENERGY=',F7.2,4X,'MASS=',F10.2
     *  ,4X,'INJECTION ENERGY=',F8.3,28X,2A4/1X,105X,2A4/1X,
     *  'EXTRACTION RADIUS=',F7.3,3X,'FREQUENCY=',F8.5,' MHZ',
     *  3X,'DEE VOLTAGE=',F5.1,' KV',3X,'PHI0=',F6.2,' DEG',3X,
     *  'HARMONIC=',I1)
Cjbb
C     Unneeded code removed here to bypass lack of date problem
Cjbb
C
  400 RETURN
      END

C$PROG JBFLDNIT - Opens files, etc for JBPFIELD
C
C     ******************************************************************
C     PFIELDNIT BY W.T. MILNER AT HRIBF - LAST MODIFIED 06/21/99
C
C     Modified for JBPFIELD program by J. Ball - 05/15/04 & 03/02/05
C     Modified for PC file handling and date/time routines - 07/01/06
C     ******************************************************************
C
      SUBROUTINE JBFLDNIT
C
      IMPLICIT NONE
C
C     ------------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      COMMON/TIMM/DAT(4),DTM(8)
      INTEGER*4   IOS,I,DTM,DAT
      INTEGER*4   MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      CHARACTER*112 CMSSG
      EQUIVALENCE (CMSSG,MSSG)
C     ------------------------------------------------------------------
C
      DO 10 I=1,28
      MSSG(I)='    '
   10 CONTINUE
      NAMPROG(1)='JBFL'
      NAMPROG(2)='DPXL'
      MSGF='    '
      LISFLG='LON '
      LOGUT=6
      LOGUP=14
C
      OPEN(UNIT       = 14,
     &     FILE       = 'jbpfield.log',
     &     STATUS     = 'UNKNOWN',
     &     ACCESS     = 'APPEND',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 100
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
C
      OPEN(UNIT       = 4,
     &     FILE       = 'tcisoc.car',
     &     STATUS     = 'OLD',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 105
C
      OPEN(UNIT       = 8,
     &     FILE       = 'jbpfield.int',
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
C     Unit=15 is now assigned in main program
C
      RETURN
C
C     ******************************************************************
C     Return error messages and EXIT
C     *********************************************************
C
  100 WRITE(CMSSG,4100)
 4100 FORMAT('attempting to open - jbpfield.log')
      GO TO 200
C
  105 WRITE(CMSSG,4105)
 4105 FORMAT('attempting to open - tcisoc.car')
      GO TO 200
C
  110 WRITE(CMSSG,4110)
 4110 FORMAT('attempting to open - tcpfield.int')
      GO TO 200
C
  120 WRITE(CMSSG,4120)
 4120 FORMAT('attempting to open - tcmagprm.bin')
      GO TO 200
C
  200 WRITE(LOGUP,4200)IOS,CMSSG
 4200 FORMAT(1X,'---'/1X,'File opening error in subroutine JBFLDNIT',
     1  10X,'Error #',I4/1X,'Failed while ',A40)
      WRITE(LOGUT,4200)IOS,CMSSG
      STOP 'EXIT CALLED FROM SUBROUTINE ISOCINIT'
      END

C$PROG LFIELD
      FUNCTION LFIELD(JJ,JANG,IOPT)
      COMMON /SCRAA/IBAV(153),IBFR(22,39),IPHIR(22,39),IBFS(11,10),
     *IPHIS(11,10),IPHISS(9),IBFT(2,29),IPHIT(2,29),IHH(22),ACOF(286)
      LFIELD=0
C
      IF(IOPT.EQ.0) RETURN
C
      LFIELD=IBAV(JJ)
      IF(JJ.GT.39) GO TO 15
      DO 10 I=1,22
      JIT=IHH(I)-1
      IF(JIT.NE.1.AND.IOPT.EQ.1) GO TO 5
      IF(JIT.NE.2.AND.IOPT.EQ.2) GO TO 5
      IF(JIT-(JIT/3)*3.NE.0) GO TO 10
    5 LFIELD=LFIELD+JFIELD(JANG,IHH(I)-1,IPHIR(I,JJ),IBFR(I,JJ))
   10 CONTINUE
      RETURN
   15 IF(JJ.GT.49) GO TO 35
      JT=JJ-39
      DO 20 I=1,2
   20 LFIELD=LFIELD+JFIELD(JANG,3*I,IPHIS(I,JT),IBFS(I,JT))
      DO 30 I=3,11
   30 LFIELD=LFIELD+JFIELD(JANG,3*I,IPHISS(I-2),IBFS(I,JT))
      RETURN
   35 IF(JJ.GT.78) RETURN
      JT=JJ-49
      DO 40 I=1,2
   40 LFIELD=LFIELD+JFIELD(JANG,3*I,IPHIT(I,JT),IBFT(I,JT))
      RETURN
      END

C$PROG PROMPT    - Displays "prompt" for keyboard input
C
      SUBROUTINE PROMPT
C
      IMPLICIT NONE
C
      WRITE(6,10)
C
   10 FORMAT(' JBPFIELD->',$)
C
      RETURN
      END

