REM Updated for Intel Compiler. Also suppressing formatting remark.
REM 20230712 EjP
REM FL /Fs /MW jbisoc.for acclib.obj
ifort jbisoc.for  -Qdiag-disable=8291 ..\JBACCEL\ACCLIB.OBJ