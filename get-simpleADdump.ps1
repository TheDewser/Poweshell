<#
Quick and dirty script to dump AD information.  
Search base can be removed if you want to cover all of AD environment
#>
$SearchOU = "OU=UserAccounts,DC=Contoso,DC=lan"
get-aduser -Filter * -SearchBase $SearchOU -Properties samaccountname,displayname,lastLogonDate,passwordlastset,whenCreated |
    select samaccountname,displayname,lastLogonDate,passwordlastset,whenCreated |
    export-csv -NoTypeInformation "Path-To-File.csv"
