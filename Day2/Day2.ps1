param(
    [string]
    $inputtype = "sample"
)

[System.Collections.ArrayList]$lines = @();

[string]$content = Get-Content -Raw -Path $(if ($inputtype -notmatch "sample") { "$($PSScriptRoot)\input.txt" } else { "$($PSScriptRoot)\sample.txt" });

$content | ForEach-Object {
    $line = [string]$_;
    $splitrawline = $line.Split([System.Environment]::NewLine, [System.StringSplitOptions]::RemoveEmptyEntries);
    $splitrawline | ForEach-Object {
        $lines.Add($_) | Out-Null;
    }
}

function part1 {
    $answer1 = 0;

    foreach ($l in $lines) {
        [string]$_l = $l;

        [System.Collections.ArrayList]$rownums = @(); 
        
        $_l.Split("", [System.StringSplitOptions]::RemoveEmptyEntries) `
        | ForEach-Object {
            $rownums.Add([int]([string]$_)) | Out-Null;
        };

        $rownums.Sort();

        $answer1 += $rownums[-1] - $rownums[0];
    }

    Write-Host "answer 1: <$answer1>";
}
function part2 {}

part1;
part2;