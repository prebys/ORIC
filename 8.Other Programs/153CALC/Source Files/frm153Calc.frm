VERSION 5.00
Begin VB.Form frm153Calc 
   BackColor       =   &H00C0FFC0&
   Caption         =   "153 Energy Calculator"
   ClientHeight    =   5064
   ClientLeft      =   60
   ClientTop       =   456
   ClientWidth     =   7572
   LinkTopic       =   "Form1"
   ScaleHeight     =   5064
   ScaleWidth      =   7572
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtNMR 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3600
      TabIndex        =   1
      Top             =   2280
      Width           =   1095
   End
   Begin VB.ComboBox cmbPart 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   3600
      Style           =   2  'Dropdown List
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   1200
      Width           =   1695
   End
   Begin VB.TextBox txtFld 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3600
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   3240
      Width           =   1095
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
      Height          =   375
      Left            =   5880
      TabIndex        =   4
      Top             =   4320
      Width           =   975
   End
   Begin VB.TextBox txtE 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   3600
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   3840
      Width           =   1095
   End
   Begin VB.CommandButton cmdCalc 
      BackColor       =   &H008080FF&
      Caption         =   "Calculate"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5400
      MaskColor       =   &H000000FF&
      TabIndex        =   3
      Top             =   2280
      UseMaskColor    =   -1  'True
      Width           =   1455
   End
   Begin VB.TextBox txtChar 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   3600
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   1680
      Width           =   495
   End
   Begin VB.Label lblVers 
      BackStyle       =   0  'Transparent
      Height          =   252
      Left            =   720
      TabIndex        =   14
      Top             =   4800
      Width           =   972
   End
   Begin VB.Label lblVerTitl 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Version "
      Height          =   252
      Left            =   120
      TabIndex        =   13
      Top             =   4800
      Width           =   612
   End
   Begin VB.Label lblNMR 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
      Caption         =   "153-deg NMR field (kG):"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   12
      Top             =   2280
      Width           =   3135
   End
   Begin VB.Label lblE 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
      Caption         =   "Calculated energy (MeV):"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   480
      TabIndex        =   9
      Top             =   3840
      Width           =   3015
   End
   Begin VB.Label lblFld 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
      Caption         =   "Corrected 153-deg field (kG):"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   8
      Top             =   3240
      Width           =   3255
   End
   Begin VB.Label lblChar 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
      Caption         =   "Ion charge:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   960
      TabIndex        =   6
      Top             =   1680
      Width           =   2535
   End
   Begin VB.Label lblPart 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0FFC0&
      Caption         =   "Accelerated particle:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1080
      TabIndex        =   5
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Label lblTitle 
      Alignment       =   2  'Center
      BackColor       =   &H00C0FFC0&
      Caption         =   "Energy Calculator for 153-deg Magnet"
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   480
      TabIndex        =   0
      Top             =   240
      Width           =   6495
   End
End
Attribute VB_Name = "frm153Calc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Program 153Calc
' Utility program to calculate energies of particles accelerated in
'   ORIC by measuring the field of the 153-deg beam analyzing magnet.
' Note that the actual field at 72" is the field measured by the NMR
'   divided by 1.02882.  The radius and NMR adjustment can be
'   modified by using the 153Calc.ini file
'
' J. Ball      August 13, 2003       Date of latest revision: 8/9/07

Public B, Badj, E, PartM, PartMc, PartQ, PartZ, R, Zcor As Single
Public Vers As String

Private Sub cmbPart_Click()
  txtE.Text = ""
  txtFld.Text = ""
'  all of the following masses are for fully stripped ions
  If cmbPart.Text = "proton" Then
    PartZ = 1
    PartM = 938.255
  End If
  If cmbPart.Text = "deuteron" Then
    PartZ = 1
    PartM = 1875.58
  End If
  If cmbPart.Text = "H2+" Then
    PartZ = 1
    PartM = 1877.02
  End If
  If cmbPart.Text = "helium-3" Then
    PartZ = 2
    PartM = 2808.34
  End If
  If cmbPart.Text = "alpha" Then
    PartZ = 2
    PartM = 3727.31
  End If
  If cmbPart.Text = "lithium-6" Then
    PartZ = 3
    PartM = 5601.42
  End If
  If cmbPart.Text = "lithium-7" Then
    PartZ = 3
    PartM = 6533.72
  End If
  If cmbPart.Text = "carbon-12" Then
    PartZ = 6
    PartM = 11174.67
  End If
  txtChar.Text = PartZ
End Sub

Private Sub cmdCalc_Click()
  PartQ = Val(txtChar.Text)
  B = Val(txtNMR) / Badj   'correct for field difference in NMR location
  txtFld.Text = Format(B, "#0.000")
  PartMc = PartM + Zcor   'add electron mass(es) for not fully stripped
  E = Sqr((B * R * PartQ / 1.3132) ^ 2 + PartMc ^ 2) - PartMc
  If E < 10# Then
    txtE = Format(E, "#0.000")
  Else
    txtE = Format(E, "#0.00")
  End If
End Sub

Private Sub cmdExit_Click()
  End
End Sub

Private Sub Form_Load()
  Vers = "080907"
  lblVers.Caption = Vers
  cmbPart.AddItem "proton"
  cmbPart.AddItem "H2+"
  cmbPart.AddItem "deuteron"
  cmbPart.AddItem "helium-3"
  cmbPart.AddItem "alpha"
  cmbPart.AddItem "lithium-6"
  cmbPart.AddItem "lithium-7"
  cmbPart.AddItem "carbon-12"
  cmbPart.Text = "proton"
'  look to see if 153Calc.ini file exists
  If Dir("153Calc.int") = "" Then  'file does not exist so use defaults
    R = 72#
    Badj = 1.02882
  Else                             'open file and input new values
    Open "153Calc.int" For Input As #1
    Input #1, R, Badj, Vers
    Close #1
    lblVers.Caption = Vers
    If R = 0 Then R = 72#   'if any values are zero, use defaults
    If Badj = 0 Then Badj = 1.02882
  End If
End Sub

Private Sub txtChar_Change()
  txtE.Text = ""
  txtFld.Text = ""
  PartQ = Val(txtChar.Text)
  If PartQ = 0 Or PartQ > PartZ Then   'charge is unphysical
    cmdCalc.Enabled = False            'so disable calculation
    txtChar.BackColor = &H3300FF       'and display red backcolor
  Else
    cmdCalc.Enabled = True
    If PartQ < PartZ Then              'charge okay but not fully stripped
      txtChar.BackColor = &H33FFFF     'so display yellow backcolor
      Zcor = (PartZ - PartQ) * 0.511   'and account for remaining electrons
    Else
      txtChar.BackColor = &HFFFFFF     'normal charge, so use white backcolor
      Zcor = 0
    End If
  End If
End Sub

Private Sub txtNMR_Change()
  txtE.Text = ""
  txtFld.Text = ""
  Debug.Print Asc(Right(txtNMR.Text, 1))
End Sub
