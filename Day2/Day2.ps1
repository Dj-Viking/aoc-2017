param(
    [string]
    $inputtype = "sample"
)

[System.Collections.ArrayList]$lines = @();

[string]$content = Get-Content -Raw -Path $(if ($inputtype -notmatch "sample") { "$($PSScriptRoot)\input.txt" } else { "$($PSScriptRoot)\$inputtype.txt" });

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

    Write-Host "answer 1: <$answer1>" -ForegroundColor Green;
}
function part2 {

    $answer2 = 0;

    #find 2 numbers in the row that evenly divide each other
    $lines | ForEach-Object {
        [string]$l = $_;

        [System.Collections.ArrayList]$rownums = @();

        $l.Split("", [System.StringSplitOptions]::RemoveEmptyEntries) `
        | ForEach-Object {
            $rownums.Add([int]([string]$_)) | Out-Null;
        }

        $calcing = $true;
        while ($calcing) {

            :calcing for ($j = 0; $j -lt $rownums.Count; $j++) {
                for ($i = 0; $i -lt $rownums.Count; $i++) {
                    $first = $rownums[$j];
                    $next_index = ($i + 1) % $rownums.Count;
                    [System.Collections.ArrayList]$tuple = @($first, $rownums[$next_index]);
        
                    $tuple.Sort();
    
                    if ($tuple[1] -eq $tuple[0]) {
                        continue;
                    }
        
                    if ($tuple[1] % $tuple[0] -eq 0) {
                        $answer2 += ($tuple[1] / $tuple[0]);
                        $calcing = $false;
                        break calcing;
                    }
                    
                }
            }
        }

    }
    Write-Host "answer2: <$($answer2)>" -ForegroundColor Green;
}

part1;
part2;