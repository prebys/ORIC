VERSION 5.00
Begin VB.Form frmC 
   BackColor       =   &H00FFC0C0&
   Caption         =   "JBCSTART 062407"
   ClientHeight    =   9444
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   7920
   LinkTopic       =   "Form1"
   ScaleHeight     =   9444
   ScaleWidth      =   7920
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtKB 
      Alignment       =   2  'Center
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
      Left            =   3600
      TabIndex        =   43
      Top             =   2280
      Width           =   732
   End
   Begin VB.CommandButton cmdXdat 
      Caption         =   "Add extraction radius and Coax data to first comment card"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   7.8
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   252
      Left            =   1560
      TabIndex        =   40
      Top             =   7200
      Width           =   4812
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
      Left            =   3480
      TabIndex        =   38
      Top             =   8760
      Width           =   972
   End
   Begin VB.TextBox txtID 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   10.2
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1800
      TabIndex        =   37
      Top             =   5880
      Width           =   4332
   End
   Begin VB.TextBox txtCoax 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   5880
      TabIndex        =   34
      Top             =   5040
      Width           =   732
   End
   Begin VB.TextBox txtT2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   5880
      TabIndex        =   32
      Top             =   3600
      Width           =   732
   End
   Begin VB.TextBox txtT1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   3840
      TabIndex        =   30
      Top             =   3600
      Width           =   732
   End
   Begin VB.TextBox txtT8 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   5880
      TabIndex        =   28
      Top             =   4560
      Width           =   732
   End
   Begin VB.TextBox txtT5 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   5880
      TabIndex        =   26
      Top             =   4080
      Width           =   732
   End
   Begin VB.TextBox txtT7 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   3840
      TabIndex        =   24
      Top             =   4560
      Width           =   732
   End
   Begin VB.TextBox txtT4 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   3840
      TabIndex        =   22
      Top             =   4080
      Width           =   732
   End
   Begin VB.TextBox txtT6 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1560
      TabIndex        =   20
      Top             =   4560
      Width           =   732
   End
   Begin VB.TextBox txtT3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1560
      TabIndex        =   18
      Top             =   4080
      Width           =   732
   End
   Begin VB.TextBox txtLCout 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   3840
      TabIndex        =   17
      Top             =   5040
      Width           =   732
   End
   Begin VB.TextBox txtLCin 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1560
      TabIndex        =   16
      Top             =   5040
      Width           =   732
   End
   Begin VB.TextBox txtMain 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1560
      TabIndex        =   13
      Top             =   3600
      Width           =   732
   End
   Begin VB.CommandButton cmdCalc 
      Caption         =   "Calculate initial magnet coil currents"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   2040
      TabIndex        =   10
      Top             =   3000
      Width           =   3852
   End
   Begin VB.TextBox txtFreq 
      Alignment       =   2  'Center
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
      Height          =   300
      Left            =   3600
      TabIndex        =   4
      Top             =   1800
      Width           =   732
   End
   Begin VB.TextBox txtE 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   3240
      TabIndex        =   2
      Top             =   1320
      Width           =   612
   End
   Begin VB.ComboBox cbxPart 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   336
      Left            =   840
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   1320
      Width           =   1212
   End
   Begin VB.ComboBox cbxR 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   336
      Left            =   5400
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   1320
      Width           =   852
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Write this parameter set to file"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   2160
      TabIndex        =   0
      Top             =   7800
      Width           =   3612
   End
   Begin VB.Label lblKBnote 
      BackStyle       =   0  'Transparent
      Caption         =   "(keep between 45 and 98)"
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
      Left            =   4440
      TabIndex        =   44
      Top             =   2280
      Width           =   2412
   End
   Begin VB.Label lblKB 
      BackStyle       =   0  'Transparent
      Caption         =   "Classical Field Constant K is"
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
      TabIndex        =   42
      Top             =   2280
      Width           =   2652
   End
   Begin VB.Label lblFnam 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800080&
      Height          =   252
      Left            =   1200
      TabIndex        =   41
      Top             =   8280
      Width           =   5532
   End
   Begin VB.Label lblIDhelp 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   $"frmCARSTART.frx":0000
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   732
      Left            =   1680
      TabIndex        =   39
      Top             =   6240
      Width           =   4572
   End
   Begin VB.Label lblIDprompt 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Enter parameter set identification (32 characters max)"
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
      TabIndex        =   36
      Top             =   5640
      Width           =   5052
   End
   Begin VB.Label lblCoax 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Coax ="
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
      TabIndex        =   35
      Top             =   5040
      Width           =   732
   End
   Begin VB.Label lblT2 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T2 ="
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
      TabIndex        =   33
      Top             =   3600
      Width           =   732
   End
   Begin VB.Label lblT1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T1 ="
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
      Left            =   3000
      TabIndex        =   31
      Top             =   3600
      Width           =   732
   End
   Begin VB.Label lblT8 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T8 ="
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
      TabIndex        =   29
      Top             =   4560
      Width           =   732
   End
   Begin VB.Label lblT5 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T5 ="
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
      TabIndex        =   27
      Top             =   4080
      Width           =   732
   End
   Begin VB.Label lblT7 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T7 ="
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
      Left            =   3000
      TabIndex        =   25
      Top             =   4560
      Width           =   732
   End
   Begin VB.Label lblT4 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T4 ="
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
      Left            =   3000
      TabIndex        =   23
      Top             =   4080
      Width           =   732
   End
   Begin VB.Label lblT6 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T6 ="
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
      Left            =   720
      TabIndex        =   21
      Top             =   4560
      Width           =   732
   End
   Begin VB.Label lblT3 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "T3 ="
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
      Left            =   720
      TabIndex        =   19
      Top             =   4080
      Width           =   732
   End
   Begin VB.Label lblLCout 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "LC-out ="
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
      Left            =   2760
      TabIndex        =   15
      Top             =   5040
      Width           =   972
   End
   Begin VB.Label lblLCin 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "LC-in ="
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
      Left            =   720
      TabIndex        =   14
      Top             =   5040
      Width           =   732
   End
   Begin VB.Label lblMain 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Main ="
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
      Left            =   720
      TabIndex        =   12
      Top             =   3600
      Width           =   732
   End
   Begin VB.Label lblRFnote 
      BackStyle       =   0  'Transparent
      Caption         =   "(must not exceed 19.0)"
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
      Left            =   4440
      TabIndex        =   11
      Top             =   1800
      Width           =   2292
   End
   Begin VB.Label lblFreq 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Coresponding rf frequency is"
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
      Left            =   720
      TabIndex        =   9
      Top             =   1800
      Width           =   2772
   End
   Begin VB.Label lblR 
      BackStyle       =   0  'Transparent
      Caption         =   "and      Extraction Radius"
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
      Left            =   4440
      TabIndex        =   8
      Top             =   1080
      Width           =   2772
   End
   Begin VB.Label lblE 
      BackStyle       =   0  'Transparent
      Caption         =   "Energy"
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
      Left            =   3240
      TabIndex        =   7
      Top             =   1080
      Width           =   852
   End
   Begin VB.Label lblPart 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Select Particle"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   216
      Left            =   720
      TabIndex        =   6
      Top             =   1080
      Width           =   1452
   End
   Begin VB.Label lblTitle 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "tcisoc.car Initial File Generator"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   612
      Left            =   360
      TabIndex        =   5
      Top             =   240
      Width           =   7092
   End
End
Attribute VB_Name = "frmC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' JBCSTART Main Form
'

Private Sub cbxPart_Click()
  If Tflag = 1 Then
    CCflag = 0
    Call CoilCur
  End If
  Pflag = 1
  PartID = cbxPart.ListIndex
  Call PartPrm
  Call Freq
  frmC.txtE.SetFocus
End Sub

Private Sub cbxR_Click()
  If Tflag = 1 Then
    CCflag = 0
    Call CoilCur
  End If
  Rflag = 1
  RadID = cbxR.ListIndex
  R = Rad(RadID)
  Call Freq
End Sub

Private Sub cmdCalc_Click()
  CCflag = 1
  Xflag = 0
  lblFnam.Caption = ""
  Call CoilCur
  cmdSave.Enabled = False
  txtID.Text = ""
  txtID.SetFocus
End Sub

Private Sub cmdExit_Click()
  End
End Sub

Private Sub cmdSave_Click()
  Call CarPrep
  Call CarWrite
  frmC.lblFnam.Caption = "Parameter set written to file " + filNam
End Sub

Private Sub cmdXdat_Click()
  Xflag = 1
  lblFnam = ""
End Sub

Private Sub Form_Load()
  cbxR.AddItem "29.0", 0
  cbxR.AddItem "29.5", 1
  cbxR.AddItem "30.0", 2
  cbxR.AddItem "30.5", 3
  cbxR.AddItem "31.0", 4
  cbxR.AddItem "31.1", 5
  cbxR.AddItem "31.2", 6
  cbxR.AddItem "31.3", 7
  cbxR.AddItem "31.4", 8
  cbxR.AddItem "31.5", 9
'
  cbxPart.AddItem "proton", 0
  cbxPart.AddItem "deuteron", 1
  cbxPart.AddItem "H2+", 2
  cbxPart.AddItem "He-3", 3
  cbxPart.AddItem "He-4", 4
'
  cmdCalc.Enabled = False
  cmdSave.Enabled = False
'
  Call Main
  
End Sub

Private Sub Text1_Change()

End Sub

Private Sub txtE_Change()
  If Tflag = 1 Then
    CCflag = 0
    Call CoilCur
  End If
  Eflag = 1
  If Len(txtE.Text) = 0 Then txtE.Text = " "
  If Right(txtE.Text, 1) = "." Then
    txtE.Text = Left(txtE.Text, Len(txtE.Text) - 1)
    cbxR.SetFocus
  End If
  If txtE.Text = " " Then
    E = 0#
  Else
    E = txtE.Text
  End If
  Call Freq
End Sub

Private Sub txtID_Change()
  Xflag = 0
  Mid(C(1), 43, 28) = "                            "
  lblFnam.Caption = ""
  If Len(txtID.Text) = 0 Then
    cmdSave.Enabled = False
  Else
    CaseID = txtID.Text
    If Len(CaseID) <= 32 Then
      txtID.BackColor = &HFFFFFF
      If CCflag = 1 Then cmdSave.Enabled = True
    Else
      txtID.BackColor = &H8080FF
      cmdSave.Enabled = False
    End If
  End If
End Sub
