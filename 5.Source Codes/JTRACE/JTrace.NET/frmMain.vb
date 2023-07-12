Option Strict Off
Option Explicit On
Friend Class frmMain
	Inherits System.Windows.Forms.Form
	' Program TRACE Main Form
	'
	'   Input data to calculate and display orbit path
	'
	' J. Ball       12/24/06          Date of latest revision: 02/16/07
	'
	
	Private Sub cmdExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdExit.Click
		End
	End Sub
	
	Private Sub cmdRun_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdRun.Click
		Call Trace.JTcode()
	End Sub
	
	'UPGRADE_WARNING: Event txtGINC.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtGINC_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtGINC.TextChanged
		Dim prnNewStep As Object
		Dim NewStep As Object
		If (Val(txtGINC.Text) < 0.1) Then txtGINC.Text = "0.1"
		If (Val(txtGINC.Text) > 2#) Then txtGINC.Text = "2.0"
		GINC = Val(txtGINC.Text)
		'UPGRADE_WARNING: Couldn't resolve default property of object NewStep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		NewStep = (700# / GINC) - 100
		'UPGRADE_WARNING: Couldn't resolve default property of object NewStep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object prnNewStep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		prnNewStep = VB6.Format(NewStep, "###0")
		'UPGRADE_WARNING: Couldn't resolve default property of object prnNewStep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Me.txtStop.Text = prnNewStep
	End Sub
	
	'UPGRADE_WARNING: Event txtPartZ.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtPartZ_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPartZ.TextChanged
		Dim inZ As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object inZ. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		inZ = Val(txtPartZ.Text)
		'UPGRADE_WARNING: Couldn't resolve default property of object inZ. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If (inZ <> 1) Then
			txtPartZ.BackColor = System.Drawing.ColorTranslator.FromOle(&HFF)
			cmdRun.Enabled = False
		End If
		'UPGRADE_WARNING: Couldn't resolve default property of object inZ. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If (inZ = 1) Then
			txtPartZ.BackColor = System.Drawing.ColorTranslator.FromOle(&HFFFFFF)
			cmdRun.Enabled = True
		End If
	End Sub
	
	'UPGRADE_WARNING: Event txtPartM.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtPartM_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtPartM.TextChanged
		Dim inM As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object inM. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		inM = Val(txtPartM.Text)
		'UPGRADE_WARNING: Couldn't resolve default property of object inM. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If (inM <> 1 Or inM <> 2) Then
			txtPartM.BackColor = System.Drawing.ColorTranslator.FromOle(&HFF)
			cmdRun.Enabled = False
		End If
		'UPGRADE_WARNING: Couldn't resolve default property of object inM. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If (inM = 1) Then
			txtPartM.BackColor = System.Drawing.ColorTranslator.FromOle(&HFFFFFF)
			txtPartE.Text = CStr(50)
			txtR90.Text = CStr(30.4)
			txtCX.Text = CStr(3.8)
			cmdRun.Enabled = True
		End If
		'UPGRADE_WARNING: Couldn't resolve default property of object inM. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If (inM = 2) Then
			txtPartM.BackColor = System.Drawing.ColorTranslator.FromOle(&HFFFFFF)
			txtPartE.Text = CStr(44)
			txtR90.Text = CStr(31.4)
			txtCX.Text = CStr(3.3)
			cmdRun.Enabled = True
		End If
	End Sub
End Class