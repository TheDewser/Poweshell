<#
Adapted from script found online
Would like to add functionality to choose output type as well.

.SYNOPSIS
    Gets hostname data for a list of IP addresses and outputs to console or file.

.PARAMETER
    The IPListFile and Outfile are mandatory parameters.
    If you do not use them, you will be prompted for values.

.EXAMPLE
    IPLookup.ps1 -IPListFile <path to file> -Outfile <path to output file>

This code does not scale well for large amounts of IP addresses.

#>

param (
    [Parameter(Mandatory=$true)]
    [string]$IPListFile,
    [string]$Outfile
)

$ListofIPs = Get-Content $IPListFile

# original code which worked fine for small lists
# creates a blank array for resolved names and creates a header row
#$ResultList = @()
#$ResultList += 'IP_Address'+','+'Server_Name'+','+'Online'

# using the .NET Generic List object, still seems to take a long time.
$ResultList = New-Object System.Collections.Generic.List[System.String]
$ResultList.Add('IP_Address'+','+'Server_Name'+','+'Online')


# Resolve each of the addresses

foreach ($ip in $ListofIPs)
{
    
    $result = $null
    $Online = $null

    $currentEAP = $ErrorActionPreference
    $ErrorActionPreference = "silentlycontinue"

    # Use the DNS Static .NET class for reverse lookup
    # details on this found http://msdn.microsoft.com/en-us/library/ms143997.aspx
    $result = [system.net.dns]::GetHostEntry($ip)
    $Online = Test-Connection -ComputerName $ip -Count 1 -Quiet

    $ErrorActionPreference = $currentEAP

    If ($result)
    {
        $ResultList.Add($ip+','+[string]$result.HostName+','+$Online)
    }
    Else
    {
        $ResultList.Add($ip+','+'No Hostname Found'+','+$Online)
    }
    
    #$ResultList | Out-File $Outfile -Append
}
    # Output to txt file

    $ResultList | Out-File $Outfile     # Would like to build the file on the fly and have it update using -Append

    # output to console
    #$ResultList
