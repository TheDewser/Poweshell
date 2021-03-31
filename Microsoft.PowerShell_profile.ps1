[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12  # need to figure out how to set multiple types
$ps_script_dir = 'InsertPathHere'
Set-Location $ps_script_dir
