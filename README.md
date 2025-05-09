# AutoBackup
🖥️ Easy Backup Tool – User Guide
Version: 1.0
Created by: Marc Kolb
Platform: Windows 10/11
Executable: BackupTool.exe

📌 What This Program Does
The Easy Backup Tool is a simple utility that safely backs up your important personal files — including your Documents, Desktop, Pictures, and Downloads folders — to an external USB drive or hard drive.

It is designed for ease of use with:

A clear graphical interface (GUI)

A drive selector to choose your external backup location

An optional “mirroring” mode to keep your backup exactly in sync with your computer

✅ Features Summary
Feature	Description
Drive Picker	Lets you select a USB or external hard drive for backup
One-Click Start	Backup begins with a single click
Progress Bar	Shows estimated progress during the backup
Status Messages	Tells you what the tool is doing in real time
Optional Mirroring	Deletes files from the backup if they’ve been removed from your computer
No Console Required	Runs as a standalone application — no scary black windows
Safe and Silent	Uses robust Windows tools to ensure smooth file copying

🗂️ What It Backs Up
The program copies files from the following folders in your user account:

Documents

Desktop

Pictures

Downloads

These folders are commonly where personal files are stored.

🔌 What You Need Before Running It
A Windows PC (Windows 10 or 11 recommended)

An external USB flash drive or external hard drive

The backup drive should have enough free space to store your files

The file: BackupTool.exe on your desktop or in an easy-to-find location

🚀 How to Use the Program
1. Plug In Your Backup Drive
Insert your USB drive or external hard drive into the computer. Wait a few seconds for it to appear.

2. Double-Click BackupTool.exe
You’ll see a window appear titled “Simple Backup Tool.”

3. Select Your Drive
Use the dropdown menu at the top to pick your USB/external drive (e.g., E:, F:, etc.).

🛈 Only non-system drives will appear (you cannot back up to your main hard drive).

4. (Optional) Enable Mirroring
Check the “Enable mirroring” box if you want the backup to remove files that no longer exist on your PC. This keeps the backup in sync, but use with caution — it will delete files on the backup that were deleted on the computer.

5. Click Start Backup
The tool will begin copying your files. You’ll see:

Status messages (e.g., “Backing up Documents…”)

A progress bar updating as each folder finishes

6. Wait for Completion
When it finishes, the status will show:

arduino
Copy
✅ Backup complete! You may now close this window.
You can now close the window and safely eject your drive.

📁 Where Are the Files Stored?
All files are saved on your backup drive in:

php-template
Copy
<Drive Letter>\Backups\
For example, if your USB is E:\, your files go to:

makefile
Copy
E:\Backups\Documents
E:\Backups\Desktop
E:\Backups\Pictures
E:\Backups\Downloads
🧽 What It Does Not Do
It does not compress or zip the files.

It does not encrypt the files.

It does not back up other system folders or programs.

It does not back up Microsoft OneDrive cloud files unless downloaded locally.

🛠️ Troubleshooting
Issue	Solution
My drive doesn’t show up	Ensure it is plugged in and recognized by Windows (check File Explorer)
Nothing happens when I click	Try right-click → “Run as Administrator” (just once)
Files don’t seem to be copied	Ensure they are stored locally and not only in the cloud
Backup takes a long time	Large folders (Downloads, Pictures) may have big files; wait patiently

🧼 Safety & Maintenance Tips
Run this backup once a week or before major updates.

Leave the “mirroring” option unchecked unless you understand how syncing works.

Safely eject the drive after you're finished.

🔒 For Advanced Users
Under the hood, the tool uses Windows’ robocopy command with these flags:

pgsql
Copy
/E  - copy subfolders, including empty ones  
/XO - skip older files already backed up  
/Z  - enable restartable mode (helps on USB drives)  
/PURGE - (optional) remove files in backup not in source
No external software is required.
