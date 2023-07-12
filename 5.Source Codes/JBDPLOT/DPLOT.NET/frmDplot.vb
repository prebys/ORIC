Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic.PowerPacks.Printing.Compatibility.VB6
Friend Class frmDplot
	Inherits System.Windows.Forms.Form
	' JBDplot Main Form
	'
	
	Public Sub mnuAbout_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuAbout.Click
		frmAbout.Show()
	End Sub
	
	Public Sub mnuDiag_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuDiag.Click
		'UPGRADE_WARNING: Couldn't resolve default property of object kpage. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		kpage = 1
		Me.mnuDiag.Checked = True
		Me.mnuLast10.Checked = False
		Me.mnuLast5.Checked = False
		Me.mnuEvery10.Checked = False
		'UPGRADE_ISSUE: Form method frmDplot.Cls was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		frmDplot.Cls()
		Call Prep()
	End Sub
	
	Public Sub mnuEvery10_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuEvery10.Click
		'UPGRADE_WARNING: Couldn't resolve default property of object kpage. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		kpage = 4
		Me.mnuDiag.Checked = False
		Me.mnuLast10.Checked = False
		Me.mnuLast5.Checked = False
		Me.mnuEvery10.Checked = True
		'UPGRADE_ISSUE: Form method frmDplot.Cls was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		frmDplot.Cls()
		Call Prep()
	End Sub
	
	Public Sub mnuExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuExit.Click
		End
	End Sub
	
	Public Sub mnuLast10_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuLast10.Click
		'UPGRADE_WARNING: Couldn't resolve default property of object kpage. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		kpage = 2
		Me.mnuDiag.Checked = False
		Me.mnuLast10.Checked = True
		Me.mnuLast5.Checked = False
		Me.mnuEvery10.Checked = False
		'UPGRADE_ISSUE: Form method frmDplot.Cls was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		frmDplot.Cls()
		Call Prep()
	End Sub
	
	Public Sub mnuLast5_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuLast5.Click
		'UPGRADE_WARNING: Couldn't resolve default property of object kpage. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		kpage = 3
		Me.mnuDiag.Checked = False
		Me.mnuLast10.Checked = False
		Me.mnuLast5.Checked = True
		Me.mnuEvery10.Checked = False
		'UPGRADE_ISSUE: Form method frmDplot.Cls was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		frmDplot.Cls()
		Call Prep()
	End Sub
	
	Public Sub mnuPrint_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuPrint.Click
		Dim Printer As New Printer
		'UPGRADE_WARNING: The CommonDialog CancelError property is not supported in Visual Basic .NET. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="8B377936-3DF7-4745-AA26-DD00FA5B9BE1"'
		CommonDialog1.CancelError = True
		On Error GoTo ErrHandler
		CommonDialog1Print.ShowDialog()
		PRN = Printer
		kprn = 1
		Call Prep()
		Printer.EndDoc()
		PRN = Me
		kprn = 0
		Exit Sub
ErrHandler: 
		Exit Sub
	End Sub
End Class