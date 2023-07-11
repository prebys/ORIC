rem Build acclib.obj and jbaccel.exe
ifort /c acclib.for
ifort jbaccel.for acclib.obj
