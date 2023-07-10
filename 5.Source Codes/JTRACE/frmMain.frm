VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H0080FFFF&
   Caption         =   "JTrace"
   ClientHeight    =   6720
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   8016
   LinkTopic       =   "Form1"
   ScaleHeight     =   6720
   ScaleWidth      =   8016
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtVers 
      Alignment       =   2  'Center
      BackColor       =   &H0080FFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   300
      Left            =   3120
      TabIndex        =   33
      Text            =   "Version #"
      Top             =   720
      Width           =   1812
   End
   Begin VB.TextBox txtVM2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   6480
      TabIndex        =   32
      Text            =   "2.5"
      Top             =   5400
      Width           =   612
   End
   Begin VB.TextBox txtVM1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   3600
      TabIndex        =   30
      Text            =   "6.0"
      Top             =   5400
      Width           =   612
   End
   Begin VB.TextBox txtLC2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   6480
      TabIndex        =   28
      Text            =   "13.0"
      Top             =   4920
      Width           =   612
   End
   Begin VB.TextBox txtLC1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   3600
      TabIndex        =   26
      Text            =   "7.0"
      Top             =   4920
      Width           =   612
   End
   Begin VB.TextBox txtStrip 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   6480
      TabIndex        =   23
      Text            =   "230.0"
      Top             =   3960
      Width           =   612
   End
   Begin VB.TextBox txtCX 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   3600
      TabIndex        =   21
      Text            =   "3.8"
      Top             =   3960
      Width           =   612
   End
   Begin VB.TextBox txtPartE 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   6480
      TabIndex        =   19
      Text            =   "50.0"
      Top             =   2520
      Width           =   612
   End
   Begin VB.TextBox txtPartZ 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   4440
      TabIndex        =   4
      Text            =   "1"
      Top             =   2520
      Width           =   492
   End
   Begin VB.TextBox txtPartM 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   2400
      TabIndex        =   3
      Text            =   "1"
      Top             =   2520
      Width           =   492
   End
   Begin VB.TextBox txtAvgR 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   6480
      TabIndex        =   13
      Text            =   "32.0"
      Top             =   3480
      Width           =   612
   End
   Begin VB.TextBox txtR90 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   3600
      TabIndex        =   12
      Text            =   "30.4"
      Top             =   3480
      Width           =   612
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   5280
      TabIndex        =   10
      Top             =   6120
      Width           =   1092
   End
   Begin VB.TextBox txtStop 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   6480
      TabIndex        =   2
      Text            =   "600"
      Top             =   1560
      Width           =   612
   End
   Begin VB.TextBox txtGINC 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   3600
      TabIndex        =   1
      Text            =   "1.0"
      Top             =   1560
      Width           =   492
   End
   Begin VB.CommandButton cmdRun 
      BackColor       =   &H00000000&
      Caption         =   "Run"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   1800
      TabIndex        =   6
      Top             =   6120
      Width           =   1212
   End
   Begin VB.Label lblVM2 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "VM #2 Field ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   5040
      TabIndex        =   31
      Top             =   5400
      Width           =   1332
   End
   Begin VB.Label lblVM1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Verticle Magnet #1 Field ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   840
      TabIndex        =   29
      Top             =   5400
      Width           =   2652
   End
   Begin VB.Label lblLC2 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "LC #2 Field ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   4920
      TabIndex        =   27
      Top             =   4920
      Width           =   1452
   End
   Begin VB.Label lblLC1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Lower Channel #1 Field ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   960
      TabIndex        =   25
      Top             =   4920
      Width           =   2532
   End
   Begin VB.Label lblExtPrm 
      BackStyle       =   0  'Transparent
      Caption         =   "Extraction Parameters:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   252
      Left            =   600
      TabIndex        =   24
      Top             =   4560
      Width           =   2532
   End
   Begin VB.Label lblStrip 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Stripper Azimuth ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   4560
      TabIndex        =   22
      Top             =   3960
      Width           =   1812
   End
   Begin VB.Label lblCX 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Starting CX ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   2040
      TabIndex        =   20
      Top             =   3960
      Width           =   1452
   End
   Begin VB.Label lblPartE 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Energy ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   5400
      TabIndex        =   18
      Top             =   2520
      Width           =   972
   End
   Begin VB.Label lblPartZ 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Charge ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   3360
      TabIndex        =   17
      Top             =   2520
      Width           =   972
   End
   Begin VB.Label lblPartM 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Mass # ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   1320
      TabIndex        =   16
      Top             =   2520
      Width           =   972
   End
   Begin VB.Label lblPartPrm 
      BackStyle       =   0  'Transparent
      Caption         =   "Particle Parameters:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   252
      Left            =   600
      TabIndex        =   15
      Top             =   2160
      Width           =   2292
   End
   Begin VB.Label lblAvgR 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Average Radius ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   4680
      TabIndex        =   14
      Top             =   3480
      Width           =   1692
   End
   Begin VB.Label lblR90 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Radius at 90 degrees ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   1080
      TabIndex        =   11
      Top             =   3480
      Width           =   2412
   End
   Begin VB.Label lblOrbPrm 
      BackStyle       =   0  'Transparent
      Caption         =   "Orbit Parameters:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   252
      Left            =   600
      TabIndex        =   9
      Top             =   3120
      Width           =   2052
   End
   Begin VB.Label lblStop 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Number of steps ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   4680
      TabIndex        =   8
      Top             =   1560
      Width           =   1692
   End
   Begin VB.Label lblGINC 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Grid step increment ="
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   1440
      TabIndex        =   7
      Top             =   1560
      Width           =   2052
   End
   Begin VB.Label lblRunPrm 
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Run Parameters:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   252
      Left            =   600
      TabIndex        =   5
      Top             =   1200
      Width           =   1812
   End
   Begin VB.Label lblHeader 
      Alignment       =   2  'Center
      BackColor       =   &H0080FFFF&
      Caption         =   "JTrace - Orbit Tracker"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   492
      Left            =   1680
      TabIndex        =   0
      Top             =   240
      Width           =   4812
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Program TRACE Main Form
'
'   Input data to calculate and display orbit path
'
' J. Ball       12/24/06          Date of latest revision: 02/16/07
'

Private Sub cmdExit_Click()
  End
End Sub

Private Sub cmdRun_Click()
  Call Trace.JTcode
End Sub

Private Sub txtGINC_Change()
  If (Val(txtGINC.Text) < 0.1) Then txtGINC = "0.1"
  If (Val(txtGINC.Text) > 2#) Then txtGINC = "2.0"
  GINC = Val(txtGINC.Text)
  NewStep = (700# / GINC) - 100
  prnNewStep = Format(NewStep, "###0")
  frmMain.txtStop.Text = prnNewStep
End Sub

Private Sub txtPartZ_Change()
  inZ = Val(txtPartZ)
  If (inZ <> 1) Then
    txtPartZ.BackColor = &HFF&
    cmdRun.Enabled = False
  End If
  If (inZ = 1) Then
    txtPartZ.BackColor = &HFFFFFF
    cmdRun.Enabled = True
  End If
End Sub

Private Sub txtPartM_Change()
  inM = Val(txtPartM)
  If (inM <> 1 Or inM <> 2) Then
    txtPartM.BackColor = &HFF&
    cmdRun.Enabled = False
  End If
  If (inM = 1) Then
    txtPartM.BackColor = &HFFFFFF
    txtPartE.Text = 50
    txtR90.Text = 30.4
    txtCX.Text = 3.8
    cmdRun.Enabled = True
  End If
  If (inM = 2) Then
    txtPartM.BackColor = &HFFFFFF
    txtPartE.Text = 44
    txtR90.Text = 31.4
    txtCX.Text = 3.3
    cmdRun.Enabled = True
  End If
End Sub
