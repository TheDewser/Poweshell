<#
Simple script that querries a remote computer for specific processes and writes them to
a CSV file.  Since the task will run multiple times a day, it should append to a daily log.
Will add features later for parameters



#>
$LogTime = Get-Date -Format "MM-dd-yyyy"
$LogFile = 'C:\Logs\'+"ProcessCheck_"+$LogTime+".csv"
$TimeStamp = (Get-Date).ToString('G')

$Processes = Get-Content C:\Code\Processes.txt
Get-Process -ComputerName MYCOMPUTER -Name $Processes | Select-Object Name,@{Name='Mem (KB)';Expression={($_.WorkingSet/1KB)}} |
Export-Csv -NoTypeInformation -Append $LogFile
