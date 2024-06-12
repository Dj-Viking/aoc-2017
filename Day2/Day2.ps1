param(
    [string]
    $inputtype = "sample"
)

[System.Collections.ArrayList]$lines = @();

Get-Content -Path $(if ($inputtype -ne "sample") { "input.txt" } else { "sample.txt" }) `
| ForEach-Object {
    $lines.Add($_) | Out-Null
};