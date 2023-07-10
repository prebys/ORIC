This is a version of the accelerator ORIC accelerator modeling code that has been modified
slightly to work with a fresh XP installation running MS FORTRAN 5.1

The XP setup required to get things working is found here:
https://eprebys.faculty.ucdavis.edu/compiling-oric-code-under-windows-xp/

The only changes relative to the original ORIC files are in the directory "5. Source
Codes" and are as follows:
- I have added the file fortran-setup.bat to define the necessary path variables 
  to run the fortran commands.  These can also be put into AUTOEXEC.BAT
- I've modified the various compilation and linking .bat files to 
    - remove the /MW flag, which doesn't work with this version of FORTRAN
    - link to the copy of ACCLIB.OBJ that's in the JBACCEL directory, so you don't
      have to make copies of it.
      
08-APR-2020	E.Prebys 	Stable
