<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmDplot
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents mnuPrint As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuExit As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuFile As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuDiag As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuLast10 As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuLast5 As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuEvery10 As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuOptions As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuAbout As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuHelp As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents MainMenu1 As System.Windows.Forms.MenuStrip
	Public CommonDialog1Print As System.Windows.Forms.PrintDialog
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmDplot))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.MainMenu1 = New System.Windows.Forms.MenuStrip
		Me.mnuFile = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuPrint = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuExit = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuOptions = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuDiag = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuLast10 = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuLast5 = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuEvery10 = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuHelp = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuAbout = New System.Windows.Forms.ToolStripMenuItem
		Me.CommonDialog1Print = New System.Windows.Forms.PrintDialog
		Me.CommonDialog1Print.PrinterSettings = New System.Drawing.Printing.PrinterSettings
		Me.MainMenu1.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.BackColor = System.Drawing.Color.White
		Me.Text = "JBDPLOT -  Diagnostics Viewer"
		Me.ClientSize = New System.Drawing.Size(661, 812)
		Me.Location = New System.Drawing.Point(9, 48)
		Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultLocation
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "frmDplot"
		Me.mnuFile.Name = "mnuFile"
		Me.mnuFile.Text = "File"
		Me.mnuFile.Checked = False
		Me.mnuFile.Enabled = True
		Me.mnuFile.Visible = True
		Me.mnuPrint.Name = "mnuPrint"
		Me.mnuPrint.Text = "Print"
		Me.mnuPrint.Checked = False
		Me.mnuPrint.Enabled = True
		Me.mnuPrint.Visible = True
		Me.mnuExit.Name = "mnuExit"
		Me.mnuExit.Text = "Exit"
		Me.mnuExit.Checked = False
		Me.mnuExit.Enabled = True
		Me.mnuExit.Visible = True
		Me.mnuOptions.Name = "mnuOptions"
		Me.mnuOptions.Text = "Options"
		Me.mnuOptions.Checked = False
		Me.mnuOptions.Enabled = True
		Me.mnuOptions.Visible = True
		Me.mnuDiag.Name = "mnuDiag"
		Me.mnuDiag.Text = "Diagnostics"
		Me.mnuDiag.Checked = True
		Me.mnuDiag.Enabled = True
		Me.mnuDiag.Visible = True
		Me.mnuLast10.Name = "mnuLast10"
		Me.mnuLast10.Text = "Last 10 Orbits"
		Me.mnuLast10.Checked = False
		Me.mnuLast10.Enabled = True
		Me.mnuLast10.Visible = True
		Me.mnuLast5.Name = "mnuLast5"
		Me.mnuLast5.Text = "Last 5 Orbits"
		Me.mnuLast5.Checked = False
		Me.mnuLast5.Enabled = True
		Me.mnuLast5.Visible = True
		Me.mnuEvery10.Name = "mnuEvery10"
		Me.mnuEvery10.Text = "Every 10 Orbits"
		Me.mnuEvery10.Checked = False
		Me.mnuEvery10.Enabled = True
		Me.mnuEvery10.Visible = True
		Me.mnuHelp.Name = "mnuHelp"
		Me.mnuHelp.Text = "Help"
		Me.mnuHelp.Checked = False
		Me.mnuHelp.Enabled = True
		Me.mnuHelp.Visible = True
		Me.mnuAbout.Name = "mnuAbout"
		Me.mnuAbout.Text = "About JBDPLOT"
		Me.mnuAbout.Checked = False
		Me.mnuAbout.Enabled = True
		Me.mnuAbout.Visible = True
		Me.CommonDialog1Print.PrinterSettings.FromPage = 1
		Me.CommonDialog1Print.PrinterSettings.ToPage = 1
		MainMenu1.Items.AddRange(New System.Windows.Forms.ToolStripItem(){Me.mnuFile, Me.mnuOptions, Me.mnuHelp})
		mnuFile.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem(){Me.mnuPrint, Me.mnuExit})
		mnuOptions.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem(){Me.mnuDiag, Me.mnuLast10, Me.mnuLast5, Me.mnuEvery10})
		mnuHelp.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem(){Me.mnuAbout})
		Me.Controls.Add(MainMenu1)
		Me.MainMenu1.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class