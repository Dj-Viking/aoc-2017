param(
    [string]
    $inputtype = "sample"
)

[System.Collections.ArrayList]$lines = @();

Get-Content -Path $(if ($inputtype -notmatch "sample") { "$($PSScriptRoot)\input.txt" } else { "$($PSScriptRoot)\$inputtype.txt" }) `
| ForEach-Object {
    $lines.Add($_) | Out-Null
};