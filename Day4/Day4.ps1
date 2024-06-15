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

function IsAnagramOf {
    [OutputType([bool])]
    param(
        [string]$word1,
        [string]$word2
    )

    $result = $false;

    [System.Collections.Generic.Dictionary[char, int]]$d1 = @{};
    [System.Collections.Generic.Dictionary[char, int]]$d2 = @{};

    $word1.ToCharArray() | ForEach-Object {
        if ($d1.ContainsKey($_)) {
            $d1[$_] += 1;
        }
        else {
            $d1[$_] = 1;
        }
    }

    $word2.ToCharArray() | ForEach-Object {
        if ($d2.ContainsKey($_)) {
            $d2[$_] += 1;
        }
        else {
            $d2[$_] = 1;
        }
    }

    $matching = 0;
    if ($d1.Keys.Count -eq $d2.Keys.Count) {
        foreach ($key in $d1.Keys) {
            if ($d1.ContainsKey($key) -and $d2.ContainsKey($key)) {
                if ($d1[$key] -eq $d2[$key]) {
                    $matching += 1;
                }
            }
        }
        if ($matching -eq $d1.Keys.Count) {
            $result = $true;
        }
    }

    return $result;

}
function part2 {
    [int]$valid = 0;
    $lines | ForEach-Object {
        [string]$l = $_;

        [string[]]$words = $l.Split("", [System.StringSplitOptions]::RemoveEmptyEntries);

        [System.Collections.Generic.Dictionary[string, bool]]$wd = @{};

        $words | ForEach-Object {
            [string]$word = $_;

            if (-not $wd.ContainsKey($word)) {
                $wd[$word] = $false;
            }
        }
        
        $hasAnagram = $false;
        :anagram for ($i = 0; $i -lt $words.Length; $i++) {

            $first = $words[0];
            $next_index = ($i + 1) % $words.Length;

            if ($first -eq $words[$next_index]) {
                continue;
            }

            if (IsAnagramOf -word1 $first -word2 $words[$next_index]) {
                $hasAnagram = $true;
                break anagram;
            }
        }

        if (-not $hasAnagram) {
            $valid += 1;
        }


    }

    # 423 too high
    Write-Host "part2: $valid";
}

part1;
part2;