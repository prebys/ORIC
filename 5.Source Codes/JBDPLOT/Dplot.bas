Attribute VB_Name = "Dcode"
'  JBDPLOT Program
'
'  Program to read the tcisoc.car and jbaccel.prn file and
'    then display parameter set and plot accel diagnostics
'
'  J. Ball     18-Mar-2007       Date of last revision: 5/30/07
'
Public tline, acdate, actime As String
Public orb(999), NL, LastOrb, kpage, kprn As Integer
Public E(999), Rcen(999), THcen(999), maxRcen As Single
Public avgR(999), DavgR(999), DRad(999), RbyrtE(999) As Single
Public maxDRad, rngDRad, Rad1, Rad2 As Single
Public Xcen(999), Ycen(999), LLX, LLY, dum As Single
Public PRN As Object
'

Public Sub Main()
' For some reason, when running on Win 11, you have to explicitly set the working directory to the
' Application directory. Since I'm building this code in a Virtual machine on the Mac, I also have to
' Add a kludge to replace "\\Mac\Home" with "Z:".  There's probably a more elegant way to do it.
' EjP 20130712
  fixpath = Replace(App.Path, "\\Mac\Home", "Z:")
  ChDrive fixpath
  ChDir fixpath
'--EjP

  Call Adata
  Debug.Print NL; "data points read"
  Set PRN = frmDplot
  kprn = 0  'this is 0 for screen plot (default) and 1 for printer
  frmDplot.Show
  kpage = 1
  Call Prep
End Sub

Public Sub Prep()
'  this routine sets up page, prints header, and selects graphics
'
  PRN.ScaleWidth = 8.5
  PRN.Scale (0#, 11#)-(8.5, 0#)
  PRN.CurrentX = 0.7
  PRN.CurrentY = 10.3
  PRN.FontName = "Arial"
  PRN.FontSize = 11
  PRN.Print "JBACCEL Diagnostics and Run Parameters"
  PRN.CurrentX = 5.5
  PRN.CurrentY = 10.3
  PRN.FontSize = 9
  PRN.Print acdate; "     "; actime
  Call PlotIN
  If kpage = 1 Then
    Call PlotD12
    Call PlotD5
    Call PlotD3
    Call PlotD4
  Else
    Call PlotOrb
  End If
End Sub

Public Sub Adata()
'  This routine reads in data from jbaccel.prn file
'
  Open "jbaccel.prn" For Input As #1
'
  L = 0     'first get total number of lines in text file
  Do While Not EOF(1)
    Line Input #1, tline
    L = L + 1
  Loop
  Close #1
  NL = L - 11   'then, total data lines are L minus 10 header
'                lines and 1 footer line
'
  Open "jbaccel.prn" For Input As #1
  For I = 1 To 10     'skip first 10 header lines of output file
    Line Input #1, tline
  Next I
  For II = 1 To NL     'now get data
    Input #1, orb(II), dum, dum, E(II), dum, dum, Rcen(II), THcen(II), avgR(II), DavgR(II), DRad(II), RbyrtE(II)
  Next II
  LastOrb = orb(NL)
  Close #1
'  now go back and get date and time info from lines 2 and 3
  Open "jbaccel.prn" For Input As #1
  Line Input #1, tline   'skip line number 1
  Line Input #1, tline   'line 2 has jbaccel date info
    acdate = Mid(tline, 98, 16)
  Line Input #1, tline   'line 3 has jbaccel time info
    actime = Mid(tline, 98, 16)
    Debug.Print acdate, actime
  Close #1
End Sub

Public Sub PlotIN()
'  this routine outputs run parameters from tcisoc.car file
'
  PRN.Font = "Courier New"
  PRN.FontSize = 9
  Open "tcisoc.car" For Input As #1
  NC = 0   'first count number of comment cards
  Do
    Line Input #1, tline
    If Left(tline, 1) <> "!" Then Exit Do
    NC = NC + 1
  Loop
  NC = NC + 11 'first cards are comments plus 11
  Close #1
  Open "tcisoc.car" For Input As #1
  PRN.CurrentY = 4.8
  PRN.CurrentX = 0
  For I = 1 To NC       'print first cards
    Line Input #1, tline
    PRN.Print "                "; Left(tline, 80)
  Next I
  For I = 1 To 2        'skip 2 blank lines
    Line Input #1, tline
  Next I
  For I = 1 To 3       'print next three cards
    Line Input #1, tline
    PRN.Print "                "; Left(tline, 80)
  Next I
  For I = 1 To 3        'skip 3 blank lines
    Line Input #1, tline
  Next I
  For I = 1 To 3       'print last three cards
    Line Input #1, tline
    PRN.Print "                "; Left(tline, 80)
  Next I
  Close #1
  PRN.Font = "Arial"
End Sub

Public Sub PlotD12()
'  This routine plots diagnostic 1 and 2
'   - R90/rtE and dRavg both as function of Ravg
'
  LLX = 1#
  LLY = 7.95
  WX = 3.5
  HY = 1.85
  dHY = HY / 6
  PRN.FontSize = 9
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 3
  End If
  dLC1 = 0.2
  C1X = LLX - 0.3
'  find maximum value for RbyrtE
  maxRbyrtE = 0#
  For I = 1 To NL
    If RbyrtE(I) > maxRbyrtE Then maxRbyrtE = RbyrtE(I)
  Next I
'  then set LC1 to keep data on scale
  LC1 = 3#
  Do
    LCT = LC1 + 1.05
    If maxRbyrtE > LCT Then
      LC1 = LC1 + dLC1
    Else
      Exit Do
    End If
  Loop
  LC2 = -0.2
  dLC2 = 0.2
  C2X = LLX + WX + 0.1
'  first print left and right sides of plot area
  PRN.Line (LLX, LLY)-(LLX, LLY + HY)
  PRN.Line (LLX + WX, LLY + HY)-(LLX + WX, LLY)
'  now print horizontal grid lines and labels
  LX1 = LLX - 0.05
  LX2 = LLX + WX + 0.05
  Y = LLY - dHY
  C1 = LC1 - dLC1
  C2 = LC2 - dLC2
  For I = 1 To 7
    LY = Y + dHY * I
    PRN.Line (LX1, LY)-(LX2, LY)
    C1 = C1 + dLC1
    PRN.CurrentX = C1X
    PRN.CurrentY = LY + 0.1
    PRN.ForeColor = RGB(0, 66, 255)
    PRN.Print C1
    C2 = C2 + dLC2
    PRN.CurrentX = C2X
    PRN.CurrentY = LY + 0.1
    PRN.ForeColor = RGB(255, 0, 255)
    PRN.Print C2
    PRN.ForeColor = &H0
  Next I
'  now print X axis tics and labels
  DR = WX / 35#
  For I = 0 To 35 Step 5
    X = LLX + DR * I
    PRN.CurrentX = X
    PRN.Line (X, LLY)-(X, LLY - 0.05)
    If I < 10 Then
      PRN.CurrentX = X - 0.07
    Else
      PRN.CurrentX = X - 0.12
    End If
    PRN.CurrentY = LLY - 0.1
    PRN.Print I
  Next I
'  print chart titles
  PRN.FontSize = 10
  PRN.FontBold = True
  PRN.CurrentY = LLY + HY - 0.1
  PRN.CurrentX = LLX + 0.2
  PRN.ForeColor = RGB(0, 66, 255)
  PRN.Print "R90/rtE vs Ravg"
  PRN.CurrentY = LLY + HY - 0.1
  PRN.CurrentX = LLX + WX - 1.3
  PRN.ForeColor = RGB(255, 0, 255)
  PRN.Print "dRavg vs Ravg"
  PRN.FontSize = 9
  PRN.FontBold = False
  PRN.ForeColor = &H0
'  and finally, print data
  scY1 = dHY / dLC1
  scY2 = dHY / dLC2
  If kprn = 0 Then
    PRN.DrawWidth = 2
  Else
    PRN.DrawWidth = 5
  End If
  For II = 2 To NL
    X1 = LLX + avgR(II) * DR
    X2 = LLX + avgR(II - 1) * DR
    Y11 = LLY + (RbyrtE(II) - LC1) * scY1
    Y12 = LLY + (RbyrtE(II - 1) - LC1) * scY1
    Y21 = LLY + (DavgR(II) - LC2) * scY2
    Y22 = LLY + (DavgR(II - 1) - LC2) * scY2
    If Y12 >= LLY Then   'point is on scale
      PRN.Line (X1, Y11)-(X2, Y12), RGB(0, 66, 255)
    End If
'  skip II = 2 since DavgR is not defined for II = 2-1 = 1
    If II > 2 Then PRN.Line (X1, Y21)-(X2, Y22), RGB(255, 0, 255)
  Next II
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 3
  End If
End Sub

Public Sub PlotD3()
'  This routine plots diagnostic 3
'   - displacement of orbit center as funtion of Ravg
'
  LLX = 1#
  LLY = 5.3
  WX = 3#
  HY = 2#
  NY = 5
  dHY = HY / NY
  PRN.FontSize = 9
  LC1 = 0#
'  need to determine scale of Y axis
  maxRcen = 0#
  For MI = 1 To NL
    If Rcen(MI) > maxRcen Then maxRcen = Rcen(MI)
  Next MI
  dLC1 = 0.1 * (Fix(maxRcen / 0.45) + 1)
  C1X = LLX - 0.3
'  first print left and right sides of plot area
  PRN.Line (LLX, LLY)-(LLX, LLY + HY)
  PRN.Line (LLX + WX, LLY + HY)-(LLX + WX, LLY)
'  now print horizontal grid lines and labels
  LX1 = LLX - 0.05
  LX2 = LLX + WX
  Y = LLY - dHY
  C1 = LC1 - dLC1
  For I = 1 To NY + 1
    LY = Y + dHY * I
    PRN.Line (LX1, LY)-(LX2, LY)
    C1 = C1 + dLC1
    PRN.CurrentX = C1X
    PRN.CurrentY = LY + 0.1
    PRN.Print C1
  Next I
'  now print X axis tics and labels
  DR = WX / 35#
  For I = 0 To 35 Step 5
    X = LLX + DR * I
    PRN.CurrentX = X
    PRN.Line (X, LLY)-(X, LLY - 0.05)
    If I < 10 Then
      PRN.CurrentX = X - 0.07
    Else
      PRN.CurrentX = X - 0.12
    End If
    PRN.CurrentY = LLY - 0.1
    PRN.Print I
  Next I
'  print chart titles
  PRN.FontSize = 10
  PRN.FontBold = True
  PRN.CurrentY = LLY + HY - 0.1
  PRN.CurrentX = LLX + 0.2
  PRN.Print "Orbit Center radius vs Ravg"
  PRN.FontSize = 9
  PRN.FontBold = False
'  and finally, print data
  scY1 = dHY / dLC1
  If kprn = 0 Then
    PRN.DrawWidth = 2
  Else
    PRN.DrawWidth = 6
  End If
  For II = 2 To NL
    X1 = LLX + avgR(II) * DR
    X2 = LLX + avgR(II - 1) * DR
    Y11 = LLY + (Rcen(II) - LC1) * scY1
    Y12 = LLY + (Rcen(II - 1) - LC1) * scY1
    If II < NL - 10 Then   'print data in blue
      PRN.Line (X1, Y11)-(X2, Y12), RGB(0, 66, 255)
    Else                   'print last 10 orbits in red
      PRN.Line (X1, Y11)-(X2, Y12), RGB(255, 0, 0)
    End If
  Next II
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 3
  End If
End Sub

Public Sub PlotD4()
'  This routine plots diagnostic 4
'   - X-Y plot of orbit center path
'
  LLX = 5.2
  LLY = 5.3
  WX = 2.2
  HY = 2.18
  NY = 4
  dHY = HY / NY
  PRN.FontSize = 9
'  first need to convert polar data to X-Y coordinates
  dpr = 57.2957795
  For I = 1 To NL
    Xcen(I) = Rcen(I) * Cos(THcen(I) / dpr)
    Ycen(I) = Rcen(I) * Sin(THcen(I) / dpr)
  Next I
'  now find the maximum value of X or Y
  Pmax = 0#
  For I = 1 To NL
    If Abs(Xcen(I)) > Pmax Then Pmax = Abs(Xcen(I))
    If Abs(Ycen(I)) > Pmax Then Pmax = Abs(Ycen(I))
  Next I
'  and set grid size
  LC1 = 0.1
  If Pmax > 0.1 Then LC1 = 0.2
  If Pmax > 0.2 Then LC1 = 0.5
  If Pmax > 0.5 Then LC1 = 1#
  If Pmax > 1# Then LC1 = 2#
  If Pmax > 2# Then LC1 = 4#
  dLC1 = LC1
  C1X = LLX - 0.3
'  first print left and right sides of plot area
   PRN.Line (LLX, LLY)-(LLX, LLY + HY)
   PRN.Line (LLX + WX, LLY + HY)-(LLX + WX, LLY)
'  now print horizontal grid lines and labels
  LX1 = LLX - 0.05
  LX2 = LLX + WX
  Y = LLY - dHY
  C1 = -LC1 - dLC1
  lbltst = 1
  For I = 1 To NY + 1
    LY = Y + dHY * I
    PRN.Line (LX1, LY)-(LX2, LY)
    If lbltst = 1 Then     'print label every other line
      C1 = C1 + dLC1
      PRN.CurrentX = C1X
      PRN.CurrentY = LY + 0.1
      PRN.Print C1
    End If
    lbltst = -1 * lbltst
  Next I
'  now print X axis tics and labels
  dX = WX / NY
  C1 = -LC1 - dLC1
  lbltst = 1
  For I = 1 To NY + 1
    LX = LLX + dX * (I - 1)
    PRN.CurrentX = X
    PRN.Line (LX, LLY + HY)-(LX, LLY - 0.05)
    If lbltst = 1 Then     'print label every other line
      C1 = C1 + dLC1
      PRN.CurrentX = LX - 0.07
      PRN.CurrentY = LLY - 0.1
      PRN.Print C1
    End If
    lbltst = -1 * lbltst
  Next I
'  print chart titles
  PRN.FontSize = 10
  PRN.FontBold = True
  PRN.CurrentY = LLY + HY - 0.1
  PRN.CurrentX = LLX + 0.2
  PRN.Print "Orbit Center path"
  PRN.FontSize = 9
  PRN.FontBold = False
'  finally, print data
  scx = dX / (0.5 * dLC1)    'each grid unit is 1/2 dLC1
  scy = dHY / (0.5 * dLC1)
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 4
  End If
  For II = 2 To NL
    X1 = LLX + 2 * dX + Xcen(II) * scx
    X2 = LLX + 2 * dX + Xcen(II - 1) * scx
    Y1 = LLY + 2 * dHY + (Ycen(II)) * scy
    Y2 = LLY + 2 * dHY + (Ycen(II - 1)) * scy
    If II < 10 Then          'plot start of line in green
      PRN.Line (X1, Y1)-(X2, Y2), RGB(0, 255, 0)
    Else
      If II > NL - 10 Then   'plot end of line in red
        PRN.Line (X1, Y1)-(X2, Y2), RGB(255, 0, 0)
      Else                   'plot middle of line in blue
        PRN.Line (X1, Y1)-(X2, Y2), RGB(0, 66, 255)
      End If
    End If
  Next II
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 4
  End If
End Sub

Public Sub PlotD5()
'  This routine plots diagnostic 5
'   - orbit separation at 90 degrees near extraction
'
  LLX = 5.5
  LLY = 8.1
  WX = 1.9
  HY = 1.7
  NY = 5
  dHY = HY / NY
  Rad1 = 27#
  Rad2 = 32#
  PRN.FontSize = 9
'  need to determine scale of Y axis
  maxDRad = 0#
  minDrad = 0#
  For MI = 1 To NL
    If avgR(MI) > Rad1 Then
      If DRad(MI) > maxDRad Then maxDRad = DRad(MI)
      If DRad(MI) < minDrad Then minDrad = DRad(MI)
    End If
  Next MI
  LC1 = 0.01 * (Int(100 * minDrad))
  Debug.Print minDrad, LC1, maxDRad
  rngDRad = maxDRad - minDrad
  dLC1 = 0.01 * (Fix(rngDRad / 0.035) + 1)
  Debug.Print rngDRad, dLC1
  C1X = LLX - 0.4
'  first print left and right sides of plot area
  PRN.Line (LLX, LLY)-(LLX, LLY + HY)
  PRN.Line (LLX + WX, LLY + HY)-(LLX + WX, LLY)
'  now print horizontal grid lines and labels
  LX1 = LLX - 0.05
  LX2 = LLX + WX
  Y = LLY - dHY
  C1 = LC1 - dLC1
  For I = 1 To NY + 1
    LY = Y + dHY * I
    PRN.Line (LX1, LY)-(LX2, LY)
    C1 = Round(C1 + dLC1, 2)
    If Abs(C1) < 0.001 Then C1 = 0
    PRN.CurrentX = C1X
    PRN.CurrentY = LY + 0.1
    PRN.Print C1
  Next I
'  now print X axis tics and labels
  DR = WX / (Rad2 - Rad1)
  For I = Fix(Rad1) To Fix(Rad2)
    X = LLX + DR * (I - Fix(Rad1))
    PRN.CurrentX = X
    PRN.Line (X, LLY)-(X, LLY - 0.05)
    If I < 10 Then
      PRN.CurrentX = X - 0.07
    Else
      PRN.CurrentX = X - 0.12
    End If
    PRN.CurrentY = LLY - 0.1
    PRN.Print I
  Next I
'  print chart titles
  PRN.FontSize = 10
  PRN.FontBold = True
  PRN.CurrentY = LLY + HY - 0.1
  PRN.CurrentX = LLX + 0.2
  PRN.Print "dR90 near extract"
  PRN.FontSize = 9
  PRN.FontBold = False
'  and finally, print data
  scY1 = dHY / dLC1
  If kprn = 0 Then
    PRN.DrawWidth = 2
  Else
    PRN.DrawWidth = 6
  End If
  For II = 2 To NL
   If avgR(II) > Rad1 Then
    X1 = LLX + (avgR(II) - Rad1) * DR
    X2 = LLX + (avgR(II - 1) - Rad1) * DR
    Y11 = LLY + (DRad(II) - LC1) * scY1
    Y12 = LLY + (DRad(II - 1) - LC1) * scY1
    If II < NL - 10 Then   'print data in blue
      PRN.Line (X1, Y11)-(X2, Y12), RGB(0, 66, 255)
    Else                   'print last 10 orbits in red
      PRN.Line (X1, Y11)-(X2, Y12), RGB(255, 0, 0)
    End If
   End If
  Next II
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 3
  End If
End Sub

Public Sub PlotOrb()
'  this routine plots the orbit paths on a plot of the ORIC dee
'   and lower channel.  Handles options of last 10 orbits,
'   last 5 orbits, and every 10 orbits.
'
  LLX = 1#
  LLY = 5.9
  WX = 6.6
  HY = 3.75
  dWX = WX / 14#
  dHY = HY / 8#
  scx = WX / 140#
  scy = HY / 80#
  PRN.FontSize = 9
  dLBL = 10
  C1X = LLX - 0.3
'  print left and right sides of grid
  PRN.Line (LLX, LLY)-(LLX, LLY + HY)
  PRN.Line (LLX + WX, LLY + HY)-(LLX + WX, LLY)
'  print horizontal grid lines and labels
  LX1 = LLX - 0.05
  LX2 = LLX + WX
  Y = LLY - dHY
  C1 = -40 - dLBL
  For I = 1 To 9
    LY = Y + dHY * I
    PRN.Line (LX1, LY)-(LX2, LY)
    C1 = C1 + dLBL
    PRN.CurrentX = C1X
    PRN.CurrentY = LY + 0.1
    PRN.Print C1
  Next I
'  now print X axis tics and labels
  X = LLX - dWX
  C1 = -40 - dLBL
  For I = 1 To 4
    X = X + dWX
    C1 = C1 + dLBL
    PRN.CurrentX = X
    PRN.Line (X, LLY)-(X, LLY - 0.05)
    PRN.CurrentX = X - 0.12
    PRN.CurrentY = LLY - 0.1
    PRN.Print C1
  Next I
  X = X + dWX
  C1 = C1 + dLBL
  PRN.CurrentX = X
  PRN.Line (X, LLY + HY)-(X, LLY - 0.05)
  PRN.CurrentX = X - 0.07
  PRN.CurrentY = LLY - 0.1
  PRN.Print C1
  For I = 6 To 15
    X = X + dWX
    C1 = C1 + dLBL
    PRN.CurrentX = X
    PRN.Line (X, LLY)-(X, LLY - 0.05)
    PRN.CurrentX = X - 0.12
    PRN.CurrentY = LLY - 0.1
    PRN.Print C1
  Next I
'  determine record number of first orbit data
  Open "jbplot.txt" For Input As #1
  For I = 1 To 2     'skip 2 header lines
    Line Input #1, tline
  Next I
  Nrec = 2
  Do
    Nrec = Nrec + 1
    Input #1, iorb, dum, dum
    If iorb >= 0 Then Exit Do
  Loop
  datstart = Nrec
  Close #1
'  now plot elements (dee, lower channel, etc.)
  Open "jbplot.txt" For Input As #1
  For I = 1 To 2     'skip 2 header lines
    Line Input #1, tline
  Next I
  If kprn = 0 Then
    PRN.DrawWidth = 2
  Else
    PRN.DrawWidth = 5
  End If
  Nrec = 2
  Do   'one loop for each element
    Nrec = Nrec + 1
    Input #1, iorb, X1, Y1
    SX1 = (X1 + 40) * scx + LLX
    SY1 = (Y1 + 40) * scy + LLY
    Do
      Nrec = Nrec + 1
      Input #1, iorb, X2, Y2
      If Y2 = 0# Then
        If X2 = 0# Then Exit Do
      End If
      SX2 = (X2 + 40) * scx + LLX
      SY2 = (Y2 + 40) * scy + LLY
      PRN.Line (SX2, SY2)-(SX1, SY1), RGB(255, 0, 255)
      SX1 = SX2
      SY1 = SY2
    Loop
  Loop While Nrec < datstart - 1
'  now prepare for orbit data
  If kprn = 0 Then
    PRN.DrawWidth = 1
  Else
    PRN.DrawWidth = 3
  End If
  datstart = Nrec + 1
  If kpage = 2 Then
    ntorb = 10
    cntbak = 9
    norbit = 900
  Else
    If kpage = 3 Then
      ntorb = 5
      cntbak = 4
      norbit = 450
    End If
  End If
  If kpage < 4 Then
    iorb1 = LastOrb - cntbak
    irecorb1 = datstart + iorb1 * 90
    For I = datstart To irecorb1 - 1
      Line Input #1, tline     'skip records to begin last 10 orbits
    Next I
    Input #1, iorb, X1, Y1
    SX1 = (X1 + 40) * scx + LLX
    SY1 = (Y1 + 40) * scy + LLY
    For I = 1 To norbit
      Input #1, iorb, X2, Y2
      SX2 = (X2 + 40) * scx + LLX
      SY2 = (Y2 + 40) * scy + LLY
      PRN.Line (SX2, SY2)-(SX1, SY1), RGB(0, 0, 255)
      SX1 = SX2
      SY1 = SY2
    Next I
 '  print chart title
    PRN.FontSize = 11
    PRN.FontBold = True
    PRN.CurrentY = LLY + HY - 0.1
    PRN.CurrentX = LLX + 3#
    PRN.ForeColor = RGB(0, 66, 255)
    PRN.Print "Last"; ntorb; "Orbits -"; LastOrb - cntbak; "to"; LastOrb
    PRN.ForeColor = RGB(0, 0, 0)
    PRN.FontBold = False
  End If
  If kpage = 4 Then
    norbit = -1
    Do
      norbit = norbit + 1
      Input #1, iorb, X1, Y1
      SX1 = (X1 + 40) * scx + LLX
      SY1 = (Y1 + 40) * scy + LLY
      For I = 1 To 89   'remember we already read one
        Input #1, iorb, X2, Y2
        SX2 = (X2 + 40) * scx + LLX
        SY2 = (Y2 + 40) * scy + LLY
        PRN.Line (SX2, SY2)-(SX1, SY1), RGB(0, 0, 255)
        SX1 = SX2
        SY1 = SY2
      Next I
      Debug.Print " iorb,norbit,LastOrb="; iorb, norbit, LastOrb
      If norbit >= LastOrb - 9 Then Exit Do
      For I = 1 To 810
        Line Input #1, tline
      Next I
      norbit = norbit + 9
    Loop
 '  print chart title
    PRN.FontSize = 11
    PRN.FontBold = True
    PRN.CurrentY = LLY + HY - 0.1
    PRN.CurrentX = LLX + 3#
    PRN.ForeColor = RGB(0, 66, 255)
    PRN.Print "Every 10 orbits from 0 to"; norbit
    PRN.ForeColor = RGB(0, 0, 0)
    PRN.FontBold = False
  End If
'  clean up and end
  Close #1
End Sub
