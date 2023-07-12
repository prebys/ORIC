<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmMain
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
	Public WithEvents txtVers As System.Windows.Forms.TextBox
	Public WithEvents txtVM2 As System.Windows.Forms.TextBox
	Public WithEvents txtVM1 As System.Windows.Forms.TextBox
	Public WithEvents txtLC2 As System.Windows.Forms.TextBox
	Public WithEvents txtLC1 As System.Windows.Forms.TextBox
	Public WithEvents txtStrip As System.Windows.Forms.TextBox
	Public WithEvents txtCX As System.Windows.Forms.TextBox
	Public WithEvents txtPartE As System.Windows.Forms.TextBox
	Public WithEvents txtPartZ As System.Windows.Forms.TextBox
	Public WithEvents txtPartM As System.Windows.Forms.TextBox
	Public WithEvents txtAvgR As System.Windows.Forms.TextBox
	Public WithEvents txtR90 As System.Windows.Forms.TextBox
	Public WithEvents cmdExit As System.Windows.Forms.Button
	Public WithEvents txtStop As System.Windows.Forms.TextBox
	Public WithEvents txtGINC As System.Windows.Forms.TextBox
	Public WithEvents cmdRun As System.Windows.Forms.Button
	Public WithEvents lblVM2 As System.Windows.Forms.Label
	Public WithEvents lblVM1 As System.Windows.Forms.Label
	Public WithEvents lblLC2 As System.Windows.Forms.Label
	Public WithEvents lblLC1 As System.Windows.Forms.Label
	Public WithEvents lblExtPrm As System.Windows.Forms.Label
	Public WithEvents lblStrip As System.Windows.Forms.Label
	Public WithEvents lblCX As System.Windows.Forms.Label
	Public WithEvents lblPartE As System.Windows.Forms.Label
	Public WithEvents lblPartZ As System.Windows.Forms.Label
	Public WithEvents lblPartM As System.Windows.Forms.Label
	Public WithEvents lblPartPrm As System.Windows.Forms.Label
	Public WithEvents lblAvgR As System.Windows.Forms.Label
	Public WithEvents lblR90 As System.Windows.Forms.Label
	Public WithEvents lblOrbPrm As System.Windows.Forms.Label
	Public WithEvents lblStop As System.Windows.Forms.Label
	Public WithEvents lblGINC As System.Windows.Forms.Label
	Public WithEvents lblRunPrm As System.Windows.Forms.Label
	Public WithEvents lblHeader As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmMain))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.txtVers = New System.Windows.Forms.TextBox
		Me.txtVM2 = New System.Windows.Forms.TextBox
		Me.txtVM1 = New System.Windows.Forms.TextBox
		Me.txtLC2 = New System.Windows.Forms.TextBox
		Me.txtLC1 = New System.Windows.Forms.TextBox
		Me.txtStrip = New System.Windows.Forms.TextBox
		Me.txtCX = New System.Windows.Forms.TextBox
		Me.txtPartE = New System.Windows.Forms.TextBox
		Me.txtPartZ = New System.Windows.Forms.TextBox
		Me.txtPartM = New System.Windows.Forms.TextBox
		Me.txtAvgR = New System.Windows.Forms.TextBox
		Me.txtR90 = New System.Windows.Forms.TextBox
		Me.cmdExit = New System.Windows.Forms.Button
		Me.txtStop = New System.Windows.Forms.TextBox
		Me.txtGINC = New System.Windows.Forms.TextBox
		Me.cmdRun = New System.Windows.Forms.Button
		Me.lblVM2 = New System.Windows.Forms.Label
		Me.lblVM1 = New System.Windows.Forms.Label
		Me.lblLC2 = New System.Windows.Forms.Label
		Me.lblLC1 = New System.Windows.Forms.Label
		Me.lblExtPrm = New System.Windows.Forms.Label
		Me.lblStrip = New System.Windows.Forms.Label
		Me.lblCX = New System.Windows.Forms.Label
		Me.lblPartE = New System.Windows.Forms.Label
		Me.lblPartZ = New System.Windows.Forms.Label
		Me.lblPartM = New System.Windows.Forms.Label
		Me.lblPartPrm = New System.Windows.Forms.Label
		Me.lblAvgR = New System.Windows.Forms.Label
		Me.lblR90 = New System.Windows.Forms.Label
		Me.lblOrbPrm = New System.Windows.Forms.Label
		Me.lblStop = New System.Windows.Forms.Label
		Me.lblGINC = New System.Windows.Forms.Label
		Me.lblRunPrm = New System.Windows.Forms.Label
		Me.lblHeader = New System.Windows.Forms.Label
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.BackColor = System.Drawing.Color.FromARGB(255, 255, 128)
		Me.Text = "JTrace"
		Me.ClientSize = New System.Drawing.Size(535, 448)
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
		Me.Name = "frmMain"
		Me.txtVers.AutoSize = False
		Me.txtVers.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
		Me.txtVers.BackColor = System.Drawing.Color.FromARGB(255, 255, 128)
		Me.txtVers.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtVers.ForeColor = System.Drawing.Color.Blue
		Me.txtVers.Size = New System.Drawing.Size(121, 20)
		Me.txtVers.Location = New System.Drawing.Point(208, 48)
		Me.txtVers.TabIndex = 33
		Me.txtVers.Text = "Version #"
		Me.txtVers.AcceptsReturn = True
		Me.txtVers.CausesValidation = True
		Me.txtVers.Enabled = True
		Me.txtVers.HideSelection = True
		Me.txtVers.ReadOnly = False
		Me.txtVers.Maxlength = 0
		Me.txtVers.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtVers.MultiLine = False
		Me.txtVers.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtVers.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtVers.TabStop = True
		Me.txtVers.Visible = True
		Me.txtVers.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.txtVers.Name = "txtVers"
		Me.txtVM2.AutoSize = False
		Me.txtVM2.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtVM2.Size = New System.Drawing.Size(41, 20)
		Me.txtVM2.Location = New System.Drawing.Point(432, 360)
		Me.txtVM2.TabIndex = 32
		Me.txtVM2.Text = "2.5"
		Me.txtVM2.AcceptsReturn = True
		Me.txtVM2.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtVM2.BackColor = System.Drawing.SystemColors.Window
		Me.txtVM2.CausesValidation = True
		Me.txtVM2.Enabled = True
		Me.txtVM2.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtVM2.HideSelection = True
		Me.txtVM2.ReadOnly = False
		Me.txtVM2.Maxlength = 0
		Me.txtVM2.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtVM2.MultiLine = False
		Me.txtVM2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtVM2.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtVM2.TabStop = True
		Me.txtVM2.Visible = True
		Me.txtVM2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtVM2.Name = "txtVM2"
		Me.txtVM1.AutoSize = False
		Me.txtVM1.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtVM1.Size = New System.Drawing.Size(41, 20)
		Me.txtVM1.Location = New System.Drawing.Point(240, 360)
		Me.txtVM1.TabIndex = 30
		Me.txtVM1.Text = "6.0"
		Me.txtVM1.AcceptsReturn = True
		Me.txtVM1.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtVM1.BackColor = System.Drawing.SystemColors.Window
		Me.txtVM1.CausesValidation = True
		Me.txtVM1.Enabled = True
		Me.txtVM1.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtVM1.HideSelection = True
		Me.txtVM1.ReadOnly = False
		Me.txtVM1.Maxlength = 0
		Me.txtVM1.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtVM1.MultiLine = False
		Me.txtVM1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtVM1.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtVM1.TabStop = True
		Me.txtVM1.Visible = True
		Me.txtVM1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtVM1.Name = "txtVM1"
		Me.txtLC2.AutoSize = False
		Me.txtLC2.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtLC2.Size = New System.Drawing.Size(41, 20)
		Me.txtLC2.Location = New System.Drawing.Point(432, 328)
		Me.txtLC2.TabIndex = 28
		Me.txtLC2.Text = "13.0"
		Me.txtLC2.AcceptsReturn = True
		Me.txtLC2.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtLC2.BackColor = System.Drawing.SystemColors.Window
		Me.txtLC2.CausesValidation = True
		Me.txtLC2.Enabled = True
		Me.txtLC2.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtLC2.HideSelection = True
		Me.txtLC2.ReadOnly = False
		Me.txtLC2.Maxlength = 0
		Me.txtLC2.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtLC2.MultiLine = False
		Me.txtLC2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtLC2.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtLC2.TabStop = True
		Me.txtLC2.Visible = True
		Me.txtLC2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtLC2.Name = "txtLC2"
		Me.txtLC1.AutoSize = False
		Me.txtLC1.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtLC1.Size = New System.Drawing.Size(41, 20)
		Me.txtLC1.Location = New System.Drawing.Point(240, 328)
		Me.txtLC1.TabIndex = 26
		Me.txtLC1.Text = "7.0"
		Me.txtLC1.AcceptsReturn = True
		Me.txtLC1.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtLC1.BackColor = System.Drawing.SystemColors.Window
		Me.txtLC1.CausesValidation = True
		Me.txtLC1.Enabled = True
		Me.txtLC1.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtLC1.HideSelection = True
		Me.txtLC1.ReadOnly = False
		Me.txtLC1.Maxlength = 0
		Me.txtLC1.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtLC1.MultiLine = False
		Me.txtLC1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtLC1.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtLC1.TabStop = True
		Me.txtLC1.Visible = True
		Me.txtLC1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtLC1.Name = "txtLC1"
		Me.txtStrip.AutoSize = False
		Me.txtStrip.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtStrip.Size = New System.Drawing.Size(41, 20)
		Me.txtStrip.Location = New System.Drawing.Point(432, 264)
		Me.txtStrip.TabIndex = 23
		Me.txtStrip.Text = "230.0"
		Me.txtStrip.AcceptsReturn = True
		Me.txtStrip.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtStrip.BackColor = System.Drawing.SystemColors.Window
		Me.txtStrip.CausesValidation = True
		Me.txtStrip.Enabled = True
		Me.txtStrip.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtStrip.HideSelection = True
		Me.txtStrip.ReadOnly = False
		Me.txtStrip.Maxlength = 0
		Me.txtStrip.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtStrip.MultiLine = False
		Me.txtStrip.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtStrip.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtStrip.TabStop = True
		Me.txtStrip.Visible = True
		Me.txtStrip.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtStrip.Name = "txtStrip"
		Me.txtCX.AutoSize = False
		Me.txtCX.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtCX.Size = New System.Drawing.Size(41, 20)
		Me.txtCX.Location = New System.Drawing.Point(240, 264)
		Me.txtCX.TabIndex = 21
		Me.txtCX.Text = "3.8"
		Me.txtCX.AcceptsReturn = True
		Me.txtCX.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtCX.BackColor = System.Drawing.SystemColors.Window
		Me.txtCX.CausesValidation = True
		Me.txtCX.Enabled = True
		Me.txtCX.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtCX.HideSelection = True
		Me.txtCX.ReadOnly = False
		Me.txtCX.Maxlength = 0
		Me.txtCX.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtCX.MultiLine = False
		Me.txtCX.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtCX.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtCX.TabStop = True
		Me.txtCX.Visible = True
		Me.txtCX.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtCX.Name = "txtCX"
		Me.txtPartE.AutoSize = False
		Me.txtPartE.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtPartE.Size = New System.Drawing.Size(41, 20)
		Me.txtPartE.Location = New System.Drawing.Point(432, 168)
		Me.txtPartE.TabIndex = 19
		Me.txtPartE.Text = "50.0"
		Me.txtPartE.AcceptsReturn = True
		Me.txtPartE.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtPartE.BackColor = System.Drawing.SystemColors.Window
		Me.txtPartE.CausesValidation = True
		Me.txtPartE.Enabled = True
		Me.txtPartE.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtPartE.HideSelection = True
		Me.txtPartE.ReadOnly = False
		Me.txtPartE.Maxlength = 0
		Me.txtPartE.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtPartE.MultiLine = False
		Me.txtPartE.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtPartE.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtPartE.TabStop = True
		Me.txtPartE.Visible = True
		Me.txtPartE.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtPartE.Name = "txtPartE"
		Me.txtPartZ.AutoSize = False
		Me.txtPartZ.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtPartZ.Size = New System.Drawing.Size(33, 20)
		Me.txtPartZ.Location = New System.Drawing.Point(296, 168)
		Me.txtPartZ.TabIndex = 4
		Me.txtPartZ.Text = "1"
		Me.txtPartZ.AcceptsReturn = True
		Me.txtPartZ.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtPartZ.BackColor = System.Drawing.SystemColors.Window
		Me.txtPartZ.CausesValidation = True
		Me.txtPartZ.Enabled = True
		Me.txtPartZ.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtPartZ.HideSelection = True
		Me.txtPartZ.ReadOnly = False
		Me.txtPartZ.Maxlength = 0
		Me.txtPartZ.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtPartZ.MultiLine = False
		Me.txtPartZ.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtPartZ.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtPartZ.TabStop = True
		Me.txtPartZ.Visible = True
		Me.txtPartZ.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtPartZ.Name = "txtPartZ"
		Me.txtPartM.AutoSize = False
		Me.txtPartM.BackColor = System.Drawing.Color.White
		Me.txtPartM.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtPartM.Size = New System.Drawing.Size(33, 20)
		Me.txtPartM.Location = New System.Drawing.Point(160, 168)
		Me.txtPartM.TabIndex = 3
		Me.txtPartM.Text = "1"
		Me.txtPartM.AcceptsReturn = True
		Me.txtPartM.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtPartM.CausesValidation = True
		Me.txtPartM.Enabled = True
		Me.txtPartM.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtPartM.HideSelection = True
		Me.txtPartM.ReadOnly = False
		Me.txtPartM.Maxlength = 0
		Me.txtPartM.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtPartM.MultiLine = False
		Me.txtPartM.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtPartM.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtPartM.TabStop = True
		Me.txtPartM.Visible = True
		Me.txtPartM.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtPartM.Name = "txtPartM"
		Me.txtAvgR.AutoSize = False
		Me.txtAvgR.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtAvgR.Size = New System.Drawing.Size(41, 20)
		Me.txtAvgR.Location = New System.Drawing.Point(432, 232)
		Me.txtAvgR.TabIndex = 13
		Me.txtAvgR.Text = "32.0"
		Me.txtAvgR.AcceptsReturn = True
		Me.txtAvgR.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtAvgR.BackColor = System.Drawing.SystemColors.Window
		Me.txtAvgR.CausesValidation = True
		Me.txtAvgR.Enabled = True
		Me.txtAvgR.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtAvgR.HideSelection = True
		Me.txtAvgR.ReadOnly = False
		Me.txtAvgR.Maxlength = 0
		Me.txtAvgR.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtAvgR.MultiLine = False
		Me.txtAvgR.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtAvgR.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtAvgR.TabStop = True
		Me.txtAvgR.Visible = True
		Me.txtAvgR.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtAvgR.Name = "txtAvgR"
		Me.txtR90.AutoSize = False
		Me.txtR90.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtR90.Size = New System.Drawing.Size(41, 20)
		Me.txtR90.Location = New System.Drawing.Point(240, 232)
		Me.txtR90.TabIndex = 12
		Me.txtR90.Text = "30.4"
		Me.txtR90.AcceptsReturn = True
		Me.txtR90.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtR90.BackColor = System.Drawing.SystemColors.Window
		Me.txtR90.CausesValidation = True
		Me.txtR90.Enabled = True
		Me.txtR90.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtR90.HideSelection = True
		Me.txtR90.ReadOnly = False
		Me.txtR90.Maxlength = 0
		Me.txtR90.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtR90.MultiLine = False
		Me.txtR90.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtR90.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtR90.TabStop = True
		Me.txtR90.Visible = True
		Me.txtR90.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtR90.Name = "txtR90"
		Me.cmdExit.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdExit.Text = "Exit"
		Me.cmdExit.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdExit.Size = New System.Drawing.Size(73, 25)
		Me.cmdExit.Location = New System.Drawing.Point(352, 408)
		Me.cmdExit.TabIndex = 10
		Me.cmdExit.BackColor = System.Drawing.SystemColors.Control
		Me.cmdExit.CausesValidation = True
		Me.cmdExit.Enabled = True
		Me.cmdExit.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdExit.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdExit.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdExit.TabStop = True
		Me.cmdExit.Name = "cmdExit"
		Me.txtStop.AutoSize = False
		Me.txtStop.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtStop.Size = New System.Drawing.Size(41, 20)
		Me.txtStop.Location = New System.Drawing.Point(432, 104)
		Me.txtStop.TabIndex = 2
		Me.txtStop.Text = "600"
		Me.txtStop.AcceptsReturn = True
		Me.txtStop.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtStop.BackColor = System.Drawing.SystemColors.Window
		Me.txtStop.CausesValidation = True
		Me.txtStop.Enabled = True
		Me.txtStop.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtStop.HideSelection = True
		Me.txtStop.ReadOnly = False
		Me.txtStop.Maxlength = 0
		Me.txtStop.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtStop.MultiLine = False
		Me.txtStop.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtStop.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtStop.TabStop = True
		Me.txtStop.Visible = True
		Me.txtStop.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtStop.Name = "txtStop"
		Me.txtGINC.AutoSize = False
		Me.txtGINC.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtGINC.Size = New System.Drawing.Size(33, 20)
		Me.txtGINC.Location = New System.Drawing.Point(240, 104)
		Me.txtGINC.TabIndex = 1
		Me.txtGINC.Text = "1.0"
		Me.txtGINC.AcceptsReturn = True
		Me.txtGINC.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtGINC.BackColor = System.Drawing.SystemColors.Window
		Me.txtGINC.CausesValidation = True
		Me.txtGINC.Enabled = True
		Me.txtGINC.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtGINC.HideSelection = True
		Me.txtGINC.ReadOnly = False
		Me.txtGINC.Maxlength = 0
		Me.txtGINC.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtGINC.MultiLine = False
		Me.txtGINC.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtGINC.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtGINC.TabStop = True
		Me.txtGINC.Visible = True
		Me.txtGINC.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtGINC.Name = "txtGINC"
		Me.cmdRun.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdRun.BackColor = System.Drawing.SystemColors.Control
		Me.cmdRun.Text = "Run"
		Me.cmdRun.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdRun.Size = New System.Drawing.Size(81, 25)
		Me.cmdRun.Location = New System.Drawing.Point(120, 408)
		Me.cmdRun.TabIndex = 6
		Me.cmdRun.CausesValidation = True
		Me.cmdRun.Enabled = True
		Me.cmdRun.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdRun.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdRun.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdRun.TabStop = True
		Me.cmdRun.Name = "cmdRun"
		Me.lblVM2.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblVM2.Text = "VM #2 Field ="
		Me.lblVM2.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblVM2.Size = New System.Drawing.Size(89, 17)
		Me.lblVM2.Location = New System.Drawing.Point(336, 360)
		Me.lblVM2.TabIndex = 31
		Me.lblVM2.BackColor = System.Drawing.Color.Transparent
		Me.lblVM2.Enabled = True
		Me.lblVM2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblVM2.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblVM2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblVM2.UseMnemonic = True
		Me.lblVM2.Visible = True
		Me.lblVM2.AutoSize = False
		Me.lblVM2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblVM2.Name = "lblVM2"
		Me.lblVM1.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblVM1.Text = "Verticle Magnet #1 Field ="
		Me.lblVM1.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblVM1.Size = New System.Drawing.Size(177, 17)
		Me.lblVM1.Location = New System.Drawing.Point(56, 360)
		Me.lblVM1.TabIndex = 29
		Me.lblVM1.BackColor = System.Drawing.Color.Transparent
		Me.lblVM1.Enabled = True
		Me.lblVM1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblVM1.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblVM1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblVM1.UseMnemonic = True
		Me.lblVM1.Visible = True
		Me.lblVM1.AutoSize = False
		Me.lblVM1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblVM1.Name = "lblVM1"
		Me.lblLC2.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblLC2.Text = "LC #2 Field ="
		Me.lblLC2.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblLC2.Size = New System.Drawing.Size(97, 17)
		Me.lblLC2.Location = New System.Drawing.Point(328, 328)
		Me.lblLC2.TabIndex = 27
		Me.lblLC2.BackColor = System.Drawing.Color.Transparent
		Me.lblLC2.Enabled = True
		Me.lblLC2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblLC2.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblLC2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblLC2.UseMnemonic = True
		Me.lblLC2.Visible = True
		Me.lblLC2.AutoSize = False
		Me.lblLC2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblLC2.Name = "lblLC2"
		Me.lblLC1.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblLC1.Text = "Lower Channel #1 Field ="
		Me.lblLC1.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblLC1.Size = New System.Drawing.Size(169, 17)
		Me.lblLC1.Location = New System.Drawing.Point(64, 328)
		Me.lblLC1.TabIndex = 25
		Me.lblLC1.BackColor = System.Drawing.Color.Transparent
		Me.lblLC1.Enabled = True
		Me.lblLC1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblLC1.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblLC1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblLC1.UseMnemonic = True
		Me.lblLC1.Visible = True
		Me.lblLC1.AutoSize = False
		Me.lblLC1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblLC1.Name = "lblLC1"
		Me.lblExtPrm.Text = "Extraction Parameters:"
		Me.lblExtPrm.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblExtPrm.ForeColor = System.Drawing.Color.Blue
		Me.lblExtPrm.Size = New System.Drawing.Size(169, 17)
		Me.lblExtPrm.Location = New System.Drawing.Point(40, 304)
		Me.lblExtPrm.TabIndex = 24
		Me.lblExtPrm.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblExtPrm.BackColor = System.Drawing.Color.Transparent
		Me.lblExtPrm.Enabled = True
		Me.lblExtPrm.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblExtPrm.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblExtPrm.UseMnemonic = True
		Me.lblExtPrm.Visible = True
		Me.lblExtPrm.AutoSize = False
		Me.lblExtPrm.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblExtPrm.Name = "lblExtPrm"
		Me.lblStrip.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblStrip.Text = "Stripper Azimuth ="
		Me.lblStrip.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblStrip.Size = New System.Drawing.Size(121, 17)
		Me.lblStrip.Location = New System.Drawing.Point(304, 264)
		Me.lblStrip.TabIndex = 22
		Me.lblStrip.BackColor = System.Drawing.Color.Transparent
		Me.lblStrip.Enabled = True
		Me.lblStrip.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblStrip.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblStrip.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblStrip.UseMnemonic = True
		Me.lblStrip.Visible = True
		Me.lblStrip.AutoSize = False
		Me.lblStrip.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblStrip.Name = "lblStrip"
		Me.lblCX.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblCX.Text = "Starting CX ="
		Me.lblCX.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblCX.Size = New System.Drawing.Size(97, 17)
		Me.lblCX.Location = New System.Drawing.Point(136, 264)
		Me.lblCX.TabIndex = 20
		Me.lblCX.BackColor = System.Drawing.Color.Transparent
		Me.lblCX.Enabled = True
		Me.lblCX.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblCX.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblCX.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblCX.UseMnemonic = True
		Me.lblCX.Visible = True
		Me.lblCX.AutoSize = False
		Me.lblCX.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblCX.Name = "lblCX"
		Me.lblPartE.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblPartE.Text = "Energy ="
		Me.lblPartE.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblPartE.Size = New System.Drawing.Size(65, 17)
		Me.lblPartE.Location = New System.Drawing.Point(360, 168)
		Me.lblPartE.TabIndex = 18
		Me.lblPartE.BackColor = System.Drawing.Color.Transparent
		Me.lblPartE.Enabled = True
		Me.lblPartE.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblPartE.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblPartE.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblPartE.UseMnemonic = True
		Me.lblPartE.Visible = True
		Me.lblPartE.AutoSize = False
		Me.lblPartE.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblPartE.Name = "lblPartE"
		Me.lblPartZ.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblPartZ.Text = "Charge ="
		Me.lblPartZ.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblPartZ.Size = New System.Drawing.Size(65, 17)
		Me.lblPartZ.Location = New System.Drawing.Point(224, 168)
		Me.lblPartZ.TabIndex = 17
		Me.lblPartZ.BackColor = System.Drawing.Color.Transparent
		Me.lblPartZ.Enabled = True
		Me.lblPartZ.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblPartZ.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblPartZ.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblPartZ.UseMnemonic = True
		Me.lblPartZ.Visible = True
		Me.lblPartZ.AutoSize = False
		Me.lblPartZ.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblPartZ.Name = "lblPartZ"
		Me.lblPartM.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblPartM.Text = "Mass # ="
		Me.lblPartM.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblPartM.Size = New System.Drawing.Size(65, 17)
		Me.lblPartM.Location = New System.Drawing.Point(88, 168)
		Me.lblPartM.TabIndex = 16
		Me.lblPartM.BackColor = System.Drawing.Color.Transparent
		Me.lblPartM.Enabled = True
		Me.lblPartM.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblPartM.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblPartM.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblPartM.UseMnemonic = True
		Me.lblPartM.Visible = True
		Me.lblPartM.AutoSize = False
		Me.lblPartM.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblPartM.Name = "lblPartM"
		Me.lblPartPrm.Text = "Particle Parameters:"
		Me.lblPartPrm.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblPartPrm.ForeColor = System.Drawing.Color.Blue
		Me.lblPartPrm.Size = New System.Drawing.Size(153, 17)
		Me.lblPartPrm.Location = New System.Drawing.Point(40, 144)
		Me.lblPartPrm.TabIndex = 15
		Me.lblPartPrm.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblPartPrm.BackColor = System.Drawing.Color.Transparent
		Me.lblPartPrm.Enabled = True
		Me.lblPartPrm.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblPartPrm.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblPartPrm.UseMnemonic = True
		Me.lblPartPrm.Visible = True
		Me.lblPartPrm.AutoSize = False
		Me.lblPartPrm.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblPartPrm.Name = "lblPartPrm"
		Me.lblAvgR.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblAvgR.Text = "Average Radius ="
		Me.lblAvgR.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblAvgR.Size = New System.Drawing.Size(113, 17)
		Me.lblAvgR.Location = New System.Drawing.Point(312, 232)
		Me.lblAvgR.TabIndex = 14
		Me.lblAvgR.BackColor = System.Drawing.Color.Transparent
		Me.lblAvgR.Enabled = True
		Me.lblAvgR.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblAvgR.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblAvgR.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblAvgR.UseMnemonic = True
		Me.lblAvgR.Visible = True
		Me.lblAvgR.AutoSize = False
		Me.lblAvgR.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblAvgR.Name = "lblAvgR"
		Me.lblR90.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblR90.Text = "Radius at 90 degrees ="
		Me.lblR90.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblR90.Size = New System.Drawing.Size(161, 17)
		Me.lblR90.Location = New System.Drawing.Point(72, 232)
		Me.lblR90.TabIndex = 11
		Me.lblR90.BackColor = System.Drawing.Color.Transparent
		Me.lblR90.Enabled = True
		Me.lblR90.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblR90.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblR90.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblR90.UseMnemonic = True
		Me.lblR90.Visible = True
		Me.lblR90.AutoSize = False
		Me.lblR90.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblR90.Name = "lblR90"
		Me.lblOrbPrm.Text = "Orbit Parameters:"
		Me.lblOrbPrm.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblOrbPrm.ForeColor = System.Drawing.Color.Blue
		Me.lblOrbPrm.Size = New System.Drawing.Size(137, 17)
		Me.lblOrbPrm.Location = New System.Drawing.Point(40, 208)
		Me.lblOrbPrm.TabIndex = 9
		Me.lblOrbPrm.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblOrbPrm.BackColor = System.Drawing.Color.Transparent
		Me.lblOrbPrm.Enabled = True
		Me.lblOrbPrm.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblOrbPrm.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblOrbPrm.UseMnemonic = True
		Me.lblOrbPrm.Visible = True
		Me.lblOrbPrm.AutoSize = False
		Me.lblOrbPrm.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblOrbPrm.Name = "lblOrbPrm"
		Me.lblStop.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblStop.Text = "Number of steps ="
		Me.lblStop.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblStop.Size = New System.Drawing.Size(113, 17)
		Me.lblStop.Location = New System.Drawing.Point(312, 104)
		Me.lblStop.TabIndex = 8
		Me.lblStop.BackColor = System.Drawing.Color.Transparent
		Me.lblStop.Enabled = True
		Me.lblStop.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblStop.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblStop.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblStop.UseMnemonic = True
		Me.lblStop.Visible = True
		Me.lblStop.AutoSize = False
		Me.lblStop.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblStop.Name = "lblStop"
		Me.lblGINC.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblGINC.Text = "Grid step increment ="
		Me.lblGINC.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblGINC.Size = New System.Drawing.Size(137, 17)
		Me.lblGINC.Location = New System.Drawing.Point(96, 104)
		Me.lblGINC.TabIndex = 7
		Me.lblGINC.BackColor = System.Drawing.Color.Transparent
		Me.lblGINC.Enabled = True
		Me.lblGINC.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblGINC.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblGINC.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblGINC.UseMnemonic = True
		Me.lblGINC.Visible = True
		Me.lblGINC.AutoSize = False
		Me.lblGINC.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblGINC.Name = "lblGINC"
		Me.lblRunPrm.BackColor = System.Drawing.Color.Transparent
		Me.lblRunPrm.Text = "Run Parameters:"
		Me.lblRunPrm.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblRunPrm.ForeColor = System.Drawing.Color.Blue
		Me.lblRunPrm.Size = New System.Drawing.Size(121, 17)
		Me.lblRunPrm.Location = New System.Drawing.Point(40, 80)
		Me.lblRunPrm.TabIndex = 5
		Me.lblRunPrm.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblRunPrm.Enabled = True
		Me.lblRunPrm.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblRunPrm.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblRunPrm.UseMnemonic = True
		Me.lblRunPrm.Visible = True
		Me.lblRunPrm.AutoSize = False
		Me.lblRunPrm.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblRunPrm.Name = "lblRunPrm"
		Me.lblHeader.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblHeader.BackColor = System.Drawing.Color.FromARGB(255, 255, 128)
		Me.lblHeader.Text = "JTrace - Orbit Tracker"
		Me.lblHeader.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblHeader.ForeColor = System.Drawing.Color.Blue
		Me.lblHeader.Size = New System.Drawing.Size(321, 33)
		Me.lblHeader.Location = New System.Drawing.Point(112, 16)
		Me.lblHeader.TabIndex = 0
		Me.lblHeader.Enabled = True
		Me.lblHeader.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblHeader.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblHeader.UseMnemonic = True
		Me.lblHeader.Visible = True
		Me.lblHeader.AutoSize = False
		Me.lblHeader.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblHeader.Name = "lblHeader"
		Me.Controls.Add(txtVers)
		Me.Controls.Add(txtVM2)
		Me.Controls.Add(txtVM1)
		Me.Controls.Add(txtLC2)
		Me.Controls.Add(txtLC1)
		Me.Controls.Add(txtStrip)
		Me.Controls.Add(txtCX)
		Me.Controls.Add(txtPartE)
		Me.Controls.Add(txtPartZ)
		Me.Controls.Add(txtPartM)
		Me.Controls.Add(txtAvgR)
		Me.Controls.Add(txtR90)
		Me.Controls.Add(cmdExit)
		Me.Controls.Add(txtStop)
		Me.Controls.Add(txtGINC)
		Me.Controls.Add(cmdRun)
		Me.Controls.Add(lblVM2)
		Me.Controls.Add(lblVM1)
		Me.Controls.Add(lblLC2)
		Me.Controls.Add(lblLC1)
		Me.Controls.Add(lblExtPrm)
		Me.Controls.Add(lblStrip)
		Me.Controls.Add(lblCX)
		Me.Controls.Add(lblPartE)
		Me.Controls.Add(lblPartZ)
		Me.Controls.Add(lblPartM)
		Me.Controls.Add(lblPartPrm)
		Me.Controls.Add(lblAvgR)
		Me.Controls.Add(lblR90)
		Me.Controls.Add(lblOrbPrm)
		Me.Controls.Add(lblStop)
		Me.Controls.Add(lblGINC)
		Me.Controls.Add(lblRunPrm)
		Me.Controls.Add(lblHeader)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class