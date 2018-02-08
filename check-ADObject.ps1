<#
Run through list of hosts and checks if they are in Active Directory
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$Hostfile,
    [string]$Outfile
)

$hostlists = get-content $Hostfile
$ResultsList = @()
$ResultsList += 'Hostname'+','+'In_Active_Directory'
$ErrorActionPreference = 'silentlycontinue'

foreach($computer in $hostlists)
{
    $getComputer = $null
    $Result = $null
    $currentEAP = $ErrorActionPreference
    $ErrorActionPreference = "silentlycontinue"

    $getComputer = get-adcomputer $computer

    IF ($getComputer){
            $Result = $true
            <#
            Write-Host "#########################"  
            Write-Host "Computer object exists"
            Write-Host "#########################" 
            #>
            $ResultsList += $computer+','+'Computer is in AD'
        }
        
    if (!$getComputer) {
        $Result = $false
        $ErrorActionPreference = $currentEAP
        <#
        Write-Host "#########################"  
        Write-Host "$computer Computer object NOT FOUND" -ForegroundColor red
        #>
        $ResultsList += $computer+','+'Computer not in AD'

    }

}

$ResultsList | Out-File $Outfile
