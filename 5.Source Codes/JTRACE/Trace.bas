Attribute VB_Name = "Trace"
' Program TRACE
'
' Calculate and display orbit path as function of incremental radii.
'   Insert stripper foil (change sign of charge) at designated
'     azimuth and follow path of extracted particle.
'
' J. Ball       12/24/06          Date of latest revision: 02/16/07
'
Public X(7000), Y(7000), R(7000) As Single
Public Bfld(-50 To 90, -70 To 50)
Public ISTOP, JR90(100), NR90, LC1pls, LC2pls, LC2ple As Integer
Public I, IM, IZ, MaxStep, Kfoil, LC1ple As Integer
Public minXfld, maxXfld, minYfld, maxYfld As Integer
Public E, BRZ, DPR, CXI, RAV, Afoil, XT, YT, GINC As Single
Public SX1, SY1 As Single
Public namP, fldFile, namVers As String

Public Sub Main()
'  This is the starting routine that sets initial parameters
'    and then loads the main screen
'
   namVers = "Vers. 021607"
   DPR = 57.2957795
   Kfoil = 0       'no stripper foil until called for
   minXfld = -50   'define area of field matrix
   maxYfld = 50
   maxXfld = 90
   minYfld = -70
   MaxStep = 7000   'set maximum number of steps to compute path
' first zero the entire field array
   For IROW = minYfld To maxYfld
     For ICOL = minXfld To maxXfld
       Bfld(ICOL, IROW) = 0#
     Next ICOL
   Next IROW
' and request run data
   frmMain.txtVers.Text = namVers
   frmMain.Show
End Sub

Public Sub JTcode()
'  This subroutine calculates the orbit path of the particle
'    through the magnetic field and then calls PlotPath
'
  On Error GoTo 18
' Get data from input form
   IM = frmMain.txtPartM     'form allows only M = 1 or 2
   If (IM = 1) Then
     PM = 938.255   'particle is a proton
     namP = "Protons"
     fldFile = "CH51fldN.txt"
   End If
   If (IM = 2) Then
     PM = 1875.58   'particle is a deuteron
     namP = "Deuterons"
     fldFile = "CD90fld.txt"
   End If
   Call JTfld
   IZ = frmMain.txtPartZ     'form allows only Z = 1
   E = frmMain.txtPartE
   BRZ = 1.3132 * Sqr(E ^ 2 + 2 * PM * E)
   GINC = Val(frmMain.txtGINC)
   ISTOP = Val(frmMain.txtStop)
   If (ISTOP > MaxStep) Then ISTOP = MaxStep
   RAV = Val(frmMain.txtAvgR)
   Afoil = Val(frmMain.txtStrip)
'
' Get the position of the first point
   CX = Val(frmMain.txtCX)
   CXI = CX    'save value for print output
   CY = 0#
   I = 1
   X(I) = 0#
   Y(I) = Val(frmMain.txtR90)
   R(I) = Y(I)
' Now calculate data by stepping X coordinates
10 I = I + 1
   If (I > ISTOP) Then GoTo 20
   R(I) = CalcR(X(I - 1), Y(I - 1))
   RC = R(I - 1) - R(I)
   CX = (X(I - 1) - CX) * RC / R(I - 1) + CX
   CY = (Y(I - 1) - CY) * RC / R(I - 1) + CY
   If (Y(I - 1) <= CY) Then
     DX = GINC * Sgn(R(I))
   Else
     DX = -GINC * Sgn(R(I))
   End If
   X(I) = X(I - 1) + DX
   Y(I) = Sgn(Y(I - 1) - CY) * Sqr(R(I) ^ 2 - (X(I) - CX) ^ 2) + CY
   If (Abs(Y(I) - Y(I - 1)) < (GINC + 0.1)) Then GoTo 10
' Transition to step Y coordinates
   If (X(I - 1) <= CX) Then
     DY = -GINC * Sgn(R(I))
   Else
     DY = GINC * Sgn(R(I))
   End If
   YN = Fix(Y(I - 1))
   Y(I) = YN
   If (Abs(Y(I - 1) - YN) < 0.3 * GINC) Then Y(I) = YN + DY
   X(I) = Sgn(X(I - 1) - CX) * Sqr(R(I) ^ 2 - (Y(I) - CY) ^ 2) + CX
' Now calculate data by stepping Y coordinates
12 I = I + 1
   If (I > ISTOP) Then GoTo 20
   R(I) = CalcR(X(I - 1), Y(I - 1))
   RC = R(I - 1) - R(I)
   CX = (X(I - 1) - CX) * RC / R(I - 1) + CX
   CY = (Y(I - 1) - CY) * RC / R(I - 1) + CY
   If (X(I - 1) <= CX) Then
     DY = -GINC * Sgn(R(I))
   Else
     DY = GINC * Sgn(R(I))
   End If
   Y(I) = Y(I - 1) + DY
   X(I) = Sgn(X(I - 1) - CX) * Sqr(R(I) ^ 2 - (Y(I) - CY) ^ 2) + CX
   If (Abs(X(I) - X(I - 1)) < (GINC + 0.1)) Then GoTo 12
' Transition to step X coordinates
   If (Y(I - 1) <= CY) Then
     DX = GINC * Sgn(R(I))
   Else
     DX = -GINC * Sgn(R(I))
   End If
   XN = Fix(X(I - 1))
   X(I) = XN
   If (Abs(X(I - 1) - XN) < 0.3 * GINC) Then X(I) = XN + DX
   Y(I) = Sgn(Y(I - 1) - CY) * Sqr(R(I) ^ 2 - (X(I) - CX) ^ 2) + CY
   GoTo 10
' if we get to 18, there was an error - assume exceeded field size
18 ISTOP = I - 1   'so back up one and stop the plot there
   Debug.Print "*** error stop at ISTOP= "; ISTOP
' Now print out test results
20 J = 0
   Open "JTrace.prn" For Output As #2
   For N = 1 To I - 1
     Write #2, N, X(N), Y(N), R(N)
     If (Abs(X(N)) < 0.001) Then
       If (Y(N) > 0) Then
         J = J + 1
         JR90(J) = N
         NR90 = J
         End If
     End If
   Next N
   Close #2
   LC1pls = 0    'set flags for start and stop indicators
   LC1ple = 0    ' for lower channel 1 and 2 magnet poles
   LC2pls = 0
   LC2ple = 0
   Call PlotPath
End Sub

Public Sub JTfld()
'  This routine reads in field data from file
'
   Open fldFile For Input As #1
   Input #1, T$    'skip first line of array
   For IY = -70 To 70
     If (IY < minYfld Or IY > maxYfld) Then GoTo 20
     Input #1, T$   'read each row and skip over first field
     Debug.Print Mid(T$, 1, 60)
     IT = -6
     For IX = -70 To 70  'now get remaining field values from string
       IT = IT + 10
       If (IX < minXfld Or IX > maxXfld) Then GoTo 10
       Bfld(IX, IY) = Val(Mid$(T$, IT, 10))
10   Next IX
20 Next IY
   Close #1
End Sub

Public Sub PlotPath()
'  This routine opens plot form, plots background info, and plots data
'
   frmPlot.Show
   frmPlot.Scale (-60, 50)-(105, -75)
   Call PlotDee
   Call PlotDliner
   Call PlotPole
   Call PlotExitArea
   frmPlot.Circle (0, 0), 0.3   'mark center of machine
   frmPlot.Line (2, 0)-(-2, 0)
   frmPlot.Line (0, 2)-(0, -2)
   For N = 2 To ISTOP
     frmPlot.Line (X(N), Y(N))-(X(N - 1), Y(N - 1)), RGB(255, 51, 51)
   Next N
   Call PlotInfo
End Sub

Public Function CalcR(XT, YT)
'  Function to get field and calculate associated radius of curvature
'
   Dim B(4), BX(4)
'
' set up to interpolate field with call to BINTRP
   IXT = Fix(XT)
   IYT = Fix(YT)
   DELX = XT - IXT
   DELY = YT - IYT
   If (Abs(DELX) < 0.001) Then     'X is an integer axis
     IX = IXT
     If (Abs(DELY) < 0.001) Then   'Y needs no interpolation
       IY = YT
       BVAL = Bfld(IX, IY)
     Else                          'need to interpolate Y
       IYT1 = IYT - 2 * Sgn(DELY)
       For k = 1 To 4
         IY = IYT1 + k * Sgn(DELY)
         B(k) = Bfld(IX, IY)
       Next k
       BVAL = BINTRP(B(), Abs(DELY))
     End If
   Else
     If (Abs(DELY) < 0.001) Then    'Y is an integer axis
       IY = IYT
       IXT1 = IXT - 2 * Sgn(DELX)   'so interpolate X
       For k = 1 To 4
         IX = IXT1 + k * Sgn(DELX)
         B(k) = Bfld(IX, IY)
       Next k
       BVAL = BINTRP(B(), Abs(DELX))
     Else     'neither axis is integer, so interpolate both
       IYT1 = IYT - 2 * Sgn(DELY)
       For k = 1 To 4
         IY = IYT1 + k * Sgn(DELY)
         IXT1 = IXT - 2 * Sgn(DELX)
         For J = 1 To 4
           IX = IXT1 + J * Sgn(DELX)
           BX(J) = Bfld(IX, IY)
         Next J
         B(k) = BINTRP(BX(), Abs(DELX))
       Next k
       BVAL = BINTRP(B(), Abs(DELY))
     End If
   End If
'
' check to see if foil should be inserted
' but allow 2 turns to be plotted first
   Itst = 400 / GINC   'enough steps for 2 turns
   If (I > Itst) Then
     If (IZ <> -1) Then Call ChkFoil
   End If
'
   If (IZ = -1) Then
     Rtst = Sqr(XT ^ 2 + YT ^ 2)
     If (Rtst >= 34) Then   'begin region of LC#1
       Badj = -Val(frmMain.txtLC1)
       If (LC1pls = 0) Then frmPlot.Circle (XT, YT), 0.3, RGB(0, 0, 255)
       LC1pls = 1
     End If
     If (Rtst > 40) Then    'end region of LC#1
       Badj = 0#
       If (LC1ple = 0) Then frmPlot.Circle (XT, YT), 0.3, RGB(0, 0, 255)
       LC1ple = 1
     End If
     If (Rtst >= 42) Then    'begin region of LC#2
       Badj = -Val(frmMain.txtLC2)
       If (LC2pls = 0) Then frmPlot.Circle (XT, YT), 0.3, RGB(0, 0, 255)
       LC2pls = 1
     End If
     If (XT > 18) Then       'end region of LC#2
       Badj = 0#
       If (LC2ple = 0) Then frmPlot.Circle (XT, YT), 0.3, RGB(0, 0, 255)
       LC2ple = 1
     End If
     If (YT < 58#) Then    'path is through the vertical bend magnets
       If (XT > 31#) Then Badj = -Val(frmMain.txtVM1)
       If (XT > 50.5) Then Badj = 0#
       If (XT > 65#) Then Badj = -Val(frmMain.txtVM2)
       If (XT > 77#) Then Badj = 0#
     Else
       Badj = 0#
     End If
   End If
   BVAL = BVAL + Badj
' if BVAL is very small, set maximum calculated radius to 10000 inches
   If (Abs(BVAL) < BRZ / 10000#) Then BVAL = BRZ / 10000#
   CalcR = BRZ / (BVAL * IZ)
End Function

Public Function BINTRP(Y(), DEL)
'
' performs 4-point interpolation of field data
'
   T = ((DEL + 1) * ((Y(4) - Y(1)) / 3 + Y(2) - Y(3))) / 2
   T = ((DEL - 1) * ((Y(3) + Y(1)) / 2 - Y(2) + T))
   T = (DEL * (Y(3) - Y(2) + T))
   BINTRP = Y(2) + T
End Function

Public Sub ChkFoil()
'  This routine checks to see if foil needs to be inserted and
'    if so, plots it at the proper azimuth and changes particle charge
'
  If (Kfoil = 1) Then
    STH = Afoil / DPR
    SX1 = (RAV - 3) * Cos(STH)
    SY1 = (RAV - 3) * Sin(STH)
    SX2 = (RAV + 1) * Cos(STH)
    SY2 = (RAV + 1) * Sin(STH)
    frmPlot.DrawWidth = 2
    frmPlot.Line (SX2, SY2)-(SX1, SY1)
    frmPlot.DrawWidth = 1
    Pang1 = Jatn(X(I - 2), Y(I - 2))
    Pang2 = Jatn(X(I - 1), Y(I - 1))
    If (Pang2 >= Afoil) Then
      If (Pang1 < Afoil) Then IZ = -1
    End If
  End If
End Sub

Public Function Jatn(X, Y)
' This routine calculates arc tangent in degrees over all 4 quadrants
'   returns X=0, Y=0 as theta=0
'
   If (X = 0#) Then
     If (Y = 0#) Then
       Jatn = 0#
     Else
       Jatn = 90#
     End If
   Else
     Jatn = Atn(Y / X) * 57.2957795
   End If
'
   If (X < 0#) Then
     Jatn = Jatn + 180#
   Else
     If (Y < 0#) Then
       If (X = 0#) Then
         Jatn = Jatn + 180#
       Else
         Jatn = Jatn + 360#
     End If
        End If
   End If
End Function

Public Sub PlotDee()
' This routine plots outline of ORIC Dee structure
'
   Dim XD(66), YD(66) As Single
'following are outline coordinates of the Dee from Cleary codes
   XD(1) = 92.562: YD(1) = 25.235
   XD(2) = 38.691: YD(2) = 16.823
   XD(3) = 30.41365: YD(3) = 16.6855
   XD(4) = 29.81848: YD(4) = 17.72722
   XD(5) = 29.18763: YD(5) = 18.74775
   XD(6) = 28.52188: YD(6) = 19.74585
   XD(7) = 27.82201: YD(7) = 20.72033
   XD(8) = 27.08886: YD(8) = 21.67002
   XD(9) = 26.32331: YD(9) = 22.5938
   XD(10) = 25.52626: YD(10) = 23.49055
   XD(11) = 24.69869: YD(11) = 24.3592
   XD(12) = 23.84158: YD(12) = 25.19871
   XD(13) = 22.95594: YD(13) = 26.00809
   XD(14) = 22.04285: YD(14) = 26.78635
   XD(15) = 21.1034: YD(15) = 27.53258
   XD(16) = 20.13869: YD(16) = 28.24587
   XD(17) = 19.1499: YD(17) = 28.92537
   XD(18) = 18.13821: YD(18) = 29.57028
   XD(19) = 17.10482: YD(19) = 30.17981
   XD(20) = 16.05097: YD(20) = 30.75325
   XD(21) = 14.97792: YD(21) = 31.2899
   XD(22) = 13.88695: YD(22) = 31.78913
   XD(23) = 12.77938: YD(23) = 32.25033
   XD(24) = 11.65651: YD(24) = 32.67295
   XD(25) = 10.5197: YD(25) = 33.0565
   XD(26) = 9.37032: YD(26) = 33.4005
   XD(27) = 8.20972: YD(27) = 33.70455
   XD(28) = 7.0393: YD(28) = 33.96828
   XD(29) = 5.86047: YD(29) = 34.19139
   XD(30) = 4.67462: YD(30) = 34.37359
   XD(31) = 3.48318: YD(31) = 34.51468
   XD(32) = 2.28758: YD(32) = 34.61449
   XD(33) = 1.08924: YD(33) = 34.67289
   XD(34) = 1.08924: YD(34) = -34.67289
   XD(35) = 2.28758: YD(35) = -34.61449
   XD(36) = 3.48318: YD(36) = -34.51468
   XD(37) = 4.67462: YD(37) = -34.37359
   XD(38) = 5.86047: YD(38) = -34.19139
   XD(39) = 7.0393: YD(39) = -33.96828
   XD(40) = 8.20972: YD(40) = -33.70455
   XD(41) = 9.37032: YD(41) = -33.4005
   XD(42) = 10.5197: YD(42) = -33.0565
   XD(43) = 11.65651: YD(43) = -32.67295
   XD(44) = 12.77938: YD(44) = -32.25033
   XD(45) = 13.88695: YD(45) = -31.78913
   XD(46) = 14.97792: YD(46) = -31.2899
   XD(47) = 16.05097: YD(47) = -30.75325
   XD(48) = 17.10482: YD(48) = -30.17981
   XD(49) = 18.13821: YD(49) = -29.57028
   XD(50) = 19.1499: YD(50) = -28.92537
   XD(51) = 20.13869: YD(51) = -28.24587
   XD(52) = 21.1034: YD(52) = -27.53258
   XD(53) = 22.04285: YD(53) = -26.78635
   XD(54) = 22.95594: YD(54) = -26.00809
   XD(55) = 23.84158: YD(55) = -25.19871
   XD(56) = 24.69869: YD(56) = -24.3592
   XD(57) = 25.52626: YD(57) = -23.49055
   XD(58) = 26.32331: YD(58) = -22.5938
   XD(59) = 27.08886: YD(59) = -21.67002
   XD(60) = 27.82201: YD(60) = -20.72033
   XD(61) = 28.52188: YD(61) = -19.74585
   XD(62) = 29.18763: YD(62) = -18.74775
   XD(63) = 29.81848: YD(63) = -17.72722
   XD(64) = 30.41365: YD(64) = -16.6855
   XD(65) = 38.691: YD(65) = -16.823
   XD(66) = 92.562: YD(66) = -25.235
'now plot the the Dee outline
   frmPlot.DrawWidth = 2
   For J = 2 To 66
     frmPlot.Line (XD(J), YD(J))-(XD(J - 1), YD(J - 1)), RGB(0, 255, 0)
   Next J
   frmPlot.DrawWidth = 1
End Sub

Public Sub PlotDliner()
' This routine plots outline of ORIC Dee liner
'
   Dim XL(66), YL(66) As Single
'input coordinates of the Dee liner
   XL(1) = 73#: YL(1) = -41#
   XL(2) = 7#: YL(2) = -41#
   XL(3) = 7#: YL(3) = -36.5
   XL(4) = -0.5: YL(4) = -36.5
   XL(5) = -0.5: YL(5) = -35.5
   XL(6) = -2.5: YL(6) = -35.5
   XL(7) = -2.5: YL(7) = 35.5
   XL(8) = -0.5: YL(8) = 35.5
   XL(9) = -0.5: YL(9) = 36.5
   XL(10) = 7#: YL(10) = 36.5
   XL(11) = 7#: YL(11) = 41#
   XL(12) = 25#: YL(12) = 41#
'now plot the the liner outline
   For J = 2 To 12
     frmPlot.Line (XL(J), YL(J))-(XL(J - 1), YL(J - 1)), RGB(0, 255, 0)
   Next J
'and add the corner instrument packages
   frmPlot.DrawStyle = 2
   frmPlot.Line (7#, -41#)-(-0.5, -41#), RGB(0, 255, 0)
   frmPlot.Line (-0.5, -41#)-(-0.5, -36.5), RGB(0, 255, 0)
   frmPlot.Line (7#, 41#)-(-0.5, 41#), RGB(0, 255, 0)
   frmPlot.Line (-0.5, 41#)-(-0.5, 36.5), RGB(0, 255, 0)
   frmPlot.DrawStyle = 0
End Sub

Public Sub PlotPole()
' This routine plots the main magnet pole and yoke
'
   Dim XMMYK(5), YMMYK(5)
'first plot pole
  Rpole = 38#
  X1 = Rpole
  Y1 = 0
  TH = 0
  frmPlot.DrawWidth = 2
  For IP = 1 To 180
    TH = TH + 2
    THR = TH / DPR
    X2 = Rpole * Cos(THR)
    Y2 = Rpole * Sin(THR)
    frmPlot.Line (X1, Y1)-(X2, Y2), RGB(0, 0, 255)
    X1 = X2
    Y1 = Y2
  Next IP
'list coordinates for main magnet yoke
  XMMYK(2) = -46.2: YMMYK(2) = -70#   'cutoff same as vacuum chamber
  XMMYK(3) = 39#: YMMYK(3) = -70#
  XMMYK(4) = 58#: YMMYK(4) = -74.25
  XMMYK(5) = 58#: YMMYK(5) = -75#
'now plot main magnet yoke
  For J = 3 To 5
    frmPlot.Line (XMMYK(J), YMMYK(J))-(XMMYK(J - 1), YMMYK(J - 1)), RGB(0, 0, 255)
  Next J
End Sub

Public Sub PlotExitArea()
' This routine plots vacuum chamber, BM V-1, BM V-2, and QD-1
'
   Dim XVC(9), YVC(9), XVCI(27), YVCI(27), XV1(22), YV1(22)
   Dim XV2(9), YV2(9)
'input coordinates for outside of vacuum chamber
   XVC(1) = -46.2: YVC(1) = -54#
   XVC(2) = -18.96: YVC(2) = -54#
   XVC(3) = -5.16: YVC(3) = -68#
   XVC(4) = 23.88: YVC(4) = -68#
   XVC(5) = 35.4: YVC(5) = -48#
   XVC(6) = 70.75: YVC(6) = -48#
   XVC(7) = 70.75: YVC(7) = -51.36
   XVC(8) = 72.84: YVC(8) = -51.36
   XVC(9) = 72.84: YVC(9) = -40#
'now plot outside surface of vacuum chamber
   frmPlot.DrawWidth = 2
  For J = 2 To 9
     frmPlot.Line (XVC(J), YVC(J))-(XVC(J - 1), YVC(J - 1)), RGB(0, 0, 255)
  Next J
'input coordinates for inside of vacuum chamber
   XVCI(1) = -46.2: YVCI(1) = -52.5
   XVCI(2) = -41.52: YVCI(2) = -52.5
   XVCI(3) = -41.52: YVCI(3) = -54#
   XVCI(4) = -21.6: YVCI(4) = -54#
   XVCI(5) = -21.6: YVCI(5) = -52.5
   XVCI(6) = -18#: YVCI(6) = -52.5
   XVCI(7) = -15.24: YVCI(7) = -55.44
   XVCI(8) = -16.68: YVCI(8) = -56.4
   XVCI(9) = -7.92: YVCI(9) = -65.16
   XVCI(10) = -6.72: YVCI(10) = -64.2
   XVCI(11) = -4.56: YVCI(11) = -66.48
   XVCI(12) = 23.1: YVCI(12) = -66.48
   XVCI(13) = 24.3: YVCI(13) = -63.95
   XVCI(14) = 25.7: YVCI(14) = -64.46
   XVCI(15) = 33.98: YVCI(15) = -50.54
   XVCI(16) = 32.52: YVCI(16) = -49.8
   XVCI(17) = 34.56: YVCI(17) = -46.5
   XVCI(18) = 38.64: YVCI(18) = -46.5
   XVCI(19) = 38.64: YVCI(19) = -48#
   XVCI(20) = 48.72: YVCI(20) = -48#
   XVCI(21) = 48.72: YVCI(21) = -46.5
   XVCI(22) = 54.72: YVCI(22) = -46.5
   XVCI(23) = 54.72: YVCI(23) = -48#
   XVCI(24) = 66.72: YVCI(24) = -48#
   XVCI(25) = 66.72: YVCI(25) = -46.5
   XVCI(26) = 70.8: YVCI(26) = -46.5
   XVCI(27) = 70.8: YVCI(27) = -42#
'now plot inside surface of vacuum chamber
  For J = 2 To 27
     frmPlot.Line (XVCI(J), YVCI(J))-(XVCI(J - 1), YVCI(J - 1)), RGB(0, 0, 255)
  Next J
'input coordinates for bending magnet V-1
   XV1(1) = 30.35: YV1(1) = -62.45   'this is lower return yoke and coil
   XV1(2) = 29.05: YV1(2) = -66.25
   XV1(3) = 34.15: YV1(3) = -67.9
   XV1(4) = 39.35: YV1(4) = -69.15
   XV1(5) = 44.6: YV1(5) = -70.2
   XV1(6) = 49.85: YV1(6) = -70.9
   XV1(7) = 50.25: YV1(7) = -66.95
   XV1(8) = 45.25: YV1(8) = -66.25
   XV1(9) = 40.2: YV1(9) = -65.3
   XV1(10) = 35.2: YV1(10) = -64#
   XV1(11) = 30.35: YV1(11) = -62.45
   XV1(12) = 31.95: YV1(12) = -57.7   'this is upper return yoke and coil
   XV1(13) = 33.25: YV1(13) = -53.9
   XV1(14) = 37.7: YV1(14) = -55.35
   XV1(15) = 42.15: YV1(15) = -56.5
   XV1(16) = 46.65: YV1(16) = -57.4
   XV1(17) = 51.25: YV1(17) = -58.05
   XV1(18) = 50.85: YV1(18) = -62#
   XV1(19) = 46.05: YV1(19) = -61.3
   XV1(20) = 41.3: YV1(20) = -60.4
   XV1(21) = 36.6: YV1(21) = -59.15
   XV1(22) = 31.95: YV1(22) = -57.7
'now plot lower part of V1
  For J = 2 To 11
     frmPlot.Line (XV1(J), YV1(J))-(XV1(J - 1), YV1(J - 1)), RGB(0, 0, 255)
  Next J
'now plot upper part of V1
  For J = 13 To 22
     frmPlot.Line (XV1(J), YV1(J))-(XV1(J - 1), YV1(J - 1)), RGB(0, 0, 255)
  Next J
'now connect the two parts
  frmPlot.DrawWidth = 1
  frmPlot.Line (XV1(12), YV1(12))-(XV1(11), YV1(11)), RGB(0, 0, 255)
  frmPlot.Line (XV1(18), YV1(18))-(XV1(7), YV1(7)), RGB(0, 0, 255)
'input coordinates for bending magnet V-2
   XV2(1) = 63#: YV2(1) = -74#   'this is the yoke
   XV2(2) = 63#: YV2(2) = -58#
   XV2(3) = 79#: YV2(3) = -58#
   XV2(4) = 79#: YV2(4) = -74#
   XV2(5) = 65#: YV2(5) = -72#   'this is the pole
   XV2(6) = 65#: YV2(6) = -60#
   XV2(7) = 77#: YV2(7) = -60#
   XV2(8) = 77#: YV2(8) = -72#
   XV2(9) = 65#: YV2(9) = -72#
'now plot the yoke for V-2
  For J = 2 To 4
     frmPlot.Line (XV2(J), YV2(J))-(XV2(J - 1), YV2(J - 1)), RGB(0, 0, 255)
  Next J
'now plot the pole for V-2
  frmPlot.DrawWidth = 2
  For J = 6 To 9
     frmPlot.Line (XV2(J), YV2(J))-(XV2(J - 1), YV2(J - 1)), RGB(0, 0, 255)
  Next J
'now plot simple outline for QD-1
  frmPlot.DrawWidth = 1
  frmPlot.Line (94#, -74#)-(100#, -74#), RGB(0, 0, 255)
  frmPlot.Line (94#, -58#)-(94#, -74#), RGB(0, 0, 255)
  frmPlot.Line (100#, -58#)-(94#, -58#), RGB(0, 0, 255)
'plot final beam path
  frmPlot.DrawStyle = 1
  frmPlot.Line (70#, -66#)-(100#, -66#)
  frmPlot.DrawStyle = 0
'
  frmPlot.DrawWidth = 1
End Sub

Public Sub PlotInfo()
  today$ = Date$
  For ID = 1 To Len(today$) - 4
    If Mid$(today$, ID, 1) = "-" Then Mid$(today$, ID, 1) = "/"
  Next ID
  frmPlot.CurrentX = 25
  frmPlot.CurrentY = 38
  frmPlot.FontName = "Arial"
  frmPlot.FontSize = 16
  prnE = Format(E, "##0.0")
  frmPlot.Print "JTRACE Calculation for "; prnE; " MeV "; namP
  frmPlot.CurrentX = 71
  frmPlot.FontSize = 12
  frmPlot.Print today$
  frmPlot.CurrentX = -46.2
  frmPlot.CurrentY = -67.5
  frmPlot.FontSize = 8
  frmPlot.Print namVers
  frmPlot.CurrentX = 64
  frmPlot.CurrentY = 10
  frmPlot.FontSize = 10
  prnR = Format(Y(1), "##0.0")
  prnRAV = Format(RAV, "##0.0")
  prnCX = Format(CXI, "#0.00")
  frmPlot.Print "Radius at 90 degrees = "; prnR
  frmPlot.CurrentX = 65
  frmPlot.Print "      Average Radius = "; prnRAV
  frmPlot.CurrentX = 67
  frmPlot.Print "         Starting CX =   "; prnCX
  frmPlot.CurrentY = -10
  frmPlot.CurrentX = 71
  prnLastX = Format(X(I - 1), "##0.0")
  prnLastY = Format(Y(I - 1), "##0.0")
  frmPlot.Print "          Last X = "; prnLastX
  frmPlot.CurrentX = 71
  frmPlot.Print "          Last Y = "; prnLastY
  If (IZ = -1) Then
    prnLC1 = Format(Val(frmMain.txtLC1), "##0.0")
    prnLC2 = Format(Val(frmMain.txtLC2), "##0.0")
    prnVM1 = Format(Val(frmMain.txtVM1), "##0.0")
    prnVM2 = Format(Val(frmMain.txtVM2), "##0.0")
    frmPlot.CurrentY = -29
    frmPlot.CurrentX = 68
    frmPlot.Print "          LC#1 Field =   "; prnLC1
    frmPlot.CurrentX = 68
    frmPlot.Print "          LC#2 Field = "; prnLC2
    frmPlot.CurrentX = 67.7
    frmPlot.Print "          VM#1 Field = "; prnVM1
    frmPlot.CurrentX = 67.7
    frmPlot.Print "          VM#2 Field = "; prnVM2
    frmPlot.CurrentY = SY1 + 2
    frmPlot.CurrentX = SX1
    prnAfoil = Format(Afoil, "#00.0")
    frmPlot.Print " "; prnAfoil; " deg."
  Else
    frmPlot.CurrentY = -26
    frmPlot.CurrentX = 70
    frmPlot.Print "        Orbit R90 Values"
    frmPlot.CurrentX = 72
    frmPlot.FontUnderline = True
    frmPlot.Print "Turn#   Y(R90)    R(R90)"
    frmPlot.FontUnderline = False
    For J = 1 To NR90
      JJ = JR90(J)
      prnTurn = Format(JJ, "###0")
      prnY90 = Format(Y(JJ), "###0.00")
      prnR90 = Format(R(JJ), "###0.00")
      prnLin$ = "                         "
      Mid$(prnLin$, 5 - Len(prnTurn), Len(prnTurn)) = prnTurn
      Mid$(prnLin$, 14 - Len(prnY90), Len(prnY90)) = prnY90
      Mid$(prnLin$, 25 - Len(prnR90), Len(prnR90)) = prnR90
      If (Len(prnTurn) < 3) Then
        frmPlot.CurrentX = 75   'correct offset of variable width font
      Else
        frmPlot.CurrentX = 74
      End If
      frmPlot.Print prnLin$
    Next J
  End If
End Sub

