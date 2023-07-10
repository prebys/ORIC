VERSION 5.00
Begin VB.Form frmHarmonicA 
   BackColor       =   &H00FFC0C0&
   Caption         =   "HarmonicA"
   ClientHeight    =   5280
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   7200
   LinkTopic       =   "Form1"
   ScaleHeight     =   5280
   ScaleWidth      =   7200
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtMagRat 
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
      Left            =   5640
      TabIndex        =   10
      Top             =   2760
      Width           =   732
   End
   Begin VB.TextBox txtDang 
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
      Left            =   2520
      TabIndex        =   8
      Top             =   2760
      Width           =   732
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
      Left            =   3120
      TabIndex        =   6
      Top             =   3960
      Width           =   852
   End
   Begin VB.CommandButton cmdCalc 
      Caption         =   "Calculate"
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
      Left            =   2880
      TabIndex        =   5
      Top             =   1800
      Width           =   1332
   End
   Begin VB.TextBox txtBmag 
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
      Left            =   5160
      TabIndex        =   4
      Text            =   "1.0"
      Top             =   1080
      Width           =   852
   End
   Begin VB.TextBox txtBang 
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
      Left            =   2280
      TabIndex        =   3
      Text            =   "225.0"
      Top             =   1080
      Width           =   732
   End
   Begin VB.Label lblMagRat 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Magnitude Ratio ="
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
      Left            =   3720
      TabIndex        =   9
      Top             =   2760
      Width           =   1812
   End
   Begin VB.Label lblDang 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Change in Azimuth ="
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
      Left            =   480
      TabIndex        =   7
      Top             =   2760
      Width           =   1932
   End
   Begin VB.Label lblBang 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Angle B ="
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
      TabIndex        =   2
      Top             =   1080
      Width           =   1092
   End
   Begin VB.Label lblBmag 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Magnitude B ="
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
      Left            =   3600
      TabIndex        =   1
      Top             =   1080
      Width           =   1452
   End
   Begin VB.Label lblTitle 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "HarmonicA"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   492
      Left            =   1800
      TabIndex        =   0
      Top             =   240
      Width           =   3012
   End
End
Attribute VB_Name = "frmHarmonicA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Program HarmonicA
'
' Study of ORIC harmonic coil behavior when the azimuth is changed
'   in the presence of an existing harmonic component
'
' J. Ball     18-Feb-2007
'



Private Sub cmdCalc_Click()
  DPR = 57.2957795
  XA1 = 0#
  YA1 = 100#
  XA2 = 100#
  YA2 = 0#
  RB = Val(txtBmag.Text)
  THB = Val(txtBang.Text) / DPR
  XB = RB * Cos(THB)
  YB = RB * Sin(THB)
  XR1 = XA1 + XB
  YR1 = YA1 + YB
  XR2 = XA2 + XB
  YR2 = YA2 + YB
  THR1 = Jatn(XR1, YR1)
  THR2 = Jatn(XR2, YR2)
  If (THR2 > THR1) Then THR2 = THR2 - 360
  DTHR = (THR1 - THR2)
  txtDang.Text = DTHR
  R1 = Sqr(XR1 ^ 2 + YR1 ^ 2)
  R2 = Sqr(XR2 ^ 2 + YR2 ^ 2)
  RRAT = R2 / R1
  txtMagRat.Text = RRAT
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

Private Sub cmdExit_Click()
  End
End Sub

Private Sub txtBang_Change()
  txtDang.Text = ""
  txtMagRat.Text = ""
End Sub

Private Sub txtBmag_Change()
  txtDang.Text = ""
  txtMagRat.Text = ""
End Sub
