Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Function to get usable drives (removable or fixed, excluding system)
function Get-BackupDrives {
    Get-WmiObject Win32_LogicalDisk |
    Where-Object { $_.DriveType -in 2, 3 -and $_.DeviceID -ne "$env:SystemDrive" } |
    Select-Object -ExpandProperty DeviceID
}

# Create Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Simple Backup Tool"
$form.Size = New-Object System.Drawing.Size(450,300)
$form.StartPosition = "CenterScreen"
$form.Topmost = $true

# Label: Drive selection
$driveLabel = New-Object System.Windows.Forms.Label
$driveLabel.Text = "1. Select your backup drive (usually your USB or external hard drive):"
$driveLabel.Location = New-Object System.Drawing.Point(20, 20)
$driveLabel.Size = New-Object System.Drawing.Size(400,20)
$form.Controls.Add($driveLabel)

# ComboBox: Drive selector
$driveBox = New-Object System.Windows.Forms.ComboBox
$driveBox.Location = New-Object System.Drawing.Point(20, 45)
$driveBox.Size = New-Object System.Drawing.Size(100,20)
$driveBox.DropDownStyle = 'DropDownList'

$drives = Get-BackupDrives
$driveBox.Items.AddRange($drives)

$form.Controls.Add($driveBox)

# Checkbox: Mirroring option
$mirrorCheck = New-Object System.Windows.Forms.CheckBox
$mirrorCheck.Text = "Enable mirroring (delete files from backup that no longer exist in originals)"
$mirrorCheck.Location = New-Object System.Drawing.Point(20, 75)
$mirrorCheck.Size = New-Object System.Drawing.Size(400,20)
$form.Controls.Add($mirrorCheck)

# Explanation for mirroring
$mirrorExplain = New-Object System.Windows.Forms.Label
$mirrorExplain.Text = "Use this with caution. It keeps the backup identical to your PC folders."
$mirrorExplain.Location = New-Object System.Drawing.Point(40, 95)
$mirrorExplain.Size = New-Object System.Drawing.Size(400,20)
$mirrorExplain.Font = "Microsoft Sans Serif, 8pt, style=Italic"
$form.Controls.Add($mirrorExplain)

# Status Label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Click 'Start Backup' when ready."
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(20, 125)
$form.Controls.Add($statusLabel)

# Progress Bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(20,155)
$progressBar.Size = New-Object System.Drawing.Size(400,25)
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$form.Controls.Add($progressBar)

# Backup Button
$backupButton = New-Object System.Windows.Forms.Button
$backupButton.Text = "Start Backup"
$backupButton.Location = New-Object System.Drawing.Point(20, 195)
$form.Controls.Add($backupButton)

# Backup logic
$backupButton.Add_Click({
    if (-not $driveBox.SelectedItem) {
        [System.Windows.Forms.MessageBox]::Show("Please select a backup drive.","Drive Required",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }

    $destRoot = $driveBox.SelectedItem + "\Backups"
    $folders = @("Documents", "Desktop", "Pictures", "Downloads")
    $userPath = [Environment]::GetFolderPath("UserProfile")
    $progressPerItem = [math]::Floor(100 / $folders.Count)
    $progress = 0

    foreach ($folder in $folders) {
        $source = Join-Path $userPath $folder
        $target = Join-Path $destRoot $folder
        if (!(Test-Path $target)) { New-Item -ItemType Directory -Path $target -Force | Out-Null }

        $statusLabel.Text = "Backing up $folder..."
        $form.Refresh()

        $args = "`"$source`" `"$target`" /E /XO /Z /R:2 /W:5"
        if ($mirrorCheck.Checked) {
            $args += " /PURGE"
        }

        Start-Process robocopy -ArgumentList $args -NoNewWindow -Wait

        $progress += $progressPerItem
        $progressBar.Value = [math]::Min($progress, 100)
    }

    $statusLabel.Text = "✅ Backup complete! You may now close this window."
})

# Run the form
[void]$form.ShowDialog()
