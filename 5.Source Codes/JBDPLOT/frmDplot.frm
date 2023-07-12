VERSION 5.00
Begin VB.Form frmDplot 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   Caption         =   "JBDPLOT -  Diagnostics Viewer"
   ClientHeight    =   11820
   ClientLeft      =   225
   ClientTop       =   870
   ClientWidth     =   9915
   LinkTopic       =   "Form1"
   ScaleHeight     =   11.478
   ScaleMode       =   0  'User
   ScaleWidth      =   8.765
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox CommonDialog1 
      Height          =   480
      Left            =   720
      ScaleHeight     =   420
      ScaleWidth      =   1140
      TabIndex        =   0
      Top             =   840
      Width           =   1200
   End
   Begin VB.Menu mnuFile 
      Caption         =   "File"
      Begin VB.Menu mnuPrint 
         Caption         =   "Print"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuOptions 
      Caption         =   "Options"
      Begin VB.Menu mnuDiag 
         Caption         =   "Diagnostics"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuLast10 
         Caption         =   "Last 10 Orbits"
      End
      Begin VB.Menu mnuLast5 
         Caption         =   "Last 5 Orbits"
      End
      Begin VB.Menu mnuEvery10 
         Caption         =   "Every 10 Orbits"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help"
      Begin VB.Menu mnuAbout 
         Caption         =   "About JBDPLOT"
      End
   End
End
Attribute VB_Name = "frmDplot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' JBDplot Main Form
'

Private Sub mnuAbout_Click()
  frmAbout.Show
End Sub

Private Sub mnuDiag_Click()
  kpage = 1
  frmDplot.mnuDiag.Checked = True
  frmDplot.mnuLast10.Checked = False
  frmDplot.mnuLast5.Checked = False
  frmDplot.mnuEvery10.Checked = False
  frmDplot.Cls
  Call Prep
End Sub

Private Sub mnuEvery10_Click()
  kpage = 4
  frmDplot.mnuDiag.Checked = False
  frmDplot.mnuLast10.Checked = False
  frmDplot.mnuLast5.Checked = False
  frmDplot.mnuEvery10.Checked = True
  frmDplot.Cls
  Call Prep
End Sub

Private Sub mnuExit_Click()
  End
End Sub

Private Sub mnuLast10_Click()
  kpage = 2
  frmDplot.mnuDiag.Checked = False
  frmDplot.mnuLast10.Checked = True
  frmDplot.mnuLast5.Checked = False
  frmDplot.mnuEvery10.Checked = False
  frmDplot.Cls
  Call Prep
End Sub

Private Sub mnuLast5_Click()
  kpage = 3
  frmDplot.mnuDiag.Checked = False
  frmDplot.mnuLast10.Checked = False
  frmDplot.mnuLast5.Checked = True
  frmDplot.mnuEvery10.Checked = False
  frmDplot.Cls
  Call Prep
End Sub

Private Sub mnuPrint_Click()
'  CommonDialog1.CancelError = True
  On Error GoTo ErrHandler
'  CommonDialog1.ShowPrinter
  Set PRN = Printer
  kprn = 1
  Call Prep
  Printer.EndDoc
  Set PRN = frmDplot
  kprn = 0
  Exit Sub
ErrHandler:
  Exit Sub
End Sub
