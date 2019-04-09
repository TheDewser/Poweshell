$targetOUs = Get-ADOrganizationalUnit -SearchBase "RootSearchBase" -filter {name -like "OUName"} | ForEach-Object {$_.DistinguishedName}

foreach($target in $targetOUs){
    $userCount += (get-aduser -SearchBase $target -Filter * | Where-Object {$_.enabled -eq "True"}).count
    
}
Write-Host $userCount
