<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmC
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
	Public WithEvents txtKB As System.Windows.Forms.TextBox
	Public WithEvents cmdXdat As System.Windows.Forms.Button
	Public WithEvents cmdExit As System.Windows.Forms.Button
	Public WithEvents txtID As System.Windows.Forms.TextBox
	Public WithEvents txtCoax As System.Windows.Forms.TextBox
	Public WithEvents txtT2 As System.Windows.Forms.TextBox
	Public WithEvents txtT1 As System.Windows.Forms.TextBox
	Public WithEvents txtT8 As System.Windows.Forms.TextBox
	Public WithEvents txtT5 As System.Windows.Forms.TextBox
	Public WithEvents txtT7 As System.Windows.Forms.TextBox
	Public WithEvents txtT4 As System.Windows.Forms.TextBox
	Public WithEvents txtT6 As System.Windows.Forms.TextBox
	Public WithEvents txtT3 As System.Windows.Forms.TextBox
	Public WithEvents txtLCout As System.Windows.Forms.TextBox
	Public WithEvents txtLCin As System.Windows.Forms.TextBox
	Public WithEvents txtMain As System.Windows.Forms.TextBox
	Public WithEvents cmdCalc As System.Windows.Forms.Button
	Public WithEvents txtFreq As System.Windows.Forms.TextBox
	Public WithEvents txtE As System.Windows.Forms.TextBox
	Public WithEvents cbxPart As System.Windows.Forms.ComboBox
	Public WithEvents cbxR As System.Windows.Forms.ComboBox
	Public WithEvents cmdSave As System.Windows.Forms.Button
	Public WithEvents lblKBnote As System.Windows.Forms.Label
	Public WithEvents lblKB As System.Windows.Forms.Label
	Public WithEvents lblFnam As System.Windows.Forms.Label
	Public WithEvents lblIDhelp As System.Windows.Forms.Label
	Public WithEvents lblIDprompt As System.Windows.Forms.Label
	Public WithEvents lblCoax As System.Windows.Forms.Label
	Public WithEvents lblT2 As System.Windows.Forms.Label
	Public WithEvents lblT1 As System.Windows.Forms.Label
	Public WithEvents lblT8 As System.Windows.Forms.Label
	Public WithEvents lblT5 As System.Windows.Forms.Label
	Public WithEvents lblT7 As System.Windows.Forms.Label
	Public WithEvents lblT4 As System.Windows.Forms.Label
	Public WithEvents lblT6 As System.Windows.Forms.Label
	Public WithEvents lblT3 As System.Windows.Forms.Label
	Public WithEvents lblLCout As System.Windows.Forms.Label
	Public WithEvents lblLCin As System.Windows.Forms.Label
	Public WithEvents lblMain As System.Windows.Forms.Label
	Public WithEvents lblRFnote As System.Windows.Forms.Label
	Public WithEvents lblFreq As System.Windows.Forms.Label
	Public WithEvents lblR As System.Windows.Forms.Label
	Public WithEvents lblE As System.Windows.Forms.Label
	Public WithEvents lblPart As System.Windows.Forms.Label
	Public WithEvents lblTitle As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.txtKB = New System.Windows.Forms.TextBox
        Me.cmdXdat = New System.Windows.Forms.Button
        Me.cmdExit = New System.Windows.Forms.Button
        Me.txtID = New System.Windows.Forms.TextBox
        Me.txtCoax = New System.Windows.Forms.TextBox
        Me.txtT2 = New System.Windows.Forms.TextBox
        Me.txtT1 = New System.Windows.Forms.TextBox
        Me.txtT8 = New System.Windows.Forms.TextBox
        Me.txtT5 = New System.Windows.Forms.TextBox
        Me.txtT7 = New System.Windows.Forms.TextBox
        Me.txtT4 = New System.Windows.Forms.TextBox
        Me.txtT6 = New System.Windows.Forms.TextBox
        Me.txtT3 = New System.Windows.Forms.TextBox
        Me.txtLCout = New System.Windows.Forms.TextBox
        Me.txtLCin = New System.Windows.Forms.TextBox
        Me.txtMain = New System.Windows.Forms.TextBox
        Me.cmdCalc = New System.Windows.Forms.Button
        Me.txtFreq = New System.Windows.Forms.TextBox
        Me.txtE = New System.Windows.Forms.TextBox
        Me.cbxPart = New System.Windows.Forms.ComboBox
        Me.cbxR = New System.Windows.Forms.ComboBox
        Me.cmdSave = New System.Windows.Forms.Button
        Me.lblKBnote = New System.Windows.Forms.Label
        Me.lblKB = New System.Windows.Forms.Label
        Me.lblFnam = New System.Windows.Forms.Label
        Me.lblIDhelp = New System.Windows.Forms.Label
        Me.lblIDprompt = New System.Windows.Forms.Label
        Me.lblCoax = New System.Windows.Forms.Label
        Me.lblT2 = New System.Windows.Forms.Label
        Me.lblT1 = New System.Windows.Forms.Label
        Me.lblT8 = New System.Windows.Forms.Label
        Me.lblT5 = New System.Windows.Forms.Label
        Me.lblT7 = New System.Windows.Forms.Label
        Me.lblT4 = New System.Windows.Forms.Label
        Me.lblT6 = New System.Windows.Forms.Label
        Me.lblT3 = New System.Windows.Forms.Label
        Me.lblLCout = New System.Windows.Forms.Label
        Me.lblLCin = New System.Windows.Forms.Label
        Me.lblMain = New System.Windows.Forms.Label
        Me.lblRFnote = New System.Windows.Forms.Label
        Me.lblFreq = New System.Windows.Forms.Label
        Me.lblR = New System.Windows.Forms.Label
        Me.lblE = New System.Windows.Forms.Label
        Me.lblPart = New System.Windows.Forms.Label
        Me.lblTitle = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'txtKB
        '
        Me.txtKB.AcceptsReturn = True
        Me.txtKB.BackColor = System.Drawing.Color.White
        Me.txtKB.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtKB.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtKB.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtKB.Location = New System.Drawing.Point(240, 152)
        Me.txtKB.MaxLength = 0
        Me.txtKB.Name = "txtKB"
        Me.txtKB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtKB.Size = New System.Drawing.Size(49, 20)
        Me.txtKB.TabIndex = 43
        Me.txtKB.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'cmdXdat
        '
        Me.cmdXdat.BackColor = System.Drawing.SystemColors.Control
        Me.cmdXdat.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdXdat.Font = New System.Drawing.Font("Arial", 7.8!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdXdat.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdXdat.Location = New System.Drawing.Point(104, 480)
        Me.cmdXdat.Name = "cmdXdat"
        Me.cmdXdat.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdXdat.Size = New System.Drawing.Size(321, 17)
        Me.cmdXdat.TabIndex = 40
        Me.cmdXdat.Text = "Add extraction radius and Coax data to first comment card"
        Me.cmdXdat.UseVisualStyleBackColor = False
        '
        'cmdExit
        '
        Me.cmdExit.BackColor = System.Drawing.SystemColors.Control
        Me.cmdExit.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdExit.Font = New System.Drawing.Font("Arial", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdExit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdExit.Location = New System.Drawing.Point(232, 584)
        Me.cmdExit.Name = "cmdExit"
        Me.cmdExit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdExit.Size = New System.Drawing.Size(65, 25)
        Me.cmdExit.TabIndex = 38
        Me.cmdExit.Text = "Exit"
        Me.cmdExit.UseVisualStyleBackColor = False
        '
        'txtID
        '
        Me.txtID.AcceptsReturn = True
        Me.txtID.BackColor = System.Drawing.SystemColors.Window
        Me.txtID.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtID.Font = New System.Drawing.Font("Courier New", 10.2!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtID.Location = New System.Drawing.Point(120, 392)
        Me.txtID.MaxLength = 0
        Me.txtID.Name = "txtID"
        Me.txtID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtID.Size = New System.Drawing.Size(289, 20)
        Me.txtID.TabIndex = 37
        '
        'txtCoax
        '
        Me.txtCoax.AcceptsReturn = True
        Me.txtCoax.BackColor = System.Drawing.SystemColors.Window
        Me.txtCoax.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCoax.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCoax.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCoax.Location = New System.Drawing.Point(392, 336)
        Me.txtCoax.MaxLength = 0
        Me.txtCoax.Name = "txtCoax"
        Me.txtCoax.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCoax.Size = New System.Drawing.Size(49, 20)
        Me.txtCoax.TabIndex = 34
        '
        'txtT2
        '
        Me.txtT2.AcceptsReturn = True
        Me.txtT2.BackColor = System.Drawing.SystemColors.Window
        Me.txtT2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT2.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT2.Location = New System.Drawing.Point(392, 240)
        Me.txtT2.MaxLength = 0
        Me.txtT2.Name = "txtT2"
        Me.txtT2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT2.Size = New System.Drawing.Size(49, 20)
        Me.txtT2.TabIndex = 32
        '
        'txtT1
        '
        Me.txtT1.AcceptsReturn = True
        Me.txtT1.BackColor = System.Drawing.SystemColors.Window
        Me.txtT1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT1.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT1.Location = New System.Drawing.Point(256, 240)
        Me.txtT1.MaxLength = 0
        Me.txtT1.Name = "txtT1"
        Me.txtT1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT1.Size = New System.Drawing.Size(49, 20)
        Me.txtT1.TabIndex = 30
        '
        'txtT8
        '
        Me.txtT8.AcceptsReturn = True
        Me.txtT8.BackColor = System.Drawing.SystemColors.Window
        Me.txtT8.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT8.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT8.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT8.Location = New System.Drawing.Point(392, 304)
        Me.txtT8.MaxLength = 0
        Me.txtT8.Name = "txtT8"
        Me.txtT8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT8.Size = New System.Drawing.Size(49, 20)
        Me.txtT8.TabIndex = 28
        '
        'txtT5
        '
        Me.txtT5.AcceptsReturn = True
        Me.txtT5.BackColor = System.Drawing.SystemColors.Window
        Me.txtT5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT5.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT5.Location = New System.Drawing.Point(392, 272)
        Me.txtT5.MaxLength = 0
        Me.txtT5.Name = "txtT5"
        Me.txtT5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT5.Size = New System.Drawing.Size(49, 20)
        Me.txtT5.TabIndex = 26
        '
        'txtT7
        '
        Me.txtT7.AcceptsReturn = True
        Me.txtT7.BackColor = System.Drawing.SystemColors.Window
        Me.txtT7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT7.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT7.Location = New System.Drawing.Point(256, 304)
        Me.txtT7.MaxLength = 0
        Me.txtT7.Name = "txtT7"
        Me.txtT7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT7.Size = New System.Drawing.Size(49, 20)
        Me.txtT7.TabIndex = 24
        '
        'txtT4
        '
        Me.txtT4.AcceptsReturn = True
        Me.txtT4.BackColor = System.Drawing.SystemColors.Window
        Me.txtT4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT4.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT4.Location = New System.Drawing.Point(256, 272)
        Me.txtT4.MaxLength = 0
        Me.txtT4.Name = "txtT4"
        Me.txtT4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT4.Size = New System.Drawing.Size(49, 20)
        Me.txtT4.TabIndex = 22
        '
        'txtT6
        '
        Me.txtT6.AcceptsReturn = True
        Me.txtT6.BackColor = System.Drawing.SystemColors.Window
        Me.txtT6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT6.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT6.Location = New System.Drawing.Point(104, 304)
        Me.txtT6.MaxLength = 0
        Me.txtT6.Name = "txtT6"
        Me.txtT6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT6.Size = New System.Drawing.Size(49, 20)
        Me.txtT6.TabIndex = 20
        '
        'txtT3
        '
        Me.txtT3.AcceptsReturn = True
        Me.txtT3.BackColor = System.Drawing.SystemColors.Window
        Me.txtT3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtT3.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtT3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtT3.Location = New System.Drawing.Point(104, 272)
        Me.txtT3.MaxLength = 0
        Me.txtT3.Name = "txtT3"
        Me.txtT3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtT3.Size = New System.Drawing.Size(49, 20)
        Me.txtT3.TabIndex = 18
        '
        'txtLCout
        '
        Me.txtLCout.AcceptsReturn = True
        Me.txtLCout.BackColor = System.Drawing.SystemColors.Window
        Me.txtLCout.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtLCout.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtLCout.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtLCout.Location = New System.Drawing.Point(256, 336)
        Me.txtLCout.MaxLength = 0
        Me.txtLCout.Name = "txtLCout"
        Me.txtLCout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtLCout.Size = New System.Drawing.Size(49, 20)
        Me.txtLCout.TabIndex = 17
        '
        'txtLCin
        '
        Me.txtLCin.AcceptsReturn = True
        Me.txtLCin.BackColor = System.Drawing.SystemColors.Window
        Me.txtLCin.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtLCin.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtLCin.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtLCin.Location = New System.Drawing.Point(104, 336)
        Me.txtLCin.MaxLength = 0
        Me.txtLCin.Name = "txtLCin"
        Me.txtLCin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtLCin.Size = New System.Drawing.Size(49, 20)
        Me.txtLCin.TabIndex = 16
        '
        'txtMain
        '
        Me.txtMain.AcceptsReturn = True
        Me.txtMain.BackColor = System.Drawing.SystemColors.Window
        Me.txtMain.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMain.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMain.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMain.Location = New System.Drawing.Point(104, 240)
        Me.txtMain.MaxLength = 0
        Me.txtMain.Name = "txtMain"
        Me.txtMain.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMain.Size = New System.Drawing.Size(49, 20)
        Me.txtMain.TabIndex = 13
        '
        'cmdCalc
        '
        Me.cmdCalc.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCalc.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCalc.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCalc.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCalc.Location = New System.Drawing.Point(136, 200)
        Me.cmdCalc.Name = "cmdCalc"
        Me.cmdCalc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCalc.Size = New System.Drawing.Size(257, 25)
        Me.cmdCalc.TabIndex = 10
        Me.cmdCalc.Text = "Calculate initial magnet coil currents"
        Me.cmdCalc.UseVisualStyleBackColor = False
        '
        'txtFreq
        '
        Me.txtFreq.AcceptsReturn = True
        Me.txtFreq.BackColor = System.Drawing.Color.White
        Me.txtFreq.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFreq.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFreq.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFreq.Location = New System.Drawing.Point(240, 120)
        Me.txtFreq.MaxLength = 0
        Me.txtFreq.Name = "txtFreq"
        Me.txtFreq.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFreq.Size = New System.Drawing.Size(49, 20)
        Me.txtFreq.TabIndex = 4
        Me.txtFreq.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'txtE
        '
        Me.txtE.AcceptsReturn = True
        Me.txtE.BackColor = System.Drawing.SystemColors.Window
        Me.txtE.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtE.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtE.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtE.Location = New System.Drawing.Point(216, 88)
        Me.txtE.MaxLength = 0
        Me.txtE.Name = "txtE"
        Me.txtE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtE.Size = New System.Drawing.Size(41, 20)
        Me.txtE.TabIndex = 2
        Me.txtE.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
        '
        'cbxPart
        '
        Me.cbxPart.BackColor = System.Drawing.SystemColors.Window
        Me.cbxPart.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbxPart.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cbxPart.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbxPart.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cbxPart.Location = New System.Drawing.Point(56, 88)
        Me.cbxPart.Name = "cbxPart"
        Me.cbxPart.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbxPart.Size = New System.Drawing.Size(81, 24)
        Me.cbxPart.TabIndex = 1
        '
        'cbxR
        '
        Me.cbxR.BackColor = System.Drawing.SystemColors.Window
        Me.cbxR.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbxR.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cbxR.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbxR.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cbxR.Location = New System.Drawing.Point(360, 88)
        Me.cbxR.Name = "cbxR"
        Me.cbxR.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbxR.Size = New System.Drawing.Size(57, 24)
        Me.cbxR.TabIndex = 3
        '
        'cmdSave
        '
        Me.cmdSave.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSave.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSave.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSave.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSave.Location = New System.Drawing.Point(144, 520)
        Me.cmdSave.Name = "cmdSave"
        Me.cmdSave.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSave.Size = New System.Drawing.Size(241, 25)
        Me.cmdSave.TabIndex = 0
        Me.cmdSave.Text = "Write this parameter set to file"
        Me.cmdSave.UseVisualStyleBackColor = False
        '
        'lblKBnote
        '
        Me.lblKBnote.BackColor = System.Drawing.Color.Transparent
        Me.lblKBnote.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblKBnote.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblKBnote.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblKBnote.Location = New System.Drawing.Point(296, 152)
        Me.lblKBnote.Name = "lblKBnote"
        Me.lblKBnote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblKBnote.Size = New System.Drawing.Size(161, 17)
        Me.lblKBnote.TabIndex = 44
        Me.lblKBnote.Text = "(keep between 45 and 98)"
        '
        'lblKB
        '
        Me.lblKB.BackColor = System.Drawing.Color.Transparent
        Me.lblKB.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblKB.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblKB.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblKB.Location = New System.Drawing.Point(64, 152)
        Me.lblKB.Name = "lblKB"
        Me.lblKB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblKB.Size = New System.Drawing.Size(177, 17)
        Me.lblKB.TabIndex = 42
        Me.lblKB.Text = "Classical Field Constant K is"
        '
        'lblFnam
        '
        Me.lblFnam.BackColor = System.Drawing.Color.Transparent
        Me.lblFnam.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFnam.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFnam.ForeColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.lblFnam.Location = New System.Drawing.Point(80, 552)
        Me.lblFnam.Name = "lblFnam"
        Me.lblFnam.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFnam.Size = New System.Drawing.Size(369, 17)
        Me.lblFnam.TabIndex = 41
        Me.lblFnam.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'lblIDhelp
        '
        Me.lblIDhelp.BackColor = System.Drawing.Color.Transparent
        Me.lblIDhelp.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblIDhelp.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblIDhelp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblIDhelp.Location = New System.Drawing.Point(112, 416)
        Me.lblIDhelp.Name = "lblIDhelp"
        Me.lblIDhelp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblIDhelp.Size = New System.Drawing.Size(305, 49)
        Me.lblIDhelp.TabIndex = 39
        Me.lblIDhelp.Text = "The suggested format is   ""xxxxxxxx - comment""   Characters before the first blan" & _
            "k will also be used to identify the output file as xxxxxxxx.tcisoc.car"
        Me.lblIDhelp.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'lblIDprompt
        '
        Me.lblIDprompt.BackColor = System.Drawing.Color.Transparent
        Me.lblIDprompt.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblIDprompt.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblIDprompt.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblIDprompt.Location = New System.Drawing.Point(96, 376)
        Me.lblIDprompt.Name = "lblIDprompt"
        Me.lblIDprompt.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblIDprompt.Size = New System.Drawing.Size(337, 17)
        Me.lblIDprompt.TabIndex = 36
        Me.lblIDprompt.Text = "Enter parameter set identification (32 characters max)"
        Me.lblIDprompt.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'lblCoax
        '
        Me.lblCoax.BackColor = System.Drawing.Color.Transparent
        Me.lblCoax.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCoax.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCoax.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblCoax.Location = New System.Drawing.Point(336, 336)
        Me.lblCoax.Name = "lblCoax"
        Me.lblCoax.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCoax.Size = New System.Drawing.Size(49, 17)
        Me.lblCoax.TabIndex = 35
        Me.lblCoax.Text = "Coax ="
        Me.lblCoax.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT2
        '
        Me.lblT2.BackColor = System.Drawing.Color.Transparent
        Me.lblT2.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT2.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT2.Location = New System.Drawing.Point(336, 240)
        Me.lblT2.Name = "lblT2"
        Me.lblT2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT2.Size = New System.Drawing.Size(49, 17)
        Me.lblT2.TabIndex = 33
        Me.lblT2.Text = "T2 ="
        Me.lblT2.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT1
        '
        Me.lblT1.BackColor = System.Drawing.Color.Transparent
        Me.lblT1.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT1.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT1.Location = New System.Drawing.Point(200, 240)
        Me.lblT1.Name = "lblT1"
        Me.lblT1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT1.Size = New System.Drawing.Size(49, 17)
        Me.lblT1.TabIndex = 31
        Me.lblT1.Text = "T1 ="
        Me.lblT1.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT8
        '
        Me.lblT8.BackColor = System.Drawing.Color.Transparent
        Me.lblT8.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT8.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT8.Location = New System.Drawing.Point(336, 304)
        Me.lblT8.Name = "lblT8"
        Me.lblT8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT8.Size = New System.Drawing.Size(49, 17)
        Me.lblT8.TabIndex = 29
        Me.lblT8.Text = "T8 ="
        Me.lblT8.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT5
        '
        Me.lblT5.BackColor = System.Drawing.Color.Transparent
        Me.lblT5.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT5.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT5.Location = New System.Drawing.Point(336, 272)
        Me.lblT5.Name = "lblT5"
        Me.lblT5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT5.Size = New System.Drawing.Size(49, 17)
        Me.lblT5.TabIndex = 27
        Me.lblT5.Text = "T5 ="
        Me.lblT5.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT7
        '
        Me.lblT7.BackColor = System.Drawing.Color.Transparent
        Me.lblT7.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT7.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT7.Location = New System.Drawing.Point(200, 304)
        Me.lblT7.Name = "lblT7"
        Me.lblT7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT7.Size = New System.Drawing.Size(49, 17)
        Me.lblT7.TabIndex = 25
        Me.lblT7.Text = "T7 ="
        Me.lblT7.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT4
        '
        Me.lblT4.BackColor = System.Drawing.Color.Transparent
        Me.lblT4.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT4.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT4.Location = New System.Drawing.Point(200, 272)
        Me.lblT4.Name = "lblT4"
        Me.lblT4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT4.Size = New System.Drawing.Size(49, 17)
        Me.lblT4.TabIndex = 23
        Me.lblT4.Text = "T4 ="
        Me.lblT4.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT6
        '
        Me.lblT6.BackColor = System.Drawing.Color.Transparent
        Me.lblT6.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT6.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT6.Location = New System.Drawing.Point(48, 304)
        Me.lblT6.Name = "lblT6"
        Me.lblT6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT6.Size = New System.Drawing.Size(49, 17)
        Me.lblT6.TabIndex = 21
        Me.lblT6.Text = "T6 ="
        Me.lblT6.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblT3
        '
        Me.lblT3.BackColor = System.Drawing.Color.Transparent
        Me.lblT3.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblT3.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblT3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblT3.Location = New System.Drawing.Point(48, 272)
        Me.lblT3.Name = "lblT3"
        Me.lblT3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblT3.Size = New System.Drawing.Size(49, 17)
        Me.lblT3.TabIndex = 19
        Me.lblT3.Text = "T3 ="
        Me.lblT3.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblLCout
        '
        Me.lblLCout.BackColor = System.Drawing.Color.Transparent
        Me.lblLCout.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblLCout.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblLCout.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblLCout.Location = New System.Drawing.Point(184, 336)
        Me.lblLCout.Name = "lblLCout"
        Me.lblLCout.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblLCout.Size = New System.Drawing.Size(65, 17)
        Me.lblLCout.TabIndex = 15
        Me.lblLCout.Text = "LC-out ="
        Me.lblLCout.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblLCin
        '
        Me.lblLCin.BackColor = System.Drawing.Color.Transparent
        Me.lblLCin.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblLCin.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblLCin.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblLCin.Location = New System.Drawing.Point(48, 336)
        Me.lblLCin.Name = "lblLCin"
        Me.lblLCin.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblLCin.Size = New System.Drawing.Size(49, 17)
        Me.lblLCin.TabIndex = 14
        Me.lblLCin.Text = "LC-in ="
        Me.lblLCin.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblMain
        '
        Me.lblMain.BackColor = System.Drawing.Color.Transparent
        Me.lblMain.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblMain.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblMain.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblMain.Location = New System.Drawing.Point(48, 240)
        Me.lblMain.Name = "lblMain"
        Me.lblMain.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblMain.Size = New System.Drawing.Size(49, 17)
        Me.lblMain.TabIndex = 12
        Me.lblMain.Text = "Main ="
        Me.lblMain.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblRFnote
        '
        Me.lblRFnote.BackColor = System.Drawing.Color.Transparent
        Me.lblRFnote.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRFnote.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRFnote.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRFnote.Location = New System.Drawing.Point(296, 120)
        Me.lblRFnote.Name = "lblRFnote"
        Me.lblRFnote.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRFnote.Size = New System.Drawing.Size(153, 17)
        Me.lblRFnote.TabIndex = 11
        Me.lblRFnote.Text = "(must not exceed 24.0)"
        '
        'lblFreq
        '
        Me.lblFreq.BackColor = System.Drawing.Color.Transparent
        Me.lblFreq.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFreq.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFreq.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFreq.Location = New System.Drawing.Point(48, 120)
        Me.lblFreq.Name = "lblFreq"
        Me.lblFreq.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFreq.Size = New System.Drawing.Size(185, 17)
        Me.lblFreq.TabIndex = 9
        Me.lblFreq.Text = "Coresponding rf frequency is"
        Me.lblFreq.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblR
        '
        Me.lblR.BackColor = System.Drawing.Color.Transparent
        Me.lblR.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblR.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblR.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblR.Location = New System.Drawing.Point(296, 72)
        Me.lblR.Name = "lblR"
        Me.lblR.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblR.Size = New System.Drawing.Size(185, 17)
        Me.lblR.TabIndex = 8
        Me.lblR.Text = "and      Extraction Radius"
        '
        'lblE
        '
        Me.lblE.BackColor = System.Drawing.Color.Transparent
        Me.lblE.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblE.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblE.Location = New System.Drawing.Point(216, 72)
        Me.lblE.Name = "lblE"
        Me.lblE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblE.Size = New System.Drawing.Size(57, 17)
        Me.lblE.TabIndex = 7
        Me.lblE.Text = "Energy"
        '
        'lblPart
        '
        Me.lblPart.BackColor = System.Drawing.Color.Transparent
        Me.lblPart.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPart.Font = New System.Drawing.Font("Arial", 9.6!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPart.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblPart.Location = New System.Drawing.Point(48, 72)
        Me.lblPart.Name = "lblPart"
        Me.lblPart.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPart.Size = New System.Drawing.Size(97, 15)
        Me.lblPart.TabIndex = 6
        Me.lblPart.Text = "Select Particle"
        Me.lblPart.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'lblTitle
        '
        Me.lblTitle.BackColor = System.Drawing.Color.Transparent
        Me.lblTitle.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTitle.Font = New System.Drawing.Font("Arial", 24.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTitle.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblTitle.Location = New System.Drawing.Point(24, 16)
        Me.lblTitle.Name = "lblTitle"
        Me.lblTitle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTitle.Size = New System.Drawing.Size(473, 41)
        Me.lblTitle.TabIndex = 5
        Me.lblTitle.Text = "tcisoc.car Initial File Generator"
        Me.lblTitle.TextAlign = System.Drawing.ContentAlignment.TopCenter
        '
        'frmC
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.ClientSize = New System.Drawing.Size(528, 630)
        Me.Controls.Add(Me.txtKB)
        Me.Controls.Add(Me.cmdXdat)
        Me.Controls.Add(Me.cmdExit)
        Me.Controls.Add(Me.txtID)
        Me.Controls.Add(Me.txtCoax)
        Me.Controls.Add(Me.txtT2)
        Me.Controls.Add(Me.txtT1)
        Me.Controls.Add(Me.txtT8)
        Me.Controls.Add(Me.txtT5)
        Me.Controls.Add(Me.txtT7)
        Me.Controls.Add(Me.txtT4)
        Me.Controls.Add(Me.txtT6)
        Me.Controls.Add(Me.txtT3)
        Me.Controls.Add(Me.txtLCout)
        Me.Controls.Add(Me.txtLCin)
        Me.Controls.Add(Me.txtMain)
        Me.Controls.Add(Me.cmdCalc)
        Me.Controls.Add(Me.txtFreq)
        Me.Controls.Add(Me.txtE)
        Me.Controls.Add(Me.cbxPart)
        Me.Controls.Add(Me.cbxR)
        Me.Controls.Add(Me.cmdSave)
        Me.Controls.Add(Me.lblKBnote)
        Me.Controls.Add(Me.lblKB)
        Me.Controls.Add(Me.lblFnam)
        Me.Controls.Add(Me.lblIDhelp)
        Me.Controls.Add(Me.lblIDprompt)
        Me.Controls.Add(Me.lblCoax)
        Me.Controls.Add(Me.lblT2)
        Me.Controls.Add(Me.lblT1)
        Me.Controls.Add(Me.lblT8)
        Me.Controls.Add(Me.lblT5)
        Me.Controls.Add(Me.lblT7)
        Me.Controls.Add(Me.lblT4)
        Me.Controls.Add(Me.lblT6)
        Me.Controls.Add(Me.lblT3)
        Me.Controls.Add(Me.lblLCout)
        Me.Controls.Add(Me.lblLCin)
        Me.Controls.Add(Me.lblMain)
        Me.Controls.Add(Me.lblRFnote)
        Me.Controls.Add(Me.lblFreq)
        Me.Controls.Add(Me.lblR)
        Me.Controls.Add(Me.lblE)
        Me.Controls.Add(Me.lblPart)
        Me.Controls.Add(Me.lblTitle)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "frmC"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "JBCSTART 062407"
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class