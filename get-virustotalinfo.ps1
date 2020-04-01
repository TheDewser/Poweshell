<#
Looking to iterate through list of URLs
Using free API, need to keep requests to 4 per minute

$response = Invoke-RestMethod 'https://www.virustotal.com/api/v3/domains/imagetopdf.com' -Method 'GET' -Headers $headers -Body $body
$response | ConvertTo-Json
#>

$apikey = 'YOURKEY' # use param for full script/function
$header = @{'x-apikey' = $apikey}

Invoke-RestMethod -Method 'GET' -Uri 'https://www.virustotal.com/api/v3/domains/imagetopdf.com' -Headers $header |
ConvertTo-JSON #needed to pull in the full set of attribute values
