<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmAbout
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
	Public WithEvents cmdOK As System.Windows.Forms.Button
	Public WithEvents lblHelp As System.Windows.Forms.Label
	Public WithEvents lblVers As System.Windows.Forms.Label
	Public WithEvents lblAuth As System.Windows.Forms.Label
	Public WithEvents lblTitle As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmAbout))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.cmdOK = New System.Windows.Forms.Button
		Me.lblHelp = New System.Windows.Forms.Label
		Me.lblVers = New System.Windows.Forms.Label
		Me.lblAuth = New System.Windows.Forms.Label
		Me.lblTitle = New System.Windows.Forms.Label
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.BackColor = System.Drawing.Color.Yellow
		Me.Text = "About JBDPLOT"
		Me.ClientSize = New System.Drawing.Size(304, 193)
		Me.Location = New System.Drawing.Point(4, 23)
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.ShowInTaskbar = True
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "frmAbout"
		Me.cmdOK.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdOK.Text = "OK"
		Me.cmdOK.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdOK.Size = New System.Drawing.Size(33, 25)
		Me.cmdOK.Location = New System.Drawing.Point(136, 152)
		Me.cmdOK.TabIndex = 4
		Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
		Me.cmdOK.CausesValidation = True
		Me.cmdOK.Enabled = True
		Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdOK.TabStop = True
		Me.cmdOK.Name = "cmdOK"
		Me.lblHelp.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblHelp.Text = "Please see the ORIC Program User Guide for discusions on how to use this program."
		Me.lblHelp.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblHelp.Size = New System.Drawing.Size(257, 33)
		Me.lblHelp.Location = New System.Drawing.Point(24, 104)
		Me.lblHelp.TabIndex = 3
		Me.lblHelp.BackColor = System.Drawing.Color.Transparent
		Me.lblHelp.Enabled = True
		Me.lblHelp.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblHelp.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblHelp.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblHelp.UseMnemonic = True
		Me.lblHelp.Visible = True
		Me.lblHelp.AutoSize = False
		Me.lblHelp.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblHelp.Name = "lblHelp"
		Me.lblVers.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblVers.Text = "Version Date:  5/30/2007"
		Me.lblVers.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblVers.Size = New System.Drawing.Size(241, 25)
		Me.lblVers.Location = New System.Drawing.Point(32, 64)
		Me.lblVers.TabIndex = 2
		Me.lblVers.BackColor = System.Drawing.Color.Transparent
		Me.lblVers.Enabled = True
		Me.lblVers.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblVers.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblVers.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblVers.UseMnemonic = True
		Me.lblVers.Visible = True
		Me.lblVers.AutoSize = False
		Me.lblVers.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblVers.Name = "lblVers"
		Me.lblAuth.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblAuth.Text = "Written by Jim Ball"
		Me.lblAuth.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAuth.Size = New System.Drawing.Size(153, 25)
		Me.lblAuth.Location = New System.Drawing.Point(72, 40)
		Me.lblAuth.TabIndex = 1
		Me.lblAuth.BackColor = System.Drawing.Color.Transparent
		Me.lblAuth.Enabled = True
		Me.lblAuth.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAuth.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAuth.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAuth.UseMnemonic = True
		Me.lblAuth.Visible = True
		Me.lblAuth.AutoSize = False
		Me.lblAuth.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAuth.Name = "lblAuth"
		Me.lblTitle.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblTitle.BackColor = System.Drawing.Color.Transparent
		Me.lblTitle.Text = "JBDPLOT Diagnostics Viewer"
		Me.lblTitle.Font = New System.Drawing.Font("Arial", 13.8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblTitle.ForeColor = System.Drawing.Color.Blue
		Me.lblTitle.Size = New System.Drawing.Size(273, 25)
		Me.lblTitle.Location = New System.Drawing.Point(16, 16)
		Me.lblTitle.TabIndex = 0
		Me.lblTitle.Enabled = True
		Me.lblTitle.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblTitle.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblTitle.UseMnemonic = True
		Me.lblTitle.Visible = True
		Me.lblTitle.AutoSize = False
		Me.lblTitle.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblTitle.Name = "lblTitle"
		Me.Controls.Add(cmdOK)
		Me.Controls.Add(lblHelp)
		Me.Controls.Add(lblVers)
		Me.Controls.Add(lblAuth)
		Me.Controls.Add(lblTitle)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class