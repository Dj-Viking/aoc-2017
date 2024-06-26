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
    Write-Host "part 1: <$sum>" -ForegroundColor Green;
}
    
function part2 {
    $chars = $lines[0].ToCharArray();
    $nums = $chars | ForEach-Object { [int]([string]$_) }

    [System.Int64]$sum2 = 0;

    for ($i = 0; $i -lt $nums.length; $i++) {
        $num = $nums[$i];
        [int]$next = ($i + ($nums.length / 2)) % $nums.length;

        # part2 sum
        if ($num -eq $nums[$next]) {
            $sum2 += $nums[$i]
        }
    }

    # 1832 too highs
    Write-Host "part 2: <$sum2>" -ForegroundColor Green;
}

part1;

part2;