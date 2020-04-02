<#
Looking to iterate through list of URLs
Using free API, need to keep requests to 4 per minute

$response = Invoke-RestMethod 'https://www.virustotal.com/api/v3/domains/imagetopdf.com' -Method 'GET' -Headers $headers -Body $body
$response | ConvertTo-Json
#>

$apikey = 'yourkey' # use param for full script/function
$header = @{'x-apikey' = $apikey}
$domain = 'test.com'
$url = 'https://www.virustotal.com/api/v3/domains/'+$domain

Invoke-RestMethod -Method 'GET' -Uri $url -Headers $header | Select-Object Data -ExpandProperty Data |
ConvertTo-JSON
