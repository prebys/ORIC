C$PROG JBFLDMAN
C
C   JBFLDMAN - Field file manipulation program
C
C   This is a major revision of the original JB3DPLOT program written 
C     for the DEC Alpha to convert polar coordinate magnet field data
C     to a Cartesian plot.  This version offers many more options in 
C     manipulating the data in both polar and Cartesian form, including
C     those found in the JBFLDLIS and JBFLDGEN programs which transform
C     from and to the binary field file used by the orbit programs.
C
C   In polar and Cartesian files that are utilized by this program, an
C     ID field is the first 10 characters of the file (position 1,1 in
C     the plot matrix) with format (1A,I4,I5).  The first character is
C     either a "P" or a "C" designating a polar or Cartesian plot.  
C     The next entry is the number of radii in the array.  The last 
C     entry is the number of rows in the array.
C
C   A polar plot must have radii in steps of 1 inch, but may have angle
C     steps of 1, 2, etc., degrees.  The total number of angular steps 
C     must be specified in the plot ID field.  For a “full” polar plot
C     the range of radii should be from 0 to 59 degrees.
C
C     NOTE: When plotting the polar output in EXCEL, declare the data
C           in columns. (X-axis values are then the angle values in
C           the first column.)
C
C   Cartesian grid orientation is that 0 degrees is on the horizontal
C     axis, pointing to the right and 90 degrees is on the vertical 
C     axis, pointing up.  (I.e., the orientation of the ORIC magnet as 
C     viewed from the control room side.)
C
C     NOTE: When plotting the Cartesian output in EXCEL, declare the 
C           data in rows. (X-axis values are then in the first row.)
C  
C     J. Ball      26-Feb-05        Date of latest revision: 03/01/07
C
      IMPLICIT NONE
C
      REAL*4 THG,TH1,TH2,RG,R1,R2,BTH1R1,BTH1R2,BTH2R1,BTH2R2
      REAL*4 BTH1,BTH2,SSQXY,X,Y,JATN,RTRIM,SF1,SF2
      REAL*4 PPBFLD(0:59,0:360),B(60)
      REAL*4 BG(-70:70),PBFLD(0:101,0:360),CF1(-70:70),CF2(-70:70)
      INTEGER*4 KSEL,IOS,IRAD,IR1,IR2,ITH,ITH1,ITH2,IX,IY,ICSZ,MCG
      INTEGER*4 IDUM,IDUM2,IDRAD,ISTEP,NRAD,NRAD2,I,II,J,LDF,IR
      INTEGER*4 NTH,NTH2,INIRAD,INITH,IDTH,KF,ITHINC,N,NREC,IREC
      INTEGER*4 NTRAD,NTTH,BUF(64),DAT(4),IB(60,181),IDUM3
      CHARACTER*15 PFNAME1,PFNAME2,PFNAME3,CFNAME1,CFNAME2,CFNAME3
      CHARACTER*15 BFNAME
      CHARACTER*1 PLTYP,CPLT,PPLT,AKSEL
C             
      CPLT="C"
      PPLT="P"
      WRITE(6,4000)
 4000 FORMAT(/' Begin Program JBFLDMAN')
C
   10 CLOSE (7)     !make sure all files are closed before selection
      CLOSE (11)    !mainly needed if backing up into options after
      CLOSE (12)    !already opening a file
      ICSZ=81       !make sure default Cartesian grid size is reset
   12 WRITE(6,4012)
 4012 FORMAT(//6X,'OPTIONS: ',
     1  '1) Convert binary field file to polar plot file'/15X,
     2  '2) Convert partial polar field to full polar plot file'/15X,
     3  '3) Generate sum or difference of two polar plot files'/15X,
     4  '4) Convert polar plot file to binary field file'/15X,
     5  '5) Convert polar plot file to Cartesian plot file'/15X,
     6  '6) Generate sum or difference of two Cartesian plot files'/15X,
     7  '7) Trim Cartesian plot file beyond specified radius'/15X,
     8  '8) Exit program'//6X,
     9  'SELECT OPTION: ',$)
   20 READ(5,4020) AKSEL
 4020 FORMAT(A1)
      KSEL=ICHAR(AKSEL)-48
      IF(KSEL.EQ.1) GO TO 100
      IF(KSEL.EQ.2) GO TO 200
      IF(KSEL.EQ.3) GO TO 300
      IF(KSEL.EQ.4) GO TO 400
      IF(KSEL.EQ.5) GO TO 500
      IF(KSEL.EQ.6) GO TO 600
      IF(KSEL.EQ.7) GO TO 800
      IF(KSEL.EQ.8) GO TO 900

      GO TO 10
C
C     =========================  OPTION 1  =========================
C
  100 LDF=10                !define and open the binary field file
      BFNAME='tcfield.bin'
C
      OPEN(UNIT       = LDF,
     &     FILE       = BFNAME,
     &     STATUS     = 'OLD',
     &     ACCESS     = 'DIRECT',
     &     RECL       = 256,
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) GO TO 190
C
      REWIND(LDF)
      NREC=1
  102 READ(LDF,REC=NREC,IOSTAT=IOS)BUF
      IF(IOS.NE.0) GO TO 192
C
      DO 104 I=1,4    !set date and time array to zero
  104 DAT(I)=BUF(I)
C
  106 DO 110 I=1,60    !set field array elements to zero
      DO 108 J=1,181
  108 IB(I,J)=0
  110 CONTINUE
C 
C     now read in the field data (2 deg increments per radius)
C
      NTH=180
      IRAD=1
  114 II=0
  116 NREC=NREC+1
      READ(LDF,REC=NREC,IOSTAT=IOS) BUF
C
      IF(IOS.NE.0) GO TO 130
C
      DO 120 N=1,64
      II=II+1
      IB(IRAD,II)=BUF(N)
  120 IF(II.GE.NTH) GO TO 124
      GO TO 116
  124 IRAD=IRAD+1
      GO TO 114
C                   finished reading file, so clean up parameters
  130 NREC=NREC-1
      NRAD=IRAD-1
  132 WRITE(6,4132) NREC-1
 4132 FORMAT(/'     Number of field data records read = ',I4)
      CLOSE(LDF)
C
C           for plotting purposes we need the plot data to go from
C           0 to 360 degrees  -  the following duplicates the data
C           at zero degrees at the array position for 360 degrees.
C
      DO 136 I=1,NRAD
  136 IB(I,181)=IB(I,1)
C
C           now generate the polar file of the field data
C
  140 WRITE(6,4140)
 4140 FORMAT(/'     Input name for data file to be generated: ',$)
  142 READ(5,4142) PFNAME1
 4142 FORMAT(A)
      IF(LEN_TRIM(PFNAME1).EQ.0) GO TO 194
C
  144 OPEN(UNIT   = 12,
     &     FILE   = PFNAME1,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
C
      IF(IOS.EQ.0) GO TO 150
C                            ! if error, assume file already exists
  146 WRITE(6,4146) PFNAME1
 4146 FORMAT(/' ### File ',A,' already exists!  Overwrite (Y/N)? ',$)
  148 READ(5,4148) KF
 4148 FORMAT(A1)
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 12,
     &       FILE   = PFNAME1,
     &       STATUS = 'OLD',
     &       IOSTAT = IOS)
      ELSE
        GO TO 140
      END IF
C
  150 WRITE(12,4150) PPLT,60,181,(IRAD,IRAD=0,59),(DAT(I),I=1,4)
 4150 FORMAT(A1,I4,I5,60I10,4A4)
C
      DO 160 J=1,181
      ITH=2*(J-1)
      DO 156 I=1,60
  156 B(I)=FLOAT(IB(I,J))/100000.0
  160 WRITE(12,4160) ITH,(B(I),I=1,60)
 4160 FORMAT(I10,60F10.4)
C
  164 WRITE(6,4164) PFNAME1
 4164 FORMAT(/' **** Finished generating polar field file ',A//)
      CLOSE(12)
      GO TO 10
C
  190 WRITE(6,4190) BFNAME,IOS
 4190 FORMAT(/' !!! CANNOT OPEN FILE ',A,'   ERROR #',I4)
      GO TO 194
  192 WRITE(6,4192)
 4192 FORMAT(/' !!! ERROR READING HEADER FILE OF ',A,
     1  '     ERROR NO.',I6/)
  194 WRITE (6,4194)
 4194 FORMAT(/' !!! TASK ABORTED !!!'//)
C
      GO TO 10
C
C     =========================  OPTION 2  =========================
C
  200 WRITE(6,4200)
 4200 FORMAT(/' Input name of partial polar field file: ',$)
  202 READ(5,4202) PFNAME1
 4202 FORMAT(A)
      IF(LEN_TRIM(PFNAME1).EQ.0) GO TO 10
C
      OPEN(UNIT    = 11,
     &     FILE    = PFNAME1,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) GO TO 206
  204 WRITE(6,4190) PFNAME1,IOS   !cannot open file message
      GO TO 200
C
  206 READ(11,4150)PLTYP,NRAD,NTH,IDUM,IDUM2,IDUM3
      WRITE(*,4150)PLTYP,NRAD,NTH,IDUM,IDUM2,IDUM3
      IF(PLTYP.NE.PPLT) THEN
  208   WRITE(6,4208) PFNAME1
 4208   FORMAT(/1X,'!!! ',A,' NOT MARKED AS A POLAR PLOT !!!')
        GO TO 200
      ELSE     !read array parameters for partial radial field
        INIRAD=IDUM          !initial radius of partial array
        IF(NRAD.GT.60) NRAD=60
        IF(NTH.GT.361) NTH=361
        IDRAD=IDUM2-IDUM    !value for radius increment
        IF(IDRAD.NE.1) THEN
  210     WRITE(6,4210)IDUM,IDUM2
 4210     FORMAT(1X,'!!Data error – radial increment not = 1',
     1    /14X,'- first two radii are',I3,' and',I3,
     2    /1X,'!!Check input data for incorrect formatting!!',/)
          GO TO 200
        END IF
  212   READ(11,4212) IDUM
 4212   FORMAT(I10)
  214   READ(11,4212) IDUM2
        INITH=IDUM         !initial angle of partial array
        IDTH=IDUM2-IDUM    !value for angle increment
      END IF
C
C - set full polar field array to 0
      NTH2=(360/IDTH)+1    !number of angles from 0 to 360
      DO 222 ITH=0,NTH2-1
      DO 220 IRAD=0,59
  220 PBFLD(IRAD,ITH)=0.0
  222 CONTINUE
C
C – read field values for the partial array into full array
      REWIND 11
  228 READ(11,4150) PLTYP,NRAD,NTH
      DO 240 ITH=0,NTH-1
  230 READ(11,4160) IDUM,(PPBFLD(IRAD,ITH),IRAD=0,NRAD-1)
      DO 234 IRAD=0,NRAD-1
      ITHINC=INITH/IDTH
  234 PBFLD(IRAD+INIRAD,ITH+ITHINC)=PPBFLD(IRAD,ITH)
  240 CONTINUE
C
C – write out the full array
  250 WRITE(6,4250)
 4250 FORMAT(/' Input name for full polar field plot: ',$)
  252 READ(5,4202) PFNAME2
      IF(LEN_TRIM(PFNAME2).EQ.0) GO TO 200
C – first open the the output file
      OPEN(UNIT    = 7,
     &     FILE    = PFNAME2,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
      IF(IOS.EQ.0) GO TO 268
C – assume error is because file already exists
  260 WRITE(6,4146) PFNAME2
  262 READ(5,4142) KF
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 7,
     &       FILE   = PFNAME2,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 250
      END IF
  268 CALL MDTSTAMP(DAT)   !get time stamp for file
C – now write the full array to file
  270 WRITE(7,4150)PPLT,60,NTH2,(IRAD,IRAD=0,59),
     1  (DAT(I),I=1,4)
      ITH2=-IDTH          !preset for calculating array angles
      DO 280 ITH=0,NTH2-1
      ITH2=ITH2+IDTH
  280 WRITE(7,4160) ITH2,(PBFLD(IRAD,ITH),IRAD=0,59)
C
  290 WRITE(6,4290) PFNAME2
 4290 FORMAT(/' **** New POLAR FIELD PLOT written to ',A)
      CLOSE(11)
      CLOSE(7)
      GO TO 10
C
C     =========================  OPTION 3  =========================
C
  300 WRITE(6,4300)
 4300 FORMAT(/' Input name of first polar plot file: ',$)
  302 READ(5,4202) PFNAME1
      IF(LEN_TRIM(PFNAME1).EQ.0) GO TO 10
C
      OPEN(UNIT    = 11,
     &     FILE    = PFNAME1,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) GO TO 306
  304 WRITE(6,4190) PFNAME1,IOS    !cannot open file message
      GO TO 300
C
  306 READ(11,4150)PLTYP,NRAD,NTH
      IF(PLTYP.NE.PPLT) THEN
  308   WRITE(6,4208) PFNAME1    !not marked as polar plot message
        GO TO 300
      END IF
C
  310 WRITE(6,4310)
 4310 FORMAT(/' Input name of second polar plot file: ',$)
  312 READ(5,4202) PFNAME2
      IF(LEN_TRIM(PFNAME2).EQ.0) GO TO 300
C
      OPEN(UNIT    = 12,
     &     FILE    = PFNAME2,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) GO TO 316
  314 WRITE(6,4190) PFNAME2,IOS    !cannot open file message
      GO TO 310
C
  316 READ(12,4150)PLTYP,NRAD2,NTH2
      IF(PLTYP.NE.PPLT) THEN
  318   WRITE(6,4208) PFNAME2    !not marked as polar plot message
        GO TO 310
      END IF
C
  319 IF(NRAD.NE.NRAD2.OR.NTH.NE.NTH2) THEN
        WRITE(6,4319) NRAD,NRAD2,NTH,NTH2
 4319   FORMAT(/3X,'!!Input plots do not have identical parameters',
     1  /1X,'      NRAD1 =',I3,'   NRAD2 =',I3,6X,'NTH1 =',I4,
     2  '   NTH2 =',I4/3X,'!!This is not a valid case!!'/)
        GO TO 10
      ELSE
        IF(NRAD.GT.60) NRAD=60
        IF(NTH.GT.361) NTH=361
        IDTH=360/(NTH-1)
      END IF
C
  320 WRITE(6,4320)
 4320 FORMAT(/6X,'SUB-OPTIONS: ',
     1  '1) Add second field to first field'/19X,
     2  '2) Subtract second field from first field'/19X,
     3  '3) Subtract first field from second field'//6X,
     4  'SELECT OPTION: ',$)
C
  322 READ(5,4020) AKSEL
 4322 FORMAT(A1)
      IF(LEN_TRIM(AKSEL).EQ.0) GO TO 310
C
  324 KSEL=ICHAR(AKSEL)-48
      SF1=1.0
      SF2=1.0
      IF(KSEL.EQ.1) GO TO 330
      IF(KSEL.EQ.2) THEN
        SF2=-1.0
        GO TO 330
      END IF
      IF(KSEL.EQ.3) THEN
        SF1=-1.0
        GO TO 330
      END IF
      GO TO 320
C  
  330 WRITE(6,4330)
 4330 FORMAT(/' Input name for resultant field plot: ',$)
  332 READ(5,4202) PFNAME3
      IF(LEN_TRIM(PFNAME3).EQ.0) GO TO 320
C
      OPEN(UNIT    = 7,
     &     FILE    = PFNAME3,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
      IF(IOS.EQ.0) GO TO 340
C – assume error is because file already exists
  336 WRITE(6,4146) PFNAME3   !overwrite existing file?
  338 READ(5,4142) KF
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 7,
     &       FILE   = PFNAME3,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 330
      END IF
C

C     read in polar plot data, take difference, and output result
C
  340 REWIND 11
      REWIND 12
C     
C     skip over header record from each input file and then
C     recreate header record for ouput file tansfering the
C     date/time stamp from the first input file
C 
  342 READ(11,4150) PLTYP,NRAD,NTH,(IDUM, IRAD=0,59),(DAT(I),I=1,4) 
  344 READ(12,4150) PLTYP,NRAD,NTH,(IDUM, IRAD=0,59)
  346 WRITE(7,4150) PLTYP,NRAD,NTH,(IRAD, IRAD=0,59),(DAT(I),I=1,4) 
C
      DO 380 ITH=0,360,IDTH    !read in data records
  350 READ(11,4160) IDUM,(PBFLD(IRAD,11), IRAD=0,59)  !use PBFLD array
  352 READ(12,4160) IDUM,(PBFLD(IRAD,12), IRAD=0,59)  !for scratch
C
      DO 360 IRAD=0,59         !perform requested operation
  360 PBFLD(IRAD,7)=SF1*PBFLD(IRAD,11)+SF2*PBFLD(IRAD,12) 
C                              !and write output record
  370 WRITE(7,4160) ITH,( PBFLD(IRAD,7), IRAD=0,59)
  380 CONTINUE
C
  390 WRITE(6,4390) PFNAME3
 4390 FORMAT(/' **** Resultant POLAR FIELD PLOT written to ',A)
      CLOSE(11)
      CLOSE(12)
      CLOSE(7)
      GO TO 10
C
C     =========================  OPTION 4  =========================
C
  400 WRITE(6,4400)
 4400 FORMAT(/' Input name of polar field file to convert: ',$)
  402 READ(5,4142) PFNAME1
      IF(LEN_TRIM(PFNAME1).EQ.0) GO TO 10
C      - open polar field data file
      OPEN(UNIT    = 11,
     &     FILE    = PFNAME1,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) THEN
        GO TO 406
      ELSE
  404   WRITE(6,4190) PFNAME1,IOS    !cannot open file message
        GO TO 400
      END IF
C
C      - get header record info
C
  406 READ(11,4150)PLTYP,NTRAD,NTTH,(IDUM,I=1,60),
     1  (DAT(II),II=1,4)
      IF(PLTYP.NE.PPLT) THEN
  408   WRITE(6,4208) PFNAME1     !not marked as polar plot
        GO TO 400
      ELSE
        ISTEP=360/(NTTH-2)   !calculate angular step from total angles
      END IF
      IF(ISTEP.NE.2) THEN
  410 WRITE(6,4410)
 4410 FORMAT(/' !!! ISTEP MUST = 2, THIS ISTEP =',I4,' !!!'/)
      GO TO 400
      END IF
C
C      - now read in the polar field data needed to make new binary file
C
      DO 420 ITH=0,180
  420 READ(11,4160) IDUM,(PBFLD(IR,ITH),IR=0,59)
C
C      - now open up the binary field file
C
      LDF=10
      BFNAME='tcfield.bin'
C
      OPEN(UNIT       = LDF,
     &     FILE       = BFNAME,
     &     STATUS     = 'UNKNOWN',
     &     ACCESS     = 'DIRECT',
     &     RECL       = 256,
     &     FORM       = 'UNFORMATTED',
     &     IOSTAT     = IOS)
C
      IF(IOS.NE.0) THEN
  430 WRITE(6,4430) BFNAME,IOS
 4430 FORMAT(/' !!! ERROR OPENING ',A,5X,'ERROR NO. ',I6/,
     1  ' !!! THIS TASK ABORTED !!!'//)
      GO TO 10
      END IF
C
C      - first write time/date stamp to first record of binary file
C
      DO 440 I=1,64
  440 BUF(I)=0
      DO 442 I=1,4
  442 BUF(I)=DAT(I)
      IREC=1
      WRITE(LDF,REC=IREC,IOSTAT=IOS) BUF
C
      IF(IOS.EQ.0) GO TO 450
  446 WRITE(6,4446) IREC,BFNAME,IOS
 4446 FORMAT(/' !!! ERROR WRITING RECORD',I4,' FOR FILE ',A,
     1  5X,'ERROR NO. ',I6/,
     2  ' !!! THIS TASK ABORTED !!!'//)
      GO TO 10
C
C      - now write field data to binary file
C
  450 NTH=NTTH-1   !don't include redundant 360 deg point
      NRAD=60
      IR=0
  452 ITH=0
  454 IREC=IREC+1
      DO 456 I=1,64
  456 BUF(I)=0
      DO 460 I=1,64
      IF(ITH.LE.NTH) BUF(I)=IFIX(100000.0*PBFLD(IR,ITH))
      ITH=ITH+1
  460 CONTINUE
      WRITE(LDF,REC=IREC,IOSTAT=IOS) (BUF(I),I=1,64)
      IF(IOS.NE.0) GO TO 446
      IF(ITH.LT.180) GO TO 454
      IR=IR+1
      IF(IR.LE.59) GO TO 452
C
      NREC=IREC-1
  470 WRITE(6,4470) BFNAME,IREC,NREC,NRAD,NTH
 4470 FORMAT(/'    *** New data written to binary field file ',A/
     1        '         Number of records written (IREC) =',I4/
     2        '            Number of data records (NREC) =',I4/
     2        '            Number of radial steps (NRAD) =',I4/
     3        '             Number of angle steps  (NTH) =',I4/
     4        '    *** Option completed!'//)
C     CLOSE(11)
      CLOSE(LDF)
      GO TO 10
C
C     =========================  OPTION 5  =========================
C
  500 WRITE(6,4500)
 4500 FORMAT(/' Input name of polar field file: ',$)
  502 READ(5,4202) PFNAME1
      IF(LEN_TRIM(PFNAME1).EQ.0) GO TO 10
C
      OPEN(UNIT    = 11,
     &     FILE    = PFNAME1,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) GO TO 506
  504 WRITE(6,4190) PFNAME1,IOS   !cannot open file message
      GO TO 500
C
  506 READ(11,4150)PLTYP,NRAD,NTH,IDUM
      IF(PLTYP.NE.PPLT) THEN
        WRITE(6,4208) PFNAME1   !message: not marked as polar plot
        GO TO 500
      END IF
      ISTEP=360/(NTH-1)   !calculate angular step from total angles
      MCG=(ICSZ-1)/2
      IF(IDUM.EQ.0) GO TO 510
C
  508 WRITE(6,4508)PFNAME1(1:LEN_TRIM(PFNAME1))
 4508 FORMAT(/3X,'!!',A,' appears to be a partial polar plot.',
     1 /3X,'!!Run first with option #1 to convert this to full polar.')
      GO TO 10
C
  510 WRITE(6,4510)
 4510 FORMAT(/' Input name for Cartesian field plot: ',$)
  512 READ(5,4202) CFNAME1
      IF(LEN_TRIM(CFNAME1).EQ.0) GO TO 500
C
      OPEN(UNIT    = 7,
     &     FILE    = CFNAME1,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
      IF(IOS.EQ.0) GO TO 516
C – assume error is because file already exists
  514 WRITE(6,4146) CFNAME1   !overwrite existing file?
  515 READ(5,4142) KF
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 7,
     &       FILE   = CFNAME1,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 510
      END IF
C
C     special input when NRAD different than default of 60
C
  516 IF(NRAD.NE.60) THEN
  518 WRITE(6,4518)
 4518 FORMAT(/1X,' WARNING! Number of polar plot radii is not',
     1  ' default value of 60',
     2  /1X,' Input value for maximum Cartesian grid ',
     3  ' dimension (min=20, max=70): ',$)
  519 READ(5,4519) MCG
 4519 FORMAT(I2)
      IF(MCG.LT.20.OR.MCG.GT.70) GO TO 518
      END IF
C
      ICSZ=2*MCG+1
C
C     read in radial grid of magnetic field data
C
  520 DO 524 ITH=0,360,ISTEP
  522 READ(11,4522) IDUM,(PBFLD(IRAD,ITH),IRAD=0,NRAD-1)
 4522 FORMAT(I10,101F10.4)
      IF(ITH.EQ.0.AND.IDUM.NE.0) GO TO 508
  524 CONTINUE
C
C     now start writing out the Cartesian grid
C
      PLTYP=CPLT
  526 WRITE(7,4526) PLTYP,ICSZ,ICSZ,(IX,IX=(-MCG),MCG)
 4526 FORMAT(A1,I4,I5,141I10)
C
C     scan through cartesian grid and interpolate field values 
C     from radial grid
C
      DO 570 IY=-MCG,MCG
      DO 550 IX=-MCG,MCG
      SSQXY=IX**2 + IY**2
      RG=SQRT(SSQXY)
      IR1=RG
      IR2=IR1+1
      IF(IR2.LE.NRAD-1) GO TO 530
      BG(IX)=0.0
      GO TO 550
  530 X=IX
      Y=IY
      THG=JATN(X,Y)
C          make sure angle limits are on ISTEP boundaries
      ITH1=IFIX(THG/FLOAT(ISTEP))*ISTEP
      ITH2=ITH1+ISTEP
C
      TH1=ITH1
      TH2=ITH2
      R1=IR1
      R2=IR2
      BTH1R1=PBFLD(IR1,ITH1)
      BTH1R2=PBFLD(IR2,ITH1)
      BTH2R1=PBFLD(IR1,ITH2)
      BTH2R2=PBFLD(IR2,ITH2)
      BTH1=(RG-R1)*(BTH1R2-BTH1R1)+BTH1R1
      BTH2=(RG-R1)*(BTH2R2-BTH2R1)+BTH2R1
      BG(IX)=((BTH2-BTH1)/(TH2-TH1))*(THG-TH1)+BTH1
      IF(BG(IX).GT.999.9999) BG(IX)=99.999    !protect from 
      IF(BG(IX).LT.-99.9999) BG(IX)=-9.999    !field-delimited overflow
  550 CONTINUE
  560 WRITE(7,4560) IY,(BG(IX), IX=(-MCG),MCG)
 4560 FORMAT(I10,141F10.4)
C
  570 CONTINUE
C
  590 WRITE(6,4590) CFNAME1
 4590 FORMAT(/' **** New CARTESIAN FIELD PLOT written to ',A)
      CLOSE(11)
      CLOSE(7)
      GO TO 10
C
C     =========================  OPTION 6  =========================
C
  600 WRITE(6,4600)
 4600 FORMAT(/' Input name of first Cartesian plot file: ',$)
  602 READ(5,4202) CFNAME1
      IF(LEN_TRIM(CFNAME1).EQ.0) GO TO 10
C
      OPEN(UNIT    = 11,
     &     FILE    = CFNAME1,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) GO TO 606
  604 WRITE(6,4190) CFNAME1,IOS   !cannot open file message
      GO TO 600
C
  606 READ(11,4526)PLTYP,NRAD,NTH
      IF(PLTYP.NE.CPLT) THEN
  608   WRITE(6,4608) CFNAME1
 4608   FORMAT(/1X,'!!! ',A,' NOT MARKED AS A CARTESIAN PLOT !!!')
        GO TO 600
      END IF
C
  610 WRITE(6,4610)
 4610 FORMAT(/' Input name of second Cartesian plot file: ',$)
  612 READ(5,4202) CFNAME2
      IF(LEN_TRIM(CFNAME2).EQ.0) GO TO 600
C
      OPEN(UNIT    = 12,
     &     FILE    = CFNAME2,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
C
      IF(IOS.EQ.0) GO TO 616
  614 WRITE(6,4190) CFNAME2,IOS   !cannot open file message
      GO TO 610
C
  616 READ(12,4526)PLTYP,NRAD,NTH
      IF(PLTYP.NE.CPLT) THEN
  618   WRITE(6,4608) CFNAME2     !not marked as Cartesian plot 
        GO TO 610
      END IF
C
  620 WRITE(6,4620)
 4620 FORMAT(/6X,'SUB-OPTIONS: ',
     1  '1) Add second field to first field'/19X,
     2  '2) Subtract second field from first field'/19X,
     3  '3) Subtract first field from second field'//6X,
     4  'SELECT OPTION: ',$)
C
  622 READ(5,4020) AKSEL
      IF(LEN_TRIM(AKSEL).EQ.0) GO TO 610
C
  624 KSEL=ICHAR(AKSEL)-48
      SF1=1.0
      SF2=1.0
      IF(KSEL.EQ.1) GO TO 630
      IF(KSEL.EQ.2) THEN
        SF2=-1.0
        GO TO 630
      END IF
      IF(KSEL.EQ.3) THEN
        SF1=-1.0
        GO TO 630
      END IF
      GO TO 620
C
  630 WRITE(6,4630)
 4630 FORMAT(/' Input name for resultant field plot: ',$)
  632 READ(5,4202) CFNAME3
      IF(LEN_TRIM(CFNAME3).EQ.0) GO TO 620
C
      OPEN(UNIT    = 7,
     &     FILE    = CFNAME3,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
      IF(IOS.EQ.0) GO TO 640
C – assume error is because file already exists
  636 WRITE(6,4146) CFNAME3   !overwrite existing file?
  638 READ(5,4142) KF
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 7,
     &       FILE   = CFNAME3,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 630
      END IF
C
C     read in Cartesian data, take difference, and output result
C
  640 REWIND 11
      REWIND 12
  642 READ(11,4526) PLTYP,IDUM,IDUM,(IY, IX=-40,40) !skip first record
  644 READ(12,4526) PLTYP,IDUM,IDUM,(IY, IX=-40,40) !of each file
  646 WRITE(7,4526) PLTYP,ICSZ,ICSZ,(IX, IX=-40,40) !then regenerate 
C                                              first record for output
      DO 680 IY=-40,40
  650 READ(11,4560) IDUM,(CF1(IX), IX=-40,40)
  652 READ(12,4560) IDUM,(CF2(IX), IX=-40,40)
C
      DO 660 IX=-40,40
  660 BG(IX)=SF1*CF1(IX)+SF2*CF2(IX) 
C
  670 WRITE(7,4560) IY,(BG(IX), IX=-40,40)
  680 CONTINUE
C
  690 WRITE(6,4690) CFNAME3
 4690 FORMAT(/' **** Resultant CARTESIAN FIELD PLOT written to ',A)
      CLOSE(11)
      CLOSE(12)
      CLOSE(7)
      GO TO 10
C
C     =========================  OPTION 7  =========================
C
  800 WRITE(6,4800)
 4800 FORMAT(/' Input name of Cartesian plot file to trim: ',$)
  802 READ(5,4202) CFNAME1
      IF(LEN_TRIM(CFNAME1).EQ.0) GO TO 10
C
      OPEN(UNIT    = 11,
     &     FILE    = CFNAME1,
     &     STATUS  = 'OLD',
     &     IOSTAT  = IOS)
      IF(IOS.EQ.0) GO TO 806
C
  804 WRITE(5,4190) CFNAME1,IOS   !cannot open file message
      GO TO 800
C
  806 READ(11,4526)PLTYP,NRAD,NTH
      IF(PLTYP.NE.CPLT) THEN
  808   WRITE(6,4608) CFNAME1     !not marked as Cartesian plot
        GO TO 800
      END IF
C
  810 WRITE(6,4810)
 4810 FORMAT(/' Input name for trimmed plot file: ',$)
  812 READ(5,4202) CFNAME2
      IF(LEN_TRIM(CFNAME2).EQ.0) GO TO 800
C
      OPEN(UNIT    = 7,
     &     FILE    = CFNAME2,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
      IF(IOS.EQ.0) GO TO 820
C – assume error is because file already exists
  816 WRITE(6,4146) CFNAME2   !overwrite existing file?
  818 READ(5,4142) KF
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 7,
     &       FILE   = CFNAME2,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 810
      END IF
C
  820 WRITE(6,4820)
 4820 FORMAT(/' Specify radius to trim beyond: ',$)
  822 READ(5,4822) RTRIM
 4822 FORMAT(F8.0)
      IF(RTRIM.LT.5.0) GO TO 810
C
C     read in plot file and set all points with R>RTRIM to 0
C
      REWIND 11
  840 READ(11,4526) PLTYP,IDUM,IDUM,(IY, IX=-40,40)  !skip first record 
  844 WRITE(7,4526) PLTYP,ICSZ,ICSZ,(IX, IX=-40,40)  !then regenerate      
C                                                     for output file
      DO 880 IY=40,-40,-1
  850 READ(11,4560) IDUM,(CF1(IX), IX=-40,40)
C
      DO 860 IX=-40,40
      SSQXY=IX**2 + IY**2
      RG=SQRT(SSQXY)
  860 IF(RG.GT.RTRIM) CF1(IX)=0.0
C
  870 WRITE(7,4560) IY, (CF1(IX), IX=-40,40)
  880 CONTINUE
C
  890 WRITE(6,4890) CFNAME2
 4890 FORMAT(/' *** Trimmed CARTESIAN FIELD PLOT written to ',A)
      CLOSE(11)
      CLOSE(7)
      GO TO 10
C
C     =========================  OPTION 8  =========================
C
  900 WRITE(6,4900)
 4900 FORMAT(/' End Program JBFLDMAN!'//)
      STOP
      END
    


C$PROG JATN
      REAL*4 FUNCTION JATN(X,Y)
C
C     calculates arc tangent in degrees over all 4 quadrants
C       returns X=0, Y=0 as theta=0
C
C     J. Ball       26-Feb-05       Date of latest revision:  3/10/05
C      
      IMPLICIT NONE
C
      REAL*4 X,Y
C
      IF(X.EQ.0.0) THEN
        IF(Y.EQ.0.0) THEN
          JATN=0.0
        ELSE
          JATN=90.0
        END IF
      ELSE 
        JATN=ATAN(Y/X)*57.2957795
      END IF
C
      IF(X.LT.0.0) THEN 
        JATN=JATN+180.0
      ELSE 
        IF(Y.LT.0.0) THEN
          IF(X.EQ.0.0) THEN
            JATN=JATN+180.0
          ELSE
            JATN=JATN+360.0
          END IF
        END IF
      END IF
      END

C$PROG MDTSTAMP
C
      SUBROUTINE MDTSTAMP(DAT)
C
C     Subroutine to make a date/time stamp for field data files
C     J Ball      8/12/2006
C
      IMPLICIT NONE
      INTEGER*4 DAT(4),DTM(8),DTM1,I
      CHARACTER DTFIL*16,CC*1,CS*1
C
C                - get date and time from system call
C
      CALL GETDAT(DTM(1),DTM(2),DTM(3))
      CALL GETTIM(DTM(5),DTM(6),DTM(7),DTM(8))
      DTM1=DTM(1)-2000      !make into 2-digit year
C
C                 - write stamp to internal file (like old encode)
      CC=':'
      CS='/'
      WRITE(DTFIL,'(I2.2,A1,I2.2,A1,I2.2,I2.2,A1,I2.2,A1,I2.2)')
     1  DTM(2),CS,DTM(3),CS,DTM1,DTM(5),CC,DTM(6),CC,DTM(7)
C
C                  - and then transfer to DAT array
      DO 100 I=1,4
  100 DAT(I)=DTFIL(4*I-3:4*I)
C
      RETURN
      END

