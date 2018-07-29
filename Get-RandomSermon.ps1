<#
pulls a random link/file from a website
in particular random sermon from PoC || gtfo
#>

$site = "https://www.alchemistowl.org/pocorgtfo/"
# get links that meet criteria
$sermons = @((Invoke-WebRequest -Uri $site).links | Where-Object {$_.href -like "poc*"} | foreach {$_.href})
$TheSermon = $sermons[(Get-Random -Maximum ([array]$sermons).count)]

#can send this write to an invoke method but these files tend to be large in this case
Write-Host "Today's Sermon is"$site$TheSermon
