Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Friend Class frmC
	Inherits System.Windows.Forms.Form
	' JBCSTART Main Form
	'
	
	'UPGRADE_WARNING: Event cbxPart.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cbxPart_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbxPart.SelectedIndexChanged
		'UPGRADE_WARNING: Couldn't resolve default property of object Tflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If Tflag = 1 Then
			'UPGRADE_WARNING: Couldn't resolve default property of object CCflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			CCflag = 0
			Call CoilCur()
		End If
		'UPGRADE_WARNING: Couldn't resolve default property of object Pflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Pflag = 1
		PartID = cbxPart.SelectedIndex
		Call PartPrm()
		Call Freq()
		Me.txtE.Focus()
	End Sub
	
	'UPGRADE_WARNING: Event cbxR.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cbxR_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbxR.SelectedIndexChanged
		Dim RadID As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object Tflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If Tflag = 1 Then
			'UPGRADE_WARNING: Couldn't resolve default property of object CCflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			CCflag = 0
			Call CoilCur()
		End If
		'UPGRADE_WARNING: Couldn't resolve default property of object Rflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Rflag = 1
		'UPGRADE_WARNING: Couldn't resolve default property of object RadID. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		RadID = cbxR.SelectedIndex
		'UPGRADE_WARNING: Couldn't resolve default property of object RadID. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Rad(RadID). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object R. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		R = Rad(RadID)
		Call Freq()
	End Sub
	
	Private Sub cmdCalc_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCalc.Click
		'UPGRADE_WARNING: Couldn't resolve default property of object CCflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		CCflag = 1
		Xflag = 0
		lblFnam.Text = ""
		Call CoilCur()
		cmdSave.Enabled = False
		txtID.Text = ""
		txtID.Focus()
	End Sub
	
	Private Sub cmdExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdExit.Click
		End
	End Sub
	
	Private Sub cmdSave_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSave.Click
		Call CarPrep()
		Call CarWrite()
		'UPGRADE_WARNING: Couldn't resolve default property of object filNam. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Me.lblFnam.Text = "Parameter set written to file " + filNam
	End Sub
	
	Private Sub cmdXdat_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdXdat.Click
		Xflag = 1
		lblFnam.Text = ""
	End Sub
	
	Private Sub frmC_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		cbxR.Items.Insert(0, "29.0")
		cbxR.Items.Insert(1, "29.5")
		cbxR.Items.Insert(2, "30.0")
		cbxR.Items.Insert(3, "30.5")
		cbxR.Items.Insert(4, "31.0")
		cbxR.Items.Insert(5, "31.1")
		cbxR.Items.Insert(6, "31.2")
		cbxR.Items.Insert(7, "31.3")
		cbxR.Items.Insert(8, "31.4")
		cbxR.Items.Insert(9, "31.5")
		'
		cbxPart.Items.Insert(0, "proton")
		cbxPart.Items.Insert(1, "deuteron")
		cbxPart.Items.Insert(2, "H2+")
		cbxPart.Items.Insert(3, "He-3")
		cbxPart.Items.Insert(4, "He-4")
		'
		cmdCalc.Enabled = False
		cmdSave.Enabled = False
		'
		Call Main_Renamed()
		
	End Sub
	
	Private Sub Text1_Change()
		
	End Sub
	
	'UPGRADE_WARNING: Event txtE.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtE_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtE.TextChanged
		'UPGRADE_WARNING: Couldn't resolve default property of object Tflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If Tflag = 1 Then
			'UPGRADE_WARNING: Couldn't resolve default property of object CCflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			CCflag = 0
			Call CoilCur()
		End If
		'UPGRADE_WARNING: Couldn't resolve default property of object Eflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Eflag = 1
		If Len(txtE.Text) = 0 Then txtE.Text = " "
		If VB.Right(txtE.Text, 1) = "." Then
			txtE.Text = VB.Left(txtE.Text, Len(txtE.Text) - 1)
			cbxR.Focus()
		End If
		If txtE.Text = " " Then
			'UPGRADE_WARNING: Couldn't resolve default property of object E. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			E = 0#
		Else
			'UPGRADE_WARNING: Couldn't resolve default property of object E. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			E = txtE.Text
		End If
		Call Freq()
	End Sub
	
	'UPGRADE_WARNING: Event txtID.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtID_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtID.TextChanged
		Xflag = 0
		'UPGRADE_WARNING: Couldn't resolve default property of object C(1). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Mid(C(1), 43, 28) = "                            "
		lblFnam.Text = ""
		If Len(txtID.Text) = 0 Then
			cmdSave.Enabled = False
		Else
			'UPGRADE_WARNING: Couldn't resolve default property of object CaseID. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			CaseID = txtID.Text
			If Len(CaseID) <= 32 Then
				txtID.BackColor = System.Drawing.ColorTranslator.FromOle(&HFFFFFF)
				'UPGRADE_WARNING: Couldn't resolve default property of object CCflag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				If CCflag = 1 Then cmdSave.Enabled = True
			Else
				txtID.BackColor = System.Drawing.ColorTranslator.FromOle(&H8080FF)
				cmdSave.Enabled = False
			End If
		End If
	End Sub
End Class