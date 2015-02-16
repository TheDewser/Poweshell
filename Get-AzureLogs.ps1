<#
Script to pull files down from Azure Blob Storage.
Removes older files based on oldblobs variable.
Logs the files copied to the local server as well as those removed from Azure.

Last Updated - 2/16/2015
Updated by - Mike Dews
Added conditional LogWrite statements for when no blobs have been deleted from the container.
Switched the $LogTime to just the date so scheduled jobs resultes will append to file.

#>

Import-Module Azure
Import-AzurePublishSettingsFile -PublishSettingsFile <PATH TO AZURE PUBLISH SETTINGS FILE>

$LogTime = get-date -Format "MM-dd-yyyy"
$LogFile = '<LOCAL PATH>'+"Azure_log_pull_"+$LogTime+".log"

Function LogWrite
{
    Param([string]$LogString)

    add-content $LogFile -value $LogString
}


$TodaysDate = get-date
$UTCTime = $TodaysDate.ToUniversalTime()
$container = '<CONTAINER WITH LOGS>'
$DestinationPath = '<LOCAL PATH TO DUMP LOGS>'
$context = New-AzureStorageContext -StorageAccountName <YOUR STORAGE ACCOUNT> -StorageAccountKey <YOUR STORAGE KEY>
$Newblobs = Get-AzureStorageBlob -Container $container -Context $context | where-object {$_.LastModified -ge $UTCTime.AddMinutes(-15)}
$oldblobs = Get-AzureStorageBlob -Container $container -Context $context | where-object {$_.LastModified -le $UTCTime.AddDays(-14)}

foreach ($blob in $Newblobs)
    {
        New-Item -ItemType Directory -Force -Path $DestinationPath

        Get-AzureStorageBlobContent `
        -Container $container -Blob $Blob.Name -Destination $DestinationPath `
        -Context $context

        LogWrite ("{0} - {1} copied to {2} successfully." -f (get-date -Format g),$blob.Name,$DestinationPath)
    }

foreach ($blob in $oldblobs) 
    {
        Write-Verbose ("Removing blob: {0}" -f $blob.Name)
        Remove-AzureStorageBlob `
        -Container $container -Blob $blob.Name `
        -Context $context
        
        $blobsRemoved += 1
        LogWrite ("{0} - {1} deleted from {2} successfull." -f (get-date -Format g),$blob.Name,$DestinationPath)    
    }
    if($blobsRemoved -gt 0){
        LogWrite ("{0} - {1} blobs removed from container {2}." -f (get-date -format g),$blobsRemoved, $container)
    }
    else{
        LogWrite ("{0} - No blobs removed from container" -f (get-date -format g))
    }
  
