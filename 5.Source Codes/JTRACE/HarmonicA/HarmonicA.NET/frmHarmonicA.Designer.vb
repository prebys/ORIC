<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmHarmonicA
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
	Public WithEvents txtMagRat As System.Windows.Forms.TextBox
	Public WithEvents txtDang As System.Windows.Forms.TextBox
	Public WithEvents cmdExit As System.Windows.Forms.Button
	Public WithEvents cmdCalc As System.Windows.Forms.Button
	Public WithEvents txtBmag As System.Windows.Forms.TextBox
	Public WithEvents txtBang As System.Windows.Forms.TextBox
	Public WithEvents lblMagRat As System.Windows.Forms.Label
	Public WithEvents lblDang As System.Windows.Forms.Label
	Public WithEvents lblBang As System.Windows.Forms.Label
	Public WithEvents lblBmag As System.Windows.Forms.Label
	Public WithEvents lblTitle As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmHarmonicA))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.txtMagRat = New System.Windows.Forms.TextBox
		Me.txtDang = New System.Windows.Forms.TextBox
		Me.cmdExit = New System.Windows.Forms.Button
		Me.cmdCalc = New System.Windows.Forms.Button
		Me.txtBmag = New System.Windows.Forms.TextBox
		Me.txtBang = New System.Windows.Forms.TextBox
		Me.lblMagRat = New System.Windows.Forms.Label
		Me.lblDang = New System.Windows.Forms.Label
		Me.lblBang = New System.Windows.Forms.Label
		Me.lblBmag = New System.Windows.Forms.Label
		Me.lblTitle = New System.Windows.Forms.Label
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.BackColor = System.Drawing.Color.FromARGB(192, 192, 255)
		Me.Text = "HarmonicA"
		Me.ClientSize = New System.Drawing.Size(480, 352)
		Me.Location = New System.Drawing.Point(4, 23)
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
		Me.Name = "frmHarmonicA"
		Me.txtMagRat.AutoSize = False
		Me.txtMagRat.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtMagRat.Size = New System.Drawing.Size(49, 20)
		Me.txtMagRat.Location = New System.Drawing.Point(376, 184)
		Me.txtMagRat.TabIndex = 10
		Me.txtMagRat.AcceptsReturn = True
		Me.txtMagRat.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtMagRat.BackColor = System.Drawing.SystemColors.Window
		Me.txtMagRat.CausesValidation = True
		Me.txtMagRat.Enabled = True
		Me.txtMagRat.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtMagRat.HideSelection = True
		Me.txtMagRat.ReadOnly = False
		Me.txtMagRat.Maxlength = 0
		Me.txtMagRat.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtMagRat.MultiLine = False
		Me.txtMagRat.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtMagRat.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtMagRat.TabStop = True
		Me.txtMagRat.Visible = True
		Me.txtMagRat.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtMagRat.Name = "txtMagRat"
		Me.txtDang.AutoSize = False
		Me.txtDang.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtDang.Size = New System.Drawing.Size(49, 20)
		Me.txtDang.Location = New System.Drawing.Point(168, 184)
		Me.txtDang.TabIndex = 8
		Me.txtDang.AcceptsReturn = True
		Me.txtDang.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtDang.BackColor = System.Drawing.SystemColors.Window
		Me.txtDang.CausesValidation = True
		Me.txtDang.Enabled = True
		Me.txtDang.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtDang.HideSelection = True
		Me.txtDang.ReadOnly = False
		Me.txtDang.Maxlength = 0
		Me.txtDang.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtDang.MultiLine = False
		Me.txtDang.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtDang.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtDang.TabStop = True
		Me.txtDang.Visible = True
		Me.txtDang.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtDang.Name = "txtDang"
		Me.cmdExit.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdExit.Text = "Exit"
		Me.cmdExit.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdExit.Size = New System.Drawing.Size(57, 25)
		Me.cmdExit.Location = New System.Drawing.Point(208, 264)
		Me.cmdExit.TabIndex = 6
		Me.cmdExit.BackColor = System.Drawing.SystemColors.Control
		Me.cmdExit.CausesValidation = True
		Me.cmdExit.Enabled = True
		Me.cmdExit.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdExit.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdExit.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdExit.TabStop = True
		Me.cmdExit.Name = "cmdExit"
		Me.cmdCalc.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdCalc.Text = "Calculate"
		Me.cmdCalc.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdCalc.Size = New System.Drawing.Size(89, 25)
		Me.cmdCalc.Location = New System.Drawing.Point(192, 120)
		Me.cmdCalc.TabIndex = 5
		Me.cmdCalc.BackColor = System.Drawing.SystemColors.Control
		Me.cmdCalc.CausesValidation = True
		Me.cmdCalc.Enabled = True
		Me.cmdCalc.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdCalc.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdCalc.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdCalc.TabStop = True
		Me.cmdCalc.Name = "cmdCalc"
		Me.txtBmag.AutoSize = False
		Me.txtBmag.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtBmag.Size = New System.Drawing.Size(57, 20)
		Me.txtBmag.Location = New System.Drawing.Point(344, 72)
		Me.txtBmag.TabIndex = 4
		Me.txtBmag.Text = "1.0"
		Me.txtBmag.AcceptsReturn = True
		Me.txtBmag.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtBmag.BackColor = System.Drawing.SystemColors.Window
		Me.txtBmag.CausesValidation = True
		Me.txtBmag.Enabled = True
		Me.txtBmag.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtBmag.HideSelection = True
		Me.txtBmag.ReadOnly = False
		Me.txtBmag.Maxlength = 0
		Me.txtBmag.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtBmag.MultiLine = False
		Me.txtBmag.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtBmag.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtBmag.TabStop = True
		Me.txtBmag.Visible = True
		Me.txtBmag.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtBmag.Name = "txtBmag"
		Me.txtBang.AutoSize = False
		Me.txtBang.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtBang.Size = New System.Drawing.Size(49, 20)
		Me.txtBang.Location = New System.Drawing.Point(152, 72)
		Me.txtBang.TabIndex = 3
		Me.txtBang.Text = "225.0"
		Me.txtBang.AcceptsReturn = True
		Me.txtBang.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtBang.BackColor = System.Drawing.SystemColors.Window
		Me.txtBang.CausesValidation = True
		Me.txtBang.Enabled = True
		Me.txtBang.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtBang.HideSelection = True
		Me.txtBang.ReadOnly = False
		Me.txtBang.Maxlength = 0
		Me.txtBang.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtBang.MultiLine = False
		Me.txtBang.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtBang.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtBang.TabStop = True
		Me.txtBang.Visible = True
		Me.txtBang.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtBang.Name = "txtBang"
		Me.lblMagRat.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblMagRat.Text = "Magnitude Ratio ="
		Me.lblMagRat.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblMagRat.Size = New System.Drawing.Size(121, 17)
		Me.lblMagRat.Location = New System.Drawing.Point(248, 184)
		Me.lblMagRat.TabIndex = 9
		Me.lblMagRat.BackColor = System.Drawing.Color.Transparent
		Me.lblMagRat.Enabled = True
		Me.lblMagRat.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblMagRat.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblMagRat.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblMagRat.UseMnemonic = True
		Me.lblMagRat.Visible = True
		Me.lblMagRat.AutoSize = False
		Me.lblMagRat.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblMagRat.Name = "lblMagRat"
		Me.lblDang.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblDang.Text = "Change in Azimuth ="
		Me.lblDang.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblDang.Size = New System.Drawing.Size(129, 17)
		Me.lblDang.Location = New System.Drawing.Point(32, 184)
		Me.lblDang.TabIndex = 7
		Me.lblDang.BackColor = System.Drawing.Color.Transparent
		Me.lblDang.Enabled = True
		Me.lblDang.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblDang.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblDang.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblDang.UseMnemonic = True
		Me.lblDang.Visible = True
		Me.lblDang.AutoSize = False
		Me.lblDang.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblDang.Name = "lblDang"
		Me.lblBang.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblBang.Text = "Angle B ="
		Me.lblBang.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblBang.Size = New System.Drawing.Size(73, 17)
		Me.lblBang.Location = New System.Drawing.Point(72, 72)
		Me.lblBang.TabIndex = 2
		Me.lblBang.BackColor = System.Drawing.Color.Transparent
		Me.lblBang.Enabled = True
		Me.lblBang.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblBang.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblBang.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblBang.UseMnemonic = True
		Me.lblBang.Visible = True
		Me.lblBang.AutoSize = False
		Me.lblBang.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblBang.Name = "lblBang"
		Me.lblBmag.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblBmag.Text = "Magnitude B ="
		Me.lblBmag.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblBmag.Size = New System.Drawing.Size(97, 17)
		Me.lblBmag.Location = New System.Drawing.Point(240, 72)
		Me.lblBmag.TabIndex = 1
		Me.lblBmag.BackColor = System.Drawing.Color.Transparent
		Me.lblBmag.Enabled = True
		Me.lblBmag.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblBmag.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblBmag.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblBmag.UseMnemonic = True
		Me.lblBmag.Visible = True
		Me.lblBmag.AutoSize = False
		Me.lblBmag.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblBmag.Name = "lblBmag"
		Me.lblTitle.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblTitle.Text = "HarmonicA"
		Me.lblTitle.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblTitle.Size = New System.Drawing.Size(201, 33)
		Me.lblTitle.Location = New System.Drawing.Point(120, 16)
		Me.lblTitle.TabIndex = 0
		Me.lblTitle.BackColor = System.Drawing.Color.Transparent
		Me.lblTitle.Enabled = True
		Me.lblTitle.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblTitle.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblTitle.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblTitle.UseMnemonic = True
		Me.lblTitle.Visible = True
		Me.lblTitle.AutoSize = False
		Me.lblTitle.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblTitle.Name = "lblTitle"
		Me.Controls.Add(txtMagRat)
		Me.Controls.Add(txtDang)
		Me.Controls.Add(cmdExit)
		Me.Controls.Add(cmdCalc)
		Me.Controls.Add(txtBmag)
		Me.Controls.Add(txtBang)
		Me.Controls.Add(lblMagRat)
		Me.Controls.Add(lblDang)
		Me.Controls.Add(lblBang)
		Me.Controls.Add(lblBmag)
		Me.Controls.Add(lblTitle)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class