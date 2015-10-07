<#
You need to enable file access auditing on your file server for this script to pull
proper data.  The select and -MaxEvents can be adjusted to fit your preferences.
#>

Param (
    [string]$computer,
    [string]$username,
    [string]$FilePath
)


# commented out to switch to parameter enabled script
#$username = "user"
#$computer = "fileserver"
$Date = Get-Date
Get-WinEvent -ComputerName $computer -LogName Security -MaxEvents 100 | 
    where {$_.Message -Match $username -and $_.TimeCreated -ge $Date.AddMinutes(-15)} |
    Select TimeCreated,Message | Export-Csv $FilePath -NoTypeInformation 
