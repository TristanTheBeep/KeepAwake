Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === Setup ===
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$iconPath = Join-Path $scriptDir "Icon.ico"
$currentInterval = 300000  # Default: 5 min

# === F15 Timer ===
$timer = New-Object Windows.Forms.Timer
$timer.Interval = $currentInterval
$timer.Add_Tick({ [System.Windows.Forms.SendKeys]::SendWait("{F15}") })
$timer.Start()

function Set-TimerInterval ($ms) {
    $global:currentInterval = $ms
    $timer.Stop()
    $timer.Interval = $ms
    if ($pauseMenuItem.Text -eq "Pause") {
        $timer.Start()
    }
}

# === Dark Mode Colors ===
$bgColor   = [System.Drawing.Color]::FromArgb(35, 61, 77)    # #233D4D
$btnColor  = [System.Drawing.Color]::FromArgb(254, 127, 45)  # #FE7F2D
$textColor = [System.Drawing.Color]::White

# === Settings Window ===
$form = New-Object Windows.Forms.Form
$form.Text = "KeepAwake"
$form.Size = New-Object Drawing.Size(250,130)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.BackColor = $bgColor
$form.ForeColor = $textColor

# === Pause/Resume Button ===
$toggleButton = New-Object Windows.Forms.Button
$toggleButton.Text = "Pause"
$toggleButton.Width = 60
$toggleButton.Height = 30
$toggleButton.Top = 20
$toggleButton.Left = 20
$toggleButton.Add_Click({
    if ($timer.Enabled) {
        $timer.Stop()
        $toggleButton.Text = "Resume"
        $pauseMenuItem.Text = "Resume"
    } else {
        $timer.Start()
        $toggleButton.Text = "Pause"
        $pauseMenuItem.Text = "Pause"
    }
})
$toggleButton.BackColor = $btnColor
$toggleButton.ForeColor = $textColor
$toggleButton.FlatStyle = 'Flat'
$toggleButton.FlatAppearance.BorderSize = 0
$form.Controls.Add($toggleButton)

# === Exit Button ===
$exitButton = New-Object Windows.Forms.Button
$exitButton.Text = "Exit"
$exitButton.Width = 60
$exitButton.Height = 30
$exitButton.Top = 20
$exitButton.Left = 140
$exitButton.Add_Click({ 
    $form.Close()
})
$exitButton.BackColor = $btnColor
$exitButton.ForeColor = $textColor
$exitButton.FlatStyle = 'Flat'
$exitButton.FlatAppearance.BorderSize = 0
$form.Controls.Add($exitButton)

# === Interval Label ===
$label = New-Object Windows.Forms.Label
$label.Text = "Interval:"
$label.Top = 70
$label.Left = 25
$label.Width = 50
$label.ForeColor = $textColor
$form.Controls.Add($label)

# === Interval ComboBox ===
$comboBox = New-Object Windows.Forms.ComboBox
$comboBox.Items.AddRange(@("1 Minute", "5 Minutes", "10 Minutes"))
$comboBox.SelectedIndex = 1  # Default to 5 Minutes
$comboBox.Top = 65
$comboBox.Left = 85
$comboBox.Width = 100
$comboBox.DropDownStyle = 'DropDownList'
$comboBox.BackColor = $bgColor
$comboBox.ForeColor = $textColor
$comboBox.Add_SelectedIndexChanged({
    switch ($comboBox.SelectedItem) {
        "1 Minute"    { Set-TimerInterval 60000 }
        "5 Minutes"   { Set-TimerInterval 300000 }
        "10 Minutes"  { Set-TimerInterval 600000 }
    }
})
$form.Controls.Add($comboBox)


# === Tray Menu ===
$contextMenu = New-Object Windows.Forms.ContextMenuStrip

$pauseMenuItem = New-Object Windows.Forms.ToolStripMenuItem "Pause"
$pauseMenuItem.Add_Click({
    if ($timer.Enabled) {
        $timer.Stop()
        $pauseMenuItem.Text = "Resume"
        $toggleButton.Text = "Resume"
    } else {
        $timer.Start()
        $pauseMenuItem.Text = "Pause"
        $toggleButton.Text = "Pause"
    }
})

$settingsItem = New-Object Windows.Forms.ToolStripMenuItem "Settings"
$settingsItem.Add_Click({ $form.ShowDialog() })

$exitItem = New-Object Windows.Forms.ToolStripMenuItem "Exit"
$exitItem.Add_Click({
    $notifyIcon.Visible = $false
    $notifyIcon.Dispose()
    [System.Windows.Forms.Application]::Exit()
})

$contextMenu.Items.AddRange(@($pauseMenuItem, $settingsItem, $exitItem))

# === Tray Icon ===
$notifyIcon = New-Object Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
$notifyIcon.Text = "KeepAwake"
$notifyIcon.Visible = $true
$notifyIcon.ContextMenuStrip = $contextMenu

# === Run ===
[System.Windows.Forms.Application]::Run()
