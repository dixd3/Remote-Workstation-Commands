# Editable Variables - Titles
$RWCtitle = "Remote Workstation Commands"
$RWCversion = "Version 1.0"
$Title = $RWCtitle + "`n" + $RWCversion + "`n"
# Editable Variables - Paths
$root = "C:\RWC"
$BacktoMenu = "$root\RWC.lnk"
$temp = "C:\Windows\Temp"
# Editable Variables - Additional Files/Paths
$Delprof2 = "$root\Delprof2.exe" #Optional Addon
# Editable Variables - Date/Time
$Date = get-date -f dd-MM-yyyy
$Time = get-date -f HH.mm.ss


function Show-Menu
{
$host.UI.RawUI.WindowTitle = "$RWCTitle"

    Clear-Host
	Write-Host $Title
	
	Write-Host "================================================================="
    Write-Host "                        User/AD Management"
    Write-Host "================================================================="
	Write-Host "1:  Unlock AD User Account"
	Write-Host "2:  Check Currently Locked Out Users"
	Write-Host "3:  Delete Computer Account from AD"
	Write-Host "================================================================="
    Write-Host "                	Device Management"
    Write-Host "================================================================="
	Write-Host "4:  Lock a Screen"
	Write-Host "5:  Logoff a Device"
	Write-Host "6:  Reboot a device"
	Write-Host "7:  Shutdown a device"
	Write-Host "8:  Rename a device"
	Write-Host "9:  Access System Info"
	Write-Host "10: Windows Update"
	Write-Host "11: Force GPUpdate"
	Write-Host "12: Create a GP Report"
	Write-Host "13: System File Checker"
	Write-Host "14: DelProf2 - All Profiles"
	Write-Host "15: DelProf2 - Specific Profile"
	Write-Host "16: Check Disk Space"
	Write-Host "17: Disk Cleanup"
	Write-Host "18: Display all Running Services"
	Write-Host "19: Kill a Running Service"
	Write-Host "20: All Remotely Uninstallable Programs"
	Write-Host "21: Uninstall a Program"
	Write-Host "================================================================="
    Write-Host "                	Additional Options"
    Write-Host "================================================================="
	Write-Host "0:  Close RWC Session"
	Write-Host "00: Restart RWC Session"
	Write-Host "================================================================="
}

do
 {
     Show-Menu
	 "`n"
	 $selection = Read-Host "Please type the associated number"
	 "`n"

	 cls
	 
     switch ($selection)
     {

		 '1' {
			Write-Host $Title
			$CMDtitle = "Unlock AD User Account"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
		    Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$ADaccount = Read-Host -Prompt 'Input the AD Username'
		 if ($ADAccount -eq 'q') {start-process $BacktoMenu; exit}
			else {
			       "`n"
				   Unlock-ADAccount -Identity $ADaccount
				   "`n"
				   pause
				 }
         }
		 
		 
		 '2' {
			Write-Host $Title
			$CMDtitle = "Check Currently Locked Out Users"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			"`n"
			#
			$session = Search-ADAccount -LockedOut -UsersOnly 
			Write-Output $session | Format-Table SamAccountName
			"`n"
			pause
				}
		 
		 
		 '3' {
			Write-Host $Title
			$CMDtitle = "Delete Computer Account from AD"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
					 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
			else {
					"`n"
					Get-ADComputer -Identity $Hostname | Remove-ADObject -Recursive
					"`n"
					pause
				}
         }
		 
		 
		 '4' {
			Write-Host $Title
			$CMDtitle = "Lock a Screen"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
					 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
			else {
					"`n"
					QUser /server:$Hostname
					"`n"
			}
			$SessionID = Read-Host -Prompt 'Input the Session ID'
					 if ($SessionID -eq 'q') {start-process $BacktoMenu; exit}
			else {
					"`n"
					tsdiscon $SessionID /SERVER:$Hostname /v
					"`n"
					pause
				}
         }
		 
		 
         '5' {
			Write-Host $Title
			$CMDtitle = "Logoff a Device"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
					 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
			else {
					"`n"
					QUser /server:$Hostname
					"`n"
			}
										 
			$SessionID = Read-Host -Prompt 'Input the Session ID'
					 if ($SessionID -eq 'q') {start-process $BacktoMenu; exit}
			else {
					Logoff $SessionID /server:$Hostname
					"`n"
					pause
			}
         } 
		 

		 '6' {
			Write-Host $Title
			$CMDtitle = "Reboot a device"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
					 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
			else {
					Restart-Computer -force -ComputerName $Hostname
					"`n"
					pause
				}
         }
		 
		 
		 '7' {
			Write-Host $Title
			$CMDtitle = "Shutdown a device"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
					 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
			else {
					Stop-Computer -force -ComputerName $Hostname
					"`n"
					pause
				}
         }
		 
		 
		 '8' {
			Write-Host $Title
			$CMDtitle = "Rename a device"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
					$CurrentComputerName = Read-Host -Prompt 'Type the current computer hostname'
					if ($CurrentComputerName -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					}
					$NewComputerName = Read-Host -Prompt 'Type the new computer name'
					if ($NewComputerName -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					}
					$Domain = Read-Host -Prompt 'Type your administrator account domain prefix'
					if ($Domain -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					}
					$AdminCredentials = Read-Host -Prompt 'Type your administrator account username'
					if ($AdminCredentials -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					$FullAdminCredentials = $Domain + "\" + $AdminCredentials
					Rename-Computer -ComputerName $CurrentComputerName -NewName $NewComputerName -DomainCredential $FullAdminCredentials -Force
					Restart-Computer -ComputerName $CurrentComputerName -Force
					"`n"
					pause
					}
				}


		 '9' {
			Write-Host $Title
			$CMDtitle = "Access System Info"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
					"`n"
					systeminfo.exe /S $Hostname > $temp\SystemInfo_$($Hostname)_$($Date)_$($Time).txt | Out-Null
					start-process C:\Windows\notepad.exe $temp\SystemInfo_$($Hostname)_$($Date)_$($Time).txt -WindowStyle maximized -Verb RunAS
					Write-Host "Deleting Temp File in 10 Seconds"
					"`n"
					TIMEOUT /T 10 /NOBREAK
					del $temp\SystemInfo_$($Hostname)_$($Date)_$($Time).txt | Out-Null
				}
			}
		 
		 
		 '10' {
			Write-Host $Title
			$CMDtitle = "Windows Update"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
			if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
					"`n"        
					Invoke-Command -computername $Hostname {cmd.exe /c start UsoClient.exe RefreshSettings StartScan StartDownload StartInstall ScanInstallWait StartInteractiveScan}
					"`n"
					pause
				}
         }
		 
		 
		 '11' {
			Write-Host $Title
			$CMDtitle = "Force GPUpdate"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
					"`n"
					Invoke-Command -computername $Hostname {Remove-Item -Force -Recurse "C:\Windows\System32\GroupPolicy"}
					Invoke-Command -computername $Hostname {gpupdate /force}
					pause
				}
         }
		 
		 
		 '12' {
			Write-Host $Title
			$CMDtitle = "Create a GP Report"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
				"`n"
				Get-ChildItem -Path "\\$Hostname\c$\Users" -Name -Exclude *desktop.ini*, *defaultuser0*, *Default*, *Public* -Force
				"`n"
				}
				$User = Read-Host -Prompt 'Input the Username'
				if ($User -eq 'q') {start-process $BacktoMenu; exit}
				else {
				"`n"
				gpresult /f /H $temp\GPReport_$($Hostname)_$($User)_$($Date)_$($Time).html /S $Hostname /USER $User
				start-process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" $temp\GPReport_$($Hostname)_$($User)_$($Date)_$($Time).html -WindowStyle maximized -Verb RunAS
				Write-Host "Deleting Temp File in 10 Seconds"
				"`n"
				TIMEOUT /T 10 /NOBREAK
				del $temp\GPReport_$($Hostname)_$($User)_$($Date)_$($Time).html
				}
         }
		 
		 
		 '13' {
			Write-Host $Title
			$CMDtitle = "System File Checker"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
					Invoke-Command -computername $Hostname {sfc /scannow}
					"`n"
					pause
				}
         }
		 
		 
		 '14' {
			Write-Host $Title
			$CMDtitle = "DelProf2 - All Profiles"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
					"`n"
					cmd.exe /c sc \\$Hostname config RemoteRegistry start=auto | Out-Null
					cmd.exe /c SC \\$Hostname START RemoteRegistry | Out-Null
					cmd.exe /c $Delprof2 /c:$Hostname
					cmd.exe /c SC \\$Hostname STOP RemoteRegistry | Out-Null
					cmd.exe /c sc \\$Hostname config RemoteRegistry start=disabled | Out-Null
					"`n"
					pause
				}
         }
		 

		 '15' {
			Write-Host $Title
			$CMDtitle = "DelProf2 - Specific Profile"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
					"`n"
					Get-ChildItem -Path "\\$Hostname\c$\Users" -Name -Exclude *desktop.ini*, *defaultuser0*, *Default*, *Public* -Force
					"`n"
				}
				if ($UserName -eq 'q') {start-process $BacktoMenu; exit}
				else {
					$UserName = Read-Host -Prompt 'Input the Username'
					"`n"
					cmd.exe /c sc \\$Hostname config RemoteRegistry start=auto | Out-Null
					cmd.exe /c SC \\$Hostname START RemoteRegistry | Out-Null
					cmd.exe /c $Delprof2 /c:$Hostname /id:$UserName
					cmd.exe /c SC \\$Hostname STOP RemoteRegistry | Out-Null
					cmd.exe /c sc \\$Hostname config RemoteRegistry start=disabled | Out-Null
					"`n"
					pause
				}
         }
		 
		 
		 '16' {
			Write-Host $Title
			$CMDtitle = "Check Disk Space"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
				if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
				else {
				"`n"
				$session = Invoke-Command -ComputerName $Hostname {Get-CimInstance -ClassName Win32_LogicalDisk}        
				Write-Output $session | Format-Table DeviceId, @{'Name' = 'Total Size (GB)'; Expression= { [int]($_.Size / 1GB) }},@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB)}}
				"`n"
				pause
					}
         }
		 

		 '17' {
			Write-Host $Title
			$CMDtitle = "Disk Cleanup"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
		 		 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					Write-Host "Current Drive Storage Capacity"
					$session = Invoke-Command -ComputerName $Hostname {Get-CimInstance -ClassName Win32_LogicalDisk}        
					Write-Output $session | Format-Table DeviceId, @{'Name' = 'Total Size (GB)'; Expression= { [int]($_.Size / 1GB) }},@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB)}}
					Invoke-Command -computername $Hostname {Get-ChildItem "C:\Users\*\AppData\Local\Temp" -Directory | Remove-Item -Recurse -ErrorAction SilentlyContinue -ErrorVariable removeErrors -Force;$removeErrors | where-object { $_.Exception.Message -notlike '*it is being used by another process*' }} | Out-Null
					Invoke-Command -computername $Hostname {Get-ChildItem "C:\Users\*\Downloads" -Directory | Remove-Item -Recurse -ErrorAction SilentlyContinue -ErrorVariable removeErrors -Force;$removeErrors | where-object { $_.Exception.Message -notlike '*it is being used by another process*' }} | Out-Null
					Invoke-Command -computername $Hostname {Get-ChildItem "C:\Windows\Temp" -Directory | Remove-Item -Recurse -ErrorAction SilentlyContinue -ErrorVariable removeErrors -Force;$removeErrors | where-object { $_.Exception.Message -notlike '*it is being used by another process*' }} | Out-Null
					cmd.exe /c sc \\$Hostname config RemoteRegistry start=auto | Out-Null
					cmd.exe /c SC \\$Hostname START RemoteRegistry | Out-Null
					cmd.exe /c $Delprof2 /c:$Hostname
					cmd.exe /c SC \\$Hostname STOP RemoteRegistry | Out-Null
					cmd.exe /c sc \\$Hostname config RemoteRegistry start=disabled | Out-Null
					"`n"
					Write-Host "New Drive Storage Capacity"
					$session = Invoke-Command -ComputerName $Hostname {Get-CimInstance -ClassName Win32_LogicalDisk}        
					Write-Output $session | Format-Table DeviceId, @{'Name' = 'Total Size (GB)'; Expression= { [int]($_.Size / 1GB) }},@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB)}}
					"`n"
					pause
				}
         }
		 
		 
		 '18' {
			Write-Host $Title
			$CMDtitle = "Display all Running Services"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
		 		 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
					else {
					tasklist /s $Hostname
					"`n"
					pause
				}
         }
		 
		 
		 '19' {
			Write-Host $Title
			$CMDtitle = "Kill a Running Service"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
		 		 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					Write-Host "Displaying all running Services"
					tasklist /s $Hostname
					"`n"
				}
				if ($Service -eq 'q') {start-process $BacktoMenu; exit}
					else {
					$Service = Read-Host -Prompt 'Input the Service Name'
					"`n"
					taskkill /s $Hostname /im $Service
					"`n"
					pause
				}
         }
		 
		 
		 '20' {
			Write-Host $Title
			$CMDtitle = "All Remotely Uninstallable Programs"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
		 		 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					Get-WmiObject Win32_Product -ComputerName $Hostname | Format-List -Property Name, Version
					"`n"
					pause
					}
         }
		 
		 
		 '21' {
			Write-Host $Title
			$CMDtitle = "Uninstall a Program"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			Write-Host "Enter 'q' to Return to RWC Menu"
			"`n"
			#
			$Hostname = Read-Host -Prompt 'Input the Hostname'
		 		 if ($Hostname -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
				}
					$Software = Read-Host -Prompt 'Input the Software name'
				if ($Software -eq 'q') {start-process $BacktoMenu; exit}
					else {
					"`n"
					cmd.exe /c wmic /node:$Hostname product where "name like '%%$Software%%'" call uninstall /nointeractive
					"`n"
					pause
				}
         }
		 
		 
		 '0' {
			Write-Host $Title
			$CMDtitle = "Close RWC Session"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			"`n"
			Write-Host "Closing Current Session..."
			TIMEOUT /T 1 /NOBREAK | Out-Null
			exit
         }
		 
		 
		 '00' {
			Write-Host $Title
			$CMDtitle = "New RWC Session"
			$host.UI.RawUI.WindowTitle = "$RWCtitle - $CMDtitle"
			Write-Host "Command Selected: $CMDtitle"
			"`n"
			Write-Host "Creating New Session..."
			TIMEOUT /T 1 /NOBREAK | Out-Null
			start-process $BacktoMenu
			exit
         }
		 
     }
	 
 }
 until ($selection -eq '')
