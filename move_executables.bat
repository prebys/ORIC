REM This file copies all the executable code from the 5.Source Codes tree into this directory to do calculations.
REM 20230713  EjP
REM NOTE! Not working yet for some reason!
REM These are all the FORTRAN programs.
cd %CD%
copy '%CD%\5.Source Codes\JBACCEL\JBACCEL.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JBFLDMAN\JBFLDMAN.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JBPFIELD\JBPFIELD.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\SPIRALJ\SPIRALJ.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JBISOC\JBISOC.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JBEQORB\JBEQORB.EXE' '%CD%\1.ORIC Orbit Calculations\'
REM These are all the Visual Basic Programs
copy '%CD%\5.Source Codes\JBCSTART\JBCSTART.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JBDPLOT\JBDPLOT.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JTRACE\JTrace.EXE' '%CD%\1.ORIC Orbit Calculations\'
copy '%CD%\5.Source Codes\JTRACE\HarmonicA/HarmonicA.EXE' '%CD%\1.ORIC Orbit Calculations\'
