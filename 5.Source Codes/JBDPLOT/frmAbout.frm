VERSION 5.00
Begin VB.Form frmAbout 
   AutoRedraw      =   -1  'True
   BackColor       =   &H0000FFFF&
   Caption         =   "About JBDPLOT"
   ClientHeight    =   2892
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2892
   ScaleWidth      =   4560
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
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
      TabIndex        =   4
      Top             =   2280
      Width           =   492
   End
   Begin VB.Label lblHelp 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Please see the ORIC Program User Guide for discusions on how to use this program."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   492
      Left            =   360
      TabIndex        =   3
      Top             =   1560
      Width           =   3852
   End
   Begin VB.Label lblVers 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Version Date:  5/30/2007"
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
      Left            =   480
      TabIndex        =   2
      Top             =   960
      Width           =   3612
   End
   Begin VB.Label lblAuth 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Written by Jim Ball"
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
      Left            =   1080
      TabIndex        =   1
      Top             =   600
      Width           =   2292
   End
   Begin VB.Label lblTitle 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "JBDPLOT Diagnostics Viewer"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.8
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   372
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   4092
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
  frmAbout.Hide
End Sub

