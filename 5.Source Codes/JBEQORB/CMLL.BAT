REM Updated for Intel compiler. Also suppressing formatting remark
REM 20230712 EjP
REM FL /Fs /MW jbeqorb.for acclib.obj
ifort jbeqorb.for  -Qdiag-disable=8291 ..\JBACCEL\acclib.obj
