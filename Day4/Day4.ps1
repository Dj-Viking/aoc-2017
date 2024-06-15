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

function part2 {

    $ordered_line = $lines | ForEach-Object {
        [string]$l = $_;

        [string[]]$words = $l.Split("", [System.StringSplitOptions]::RemoveEmptyEntries);

        # order words alphabetically in the line

        $words_ordered = [System.Linq.Enumerable]::OrderBy(
            [string[]]$words, 
            [Func[string, string]] { param($s) $s }
        )

        $words_ordered -join " "
    }

    $thing = $ordered_line | ForEach-Object {

        [string]$l = $_;
        [string[]]$line_words = $l.Split("", [System.StringSplitOptions]::RemoveEmptyEntries);

        [System.Collections.ArrayList]$validlist = @();

        :linewords for ($w = 0; $w -lt $line_words.Count; $w++) {
            [char[]]$first = $line_words[0].ToCharArray();
            [char[]]$next = $line_words[($w + 1) % $line_words.Count].ToCharArray();

            $len = $first.Length;

            if ($first.Length -ne $next.Length) {
                $validlist += $true;

                continue linewords;
            }

            # Sort chararrs
            [System.Collections.ArrayList]$sortedFirst = @();
            [System.Collections.ArrayList]$sortedNext = @();

            foreach ($c in $first) { $sortedFirst += $c }
            $sortedFirst.Sort();
            foreach ($c in $next) { $sortedNext += $c }
            $sortedNext.Sort();

            # compare sorted chars

            for ($i = 0; $i -lt $len; $i++) {
                if ($sortedFirst[$i] -ne $sortedNext[$i]) {
                    $validlist += $true;
                    continue linewords;
                }
            }

            # Write-Host "";

        }

        if ($validlist.Count -eq $line_words.Count) {
            return $true;
        }

    }

    # 423 too high

    # why the fuck am i getting 43???

    # should be 251??
    Write-Host "part2: $(($thing | Where-Object { $_ -eq $true }).Length)";



}

part1;
part2;