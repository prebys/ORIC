C       SPIRALJ  -  Revised version of the SPIRALS code 
C
C       Input and output files are now specified within the program.
C       Logical units now compatible with Physics Linux server defaults.
C       Option added to input current for multiple segments.
C       Summary results not output at each angle, but as a table at end
C         and can also be output as a special file for input into Excel.
C       Both versions (DEC and MS Fortran) now output date and time.
C
C       J. Ball     7-July-2005        Date of latest revision: 7/22/06
C
C
C    NOTE 1: COMMENTS ALL IN UPPER CASE are from the SPIRALS version.
C            Those in lower case are from this revision.
C
C    NOTE 2: If the program "hangs,", it is probably in an endless 
C            loop caused by the equality condition being set too 
C            tight in statement 17 in the ELIPIN subroutine.
C
C    NOTE 3: A check of the original SPIRAL output for a simple arc 
C            and a long straight segment showed that the calculated 
C            values are a factor of 2 greater than given by the  
C            simple formula for an infinite straight wire.  This
C            version of the program has been renormalized to give
C            the correct results.  This renormalization has been
C            done in subroutines BZSTR and BZCIR (10/21/05). 
C
C   NOTE 3R: On further reflection (pun intended), the code was likely
C            intended to be run with only input of data on one side of
C            the median plane.  Thus, assuming the physical coils will
C            be symmetric about the median plane, the results of the
C            calculation would need to be doubled.  This must certainly
C            be the source of the factor of 2 discrepancy noted above. 
C            The code has now been revised to check whether the input
C            data is symmetric or "one sided," and to renormalize the
C            results accordingly.  The action taken is output to the
C            console to inform the user of how the data was treated.
C            (7/15/06)
C
C    NOTE 4: If a large nubmer of radii and angles are selected, the
C            calculation may take some time.  Because of this a "busy
C            bar" has been added to the console output so that the user
C            will know that the calculation is running. (7/33/06)
C
C
C       MODIFICATION TO MOSELEY CODE TO ADD VARIABLE DIMENSIONS - 
C               - MCNEILLY                                                  
C                                                                           
C       THE FOLLOWING ARRAYS CONSTRAIN PROGRAM VARIABLES AS FOLLOWS:        
C       (NOTE THAT ARRAYS NEED BE CHANGED ONLY IN THIS ROUTINE TO           
C               VARY PROGRAM CONSTRAINTS )                                  
C                                                                           
C       M .LE. P ARRAY                                                      
C                                                                           
C       IC .LE. MCIR = NCT,A,THR,THZ,CC( 5 ARRAYS), AND THE FIRST INDEX     
C       OF PBX THROUGH AEFE( 15 ARRAYS)                                     
C                                                                           
C       NUMBER OF CONDUCTORS PER CIRCUIT .LE. NCMAX - THE SECOND            
C       INDEX OF PBX THROUGH BZTMP (16 ARRAYS), AND LTMP, NCTMP             
C                                                                           
C       IR .LE. IRMAX - BZ,BZT,RR( 3 ARRAYS), AND                           
C        FIRST DIMENSION OF BZTMP (ADDED TO IMPROVE PRINTOUT)               
C                                                                           
C       THE DIMENSIONS IN FOLLOWING LINES WERE CHANGED BY JAM TO                
C       ACCOMMODATE LOWER CHANNEL CALCULATIONS (4/30/85)
C                    
      IMPLICIT REAL*8(A-H,O-Z)
      CHARACTER*15 FILNAM4,FILNAM7
C                                            
      DIMENSION P(250),NCT(200),A(200),THR(200),THZ(200),CC(200)             
      DIMENSION PBX(200,10),PBY(200,10),CX(200,10),CY(200,10)                    
      DIMENSION BX(200,10),BY(200,10),ASZ(200,10),D(200,10)                      
      DIMENSION R(200,10),PEX(200,10),PEY(200,10),CKC(200,10)                    
      DIMENSION APC(200,10),ST(200,10),BZ(200),BZT(200),RR(200)                
      DIMENSION AEFE (200,10), BZTMP(200,10), LTMP(10), NCTMP(10)               
      DATA MCIR,IRMAX,NCMAX / 200,200,10 /                                 
C                                                                           
C       ONLY ABOVE CODE NEED BE CHANGED TO VARY PROGRAM CONSTRAINTS         
C                                                                           
C     first define input data file and output results file
C
   50 WRITE(6,4050)
 4050 FORMAT(//' ***** Start Program SPIRALJ *****')
   52 WRITE(6,4052)
 4052 FORMAT(/' Input name of coil data file: ',$)
   54 READ(5,4054) FILNAM4
 4054 FORMAT(A)
      IF(LEN_TRIM(FILNAM4).EQ.0) GO TO 250
C
      OPEN(UNIT   = 4,
     &     FILE   = FILNAM4,
     &     STATUS = 'OLD',
     &     IOSTAT = IOS)
      IF(IOS.NE.0) GO TO 200
C
   60 WRITE(6,4060)
 4060 FORMAT(/' Input name for output results file: ',$)
   62 READ(5,4054) FILNAM7
      OPEN(UNIT   = 7,
     &     FILE   = FILNAM7,
     &     STATUS = 'NEW',
     &     IOSTAT = IOS)
      IF(IOS.EQ.0) GO TO 100
C
      LNAM=LEN_TRIM(FILNAM7)
   70 WRITE(6,4070) FILNAM7(:LNAM)
 4070 FORMAT(/' ### File ',A,' already exists!  Overwrite (Y/N)? ',$)
   72 READ(5,4072) KF
 4072 FORMAT(A1)
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 7,
     &       FILE   = FILNAM7,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 60
      END IF      
C               now call calculation subroutine
C               (sometime the dimension passing should be changed
C                to common statements)
C
  100 CALL  SPIRAL( MCIR, IRMAX, NCMAX,
     1  P,NCT,A,THR,THZ,CC,
     2  PBX,PBY,CX,CY,                                                      
     3  BX,BY,ASZ,D,
     4  R,PEX,PEY,CKC,                                                      
     5  APC,ST,BZ,BZT,RR,
     6  AEFE,BZTMP,LTMP,NCTMP )
C
  150 WRITE(6,4150) FILNAM7
 4150 FORMAT(/' Calculation complete.  Results written to ',A,
     1  //' ***** End Program SPIRALJ *****'//)
      CLOSE(UNIT=4)
      CLOSE(UNIT=7)
      GO TO 250
C
  200 WRITE(6,4200) FILNAM4,IOS
 4200 FORMAT(/' !!!!! Cannot open file ',A,'     ERROR #',I4//)
      GO TO 52
  250 STOP
      END
C
C
      SUBROUTINE SPIRAL( MCIR , IRMAX , NCMAX ,                           
     1  P,NCT,A,THR,THZ,CC,                                                 
     2  PBX,PBY,CX,CY,                                                      
     3  BX,BY,ASZ,D,                                                        
     4  R,PEX,PEY,CKC,                                                      
     5  APC,ST,BZ,BZT,RR,                                                   
     6  AEFE,BZTMP,LTMP,NCTMP )                                             
C     SPIRAL COIL CODE.  COMBINED STRAIGHT AND CIRCULAR ARC                 
C     CONDUCTORS.  G L BROYLES   ROOM S 119                                 
      IMPLICIT REAL*8(A-H,O-Z)                                              
      COMMON/NORM/ RENORM     !added to pass renorm factor to subs
      INTEGER SWC
      INTEGER DTM(8)      ! added for date and time routine
      DIMENSION ITITL(15),CCUR(9),SUMRES(201,201),LBLSEG(9)
      CHARACTER FILNAM11*15,DUM*12,BBCHR*1
      CHARACTER*6 LBLCIR,LBLCON                                                         
      DIMENSIONP(1),NCT(1),A(1),THR(1),THZ(1),CC(1)                         
      DIMENSIONPBX(MCIR,1),PBY(MCIR,1),CX(MCIR,1),CY(MCIR,1)                
      DIMENSIONBX(MCIR,1),BY(MCIR,1),ASZ(MCIR,1),D(MCIR,1)                  
      DIMENSIONR(MCIR,1),PEX(MCIR,1),PEY(MCIR,1),CKC(MCIR,1)                
      DIMENSIONAPC(MCIR,1),ST(MCIR,1),BZ(1),BZT(1),RR(1)                    
      DIMENSION AEFE (MCIR,1), BZTMP(IRMAX,1), LTMP(1), NCTMP(1)            
        DATA IPAGE/0/                                                       
C
      SECONF (X2,Y2,X1,Y1)=(X2-X1)/DSQRT ((X2-X1)**2+(Y2-Y1)**2)            
      THIRDF(X2,Y2,X1,Y1)=(Y2-Y1)/DSQRT ((X2-X1)**2+(Y2-Y1)**2)             
      FOURF(X2,Y2,X1,Y1)=X2*Y1-Y2*X1                                        
      FIVEF(X2,Y2,X1,Y1)=X2*X1+Y2*Y1                                        
C
      LBLCIR=' CIRC#'
      LBLCON=' COND#'
      SYMCK1=0.0
      SYMCK2=0.0
      RENORM=1.0
C
C     START AND TEST CODE                                                   
C                                                                           
C     ISAVE NE 0 CAUSES FIELD FROM EACH CURRENT TO BE OUTPUT TO UNIT ISAVE     
C     FOR LATER RECONSTRUCTION IN AN (R,THETA) MESH                            
C     FIRST WRITE OUTPUTS # RADII,# THETAS,# CIRCUITS,RINIT, RDEL, CYUNIT      
C
C     Note: The ISAVE option is not active in this version of SPIRAL
C
C     If ISUM is not equal zero the program will offer the option of
C     writing the summary field data to a designated file in the form of
C     a fixed-space file suitable for input into an EXCEL worksheet.
C     This file is formatted as a "polar" plot file compatible with the
C     JB series of utility programs such as JBFLDGEN and JB3DPLOT.
C
C     The IWX parameter extends the printing limitations offered by IW
C       IWX=0 (or blank)  printout will be as specified by IW
C       IWX=1  the copy of the conductor input will be omitted
C       IWX=2  copy of cond input omitted, conductor parameters omitted
C        (thus if IWX=2 and IW=3, e.g., only the summary field data is printed
C
  209 READ(4,4209) KW,ISAVE,ISUM,IWX,ITITL
 4209 FORMAT(I1,4X,3I5,15A4)
C
C     note that date and time routines are different for DEC and MS Fortran
C
C      CALL DATE_AND_TIME(DUM,DUM,DUM,DTM)      ! use this with DEC Fortran
C
      CALL GETDAT(DTM(1),DTM(2),DTM(3))         ! use this with MS Fortran
      CALL GETTIM(DTM(5),DTM(6),DTM(7),DTM(8))  ! use this with MS Fortran
C
  210 WRITE(7,4210) ITITL,DTM(2),DTM(3),DTM(1),DTM(5),DTM(6),DTM(7),
     1  DTM(8)/100
 4210 FORMAT(1X,'SPIRAL:',15A4,10X,'DATE: ',2(I2.2,'/'),I4,
     1  5X,'TIME: ',2(I2.2,':'),I2.2,'.',I1)
C
      WRITE(7,1005)KW,ISAVE,ISUM,IWX                !see above for IWX
 1005 FORMAT(/1X,'INPUT SUMMARY:'/1X,I1,4X,3I5)     
      IF(KW-1)211,211,229                           !IR is # radii
  211 READ(4,4211)IR,IT,IS,IC,IW,KCIN               !IT is # angles
 4211 FORMAT(6I3)                                   !IS is # sectors     
      WRITE(7,1006)IR,IT,IS,IC,IW,KCIN              !IC is # circuits           
 1006 FORMAT(1X,6I3)                                !IW sets output style
C                                                       
C     KCIN not zero flags that a card will be added after the next card
C        to input coil currents common to several segments
C                                                !A1 is start radius
      READ(4,213)A1,A2,A3,A4,A6,A10,A11          !A2 is radius inc   
  213 FORMAT(2F10.7,3F10.5,2F5.1)               !A3 is start angle  
      WRITE(7,1007)A1,A2,A3,A4,A6,A10,A11      !A4 is angle inc               
 1007 FORMAT(1X,5F10.2,2F5.2)                 !A6 is cyc unit dim (in)
C                                          !A10 is arc first approx dist
C                                       !A11 is straight first approx dist
C       if KCIN is not zero, then read in coil currents
C
      IF(KCIN.NE.0) THEN
        READ(4,4212) (CCUR(I),I=1,9)
        WRITE(7,4213) (CCUR(I),I=1,9)
      END IF
 4212 FORMAT(9F8.0)
 4213 FORMAT(1X,9F8.1)
C                                           
      THETA1=A3          !save value in degrees for later printing check
      IF(IW)228,228,214                                                     
  214 ASSIGN133TOKVE11                                                      
      IF(IW-9)215,215,223                                                   
  215 ASSIGN177TOKVE12                                                      
      ASSIGN191TOKVE14                                                      
      IF(IW-3)216,216,220                                                   
  216 ASSIGN178TOKVE13                                                      
      IF(IW-2)217,218,219                                                   
  217 ASSIGN198TOKVE15                                                      
      ASSIGN205TOKVE16                                                      
      GOTO85                                                                
  218 ASSIGN198TOKVE15                                                      
      ASSIGN206TOKVE16                                                      
      GOTO85                                                                
  219 ASSIGN197TOKVE15                                                      
      ASSIGN206TOKVE16                                                      
      GOTO85                                                                
  220 IF(IW-6)221,221,222                                                   
  221 ASSIGN179TOKVE13                                                      
      IF(IW-5)217,218,219                                                   
  222 ASSIGN180TOKVE13                                                      
      IF(IW-8)217,218,219                                                   
  223 ASSIGN181TOKVE12                                                      
      ASSIGN192TOKVE14                                                      
      IF(IW-13)224,224,225                                                  
  224 ASSIGN178TOKVE13                                                      
      IF(IW-12)217,218,219                                                  
  225 IF(IW-16)226,226,227                                                  
  226 ASSIGN179TOKVE13                                                      
      IF(IW-15)217,218,219                                                  
  227 ASSIGN180TOKVE13                                                      
      IF(IW-18)217,218,219                                                  
  228 ASSIGN156TOKVE11                                                      
      GOTO85                                                                
C                                                                           
C       CODE MOVED FROM INLINE TO SUBROUTINE TEST                           
C                                                                           
229     CONTINUE                                                            
        CALL TEST( BZ )                                                     
        GO TO 900                                                           
C                                                                           
C                                                                           
C                                                                           
C     TWO ARC CLOSURE                                                       
   39 T12=T11                                                               
      T13=-T10                                                              
      T14=T7                                                                
      T15=-T6                                                               
      T16=T1-T8                                                             
      T17=T2-T9                                                             
      IF(FIVEF(T12,T13,T16,T17))40,41,41                                    
   40 T12=-T12                                                              
      T13=-T13                                                              
   41 IF(FIVEF(T14,T15,T16,T17))43,42,42                                    
   42 T14=-T14                                                              
      T15=-T15                                                              
   43 T3=DSQRT((T1-T8)**2+(T2-T9)**2)                                       
      T4=FIVEF(T12,T13,T16,T17)/T3                                          
      T5=FIVEF(T14,T15,T16,T17)/(-T3)                                       
      T18=FIVEF(T12,T13,T14,T15)                                            
      T19=FIVEF(T12,T13,T6,T7)                                              
      T20=FIVEF(T14,T15,T10,T11)                                            
      IF(T19)44,49,49                                                       
   44 IF(T20)51,45,45                                                       
   45 IF(T5-T4)46,47,47                                                     
   46 ASSIGN53TOKVE3                                                        
   48 ASSIGN58TOKVE4                                                        
      GOTO52                                                                
   47 ASSIGN54TOKVE3                                                        
      GOTO48                                                                
   49 IF(T20)50,51,51                                                       
   50 IF(T5-T4)47,46,46                                                     
   51 ASSIGN59TOKVE4                                                        
      GOTO56                                                                
   52 T21=DSQRT (1.0D0-2.0D0*T4*T5/(1.0D0-T18))                             
      GOTOKVE3,(53,54)                                                      
   53 T22=((1.0D0+T21)*T3)/(2.0D0*T5)                                       
      T21=((1.0D0-T21)*T3)/(2.0D0*T4)                                       
      GOTO55                                                                
   54 T22=((1.0D0-T21)*T3)/(2.0D0*T5)                                       
      T21=((1.0D0+T21)*T3)/(2.0D0*T4)                                       
   55 GOTO57                                                                
   56 T22=DSQRT(T4*T5*(T4*T5+0.5D0*(1.0D0+T18)))                            
      T21=(T22-T4*T5)*T3/(T4*(1.0D0+T18))                                   
      T22=(T22-T4*T5)*T3/(T5*(1.0D0+T18))                                   
   57 T3=T8+T21*T12                                                         
      T4=T9+T21*T13                                                         
      T19=T1+T22*T14                                                        
      T20=T2+T22*T15                                                        
      GOTOKVE4,(58,59)                                                      
   58 T23=(T22*T3-T21*T19)/(T22-T21)                                        
      T24=(T22*T4-T21*T20)/(T22-T21)                                        
      GOTO60                                                                
   59 T23=(T22*T3+T21*T19)/(T22+T21)                                        
      T24=(T22*T4+T21*T20)/(T22+T21)                                        
   60 T12=-T12                                                              
      T13=-T13                                                              
      T14=-T14                                                              
      T15=-T15                                                              
      T5=FOURF(T14,T15,T6,T7)                                               
      T25=SECONF (T23,T24,T19,T20)                                          
      T26=THIRDF(T23,T24,T19,T20)                                           
      T27=FIVEF(T25,T26,T6,T7)                                              
      T28=FIVEF(T25,T26,T14,T15)                                            
      T25=DSQRT (0.5D0-0.5D0*T28)                                           
      T26=DSQRT (1.0D0-T25*T25)                                             
      T29 = ARCSIN(T26,T25)                                                 
      IF(T27)62,61,61                                                       
   62 T29=3.14159265D0-T29                                                  
      T26=-T26                                                              
   61 T16=T14*T26+T6*T25                                                    
      T17=T15*T26+T7*T25                                                    
      T14=SECONF (T23,T24,T3,T4)                                            
      T15=THIRDF(T23,T24,T3,T4)                                             
      T27=FOURF(T12,T13,T10,T11)                                            
      IF(T27)64,63,63                                                       
   63 T25=-T15                                                              
      T26=T14                                                               
      GOTO65                                                                
   64 T25=T15                                                               
      T26=-T14                                                              
   65 T18=FIVEF(T12,T13,T25,T26)                                            
      T28=FIVEF(T12,T13,T14,T15)                                            
      T12=DSQRT (0.5D0-0.5D0*T28)                                           
      T13=DSQRT (1.0D0-T12*T12)                                             
      T30 = ARCSIN(T13,T12)                                                 
      IF(T18)66,67,67                                                       
   66 T30=3.14159265D0-T30                                                  
      T13=-T13                                                              
   67 T14=T14*T13+T25*T12                                                   
      T15=T15*T13+T26*T12                                                   
      BX(L,NC)=T16                                                          
      BY(L,NC)=T17                                                          
      CX(L,NC)=T19                                                          
      CY(L,NC)=T20                                                          
      ASZ(L,NC)=T5                                                          
      D(L,NC)=T29                                                           
      R(L,NC)=T22                                                           
      PEX(L,NC)=T23                                                         
      PEY(L,NC)=T24                                                         
      PBX(L,NC+1)=T23                                                       
      PBY(L,NC+1)=T24                                                       
      BX(L,NC+1)=T14                                                        
      BY(L,NC+1)=T15                                                        
      CX(L,NC+1)=T3                                                         
      CY(L,NC+1)=T4                                                         
      ASZ(L,NC+1)=T27                                                       
      D(L,NC+1)=T30                                                         
      R(L,NC+1)=T21                                                         
      PEX(L,NC+1)=T8                                                        
      PEY(L,NC+1)=T9                                                        
      PBX(L,NC+2)=T8                                                        
      PBY(L,NC+2)=T9                                                        
      GOTOKVE5,(122,130)                                                    
C     ONE ARC CLOSURE                                                       
   68 T12=T11                                                               
      T13=-T10                                                              
      T14=T7                                                                
      T15=-T6                                                               
      T16=T1-T8                                                             
      T17=T2-T9                                                             
      IF(FIVEF(T12,T13,T16,T17))69,70,70                                    
   69 T12=-T12                                                              
      T13=-T13                                                              
   70 IF(FIVEF(T14,T15,T16,T17))72,71,71                                    
   71 T14=-T14                                                              
      T15=-T15                                                              
   72 T3=FOURF(T10,T11,T6,T7)                                               
      T4=T3*T17                                                             
      T5=-T3*T16                                                            
      T18=FIVEF(T6,T7,T4,T5)/(T3*T3)                                        
      T19=FIVEF(T10,T11,T4,T5)/(T3*T3)                                      
      T3=DABS (T18)                                                         
      T4=DABS (T19)                                                         
      T5=-FIVEF(T10,T11,T6,T7)                                              
      T18=DSQRT ((1.0D0-T5)/2.0D0)                                          
      T19=T18/DSQRT (1.0D0-T18*T18)                                         
      T24 = DSQRT (1.0D0 - T18*T18)                                         
      T18 = ARCSIN(T24,T18)                                                 
      T20=SECONF (T6,T7,T10,T11)                                            
      T21=THIRDF(T6,T7,T10,T11)                                             
      T5=-FOURF(T14,T15,T6,T7)                                              
      T22=FIVEF(T12,T13,T6,T7)                                              
      T23=FIVEF(T14,T15,T10,T11)                                            
      IF(T22)73,77,77                                                       
   73 IF(T23)74,74,75                                                       
   74 GOTO800                                                               
   75 IF(T4-T3)76,76,81                                                     
   76 D(L,NC)=1.57079633D0-T18                                              
      PEX(L,NC)=T8-T10*(T3-T4)                                              
      PEY(L,NC)=T9-T11*(T3-T4)                                              
      GOTO80                                                                
   77 IF(T23)78,801,801                                                     
   78 IF(T4-T3)82,82,79                                                     
   79 D(L,NC)=1.57079633D0+T18                                              
      PEX(L,NC)=T8+T10*(T3-T4)                                              
      PEY(L,NC)=T9+T11*(T3-T4)                                              
   80 T22=T4*T19                                                            
      CX(L,NC)=T1+T22*T14                                                   
      CY(L,NC)=T2+T22*T15                                                   
      ASZ(L,NC)=T5                                                          
      R(L,NC)=T22                                                           
      PBX(L,NC+1)=PEX(L,NC)                                                 
      PBY(L,NC+1)=PEY(L,NC)                                                 
      BX(L,NC)=T20                                                          
      BY(L,NC)=T21                                                          
      CX(L,NC+1)=0.0D0                                                      
      CY(L,NC+1)=0.0D0                                                      
      BX(L,NC+1)=0.0D0                                                      
      BY(L,NC+1)=0.0D0                                                      
      ASZ(L,NC+1)=0.0D0                                                     
      D(L,NC+1)=0.0D0                                                       
      R(L,NC+1)=0.0D0                                                       
      PEX(L,NC+1)=T8                                                        
      PEY(L,NC+1)=T9                                                        
      PBX(L,NC+2)=T8                                                        
      PBY(L,NC+2)=T9                                                        
      GOTO84                                                                
   81 D(L,NC+1)=1.57079633D0-T18                                            
      PEX(L,NC)=T1+T6*(T4-T3)                                               
      PEY(L,NC)=T2+T7*(T4-T3)                                               
      GOTO83                                                                
   82 D(L,NC+1)=1.57079633D0+T18                                            
      PEX(L,NC)=T1-T6*(T4-T3)                                               
      PEY(L,NC)=T2-T7*(T4-T3)                                               
   83 BX(L,NC)=0.0D0                                                        
      BY(L,NC)=0.0D0                                                        
      CX(L,NC)=0.0D0                                                        
      CY(L,NC)=0.0D0                                                        
      ASZ(L,NC)=0.0D0                                                       
      D(L,NC)=0.0D0                                                         
      R(L,NC)=0.0D0                                                         
      PBX(L,NC+1)=PEX(L,NC)                                                 
      PBY(L,NC+1)=PEY(L,NC)                                                 
      BX(L,NC+1)=T20                                                        
      BY(L,NC+1)=T21                                                        
      T22=T3*T19                                                            
      CX(L,NC+1)=T8+T22*T12                                                 
      CY(L,NC+1)=T9+T22*T13                                                 
      ASZ(L,NC+1)=T5                                                        
      R(L,NC+1)=T22                                                         
      PEX(L,NC+1)=T8                                                        
      PEY(L,NC+1)=T9                                                        
      PBX(L,NC+2)=T8                                                        
      PBY(L,NC+2)=T9                                                        
   84 GOTOKVE6,(122,130)                                                    
  600 WRITE(7,601)                                                          
  601 FORMAT(39H SPECIFIED ONE ARC CLOSURE NOT POSSIBLE)                    
      GOTOKVE30,(75,78)                                                     
  800 ASSIGN75TOKVE30                                                       
      GOTO600                                                               
  801 ASSIGN78TOKVE30                                                       
      GOTO600                                                               
C     PARAMETER REDUCTION CODE                !A5 is cond current
   85 L=1                                     !A8 is cond half-width  
   86 IF(IC-L)153,87,87                       !A9 is cond half-height
   87 READ (4,88)A5,A8,A9,A7,M,LBLSEG         !A7 is dist to median plane 
   88 FORMAT(4F10.3,I3,9A4)                   !M is # of additional cards
      IF(IWX.LT.1)WRITE(7,4088)A5,A8,A9,A7,M,LBLSEG
 4088 FORMAT(1X,F10.1,3F10.4,I3,2X,9A4)       !LBLSEG is optional label      
C                                             
C       If current specified by A5 is less than 10 amps, then
C       obtain current from value of A5 input from current card.
C       The sign of the current will be the sign of A5.
C
      IF(ABS(A5).LT.10.0) THEN
        IA5=ABS(A5)
        A5=SIGN(CCUR(IA5),A5)
      END IF
C
      READ(4 ,89)(P(MM),MM=1,M)                                     
   89 FORMAT(E13.7)                                                         
C                                                                           
C  THESE 2 STMTS PERTAIN TO CREATING A FILE OF BFIELD CONTRIBUTIONS         
C  FROM EACH COIL.  COILS MUST BE CIRCULAR AND BE AT EVEN INCREMENTS        
C  FOR RCINIT AND RCDEL TO BE CORRECT. IF THIS IS NOT THE CASE              
C  THE FIRST LINE OF THE FILE SHOULD BE EDITTED TO SUPPLY CORRECT           
C  VALUES                                                                   
        IF(L.EQ.1) RCINIT=P(3)                                              
        IF(L.EQ.2) RCDEL=P(3)-RCINIT                                        
      IF(IWX.LT.1) WRITE(7,1004)(P(MM),MM=1,M)                                  
 1004 FORMAT(1H ,6X,E15.7)                                                  
      N=1                                                                   
      NC=1                                                                  
      A(L)=A7
      SYMCK1=SYMCK1+A7       !part of data symmetry check
      SYMCK2=SYMCK2+ABS(A7)  !part of data symmetry check
      THR(L)=A8                                                             
      THZ(L)=A9                                                             
      CC(L)=A5                                                              
      IF(P(1)-8.00D3)99,90,99                                               
   90 PBX(L,NC)=P(2)                                                        
      PBY(L,NC)=P(3)                                                        
      T1=P(2)                                                               
      T2=P(3)                                                               
      T6=SECONF (P(4),P(5),P(2),P(3))                                       
      T7=THIRDF(P(4),P(5),P(2),P(3))                                        
      N=4                                                                   
   91 PEX(L,NC)=P(N)                                                        
      IF(T6)93,92,93                                                        
   92 PEY(L,NC)=P(N+1)                                                      
      GOTO94                                                                
   93 PEY(L,NC)=T2+(P(N)-T1)*T7/T6                                          
   94 T1=P(N)                                                               
      T2=PEY(L,NC)                                                          
      CX(L,NC)=0.0D0                                                        
      CY(L,NC)=0.0D0                                                        
      BX(L,NC)=0.0D0                                                        
      BY(L,NC)=0.0D0                                                        
      ASZ(L,NC)=0.0D0                                                       
      D(L,NC)=0.0D0                                                         
      R(L,NC)=0.0D0                                                         
      PBX(L,NC+1)=T1                                                        
      PBY(L,NC+1)=T2                                                        
      N=N+2                                                                 
      IF(P(N)-5.0D3)95,132,95                                               
   95 IF(P(N)-1.0D3)96,119,96                                               
   96 IF(P(N)-2.0D3)97,118,97                                               
   97 IF(P(N)-8.0D3)114,98,114                                              
   98 NC=NC+1                                                               
      PBX(L,NC)=T1                                                          
      PBY(L,NC)=T2                                                          
      N=N+1                                                                 
      T6=SECONF (P(N),P(N+1),T1,T2)                                         
      T7=THIRDF(P(N),P(N+1),T1,T2)                                          
      GOTO91                                                                
   99 PBX(L,NC)=P(3)                                                        
      PBY(L,NC)=P(4)                                                        
      T1=P(3)                                                               
      T2=P(4)                                                               
      T3=P(5)                                                               
      T4=P(6)                                                               
      T5=P(7)/57.2957795D0                                                  
      T6=THIRDF(T1,T2,T3,T4)                                                
      T7=SECONF (T1,T2,T3,T4)                                               
      IF(P(1))100,101,100                                                   
  100 IF(P(1)*T6)102,102,104                                                
  102 T6=-T6                                                                
  103 N=8                                                                   
      GOTO105                                                               
  101 IF(P(2)*T7)104,104,102                                                
  104 T7=-T7                                                                
      GOTO103                                                               
  105 CX(L,NC)=T3                                                           
      CY(L,NC)=T4                                                           
      T8=SECONF (T1,T2,T3,T4)                                               
      T9=THIRDF(T1,T2,T3,T4)                                                
      BX(L,NC)=T8*DCOS (T5)+T6*DSIN (T5)                                    
      BY(L,NC)=T9*DCOS (T5)+T7*DSIN (T5)                                    
      T10=FOURF(T8,T9,T6,T7)                                                
      ASZ(L,NC)=T10                                                         
      D(L,NC)=T5                                                            
      R(L,NC)=DSQRT ((T1-T3)**2+(T2-T4)**2)                                 
      PEX(L,NC)=2.0D0*(T3+BX(L,NC)*R(L,NC)*DCOS (T5))-T1                    
      PEY(L,NC)=2.0D0*(T4+BY(L,NC)*R(L,NC)*DCOS (T5))-T2                    
      T8=THIRDF(PEX(L,NC),PEY(L,NC),T3,T4)                                  
      T9=SECONF (PEX(L,NC),PEY(L,NC),T3,T4)                                 
      T11=PEY(L,NC)+(P(N)-PEX(L,NC))*T8/T9                                  
      IF(T10)106,106,107                                                    
  106 T9=-T9                                                                
      GOTO108                                                               
  107 T8 = -T8                                                              
  108 IF(P(N)-5.0D3)109,132,109                                             
  109 IF(P(N)-1.0D3)110,117,110                                             
  110 IF(P(N)-2.0D3)111,115,111                                             
  111 IF(P(N)-8.0D3)112,113,112                                             
  112 PBX(L,NC+1)=PEX(L,NC)                                                 
      PBY(L,NC+1)=PEY(L,NC)                                                 
      T1=PEX(L,NC)                                                          
      T2=PEY(L,NC)                                                          
      T3=P(N)                                                               
      T4=T11                                                                
      T5=P(N+1)/57.2957795D0                                                
      T6=T8                                                                 
      T7=T9                                                                 
      NC=NC+1                                                               
      N=N+2                                                                 
      GOTO105                                                               
  113 N=N+1                                                                 
      T1=PEX(L,NC)                                                          
      T2=PEY(L,NC)                                                          
      PBX(L,NC+1)=T1                                                        
      PBY(L,NC+1)=T2                                                        
      T6=T8                                                                 
      T7=T9                                                                 
      NC=NC+1                                                               
      GOTO91                                                                
  114 T3=P(N)                                                               
      T5=P(N+1)/57.2957795D0                                                
      T4=T2-(T3-T1)*T6/T7                                                   
      N=N+2                                                                 
      NC=NC+1                                                               
      GOTO105                                                               
  115 ASSIGN118TOKVE7                                                       
  116 PBX(L,NC+1)=PEX(L,NC)                                                 
      PBY(L,NC+1)=PEY(L,NC)                                                 
      T1=PEX(L,NC)                                                          
      T2=PEY(L,NC)                                                          
      T6=T8                                                                 
      T7=T9                                                                 
      GOTOKVE7,(118,119)                                                    
  117 ASSIGN119TOKVE7                                                       
      GOTO116                                                               
  118 ASSIGN39TOKVE8                                                        
      ASSIGN39TOKVE9                                                        
      ASSIGN39TOKVE10                                                       
      GOTO120                                                               
  119 ASSIGN68TOKVE8                                                        
      ASSIGN68TOKVE9                                                        
      ASSIGN68TOKVE10                                                       
  120 IF(P(N+1)-8.0D3)125,121,125                                           
  121 NC=NC+1                                                               
      ASSIGN122TOKVE5                                                       
      ASSIGN122TOKVE6                                                       
      T8=P(N+2)                                                             
      T9=P(N+3)                                                             
      T12=P(N+4)                                                            
      T13=P(N+5)                                                            
      T10=SECONF (T12,T13,T8,T9)                                            
      T11=THIRDF(T12,T13,T8,T9)                                             
      GOTOKVE8,(39,68)                                                      
  122 IF(P(N+6)-4.0D3)123,124,123                                           
  123 NC=NC+2                                                               
      N=N+4                                                                 
      T1=T8                                                                 
      T2=T9                                                                 
      T6=T10                                                                
      T7=T11                                                                
      GOTO91                                                                
  124 NCT(L)=NC+1                                                           
      L=L+1                                                                 
      GOTO86                                                                
  125 NC=NC+1                                                               
      ASSIGN130TOKVE5                                                       
      ASSIGN130TOKVE6                                                       
      T8=P(N+3)                                                             
      T9=P(N+4)                                                             
      T12=P(N+5)                                                            
      T13=P(N+6)                                                            
      T10=THIRDF(T8,T9,T12,T13)                                             
      T11=SECONF (T8,T9,T12,T13)                                            
      IF(P(N+1))126,129,126                                                 
  126 IF(P(N+1)*T10)127,127,128                                             
  127 T10=-T10                                                              
      GOTOKVE9,(39,68)                                                      
  128 T11=-T11                                                              
      GOTOKVE10,(39,68)                                                     
  129 IF(P(N+2)*T11)128,128,127                                             
  130 IF(P(N+8)-4.0D3)131,124,131                                           
  131 NC=NC+2                                                               
      T1=T8                                                                 
      T2=T9                                                                 
      T3=P(N+5)                                                             
      T4=P(N+6)                                                             
      T5=P(N+7)/57.2957795D0                                                
      T6=T10                                                                
      T7=T11                                                                
      N=N+8                                                                 
      GOTO105                                                               
  132 NCT(L)=NC                                                             
      L=L+1                                                                 
      GOTO86                                                                
C
C     PARAMETER REDUCTION PRINTOUT                                          
C
Cjbb  renormalization check of data inserted at statement 153
  153 WRITE(6,4300) SYMCK1,SYMCK2
 4300 FORMAT(/5X,'DATA SYMMETRY TEST: SYMCK1 =',F8.3,5X,'SYMCK2 =',F8.3)
      IF(ABS(SYMCK1).LT.0.01) THEN
        RENORM=0.5
        WRITE(6,4301) RENORM
 4301   FORMAT(5X,'REDUNDANT DATA IS SYMMETRIC ABOUT MEDIAN PLANE'/5X,
     1    'RENORMALIZATION =',F4.1)
      ELSE
        IF(ABS(SYMCK2-ABS(SYMCK1)).LT.0.01) THEN
          RENORM=1.0
          WRITE(6,4302) 
 4302     FORMAT(5X,'DATA INPUT FOR ONE SIDE OF MEDIAN PLANE ONLY - ',
     1      'SYMMETRY ASSUMED'/5X,'NO RENORMALIZATION'/)
        ELSE
          WRITE(6,4303)
 4303     FORMAT(5X,'INPUT DATA HAS PROBLEMS WITH SYMMETRY ABOUT ',
     1      'MEDIAN PLANE'/5X,'PLEASE CORRECT DATA AND RUN AGAIN'//)
          STOP ' !!! EXIT SPIRALJ !!!'
        END IF
      END IF
Cjbb                  !set up for "busy bar"
      BBCHR=CHAR(128)
      BBCTR=0
      WRITE(6,4304)
 4304 FORMAT(4X,'-',$)
Cjbb
C 153 L=1    !commented out old statement 153                                                                  
      L=1
  604 IF(IC-L)155,610,610                                                   
  610 IF(IWX.LT.2) WRITE(7,154) L                                             
  154 FORMAT(42X,21HCONDUCTOR PARAMETERS.,                              
     113H  CIRCUIT NO.,I3)
      IF(IWX.LT.2) WRITE(7,605)                                                 
  605 FORMAT(1X,'CN  PX BEGIN  PY BEGIN    PX END    PY END',
     1  '        BX        BY  CENT X  CENT Y  RADIUS',   
     2  '     PHI     AXS      CZ    CCUR')
      I=1                                                                   
  608 IF(NCT(L)-I)609,606,606                                               
  606 D(L,I)=57.2957795D0*D(L,I)                                            
      IF(IWX.LT.2) WRITE(7,607)I,PBX(L,I),PBY(L,I),PEX(L,I),PEY(L,I),    
     1  BX(L,I),BY(L,I),CX(L,I),CY(L,I),R(L,I),D(L,I),ASZ(L,I),
     2  A(L),CC(L)                       
      D(L,I)=D(L,I)/57.2957795D0                                            
  607 FORMAT(1X ,I2,6F10.5,6F8.3,F8.1)
      I=I+1                                                                 
      GOTO608                                                               
  609 L=L+1                                                                 
      GOTO604                                                               
  155 GOTOKVE11,(156,133)                                                   
  156 GOTO900                                                               
C
C     CURVATURE CORRECTIONS                                                 
  133 L=1                                                                   
  135 IF(IC-L)145,134,134                                                   
  134 NC=1                                                                  
  137 IF(NCT(L)-NC)144,136,136                                              
  136 IF(ASZ(L,NC))138,143,138                                              
  138 T1=(THR(L)/R(L,NC))**2                                                
      T2=1.0D0                                                              
      T3=1.0D0                                                              
      T4=1.0D0                                                              
  139 T4=((2.0D0*T2-1.0D0)/(2.0D0*T2+1.0D0))*T4*T1                          
      T3=T3+T4                                                              
  715 IF(T4-1.0D-8)141,141,140                                              
  140 T2=T2+1.0D0                                                           
      GOTO139                                                               
  141 CKC(L,NC)=1.0D0/T3                                                    
  361 T16 = DSQRT ((R(L,NC)-THR(L))**2+A(L)**2)                             
      T17 = DSQRT ((R(L,NC)+THR(L))**2+A(L)**2)                             
      T18 = THZ(L)/T16                                                      
      T19 = THZ(L)/T17                                                      
  362 T20 = A(L)/T16                                                        
      T21 = A(L)/T17                                                        
      T22 = T18*T18+T18*T19+T19*T19                                         
      T23 = T18*T18*T20+T19*T19*T21                                         
  363 T24 = T20+T21                                                         
      T25 = T18*T19*T20*T21                                                 
      T26 = T18**3+T19**3                                                   
      T27 = T18+T19                                                         
  364 T28 = T18*T19                                                         
      T29 = T18**4+T19**4                                                   
      T30 = T20*T20+T20*T21+T21*T21                                         
      T31 = T18**4*T20+T19**4*T21                                           
  365 T32 = T20*T20+T21*T21                                                 
      T33 = T18**6+T19**6                                                   
      T34 = T20**3+T21**3                                                   
      T35 = (T20*T21)**2                                                    
  366 T36 = T18**6*T20+T19**6*T21                                           
      T37 = T20**4+T35+T21**4                                               
      T37 = (33.0D0/16.0D0)*(T36*T37*T24+T25**3)                            
      T36 = (-45.0D0/16.0D0)*(T33*(T24*T34+T35)+T28*T25*T25)                
  367 T35 = (15.0D0/16.0D0)*(T33*T30+T28*T25*T22)                           
      T34 = (-5.0D0/112.0D0)*(T29*T22+T28**3)                               
      T33 = (5.0D0/7.0D0)*(T31*T32*T24+T25*T25)                             
      T32 = (-3.0D0/4.0D0)*(T29*T30+T28*T25)                                
  368 T31 = (3.0D0/40.0D0)*(T26*T27+T28*T28)                                
      T30 = (1.0D0/2.0D0)*(T23*T24+T25)                                     
      T29 = (-1.0D0/6.0D0)*T22                                              
      T28 = 1.0D0+T29+T30+T31+T32+T33+T34+T35+T36+T37                       
  369 T27 = (1.0D0/2.0D0)*(T16/R(L,NC))*(T17/R(L,NC))*((T16+T17)/R(L,NC)    
     >)*(1.0D0/T28)                                                         
      T26 = (2.0D0/3.0D0)*DLOG(T27)                                         
      T25 = DEXP (T26)                                                      
      T24 = R(L,NC)*(T25-1.0D0)                                             
  370 AEFE(L,NC) = T24
  142 NC=NC+1                                                               
      GOTO137                                                               
  143 CKC(L,NC)=1.0D0                                                       
      GOTO142                                                               
  144 L=L+1
      GOTO135                                                                 
C
C     APPROX. CRITERIA AND LENGTHS                                          
  145 L=1                                                                   
  146 IF(IC-L)157,611,611                                                   
  611 NC=1                                                                  
  147 IF(NCT(L)-NC)152,148,148                                              
  148 IF(ASZ(L,NC))149,151,149                                              
  149 APC(L,NC)=A10/(A6*DSQRT (A6*R(L,NC)))
  150 NC=NC+1                                                               
      GOTO147                                                               
  151 ST(L,NC)=DSQRT ((PBX(L,NC)-PEX(L,NC))**2+(PBY(L,NC)-PEY(L,NC))**2)    
      GOTO150                                                               
  152 L=L+1                                                                 
      GOTO146                                                               
C     BZ CODE                                                               
  157 A3=A3/57.2957795D0                                                    
      A4=A4/57.2957795D0                                                    
      J=1                                                                   
      T1=FLOAT (IS)                                                         
      T1=6.28318531D0/T1                                                    
      T30=DSQRT (3.0D0)                                                     
      T3=DSIN (T1)                                                          
      T4=DCOS (T1)                                                          
      T1=DSIN (A3)                                                          
      T2=DCOS (A3)                                                          
      T5=DSIN (A4)                                                          
      T6=DCOS (A4)                                                          
  159 IF(IT-J)208,158,158                                                   
  158 I=1                                                                   
      RR(1)=A1                                                              
  160 IF(IR-I)162,161,161                                                   
  161 BZT(I)=0.0D0                                                          
      I=I+1                                                                 
      RR(I)=RR(I-1)+A2                                                      
      GOTO160                                                               
  162 L=1                                                                   
  163 IF(IC-L)204,164,164
  164 T9=A(L)                                                               
      T10=THR(L)                                                            
      T11=THZ(L)                                                            
      NC=1                                                                  
      A5=CC(L)                                                              
  165 IF(NCT(L)-NC)203,166,166                                              
  166 T12=PBX(L,NC)                                                         
      T13=PBY(L,NC)                                                         
      T14=BX(L,NC)                                                          
      T15=BY(L,NC)                                                          
      T16=CX(L,NC)                                                          
      T17=CY(L,NC)                                                          
      T18=ASZ(L,NC)                                                         
      T19=D(L,NC)                                                           
      T20=R(L,NC)                                                           
      T21=PEX(L,NC)                                                         
      T22=PEY(L,NC)                                                         
      T23=CKC(L,NC)                                                         
      T24=APC(L,NC)                                                         
      T25=ST(L,NC)                                                          
      T37 = AEFE(L,NC)                                                      
      IF(T18)602,668,602                                                    
  668 T14=(T21-T12)/T25                                                     
      T15=(T22-T13)/T25                                                     
  602 I=1                                                                   
  167 IF(IR-I)169,168,168                                                   
  168 BZ(I)=0.0D0                                                           
      I=I+1                                                                 
      GO TO 167                                                             
  169 NH=1                                                                  
      T7=T1                                                                 
      T8=T2                                                                 
  170 IF(IS-NH)196,171,171                                                  
  171 I=1                                                                   
      T26=A1                                                                
  172 IF(IR-I)195,173,173                                                   
  173 IF(T18)174,190,174                                                    
  174 T27=T26*T8-T16                                                        
      T28=T26*T7-T17                                                        
C                                                                           
C * * TEST AND SET 0/0 TO 0, AND ARCSIN = PI/2 - MCNEILLY                   
C                                                                           
        IF( T27 .NE. 0D0  .OR.  T28 .NE. 0D0 ) GO TO 175                    
        T29 = 0D0                                                           
        T31 = 0D0                                                           
        T32 = 0D0                                                           
        T27 = 1.57079633D0                                                  
        GO TO 176                                                           
175     CONTINUE                                                            
      T29=DSQRT (T27*T27+T28*T28)                                           
      T31=(T14*T27+T15*T28)/T29                                             
      T32 = DABS ((T27*T15 - T28*T14)/T29)                                  
      T27 = ARCSIN(T31,T32)                                                 
  176 GOTOKVE12,(177,181)                                                   
  177 GOTOKVE13,(178,179,180)                                               
  178 T28=BZCIR(T20,T29,T9,T27,T19,A5,A6)                                   
      GOTO189                                                               
  179 T28=BZCIR(T20,T29,T9,T27,T19,A5,A6)                                   
      T28=T28*T23                                                           
      GOTO189                                                               
  180 T28 = T23*BZCIR(T20,T29,T37,T27,T19,A5,A6)
      GOTO189                                                               
  181 IF(T9-4.0D0/A6)182,182,177                                            
  182 IF(T27-T19)183,183,185                                                
  183 IF(DABS (T20-T29)-T24)184,184,177                                     
  185 IF(DABS (T20-T29)-T24)186,186,177                                     
  186 IF(T24-T20*(3.14159265D0-T19))187,184,184                             
  187 IF(T20*(T27-T19)-T24)184,184,177                                      
  184 T31=T20+T10/T30                                                       
      T32=T9+T11/T30                                                        
      T28=BZCIR(T31,T29,T32,T27,T19,A5,A6)*(T20/T31)                        
      T32=T9-T11/T30                                                        
      T28=T28+(T20/T31)*BZCIR(T31,T29,T32,T27,T19,A5,A6)                    
      T31=T20-T10/T30                                                       
      T28=T28+(T20/T31)*BZCIR(T31,T29,T32,T27,T19,A5,A6)                    
      T32=T9+T11/T30                                                        
      T28=T28+(T20/T31)*BZCIR(T31,T29,T32,T27,T19,A5,A6)                    
      T28=0.25D0*T28*T23                                                    
      IF(T18)188,188,189                                                    
  188 T28=-T28                                                              
  189 BZ(I)=BZ(I)+T28                                                       
      BZT(I)=BZT(I)+T28                                                     
      I=I+1                                                                 
      T26=T26+A2                                                            
      GOTO172                                                               
  190 T31=T15*(T26*T8-T12)-T14*(T26*T7-T13)                                 
      T32=T14*(T26*T8-T12)+T15*(T26*T7-T13)                                 
      GOTOKVE14,(191,192)                                                   
  191 T28=BZSTR(T31,T32,T9,T25,A5,A6)                                       
      GOTO189                                                               
  192 IF(T9-4.0D0/A6)193,193,191                                            
  193 T27=DSQRT (T31*T31+T32*T32)                                           
      T28=DSQRT (T31*T31+(T32-T25)*(T32-T25))                               
      IF(T27+T28-(A11/A6)-ST(L,NC))194,194,191                              
  194 T27=T31+T10/T30                                                       
      T33=T9+T11/T30                                                        
      T28=BZSTR(T27,T32,T33,T25,A5,A6)                                      
      T33=T9-T11/T30                                                        
      T28=T28+BZSTR(T27,T32,T33,T25,A5,A6)                                  
      T27=T31-T10/T30                                                       
      T28=T28+BZSTR(T27,T32,T33,T25,A5,A6)                                  
      T33=T9+T11/T30                                                        
      T28=0.25D0*(T28+BZSTR(T27,T32,T33,T25,A5,A6))                         
      GOTO189                                                               
  195 NH=NH+1                                                               
      T34=T7*T4+T8*T3                                                       
      T8=T8*T4-T7*T3                                                        
      T7=T34                                                                
      GOTO170                                                               
  196 GOTOKVE15,(197,198)                                                   
  197 NC=NC+1                                                               
      GOTO165                                                               
  198 THETA=FLOAT (J)                                                       
      THETA=(A3+(THETA-1.0D0)*A4)*57.2957795D0                              
C  199 WRITE(7,200)L,NC,THETA                                       
C  200 FORMAT(1H ,51X,18HMAGNETIC INDUCTION/33X,                            
C     111HCIRCUIT NO.I2,15H, CONDUCTOR NO.I3,                               
C     29H, THETA =F8.3,8H DEGREES/43X,6H(R IN ,                             
C     330HCYCLOTRON UNITS, B IN GAUSSES)/                                   
C     41H0,52X,1HR,12X,1HB)                                                 
C  201 WRITE(7,202)(RR(I),BZ(I),I=1,IR)                             
  202 FORMAT(50H                                                            
     1,F8.5,F15.5)
C                                                                           
C     SECTION ADDED BY LBM TO IMPROVE PRINTOUT AND SAVE FEILD               
C     VALUES ON UNIT ISAVE                                                  
C                                                                           
199     IF(IPAGE.NE.0) GO TO 1200                                           
        IF(L.EQ.1.AND.ISAVE.NE.0)                                           
     &  WRITE(ISAVE,1011) IR,IT,IC,A1,A2,A6,RCINIT,RCDEL                    
1011    FORMAT(3I5,5F10.5)                                                  
        WRITE(7,1201) THETA                                                 
1201    FORMAT(37X,'MAGNETIC INDUCTION AT THETA =',F7.2,' DEGREES')     
        WRITE(7,1202)                                                       
1202  FORMAT(43X,'(R IN CYCLOTRON UNITS, B IN GAUSS)')
1200    IPAGE=IPAGE+1                                                       
        LTMP(IPAGE)=L                                                       
        NCTMP(IPAGE)=NC                                                     
        DO 1205 I=1,IR                                                      
        BZTMP(I,IPAGE)=BZ(I)                                                
1205    CONTINUE                                                            
        IF(ISAVE.NE.0) WRITE(ISAVE,1500) THETA,L,NC,(BZ(IB),IB=1,IR)        
1500    FORMAT(F5.0,2I5,(5F12.5))                                           
        IF(IPAGE.NE.NCMAX.AND.L.NE.IC) GO TO 197                            
        WRITE(7,1206) (LBLCIR,LTMP(IL),IL=1,IPAGE)                                 
1206    FORMAT(5X,'R',2X,10(2X,A6,I3))                           
        WRITE(7,1207) (LBLCON,NCTMP(IL),IL=1,IPAGE)                                
1207    FORMAT(8X,10(2X,A6,I3))                                
        DO 1210 IP=1,IR                                                     
        WRITE(7,1211) RR(IP),(BZTMP(IP,IPG),IPG=1,IPAGE)                    
1211    FORMAT(1X,F7.2,10F11.4)                                                 
1210    CONTINUE                                                            
        IPAGE=0                                                             
        GO TO 197                                                           
C                                                                           
C     END OF SECTION                                                        
C                                                                           
  203 L=L+1                                                                 
      GOTO163                                                               
  204 GOTOKVE16,(205,206)                                                   
  205 J=J+1                                                                 
      T34=T1*T6+T2*T5                                                       
      T2=T2*T6-T1*T5                                                        
      T1=T34
Cjbb               !print out busy bar element here
 2205 BBCTR=BBCTR+1
      IF(BBCTR.LE.60) THEN
        WRITE(6,4310) BBCHR
 4310   FORMAT(1A,$)
      ELSE
        BBCTR=0
        WRITE(6,4311)
 4311   FORMAT(1X/4X,'-',$)
        GO TO 2205
      END IF
Cjbb                                                                
      GOTO159                                                               
  206 THETA=FLOAT (J)                                                       
      THETA=(A3+(THETA-1.0D0)*A4)*57.2957795D0                              
C
C     instead of the following print at each angle, let's save the
C     information in an array and print a summary table at the very end
C
c      WRITE(7,207)THETA                                            
C  207 FORMAT(1H ,34X,25HSUMMARY OF TOTAL MAGNETIC INDUCTION ,                          
C     111HAT THETA = ,F7.3,8H DEGREES/43X,6H(R IN ,
C     230HCYCLOTRON UNITS, B IN GAUSSES)/1H0,52X,
C     31HR,12X,1HB)                                                          
C      WRITE(7,202)(RR(I),BZT(I),I=1,IR)                            
CC                                                                           
CC     ADDITION BY LBM TO OUTPUT SUMMED FIELDS TO UNIT ISUM                  
CC                                                                           
C        IF(ISUM.NE.0) WRITE (ISUM,2202) (RR(I),BZT(I),I=1,IR)               
C2202    FORMAT(1H ,F8.5,F15.5)                                              
C
C     here we build the summary array
C
      IF(ABS(THETA-THETA1).LT.0.001) THEN
        DO 410 KIR=1,IR          !write radii in first column
  410   SUMRES(KIR+1,1)=RR(KIR)  !but skip first cell
      END IF                     !then,
      SUMRES(1,J+1)=THETA        !first cell in each column is theta
      DO 412 KIR=1,IR            !and rest of cells are field data
  412 SUMRES(KIR+1,J+1)=BZT(KIR)
C
      GOTO205                                                               
  208 GOTO900                                                               
C
C     now print out the summary array
C
  900 WRITE(7,4900)
 4900 FORMAT(//1X,'SUMMARY OF TOTAL MAGNETIC INDUCTION   ',
     1  '(R IN CYCLOTRON UNITS, B IN GAUSS)')
      NCOLT=IT
      NCOL1=2
  415 IF(NCOLT.GT.10) THEN       !print max of 10 theta at a time
        NCOL2=NCOL1+9
      ELSE
        NCOL2=IT+1
      END IF
      WRITE(7,4902) (SUMRES(1,KIT),KIT=NCOL1,NCOL2)
 4902 FORMAT(/5X,'R',2X,10(F7.1,' DEG'))
      DO 420 KIR=1,IR
  420 WRITE(7,4904) SUMRES(KIR+1,1),(SUMRES(KIR+1,KIT),KIT=NCOL1,NCOL2)
 4904 FORMAT(1X,F7.2,10F11.3)
      IF(NCOLT.GT.10) THEN
        NCOLT=NCOLT-10
        NCOL1=NCOL2+1
        GO TO 415
      END IF
C
C     summary array printed - end of case
C
      WRITE(7,4910)
 4910 FORMAT(/1X,'***** END SUMMARY *****')
C
C     now if ISUM is not zero, offer to write the summary table to file
C
      IF(ISUM.EQ.0) GO TO 470
  440 WRITE(6,4440)
 4440 FORMAT(//' Input name for special field summary file: ',$)
  442 READ(5,4442) FILNAM11
 4442 FORMAT(A)
      IF(LEN_TRIM(FILNAM11).EQ.0) THEN       !if null input, don't write file
        WRITE(6,4444)
 4444   FORMAT(/1X,'*** NO SPECIAL FIELD SUMMARY FILE WRITTEN ***')
        GO TO 470
      ELSE 
        OPEN(UNIT   = 11,
     &       FILE   = FILNAM11,
     &       STATUS = 'NEW',
     &       IOSTAT = IOS)
      END IF
      IF(IOS.EQ.0) GO TO 450
C
      LNAM=LEN_TRIM(FILNAM11)
  446 WRITE(6,4446) FILNAM11(:LNAM)
 4446 FORMAT(/' ### File ',A,' already exists!  Overwrite (Y/N)? ',$)
  448 READ(5,4448) KF
 4448 FORMAT(A1)
      IF(KF.EQ.'Y'.OR.KF.EQ.'y') THEN
        OPEN(UNIT   = 11,
     &       FILE   = FILNAM11,
     &       STATUS = 'UNKNOWN',
     &       IOSTAT = IOS)
      ELSE
        GO TO 440
      END IF      
C               write summary data array to file on unit=11
C
  450 WRITE(11,4450) 'P',IR,IT,(IDINT(SUMRES(ICOL,1)),ICOL=2,IR+1)
 4450 FORMAT(A1,I4,I5,200I10)
      DO 452 IROW=2,IT+1
  452 WRITE(11,4452) IDINT(SUMRES(1,IROW)),
     1  (SUMRES(ICOL,IROW)/1000,ICOL=2,IR+1)   !output field in KG
 4452 FORMAT(I10,200F10.4)
  456 WRITE(6,4456)FILNAM11
 4456 FORMAT(/1X,'Summary data file written to: ',A)
      CLOSE(UNIT=11)
C
  470 READ(4,901)SWC                                               
  901 FORMAT(I1)                                                            
      IF(SWC.NE.0) WRITE(7,1013)SWC                                             
 1013 FORMAT(//6X,I1)                                                     
 1000 GO TO 1003                                                            
 1003 IF(SWC)902,902,209                                                    
902     RETURN                                                              
      END
C
C     **************************************************************************
        SUBROUTINE TEST( BZ )                                               
        IMPLICIT REAL*8(A-H,O-Z)                                            
        DIMENSION BZ(1)                                                     
        T1=DSQRT (1.0D0/3.0D0)                                              
      T2=DSQRT (3.0D0/5.0D0)                                                
      T3=10.0D0/81.0D0                                                      
      T4=25.0D0/324.0D0                                                     
      T5=16.0D0/81.0D0                                                      
      T6=-49.0D0/162.0D0                                                    
      T10=DSQRT (443.0D0/875.0D0)                                           
      T7=DSQRT (5.0D0*(1.0D0+T10)/9.0D0)                                    
      T8=DSQRT (5.0D0*(1.0D0-T10)/9.0D0)                                    
      T9=(161.0D0/1296.0D0)*(1.0D0-373.0D0/(805.0D0*T10))                   
      T10=(161.0D0/1296.0D0)*(1.0D0+373.0D0/(805.0D0*T10))                  
      L=1                                                                   
      READ(4,230)MST,MC                                                   
      WRITE(7,230)MST,MC                                                   
 1008 FORMAT(1H ,6X,2I3)                                                    
230   FORMAT(2I3)                                                           
231   IF(MST - L)255,235,235                                                
  235 READ (4,232)A7,A10,A1,A2,A3,A4,A8,A9                                  
      WRITE(7,232)A7,A10,A1,A2,A3,A4,A8,A9                                  
 1009 FORMAT(1H ,6X,8F9.6)                                                  
  232 FORMAT(8F9.6)                                                         
      READ (4,233)A5,A6,IR,IT                                               
      WRITE(7,233)A5,A6,IR,IT                                               
 1010 FORMAT(1H ,6X,F9.4,F9.5,2I3)                                          
  233 FORMAT(F9.4,F9.5,2I3)                                                 
      J=1                                                                   
      T11=A3                                                                
  234 IF(IT-J)254,236,236                                                   
  236 I=1                                                                   
      IU=1                                                                  
      T12=A1                                                                
  237 IF(IR-I)247,238,238                                                   
  238 BZ(IU)=BZSTR(T12,T11,A7,A10,A5,A6)                                    
      T13=T12+T1*A8                                                         
      T14=A7+T1*A9                                                          
      T15=BZSTR(T13,T11,T14,A10,A5,A6)                                      
      T14=A7-T1*A9                                                          
      T15=T15+BZSTR(T13,T11,T14,A10,A5,A6)                                  
  239 T13=T12-T1*A8                                                         
      T15=T15+BZSTR(T13,T11,T14,A10,A5,A6)                                  
      T14=A7+T1*A9                                                          
      BZ(IU+1)=0.25D0*(T15+BZSTR(T13,T11,T14,A10,A5,A6))                    
      T15=T5*BZSTR(T12,T11,A7,A10,A5,A6)                                    
      T13=T12+T2*A8                                                         
      T15=T15+T3*BZSTR(T13,T11,A7,A10,A5,A6)                                
  240 T13=T12-T2*A8                                                         
      T15=T15+T3*BZSTR(T13,T11,A7,A10,A5,A6)                                
      T14=A7+T2*A9                                                          
      T15=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                               
      T13=T12+T2*A8                                                         
      T15=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                               
  241 T15=T15+T3*BZSTR(T12,T11,T14,A10,A5,A6)                               
      T14=A7-T2*A9                                                          
      T15=T15+T3*BZSTR(T12,T11,T14,A10,A5,A6)                               
      T15=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                               
      T13=T12-T2*A8                                                         
  242 BZ(IU+2)=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                          
      T15=T6*BZSTR(T12,T11,A7,A10,A5,A6)                                    
      T14=A7+T8*A9                                                          
      T15=T15+T10*BZSTR(T12,T11,T14,A10,A5,A6)                              
      T14=A7-T8*A9                                                          
      T15=T15+T10*BZSTR(T12,T11,T14,A10,A5,A6)                              
      T14=A7+T7*A9                                                          
  243 T15=T15+T9*BZSTR(T12,T11,T14,A10,A5,A6)                               
      T14=A7-T7*A9                                                          
      T15=T15+T9*BZSTR(T12,T11,T14,A10,A5,A6)                               
      T13=T12+T8*A8                                                         
      T15=T15+T10*BZSTR(T13,T11,A7,A10,A5,A6)                               
      T13=T12-T8*A8                                                         
  244 T15=T15+T10*BZSTR(T13,T11,A7,A10,A5,A6)                               
      T13=T12+T7*A8                                                         
      T15=T15+T9*BZSTR(T13,T11,A7,A10,A5,A6)                                
      T13=T12-T7*A8                                                         
      T15=T15+T9*BZSTR(T13,T11,A7,A10,A5,A6)                                
      T13=T12+T2*A8                                                         
  245 T14=A7+T2*A9                                                          
      T15=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                               
      T13=T12-T2*A8                                                         
      T15=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                               
      T14=A7-T2*A8                                                          
      T15=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                               
      T13=T12+T2*A8                                                         
  246 BZ(IU+3)=T15+T4*BZSTR(T13,T11,T14,A10,A5,A6)                          
      I=I+1                                                                 
      IU=IU+4                                                               
      T12=T12+A2                                                            
      GOTO237                                                               
  247 WRITE(7,248)A5,A10,T11                                                
  248 FORMAT(1H ,12X,29HCOMPARISON OF APPROXIMATIONS ,                      
     152HTO THE INDUCTION (GAUSSES) AT POINTS X,Y (CYCLOTRON ,              
     215HUNITS) DUE TO A/24X,20HCURRENT I (AMPERES) ,                       
     336HIN A STRAIGHT CONDUCTOR OF LENGTH L ,                              
     417H(CYCLOTRON UNITS)/31X,4HI = ,F9.4,
     510X,4HL = ,F9.6,10X,4HY = ,F9.6)
      WRITE(7,249)                                                          
  249 FORMAT(1H0,19X,1HX,16X,6HZEROTH,15X,5HFIRST,                          
     114X,6HSECOND,15X,5HTHIRD)                                             
      T20=A1                                                                
      I=1                                                                   
      IU=1                                                                  
  252 IF(IR-I)253,250,250                                                   
  250 T21=BZ(IU)                                                            
      T22=BZ(IU+1)                                                          
      T23=BZ(IU+2)                                                          
      T24=BZ(IU+3)                                                          
      WRITE(7,251)T20,T21,T22,T23,T24                                       
  251 FORMAT(1H ,F24.6,4F20.5)
      I=I+1                                                                 
      IU=IU+4                                                               
      T20=T20+A2                                                            
      GOTO252                                                               
  253 J=J+1                                                                 
      T11=T11+A4                                                            
      GOTO234                                                               
  254 L=L+1                                                                 
      GOTO231                                                               
  255 L=1                                                                   
  256 IF(MC-L)293,257,257                                                   
  257 READ (4,258)A7,A1,A2,A10,A3,A4,A11                                    
      WRITE(7,258)A7,A1,A2,A10,A3,A4,A11                                    
 1011 FORMAT(1H ,6X,4F9.6,3F9.4)                                            
  258 FORMAT(4F9.6,3F9.4)                                                   
      READ (4,259)A8,A9,A5,A6,IR,IT,IWW                                     
      WRITE(7,259)A8,A9,A5,A6,IR,IT,IWW                                     
 1012 FORMAT(1H ,6X,2F9.6,F9.4,F9.5,3I3)                                    
  259 FORMAT(2F9.6,F9.4,F9.5,3I3)                                           
      A3=A3/57.2957795D0                                                    
      A4=A4/57.2957795D0                                                    
      A11=A11/57.2957795D0                                                  
      T13=(A8/A10)**2                                                       
      T14=1.0D0                                                             
      T15=1.0D0                                                             
  260 T16=1.0D0                                                             
  261 T16=((2.0D0*T14-1.0D0)/(2.0D0*T14+1.0D0))*T16*T13                     
      T15=T15+T16                                                           
  714 IF(T16 - 1.0D-8) 262, 262, 351                                        
  351 T14 = T14 + 1.0D0                                                     
      GO TO 261                                                             
  262 T13=1.0D0/T15                                                         
  352 T16 = DSQRT ((A10-A8)**2+A7**2)                                       
      T17 = DSQRT ((A10+A8)**2+A7**2)                                       
      T18 = A9/T16                                                          
      T19 = A9/T17                                                          
  353 T20 = A7/T16                                                          
      T21 = A7/T17                                                          
      T22 = (T18*T18+T18*T19+T19*T19)                                       
      T23 = T18*T18*T20+T19*T19*T21                                         
      T24 = T20+T21                                                         
  354 T25 = T18*T19*T20*T21                                                 
      T26 = T18**3+T19**3                                                   
      T27 = T18+T19                                                         
      T28 = T18*T19                                                         
      T29 = T18**4+T19**4                                                   
  355 T30 = T20*T20+T20*T21+T21*T21                                         
      T31 = T18**4*T20+T19**4*T21                                           
      T32 = T20*T20+T21*T21                                                 
      T33 = T18**6+T19**6                                                   
  356 T34 = T20**3+T21**3                                                   
      T35 = (T20*T21)**2                                                    
      T36 = T18**6*T20+T19**6*T21                                           
      T37 = T20**4+T35+T21**4                                               
  357 T37 = (33.0D0/16.0D0)*(T36*T37*T24+T25**3)                            
      T36 = (-45.0D0/16.0D0)*(T33*(T24*T34+T35)+T28*T25*T25)                
      T35 = (15.0D0/16.0D0)*(T33*T30+T28*T25*T22)                           
      T34 = (-5.0D0/112.0D0)*(T29*T22+T28**3)                               
  358 T33 = (5.0D0/7.0D0)*(T31*T32*T24+T25*T25)                             
      T32 = (-3.0D0/4.0D0)*(T29*T30+T28*T25)                                
      T31 = (3.0D0/40.0D0)*(T26*T27+T28*T28)                                
      T30 = (1.0D0/2.0D0)*(T23*T24+T25)                                     
  359 T29 = -T22/6.0D0                                                      
      T28 = 1.0D0+T29+T30+T31+T32+T33+T34+T35+T36+T37                       
      T27 = (1.0D0/2.0D0)*(T16/A10)*(T17/A10)*((T16+T17)/A10)*(1.0D0/T28    
     >)                                                                     
      T26 = (2.0D0/3.0D0)*DLOG(T27)                                         
  360 T25 = DEXP (T26)                                                      
      T40 = A10*DSQRT (T25-1.0D0)                                           
      IF(IWW-4)263,294,294                                                  
  263 ASSIGN283TOKVE18                                                      
      IF(IWW-2)264,265,266                                                  
  264 ASSIGN272TOKVE17                                                      
      GOTO267                                                               
  265 ASSIGN273TOKVE17                                                      
      GOTO267                                                               
  266 ASSIGN274TOKVE17                                                      
  267 J=1                                                                   
      T11=A3                                                                
  268 IF(IT-J)292,269,269                                                   
  269 I=1                                                                   
      IU=1                                                                  
      T12=A1                                                                
  270 IF(IR-I)284,271,271                                                   
  271 GOTOKVE17,(272,273,274)                                               
  272 BZ(IU)=BZCIR(A10,T12,A7,T11,A11,A5,A6)                                
      GOTO275                                                               
  273 BZ(IU)=T13*BZCIR(A10,T12,A7,T11,A11,A5,A6)                            
      GOTO275                                                               
  274 BZ(IU) = T13*BZCIR(A10,T12,T40,T11,A11,A5,A6)                         
  275 T14=A10+T1*A8                                                         
      T15=A7+T1*A9                                                          
      T16=0.25D0*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T14=A10-T1*A8                                                         
      T16=T16+0.25D0*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)             
      T15=A7-T1*A9                                                          
  276 T16=T16+0.25D0*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)             
      T14=A10+T1*A8                                                         
      BZ(IU+1)=T16+0.25D0*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)        
  277 T16=T5*BZCIR(A10,T12,A7,T11,A11,A5,A6)                                
      T14=A10+T2*A8                                                         
      T16=T16+T3*(A10/T14)*BZCIR(T14,T12,A7,T11,A11,A5,A6)                  
      T15=A7+T2*A9                                                          
      T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T16=T16+T3*BZCIR(A10,T12,T15,T11,A11,A5,A6)                           
      T14=A10-T2*A8                                                         
  278 T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T16=T16+T3*(A10/T14)*BZCIR(T14,T12,A7,T11,A11,A5,A6)                  
      T15=A7-T2*A9                                                          
      T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T16=T16+T3*BZCIR(A10,T12,T15,T11,A11,A5,A6)                           
      T14=A10+T2*A8                                                         
      BZ(IU+2)=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)            
  279 T16=T6*BZCIR(A10,T12,A7,T11,A11,A5,A6)                                
      T14=A10+T8*A8                                                         
      T16=T16+T10*(A10/T14)*BZCIR(T14,T12,A7,T11,A11,A5,A6)                 
      T14=A10-T8*A8                                                         
      T16=T16+T10*(A10/T14)*BZCIR(T14,T12,A7,T11,A11,A5,A6)                 
      T14=A10+T7*A8                                                         
      T16=T16+T9*(A10/T14)*BZCIR(T14,T12,A7,T11,A11,A5,A6)                  
      T14=A10-T7*A8                                                         
  280 T16=T16+T9*(A10/T14)*BZCIR(T14,T12,A7,T11,A11,A5,A6)                  
      T15=A7+T8*A9                                                          
      T16=T16+T10*BZCIR(A10,T12,T15,T11,A11,A5,A6)                          
      T15=A7-T8*A9                                                          
      T16=T16+T10*BZCIR(A10,T12,T15,T11,A11,A5,A6)                          
      T15=A7+T7*A9                                                          
      T16=T16+T9*BZCIR(A10,T12,T15,T11,A11,A5,A6)                           
  281 T15=A7-T7*A9                                                          
      T16=T16+T9*BZCIR(A10,T12,T15,T11,A11,A5,A6)                           
      T14=A10+T2*A8                                                         
      T15=A7+T2*A9                                                          
      T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T14=A10-T2*A8                                                         
  282 T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T15=A7-T2*A9                                                          
      T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      T14=A10+T2*A8                                                         
      T16=T16+T4*(A10/T14)*BZCIR(T14,T12,T15,T11,A11,A5,A6)                 
      GOTOKVE18,(283,299)                                                   
  283 BZ(IU+3)=T16                                                          
      I=I+1                                                                 
      IU=IU+4                                                               
      T12=T12+A2                                                            
      GOTO270                                                               
  284 WRITE(7,285)                                                          
  285 FORMAT(1H ,2X,29HCOMPARISON OF APPROXIMATIONS ,                       
     141HTO THE INDUCTION (GAUSSES) AT THE POINTS ,                         
     237HR (CYCLOTRON UNITS), THETA (DEGREES) ,                             
     38HDUE TO A/12X,23HCURRENT I (AMPERES) IN ,                            
     439HA CIRCULAR ARC OF RADIUS RR (CYCLOTRON ,                           
     535HUNITS) AND HALF ANGLE PHI (DEGREES))                               
      T20=A11*57.2957795D0                                                  
      T21=T11*57.2957795D0                                                  
      WRITE(7,286)A5,A10,T20,T21                                            
  286 FORMAT(20H0               I = ,F9.4,15H          RR = ,F9.6,
     116H          PHI = ,F9.4,18H          THETA = ,F9.4)
      WRITE(7,287)                                                          
      T20=A1                                                                
  287 FORMAT(1H0,19X,1HR,16X,6HZEROTH,15X,                                  
     15HFIRST,14X,6HSECOND,15X,5HTHIRD)                                     
      I=1                                                                   
      IU=1                                                                  
  288 IF(IR-I)291,289,289                                                   
  289 T21=BZ(IU)                                                            
      T22=BZ(IU+1)                                                          
      T23=BZ(IU+2)                                                          
      T24=BZ(IU+3)                                                          
      WRITE(7,290)T20,T21,T22,T23,T24                                       
  290 FORMAT(1H ,F24.6,4F20.5)
      I=I+1                                                                 
      IU=IU+4                                                               
      T20=T20+A2                                                            
      GOTO288                                                               
  291 J=J+1                                                                 
      T11=T11+A4                                                            
      GOTO268                                                               
  292 L=L+1                                                                 
      GOTO256                                                               
  293 RETURN                                                              
  294 ASSIGN299TOKVE18                                                      
      J=1                                                                   
      T11=A3                                                                
  295 IF(IT-J)308,296,296                                                   
  296 I=1                                                                   
      IU=1                                                                  
      T12=A1                                                                
  297 IF(IR-I)300,298,298                                                   
  298 T20=BZCIR(A10,T12,A7,T11,A11,A5,A6)                                   
      T21=T13*T20                                                           
      T22 = T13*BZCIR(A10,T12,T40,T11,A11,A5,A6)                            
      GOTO279                                                               
  299 BZ(IU)=T16                                                            
      BZ(IU+1)=T20                                                          
      BZ(IU+2)=T21                                                          
      BZ(IU+3)=T22                                                          
      BZ(IU+4)=T20-T16                                                      
      BZ(IU+5)=T21-T16                                                      
      BZ(IU+6)=T22-T16                                                      
      I=I+1                                                                 
      IU=IU+7                                                               
      T12=T12+A2                                                            
      GOTO297                                                               
  300 WRITE(7,301)                                                          
  301 FORMAT(37H  COMPARISON OF ZEROTH APPROXIMATIONS,                      
     140H TO THE INDUCTION (GAUSSES) AT POINTS R ,                          
     239H(CYCLOTRON UNITS), THETA (DEGREES) DUE ,                           
     34HTO A/13X,25HCURRENT I (AMPERES) IN A ,                              
     443HCIRCULAR ARC OF RADIUS S (CYCLOTRON UNITS) ,                       
     528HAND HALF ANGLE PHI (DEGREES))                                      
      T20=A11*57.2957795D0                                                  
      T21=T11*57.2957795D0                                                  
      WRITE(7,302)A5,A10,T20,T21                                            
  302 FORMAT(21H0                I = ,F9.4,14H          S = ,F9.6,
     116H          PHI = ,F9.4,18H          THETA = ,F9.4)
      WRITE(7,303)                                                          
  303 FORMAT(1H0,7X,1HR,12X,5HTHIRD,12X,1HA,14X,                            
     11HB,14X,1HC,11X,7HA-THIRD,8X,7HB-THIRD,                               
     28X,7HC-THIRD)                                                         
      T20=A1                                                                
      I=1                                                                   
      IU=1                                                                  
  304 IF(IR-I)307,305,305                                                   
  305 T21=BZ(IU)                                                            
      T22=BZ(IU+1)                                                          
      T23=BZ(IU+2)                                                          
      T24=BZ(IU+3)                                                          
      T25=BZ(IU+4)                                                          
      T26=BZ(IU+5)                                                          
      T27=BZ(IU+6)                                                          
      WRITE(7,306)T20,T21,T22,T23,T24,T25,T26,T27                           
  306 FORMAT(1H ,F12.6,7F15.5)
      I=I+1                                                                 
      IU=IU+7                                                               
      T20=T20+A2                                                            
      GOTO304                                                               
  307 J=J+1                                                                 
      T11=T11+A4                                                            
      GOTO295                                                               
  308 L=L+1                                                                 
      GOTO256                                                               
        END                                                                 
C
C
      FUNCTION BZCIR(RB,RS,A,TH,PHE,CYC,CYL)
      IMPLICIT REAL*8(A-H,O-Z)
      COMMON/NORM/ RENORM     !added to pass renormalization factor
  708 TT1=(RB+RS)**2+A*A                                                    
      TT2=0.5D0*(3.14159265D0+PHE+TH)                                       
      TT3=DABS (4.0D0*RS*RB/TT1)                                            
      TT1=DSQRT (TT1)                                                       
      TT1=(0.07874D0*CYC)/(CYL*TT1)                                         
      TT4=(RB*RB-RS*RS-A*A)/((RB-RS)**2+(A*A))                              
      TT5=0.5D0*TT3*TT4                                                     
  709 CALL ELIPIN(TT2,TT3,TT6,TT7)                                           
      TT2=0.5D0*(3.14159265D0+TH-PHE)                                       
      CALL ELIPIN(TT2,TT3,TT8,TT9)                                           
      TT2=DSIN (TH+PHE)                                                     
      TT10=DCOS (0.5D0*(TH+PHE))                                            
  710 TT2=TT2/(DSQRT (1.0D0-TT3*TT10*TT10))                                 
      TT10=DSIN (PHE-TH)                                                    
      TT11=DCOS (0.5D0*(PHE-TH))                                            
      TT10=TT10/(DSQRT (1.0D0-TT3*TT11*TT11))                               
  711 BZCIR=TT1*(TT6-TT8+TT4*(TT7-TT9)+TT5*(TT2+TT10))
C       the following renormalization is introduced to handle
C       case of data symmetric about median plane - jbb 7/17/06
      BZCIR=BZCIR*RENORM
      RETURN                                                                
      END                                                                   
C
C
      FUNCTION BZSTR(X,Y,A,STL,CYC,CYL)                                      
      IMPLICIT REAL*8(A-H,O-Z)                                              
      COMMON/NORM/ RENORM     !added to pass renormalization factor
  712 SSA=(0.07874D0*CYC*X)/(CYL*(X*X+A*A))                                 
      SSB=(Y-STL)/DSQRT (X*X+A*A+(Y-STL)*(Y-STL))                           
      SSC=Y/DSQRT (X*X+A*A+Y*Y)                                             
  713 BZSTR=SSA*(SSB-SSC)                                                   
C       the following renormalization is introduced to handle
C       case of data symmetric about median plane - jbb 7/17/06
      BZSTR=BZSTR*RENORM
      RETURN                                                                
      END
C
C                                                                   
      SUBROUTINE ELIPIN(TH,PK2,FKEI,EKEI)                                    
      IMPLICIT REAL*8(A-H,O-Z)
  701 IF(TH-3.14159265D0)12,13,13                                           
   12 KX3=0                                                                 
      QX4=TH                                                                
      GOTO14                                                                
   13 IF(TH-6.2831853D0)707,37,37                                           
  707 KX3=1                                                                 
      QX4=TH-3.14159265D0                                                   
      GO TO 14                                                              
   37 KX3=2                                                                 
      QX4=TH-6.2831853D0                                                    
   14 QX5=DSIN (QX4)                                                        
      QX6=DCOS (QX4)                                                        
   16 QX7=1.0D0                                                             
      QX10=1.0D0                                                            
      QX13=1.0D0                                                            
      QX8=PK2                                                               
      QX9=DSQRT (QX8)                                                       
      QX11=QX9                                                              
      QX12=DSQRT (QX9)                                                      
      QX14=0.0D0                                                            
      ASSIGN26TOKVE1                                                        
      ASSIGN30TOKVE2                                                        
   17 IF(QX11-0.00033D0)36,36,18
   18 QX15=DSQRT (1.0D0-QX8)                                                
      QX16=1.0D0+QX15                                                       
      QX15=(1.0D0-QX15)/QX16                                                
      QX7=0.5D0*(1.0D0+QX15)*QX7
      RTARG=1.0D0-QX8*QX5*QX5
      QX18=(QX16*QX5*QX6)/(DSQRT (1.0D0-QX8*QX5*QX5))                       
      QX18=DABS (QX18)
      IF(QX18.GT.1.0D0) QX18=1.0D0  !avoids very rare case of roundoff error
      QX17=DSQRT (1.0D0-QX18*QX18)                                          
  703 IF(QX5*QX5-1.0D0/QX16)19,22,22                                        
   19 IF(QX6)20,21,21                                                       
   20 KX3=2*KX3+1                                                           
      QX6=-QX17                                                             
      GOTO25                                                                
   21 KX3=2*KX3                                                             
      QX6=QX17                                                              
      GOTO25                                                                
   22 IF(QX6)23,23,24                                                       
   23 KX3=2*KX3+1                                                           
      QX6=QX17                                                              
      GOTO25                                                                
   24 KX3=2*KX3                                                             
      QX6=-QX17                                                             
   25 QX5=QX18
      GOTOKVE1,(26,29)                                                      
   26 QX9=QX9*QX11*0.5D0                                                    
  704 IF(QX9-1.0D-8)28,28,27                                                
   27 QX10=QX10-QX9                                                         
   29 GOTOKVE2,(30,34)                                                      
   28 ASSIGN29TOKVE1                                                        
      GOTO29
   30 QX17=DSQRT (QX11)                                                
      QX12=(0.5D0*QX11/QX13)*QX12*QX17                                      
  705 IF(QX12-1.0D-8)35,35,31                                               
   31 QX17=QX5/QX16                                                         
  706 IF( MOD (KX3,2))32,33,32                                              
   32 QX17=-QX17                                                            
   33 QX14=QX14+QX12*QX17                                                   
      QX13=QX11                                                             
      QX11=QX15                                                             
   34 QX8=QX15*QX15                                                         
      GOTO17                                                                
   35 ASSIGN34TOKVE2                                                        
      GOTO34                                                                
   36 QX18 = ARCSIN(QX6,QX5)                                                
   38 QX17=FLOAT (KX3)                                                      
      QX4=(3.14159265D0*QX17+QX18)*QX7                                      
      QX5=QX4*QX10+QX14                                                     
      FKEI=QX4                                                              
      EKEI=QX5
      RETURN                                                                
      END                                                                   
C
C
      FUNCTION ARCSIN (X,Y)                                                 
      IMPLICIT REAL*8(A-H,O-Z)                                              
    1 S1 = DABS (Y)                                                         
      S2 = DABS (X)                                                         
      IF(S1-S2) 2,3,3                                                       
    2 ASSIGN 9 TO KCE1                                                      
      GO TO 4                                                               
    3 S1 = S2                                                               
      ASSIGN 8 TO KCE1                                                      
    4 S2 = S1*S1                                                            
      S3 = S1                                                               
      S4 = 0.0D0                                                            
    5 IF (S1-1.0D-8)7,7,6                                                   
    6 S1 = ((2.0D0*S4+1.0D0)**2*S2*S1)/((2.0D0*S4+2.0D0)*(2.0D0*S4+3.0D0    
     >))                                                                    
      S3 = S3+S1                                                            
      S4 = S4+1.0D0                                                         
      GO TO 5                                                               
    7 GO TO KCE1, (8,9)                                                     
    8 S3 = 1.57079633D0-S3                                                  
    9 IF(X) 381,10,10                                                       
   10 IF(Y) 380,11,11                                                       
   11 ARCSIN = S3                                                           
      GO TO 384                                                             
  380 ARCSIN = -S3                                                          
      GO TO 384                                                             
  381 IF(Y) 383,382,382                                                     
382   ARCSIN = 3.14159265D0 - S3                                            
      GO TO 384                                                             
  383 ARCSIN = -3.14159265D0+S3                                             
  384 RETURN                                                                
      END                                                                   
