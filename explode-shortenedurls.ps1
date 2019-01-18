<#
basic bulk shortened URL lookup
Note there is a 10 request rate limit for new URLS with unshorten.me

#>

# Parameter help description
param(
    [Parameter(Mandatory=$false)]
    [string]$bulklist,
    [string]$OutFile
)

$urllist = get-content $bulklist
$ResolvedURLs = @()
$ResolvedURLs +='Shortened_URL'+','+'Resolved_Url'

[System.Net.ServicePointManager]::SecurityProtocol = (
    [System.Net.ServicePointManager]::SecurityProtocol -bor 
    [System.Net.SecurityProtocolType]::Tls12
)

foreach($url in $urllist)
{
    $resolved = $null
    
    $resolved = (Invoke-RestMethod -Uri https://unshorten.me/json/$url).resolved_url
    $ResolvedURLs += $resolved+','+$url
}

$ResolvedURLs | Out-File $OutFile
