VERSION 5.00
Begin VB.Form frmPlot 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "JTracePlot"
   ClientHeight    =   10848
   ClientLeft      =   120
   ClientTop       =   492
   ClientWidth     =   14232
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   10.2
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   10667.4
   ScaleMode       =   0  'User
   ScaleWidth      =   13528.41
   StartUpPosition =   2  'CenterScreen
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Index           =   2
      Begin VB.Menu mnuPrint 
         Caption         =   "&Print"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Edit"
      Index           =   2
      Begin VB.Menu mnuRerun 
         Caption         =   "&Rerun"
      End
      Begin VB.Menu mnuFoil 
         Caption         =   "&Insert Foil"
      End
   End
End
Attribute VB_Name = "frmPlot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' JTrace1 - Plot Form (frmPlot)
'
'  This form is completely blank to show plot.
'  It contains only menu items.
'
'  THIS VERSION OPTIMIZED FOR 1024 X 768 DISPLAY
'

Private Sub mnuExit_Click()
  End
End Sub

Private Sub mnuFoil_Click()
  Kfoil = 1
  Cls
  Call JTcode
End Sub

Private Sub mnuPrint_Click()
  PrintForm
End Sub

Private Sub mnuRerun_Click()
  Cls
  Kfoil = 0     'no stripper until requested
  Hide
  frmMain.Show
End Sub

