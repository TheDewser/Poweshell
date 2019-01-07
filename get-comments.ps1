Set-Location "localpath"

$script = "target_script"
$out = "$script comments.txt"

New-Item "out" -ItemType File

Get-Content $script

$comments = @()
# Change pattern based on target script language
Select-String -Pattern "#" $script |
    ForEach-Object {
        $comments += $_.Line
        $comments += $_.Context.PostContext

    }

$comments | Set-Content $out

