REM Updated to work with Intel compiler
REM 20230712 EjP
REM FL /W2 /Fs  jbpfield.for ..\jbaccel\acclib.obj
ifort jbpfield.for ..\jbaccel\acclib.obj
