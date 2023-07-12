Option Strict Off
Option Explicit On
Friend Class frmPlot
	Inherits System.Windows.Forms.Form
	' JTrace1 - Plot Form (frmPlot)
	'
	'  This form is completely blank to show plot.
	'  It contains only menu items.
	'
	'  THIS VERSION OPTIMIZED FOR 1024 X 768 DISPLAY
	'
	
	Public Sub mnuExit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuExit.Click
		End
	End Sub
	
	Public Sub mnuFoil_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuFoil.Click
		'UPGRADE_WARNING: Couldn't resolve default property of object Kfoil. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Kfoil = 1
		'UPGRADE_ISSUE: Form method frmPlot.Cls was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		Cls()
		Call JTcode()
	End Sub
	
	Public Sub mnuPrint_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuPrint.Click
		PrintForm1.Print(Me, PowerPacks.Printing.PrintForm.PrintOption.CompatibleModeClientAreaOnly)
	End Sub
	
	Public Sub mnuRerun_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles mnuRerun.Click
		'UPGRADE_ISSUE: Form method frmPlot.Cls was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		Cls()
		'UPGRADE_WARNING: Couldn't resolve default property of object Kfoil. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		Kfoil = 0 'no stripper until requested
		Hide()
		frmMain.Show()
	End Sub
End Class