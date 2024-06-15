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
    $valid = 0;
    $lines | ForEach-Object {
        [string]$l = $_;
        
        [string[]]$words = $l.Split("", [System.StringSplitOptions]::RemoveEmptyEntries);
        
        [System.Collections.Generic.Dictionary[string, int]]$wd = @{};

        $words | ForEach-Object {
            [string]$word = $_;

            if ($wd.ContainsKey($word)) {
                $wd[$word] += 1;
            }
            else {
                $wd.add($word, 1);
            }
        }

        $isValid = $true

        :validaterow foreach ($key in $wd.keys) {
            if ($wd[$key] -gt 1) {
                $isValid = $false;
                break validaterow;
            }
        }

        if ($isValid) {
            $valid += 1;
        }

    }

    # 512 too high
    # 466!!!
    Write-Host "part1: $valid";
}

part1;