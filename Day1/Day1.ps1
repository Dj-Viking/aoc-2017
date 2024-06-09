param(
    [string]
    $inputtype = "sample"
)

[System.Collections.ArrayList]$lines = @();

Get-Content -Path $(if ($inputtype -ne "sample") { "input.txt" } else { "sample.txt" }) `
| ForEach-Object {
    $lines.Add($_) | Out-Null
};

function part1 {
    foreach ($l in $lines) {
        Write-Host $l;
    }

    Write-Host "part 1: <>";
}
    
function part2 {
    foreach ($l in $lines) {
        Write-Host $l;
    }
}
Write-Host "part 2: <>";

part1;