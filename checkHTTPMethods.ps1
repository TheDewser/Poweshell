<#
Mike Dews - 10-09-2018

.SYNOPSIS
    Checks if various methods are available.

.PARAMETER
    The methods and sitelist parameters are mandatory.
    Methods - any standard HTTP method example: GET, POST, OPTIONS etc...
    sitelist - txt file of the websites you want to check
    statuscode - any web status code will do

.EXAMPLE
    checkHTTPMethods.ps1 -methods 'OPTIONS' -sitelist <path to txt file> -statuscode <insert code you want to check>

#>

param (
    [parameter(Mandatory=$true)]
    [string]$methods,
    [string]$sitelist,
    [string]$statuscode

)
# adds support for TLS 1.2, default only uses 1.0/1.1 this can be added to your default PS profile
[System.Net.ServicePointManager]::SecurityProtocol = (
    [System.Net.ServicePointManager]::SecurityProtocol -bor 
    [System.Net.SecurityProtocolType]::Tls12
)


$targets = get-content $sitelist


foreach($target in $targets)
{
    $results = @()
    $results = Invoke-WebRequest -Uri $target -Method $methods
    $ErrorActionPreference = "SilentlyContinue" # 400 errors will register accordingly
        if ($results.statuscode -eq $statuscode){
        Write-Host $target" $methods Method enabled"
        }
        else {
        Write-Host $target" method not enabled"
    }
}
