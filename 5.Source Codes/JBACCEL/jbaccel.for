C$PROG JBACCEL
C
C     Modified version of TCACCEL program 
C      Generates plot file, but eliminates on-line plotting
C       Requires modified version of ACCEL, ACCELNIT, SPLOT and PLTDEE  
C         J. Ball    25-Jan-2005       Date of latest mod: 26-Apr-2005
C
C     This version was further modified to run on a PC with MS FORTRAN
C       This version now generates ORIC field internally if needed
C       Latest version changes output list to include additional diag.
C      
C         J. Ball    30-Mar-2006       Date of latest mod: 21-May-2007
C
      COMMON /LIN/LDNB,NPOS,CUR(23)
      COMMON /RIP1/LTERM,LASTER,LGRED,NXT
      COMMON /PART/Q,AM2,S
      COMMON /SCRAA/YFIT(2522)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /FEQOR/ALPHA,VV
      COMMON /STOREB/LDF,JOFF
      COMMON /ANGSTR/ROB(181),VOB(181)
      COMMON /LOWCH/REN,REX,AIIN,AIOUT
      COMMON /ORBPRM/SA(4,2),LAB(4,2)
      COMMON /EXTFLD/BFC(78),KEXTRC
      COMMON /PRNORB/APARM(5),NPRINT
      COMMON /TIMM/DAT(4),DTM(8)
      COMMON /VERS/VNUM,PRMID
      DIMENSION PROG(2),TPROG(8),YI(5),Y(5),INWORD(20)
C
      DOUBLE PRECISION YI,Y
C
      INTEGER*4 DTM
      CHARACTER*8  CPROG,VNUM,PRMID*32
      CHARACTER*32 CTPROG
      EQUIVALENCE (CPROG,PROG),(CTPROG,TPROG),(CIDPLT,IDPLT)
      DATA CPROG/'JBACCEL '/
      DATA CTPROG/'ORIC ACCELERATION PROGRAM       '/
      DATA VNUM/'v.052107'/   !version number (date) for this program
C
   10 WRITE(6,*)' *** Begin Program JBACCEL ***'
C
      CALL ACCELNIT
C
      PRMID='                                '
      LDF=10
      LGRED=4
C
      CALL SETSWT
      CALL ACCELOPT
C
      READ(8,20) EFI
   20 FORMAT(2F10.0)
C
      CALL SETUP(PHINIT,JSYM,IA,JHARM)
      CALL ORBRAD(EE,AM1,FREQ,HA,RE,BETA,YFIT(2237))
      CALL HEADER(PROG,TPROG,PHINIT,JSYM,IA,JHARM)
      CALL CFIELD
      CALL SSWTCH(15,NDIREC)
      CALL GORBPM(EST,R,DR,TO,EFI,NDIREC,PROG)
C
      NDIREC=-3+2*NDIREC
      IF(NDIREC.EQ.1) EFI=SA(3,1)
C
      Q=-Z1
      YI(1)=R
      YI(2)=DR
      YI(3)=-TO
      YI(5)=0.0
      YI(4)=0.0
C
      CALL EXTRAK(CUR(1),REN,REX,AIIN,AIOUT,ROB)
      CALL ZODDHM
C
      KEXTRC=2
      CALL CALFLD
C
      CALL SPLOT(0.0,0.0,0,-99)  !dummy call to set SPLOT continue flag
   30 WRITE(11,4030)PRMID        !now output header for plot file
 4030 FORMAT(1X,'ORBIT PLOT DATA FOR PARAMETER SET ',A\)
   31 WRITE(11,4031)DTM(2),DTM(3),DTM(1),DTM(5),DTM(6),DTM(7),
     1  DTM(8)/100
 4031 FORMAT(5X,2(I2.2,'/'),I4,2X,2(I2.2,':'),I2.2,'.',I1)
   32 WRITE(11,4032)
 4032 FORMAT(1X,'ORBIT #     X(IN)     Y(IN)')
C
      CALL PLTDEE
      CALL PLTLC
C
      DO 40 I=1,181
      AN=FLOAT(I-1)*0.03490659
      ROB(I)=DCOS(DBLE(AN))
      VOB(I)=DSIN(DBLE(AN))
   40 CONTINUE
C
      TO=0.0
      WRITE(15,60)
   60 FORMAT(/1X,'ORBIT',3X,'RADIUS',6X,'BETA-R',4X,'ENERGY',
     *  5X,'PHASE',4X,'PERIOD',4X,'R-CEN',3X,'THET-CEN',
     *  4X,'AVRAD',4X,'DAVRAD',4X,'DRAD',3X,'RAD/rtE')
      NPRINT=0
C
   80 CALL ACCEL(YI,Y,EST,EFI,TO,NDIREC)
C
      WRITE(15,100)
  100 FORMAT(1X,113('-'))
      NPRINT=0
C
      WRITE(6,*)' *** End Program JBACCEL ***'
      STOP '  '
      END

C$PROG ACCEL
      SUBROUTINE ACCEL(YI,Y,EST,EFI,TO,NDIREC)
C
C     Modified for use with JBACCEL program
C      Eliminates on-line plotting calls
C       Generates plot file with orbit number and X-Y coordinates
C        Also outputs average radius and radius gain for each orbit
C         J. Ball    2/5/05          Date of latest mod: 9-May-2005
C
C
C        ACCELERATION PROGRAM: CALCULATES ORBIT AND PLOTS PARTICLE
C        PATH FOR PARTICLE STARTING WITH INITIAL ENERGY EST AND END-
C        ING WITH ENERGY EFI.
C        ALSO PROVIDES LISTING OF ORBIT PARAMETERS FOR EACH ORBIT AT
C        90 DEG POINT.
C        IF NDIREC=+1, PARTICLE IS ACCELERATED OUTWARD TOWARD
C                      EXTRACTION
C                  -1, PARTICLE IS DECCELERATED INWARD.
C
      COMMON /CONT/NSK(3),NSKIP,NTK(2)
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /ANGSTR/CO(181),SI(181)
      COMMON /PART/Q,AM2,S
      COMMON /PRNORB/RMIN,RMAX,ANGSTP,ANGMIN,ANGMAX,NPRINT
C
      DIMENSION YI(5),Y(5)
      DOUBLE PRECISION YI,Y,YTIM,YSTOR(2)
      EXTERNAL FACCEL
C
      NE=5
      NORB=0
      EET=EST
      EBMP=VDEE*Z1*0.001
      SIG=-NDIREC
      NSKIP=0
      NSTEP=1
      YF=1.0D-06/FREQ/HA
      NP=0
      YTIM=YI(3)
C
      DO 10 I=1,NE
      Y(I)=YI(I)
   10 CONTINUE
C
      W=FLOAT(NDIREC)*4.0
      Q=0.0
      CALL KICK(EET,Y(3),TO,NORB)
      Q=FLOAT(NDIREC)*Z1
      VDEE=FLOAT(NDIREC)*VDEE
      BRP=Y(2)*2.54/3.0E+10
      PH=-(Y(3)-TO)*FREQ*1.0D+06*360.*HA
      PH=PH/HA
      IF(NPRINT.EQ.1) GO TO 20
C
Cjbb            - don't print this data until other properties 
Cjbb              of this orbit are calculated
Cjbb    WRITE(15,3000) NORB,Y(1),BRP,EET,PH
C
      XX=Y(1)*CO(46)
      YY=Y(1)*SI(46)
      CALL SPLOT(XX,YY,0,NORB)
Cjbb            - save first radius for orbit 0 averaging
      BEGRAD=Y(1)
C
   20 XI=90.
      Y(4)=0.0
      Y(5)=0.0
Cjbb
Cjbb            - need to save orbit data here to print later
Cjbb              after average orbit properties are determined 
      NORBT=NORB
      Y1T=Y(1)
      BRPT=BRP
      EETT=EET
      PHT=PH
      ROVRTE=Y1T/SQRT(EETT)     !orbit diagnostic quantity to print
Cjbb            - set up to get average radius for next orbit
      SUMRAD=BEGRAD
Cjbb            - start of orbit calculation loop
      DO 35 I=1,2
      VDEE=-VDEE
      IF(NDIREC.EQ.1) GO TO 25
Cjbb            - if accelerating backwards, kick at this point
      CALL KICK(EET,Y(3),TO,NORB)
      YSTOR(I)=Y(3)
Cjbb            - calculate orbit through 180 degrees
   25 DO 30 J=1,45
      CALL QKUTTA(FACCEL,NE,XI,NSTEP,W,Y)
      IF(NSKIP.NE.0) GO TO 50
C
      L=IFIX(XI)/2+180
      L=MOD(L,180)+1
      IF(NPRINT.EQ.1) GO TO 28
C
      XX=Y(1)*CO(L)
      YY=Y(1)*SI(L)
Cjbb            - to get consistency between the .prn file output and
Cjbb              the orbit plot output, the last point that is
Cjbb              calculated in this loop is really the first point of
Cjbb              the next orbit.  The next lines correct this for the
Cjbb              the plot file output.  A formatting change was made 
Cjbb              to the .prn file output to more accurately reflect
Cjbb              which orbits the results refer to.  This has now been
Cjbb              replaced by saving some results until everything for 
Cjbb              a given orbit can be printed on the same line.
      IF(I.EQ.2.AND.J.EQ.45) THEN
        CALL SPLOT(XX,YY,1,NORB+1)
        BEGRAD=Y(1)
      ELSE
        CALL SPLOT(XX,YY,1,NORB)
        SUMRAD=SUMRAD+Y(1)
      END IF
      GO TO 30
C
   28 IF(J+I.EQ.2) IPSTAT=1
      IF(J+I.EQ.2.AND.(Y(1).LT.RMIN.OR.Y(1).GT.RMAX)) IPSTAT=0
      IF(IPSTAT.EQ.0) GO TO 30
C
      XITM=XI+360.
      XITM=AMOD(XITM,360.)
      IF(XITM.LT.ANGMIN.OR.XITM.GT.ANGMAX) GO TO 30
C
      IF(AMOD(XITM+2.0,ANGSTP).NE.0.0)     GO TO 30
C
      BRP=Y(2)*2.54/3.0E+10
      NORBTM=NORB+1
C
      WRITE(15,3050) NORBTM,XITM,Y(1),BRP
 3050 FORMAT(1X,I4,F10.0,F10.3,E12.4)
C
   30 CONTINUE
C
      IF(NDIREC.EQ.-1) GO TO 35
Cjbb            - if accelerating forwards, kick at this point
      CALL KICK(EET,Y(3),TO,-NORB)
      YSTOR(I)=Y(3)
C
   35 CONTINUE
C
      AVRAD=SUMRAD/90
      IF(NORB.EQ.0) THEN
        DAVRAD=0
        DRAD=0
      ELSE
        DAVRAD=AVRAD-PREVAV
        DRAD=Y1T-PREVR
      END IF
      PREVAV=AVRAD
      PREVR=Y1T
C
      PH1=-(YSTOR(2)-TO)*FREQ*1.0D+06*HA+FLOAT(-NDIREC*NORB)+
     &   0.5*FLOAT(-NDIREC)-0.25*FLOAT(1+NDIREC)
C
      PH2=-(YSTOR(1)-TO)*FREQ*1.0D+06*HA+FLOAT(-NDIREC*NORB)
     &   -0.25*FLOAT(1+NDIREC)
C
      NORB=NORB+1
      TPH=PH1+PH2
      TPH=SIGN(1.0,TPH)
      PH1=COS(6.283185*PH1/HA)
      PH2=COS(6.283185*PH2/HA)
      PH=TPH*ACOS((PH1+PH2)/2.0)*57.29578
      YTIM=DABS((Y(3)-YTIM)/YF)
      RCEN=SQRT(Y(4)*Y(4)+Y(5)*Y(5))
      TCEN=ATAN2(SIG*Y(5),SIG*Y(4))*57.29578
      IF(TCEN.LT.0.0) TCEN=TCEN+360   !get theta in correct quadrant
      BRP=Y(2)*2.54/3.0E+10
C
C     WRITE(6,3000) NORB,Y(1),BRP,EET,PH,YTIM,RCEN
C
      IF(NPRINT.EQ.0) WRITE(15,3000) NORBT,Y1T,BRPT,EETT,PHT,
     &   YTIM,RCEN,TCEN,AVRAD,DAVRAD,DRAD,ROVRTE
C
      YTIM=Y(3)
C
 3000 FORMAT(1X,I4,F10.3,E12.4,2F10.3,F10.5,F9.3,
     *  F10.2,F10.3,F10.4,F8.3,F10.4)
C
      CALL SSWTCH(14,LSTAT)
      IF(LSTAT.EQ.1) GO TO 40
C
      IF(NDIREC.EQ.-1.AND.EET.GT.EFI+EBMP) GO TO 20
      IF(NDIREC.EQ.1.AND.EET.LT.EFI-EBMP)  GO TO 20
C
   40 VDEE=ABS(VDEE)
C
      IF(NPRINT.EQ.0) GO TO 45
C
      WRITE(6,3060)
 3060 FORMAT(' FINISHED PRINTING***')
   45 RETURN
C
   50 IF(NSKIP.EQ.1) WRITE(15,3020) NORB,XI,Y,EET
C
 3020 FORMAT(1X,'*** PARTICLE ORBIT OUT OF CYCLOTRON--',
     &  I4,7E12.5)
      RETURN
      END

C$PROG ACCELNIT  - Opens files, etc for JBACCEL
C
C     Modified for use with JBACCEL program
C         J. Ball    1/26/05          Date of latest mod: 27-Apr-2006
C
      SUBROUTINE ACCELNIT
C
      IMPLICIT NONE
C
C     ----------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      COMMON/TIMM/DAT(4),DTM(8)
      INTEGER*4 MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      INTEGER*4 IOS,I,DTM,DAT
      CHARACTER*112 CMSSG
      EQUIVALENCE (CMSSG,MSSG)
C     ----------------------------------------------------------------
C
      DO 10 I=1,28
      MSSG(I)='    '
   10 CONTINUE
      NAMPROG(1)='JBAC'
      NAMPROG(2)='CEL '
      MSGF='    '
      LISFLG='LON '
      LOGUT=6
      LOGUP=14
C
      OPEN(UNIT       = 14,
     &     FILE       = 'jbaccel.log',
     &     STATUS     = 'UNKNOWN',
     &     ACCESS     = 'APPEND',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 100
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
     &     FILE       = 'jbaccel.int',
     &     STATUS     = 'OLD',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 110
C
      OPEN(UNIT       = 9,
     &     FILE       = 'tcmagprm.bin',
     &     STATUS     = 'OLD',
     &     ACCESS     = 'DIRECT',
     &     MODE       = 'READ',
     &     RECL       = 256,
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 120
C
      OPEN(UNIT       = 11,
     &     FILE       ='jbplot.txt',
     &     STATUS     ='UNKNOWN',
     &     IOSTAT     =IOS)
C
      CLOSE(UNIT      = 11,
     &      STATUS    = 'DELETE')
C
      OPEN(UNIT       = 11,
     &     FILE       ='jbplot.txt',
     &     STATUS     ='NEW',
     &     IOSTAT     =IOS)
C
      OPEN(UNIT       = 15,
     &     FILE       = 'jbaccel.prn',
     &     STATUS     = 'UNKNOWN',
     &     IOSTAT     = IOS)
C
      CLOSE(UNIT      = 15,
     &      STATUS    = 'DELETE')
C
      OPEN(UNIT       = 15,
     &     FILE       = 'jbaccel.prn',
     &     STATUS     = 'NEW',
     &     IOSTAT     = IOS)
C
C
      RETURN
C
C     ******************************************************************
C     Output error messages and terminate run - rewritten 4/9/06
C     ******************************************************************
C
  100 WRITE(CMSSG,4100)
 4100 FORMAT('attempting to open - jbaccel.log')
      GO TO 200
C
  105 WRITE(CMSSG,4105)
 4105 FORMAT('attempting to open - tcisoc.car')
      GO TO 200
C
  110 WRITE(CMSSG,4110)
 4110 FORMAT('attempting to open - jbaccel.int')
      GO TO 200
C
  120 WRITE(CMSSG,4120)
 4120 FORMAT('attempting to open - tcmagprm.bin')
      GO TO 200
C
  200 WRITE(LOGUP,4200)IOS,CMSSG
 4200 FORMAT(1X,'---'/1X,'File opening error in subroutine ACCELNIT',
     1  10X,'Error #',I4/1X,'Failed while ',A40)
      WRITE(LOGUT,4200)IOS,CMSSG
      STOP
      END

C$PROG ACCELOPT  - Inputs run-time options for JBACCEL
C
C     Replaces the old command line options so that running from a
C     command line is not required to select an option
C
C     J. Ball   10-Oct-2006          Date of latest mod: 10-Oct-2006
C
      SUBROUTINE ACCELOPT
C
      IMPLICIT NONE
C
      INTEGER*4 KSEL
      CHARACTER AKSEL*1
C
  100 WRITE(6,4100)
 4100 FORMAT(/2X,'JBACCEL OPTIONS: ',
     1  '1) Accelerate beam from center outwards (default)'/19X,
     2  '2) Decelerate beam from extraction inwards'//4X,
     3  'SELECT OPTION: ',$)
C
  110 READ(5,4110) AKSEL
 4110 FORMAT(A1)
      IF(LEN_TRIM(AKSEL).EQ.0) THEN
        CALL SETSSW(15,2)
        GO TO 200
      END IF
C
      KSEL=ICHAR(AKSEL)-48
      IF(KSEL.EQ.2) THEN
        CALL SETSSW(15,1)
      ELSE
        CALL SETSSW(15,2)
      END IF
C
  200 RETURN      
      END

C$PROG CFIELD    - Creates file on disk to hold field mesh
C
C     9/28/05  -  Modified by JBB to allow override and force using 
C           existing file field even though identifiers don't match.  
C           For use with the JBACCEL program.
C
C     4/09/06  -  output of error message rewritten
C
C     5/23/06  -  activated option to generate new field if needed
C 
      SUBROUTINE CFIELD
C
C     ------------------------------------------------------------------
      COMMON/LLL/ MSSG(28),NAMPROG(2),LOGUT,LOGUP,LISFLG,MSGF
      INTEGER*4   MSSG,NAMPROG,LOGUT,LOGUP,LISFLG,MSGF
      CHARACTER*112 CMSSG
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
C     IF FILE ALREADY EXISTS, CHECK FIELD IDENTIFIER AGAINST PRESENT
C     IDENTIFIER FROM TCISOC.CAR. IF DIFFERENT SET JOFF=0, SETTING
C     FLAG TO CALCULATE NEW FIELD MESH.
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
C     Now offer user the option to override generating a new file
C
  118 IF(JOFF.NE.0) GO TO 150
  120 WRITE(6,4120)
 4120 FORMAT(/' *** TCFIELD.BIN DATE DOES NOT MATCH TCISOC.CAR ***'//,
     1  ' OPTIONS: 1) Generate new tcfield.bin file (default)'/9X,
     2  ' 2) Override default and use existing tcfield.bin file',/
     3  ' SELECT OPTION: ',$)
  122 READ(5,4122) KSEL
 4122 FORMAT(I1)
      WRITE(*,*)'  '    !blank line for output formatting
C
      IF(KSEL.EQ.1) THEN
        JOFF=0    !this forces calculating new field data
      ELSE
        JOFF=10   !this forces use of existing field data
      END IF
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

C$PROG FLUSHIT   - Flushes plot-command buffer
C
C     ************************************************************
C     BY WT MILNER AT HHIRF - LAST MODIFIED 07/23/90
C     ************************************************************
C
      SUBROUTINE FLUSHIT
C
Cjbb   - used to flush buffer; now just write separator
C
      CALL SPLOT(0.0,0.0,-1,0)
C
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
C         J. Ball     3-Apr-2006       Date of latest mod: 10-Oct-2006
C
C     10/10/06 - did away with command line options.  Replaced with
C                subroutine ACCOPT so don't have to run from DOS prompt
C
      COMMON /KINE/EE,AM1,Z1,RE,FREQ,VDEE,HA,EINJ,RINJ,ZINJ
      COMMON /TIMM/DAT(4),DTM(8)
      COMMON /VERS/VNUM,PRMID
      DIMENSION PROG(2),A(8)
      INTEGER DTM,DTMP,DTM1
      CHARACTER DUM*12,PRMID*32,DTFIL*16,CC*1,CS*1,VNUM*8,ET*8
C Declare DAT a character string -EjP 20230706
      CHARACTER DAT*4
      
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


C$PROG PLTDEE
      SUBROUTINE PLTDEE
C
C        PLOT DEE STRUCTURE.
C
C     Modified for use with JBACCEL program
C      Plots only outline of dee - omits stuff of interest to coupled
C       operation. Note that the plot ID for the dee structure is -13
C         J. Ball    1/27/05          Date of latest mod: 5-Feb-2005
C
      XT(TANG)=RR*COS(TANG)+X0
      YT(TANG)=RR*SIN(TANG)+Y0
      RR=34.69
      X0=0.0
      Y0=0.0
      CALL SPLOT(92.562,25.235,0,-13)
      CALL SPLOT(38.691,16.823,1,-13)
      DO 10 I=1,31
      ANG=0.501782+FLOAT(I-1)*0.034587
   10 CALL SPLOT(XT(ANG),YT(ANG),1,-13)
      DO 20 I=1,31
      ANG=-0.501782+FLOAT(I-31)*0.034587
   20 CALL SPLOT(XT(ANG),YT(ANG),1,-13)
      CALL SPLOT(38.691,-16.823,1,-13)
      CALL SPLOT(92.562,-25.235,1,-13)
Cjbb
Cjbb  this is end of data for the dee outline
Cjbb  so send plot break and end here
Cjbb
      CALL SPLOT(0.0,0.0,0,-13)
   50 RETURN
      END

C$PROG PLTLC
      SUBROUTINE PLTLC
C
C       PLOT LOWER CHANNEL OUTLINE
C
C       Note that the plot ID for the dee structure is -17
C         J. Ball    4-Apr-2007       Date of latest mod: 4/4/07
C
      REAL LCX(27),LCY(27)
      DATA LCX/-36.692,-32.943,-30.971,-30.455,-29.882,-29.255,
     1  -28.573,-27.837,-27.048,-26.208,-25.317,-24.376,-23.387,
     2  -22.350,-21.268,-20.140,-19.842,-24.395,-25.603,-26.759,
     3  -27.863,-28.913,-35.000,-35.580,-36.015,-36.386,-36.692/
      DATA LCY/-3.645,-3.014,-7.757,-9.368,-10.961,-12.533,
     1  -14.082,-15.606,-17.104,-18.573,-20.012,-21.419,-22.792,
     2  -24.130,-25.431,-26.693,-27.013,-31.115,-29.668,-28.181,
     3  -26.653,-25.089,-20.000,-9.155,-7.332,-5.494,-3.645/
C
      DO 10 I=1,27
   10 CALL SPLOT(LCX(I),LCY(I),1,-17)
C
C       send plot break to mark end of LC data
C
      CALL SPLOT(0.0,0.0,0,-17)
   20 RETURN
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
   10 FORMAT(' JBACCEL->',$)
C
      RETURN
      END


C$PROG SPLOT     - Replaces TC's SPLOT
C
C     Modified for use with JBACCEL program
C      Eliminates call to on-line plotting subroutine
C       Generates plot file with orbit number or element ID in first 
C        of three fields per point
C           J. Ball    1/26/05          Date of latest mod: 9-May-2006
C
C      5/9/06 - changed from binary output file to text file
C
      SUBROUTINE SPLOT(X,Y,I,J)
C
      DATA NCALL/0/
C
      IF(NCALL.GT.0) GO TO 100
C
      I=0     !this argument not used here, but reserved for future
              !use as a pen-up/pen-down indicator
C
      NCALL=1
      REWIND 11
C
  100 IF(J.NE.-99)WRITE(11,4100)J,X,Y   !don't print dummy call from MAIN
 4100 FORMAT(1X,I7,2F10.5)
C
      RETURN
      END


