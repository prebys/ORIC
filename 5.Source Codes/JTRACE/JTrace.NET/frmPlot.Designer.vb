<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmPlot
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
	Public PrintForm1 As Microsoft.VisualBasic.PowerPacks.Printing.PrintForm
	Public WithEvents mnuPrint As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuExit As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents _mnuFile_2 As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuRerun As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents mnuFoil As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents _mnuEdit_2 As System.Windows.Forms.ToolStripMenuItem
	Public WithEvents MainMenu1 As System.Windows.Forms.MenuStrip
	Public WithEvents mnuEdit As Microsoft.VisualBasic.Compatibility.VB6.ToolStripMenuItemArray
	Public WithEvents mnuFile As Microsoft.VisualBasic.Compatibility.VB6.ToolStripMenuItemArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmPlot))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.PrintForm1 = New Microsoft.VisualBasic.PowerPacks.Printing.PrintForm(Me)
		Me.MainMenu1 = New System.Windows.Forms.MenuStrip
		Me._mnuFile_2 = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuPrint = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuExit = New System.Windows.Forms.ToolStripMenuItem
		Me._mnuEdit_2 = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuRerun = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuFoil = New System.Windows.Forms.ToolStripMenuItem
		Me.mnuEdit = New Microsoft.VisualBasic.Compatibility.VB6.ToolStripMenuItemArray(components)
		Me.mnuFile = New Microsoft.VisualBasic.Compatibility.VB6.ToolStripMenuItemArray(components)
		Me.MainMenu1.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.mnuEdit, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.mnuFile, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.BackColor = System.Drawing.Color.White
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
		Me.Text = "JTracePlot"
		Me.ClientSize = New System.Drawing.Size(949, 748)
		Me.Location = New System.Drawing.Point(8, 33)
		Me.Font = New System.Drawing.Font("Arial", 10.2!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "frmPlot"
		Me._mnuFile_2.Name = "_mnuFile_2"
		Me._mnuFile_2.Text = "&File"
		Me._mnuFile_2.Checked = False
		Me._mnuFile_2.Enabled = True
		Me._mnuFile_2.Visible = True
		Me.mnuPrint.Name = "mnuPrint"
		Me.mnuPrint.Text = "&Print"
		Me.mnuPrint.Checked = False
		Me.mnuPrint.Enabled = True
		Me.mnuPrint.Visible = True
		Me.mnuExit.Name = "mnuExit"
		Me.mnuExit.Text = "E&xit"
		Me.mnuExit.Checked = False
		Me.mnuExit.Enabled = True
		Me.mnuExit.Visible = True
		Me._mnuEdit_2.Name = "_mnuEdit_2"
		Me._mnuEdit_2.Text = "&Edit"
		Me._mnuEdit_2.Checked = False
		Me._mnuEdit_2.Enabled = True
		Me._mnuEdit_2.Visible = True
		Me.mnuRerun.Name = "mnuRerun"
		Me.mnuRerun.Text = "&Rerun"
		Me.mnuRerun.Checked = False
		Me.mnuRerun.Enabled = True
		Me.mnuRerun.Visible = True
		Me.mnuFoil.Name = "mnuFoil"
		Me.mnuFoil.Text = "&Insert Foil"
		Me.mnuFoil.Checked = False
		Me.mnuFoil.Enabled = True
		Me.mnuFoil.Visible = True
		Me.mnuEdit.SetIndex(_mnuEdit_2, CType(2, Short))
		Me.mnuFile.SetIndex(_mnuFile_2, CType(2, Short))
		CType(Me.mnuFile, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.mnuEdit, System.ComponentModel.ISupportInitialize).EndInit()
		MainMenu1.Items.AddRange(New System.Windows.Forms.ToolStripItem(){Me._mnuFile_2, Me._mnuEdit_2})
		_mnuFile_2.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem(){Me.mnuPrint, Me.mnuExit})
		_mnuEdit_2.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem(){Me.mnuRerun, Me.mnuFoil})
		Me.Controls.Add(MainMenu1)
		Me.MainMenu1.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class