<#
Run nbtstat against a list of IP addresses and lists the actual hostname.
Useful when dealing with systems that are not using the Corp DHCP/DNS services.
Operationaly Technology or Shadow IT systems that may get tagged for Incident related IoCs.
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$IPListFile,
    [string]$Outfile
)

$unresolvedip = get-content $IPListFile

$resolvedlist = @()
$resolvedlist += 'IP_Address'+','+'ResolvedName'
$ErrorActionPreference = 'silentlycontinue'

foreach($ip in $unresolvedip){
    $resolvedname = $null
    $Result - $null
    $currentEAP = $ErrorActionPreference
    
    $resolvedname = (nbtstat -A $ip | ?{$_ -match '\<00\>  UNIQUE'}).Split()[4]
    # Something here is causing the results to also display in teh console not sure why yet.
    if ($resolvedname){
        $Result = $true
        $resolvedlist += $ip + ',' + $resolvedname
    }

    if (!$resolvedname){
        $Result = $false
        $ErrorActionPreference = $currentEAP
        $resolvedlist += $ip + ',' + 'Try NMAP - could not resolve'
    }

}

# Already produces a CSV formatted list - export-csv will not display the results.
$resolvedlist | Out-File $Outfile