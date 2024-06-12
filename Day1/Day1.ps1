param(
    [string]
    $inputtype = "sample"
)

[System.Collections.ArrayList]$lines = @();

Get-Content -Path $(if ($inputtype -notmatch "sample") { "$($PSScriptRoot)\input.txt" } else { "$($PSScriptRoot)\$inputtype.txt" }) `
| ForEach-Object {
    $lines.Add($_) | Out-Null
};

function part1 {
    $chars = $lines[0].ToCharArray();
    $nums = $chars | ForEach-Object { [int]([string]$_) }

    [System.Int64]$sum = 0;
    [System.Collections.ArrayList]$matchstack = @();

    for ($i = 0; $i -lt $nums.length; $i++) {
        $num = $nums[$i];
        [int]$next = ($i + 1) % $nums.length;

        # part1 sum
        if ($num -eq $nums[$next]) {
            $sum += $nums[$i];
        }
    }


    # 1048 too low
    # 5651 too high
    Write-Host "part 1: <$sum>";
}
    
function part2 {
    Write-Host "part 2: <>";
}

part1;

part2;