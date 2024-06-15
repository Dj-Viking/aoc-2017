param(
    [string]
    $inputtype = "sample"
)

$PSVersionTable

[int]$input1 = 368078;

# end point of the grid trace back to start (0, 0) how many steps?


function part1 {

    # powershell int casting will round a float up so don't add one here
    [int]$upperbase = [int]([System.Math]::Sqrt($input1));
    [int]$upperlimit = [int]([System.Math]::Pow($upperbase, 2));

    # dont int cast here....because powershell?????
    [int]$segment = ([System.Math]::Sqrt($input1) / 2);
    
    # subtract 1 from upper base because ?????? no idea it works though
    [int]$answer = (($upperbase - 1) / 2) + ($upperlimit - $input1 + $segment) % $segment;

    #374 too high
    #370 too low
    #371 according to my solution example from kezzryn
    Write-Host "part1: $answer"
}

class Point {
    [System.Drawing.Point]
    $pt

    Point($x, $y) {
        $this.pt = [System.Drawing.Point]::new($x, $y);
    }

    [string]ToString() {
        return "$($this.pt.X),$($this.pt.Y)";
    }

    [int]GetNborVal(
        [System.Collections.Generic.Dictionary[string, int]]$memmap
    ) {

        [int]$val = 0;
        [System.Collections.ArrayList]$nbors = @();

        [System.Linq.Enumerable]::Range($this.pt.X - 1, 3) | ForEach-Object {
            [int]$xnum = $_;

            [System.Linq.Enumerable]::Range($this.pt.Y - 1, 3) | ForEach-Object {
                [int]$ynum = $_;

                if (!($xnum -eq $this.pt.X -and $ynum -eq $this.pt.Y)) {
                    $nbors.Add([Point]::new($xnum, $ynum)) | Out-Null;
                }
            }
        }

        [System.Collections.ArrayList]$Results = @(); 
        $nbors | ForEach-Object {
            [Point]$nbor = $_;

            if ($null -ne $memmap[$nbor.ToString()]) {
                $Results.Add($memmap[$nbor.ToString()]) | Out-Null;
            }
            else {
                $Results.add(0) | Out-Null;
            }
        }

        $Results | ForEach-Object {
            $val += $_;
        }

        if ($val -eq 0) {
            return 1;
        }
        else {
            return $val;
        }
    }
}

function part2 {
    [int]$answer2 = 0;

    [System.Collections.Generic.Dictionary[string, int]]$memorymap = @{};

    [Point]$cursor = [Point]::new(0, 0);

    [System.Numerics.Complex]$direction = [System.Numerics.Complex]::new(1, 0);

    [int]$spiral_level = 0;
    [int]$spiral_steps = 0;

    do {
        [int]$val = $cursor.GetNborVal($memorymap);

        if ($val -ge $input1) {
            $answer2 = $val;
        }

        try {
            $memorymap.Add($cursor.ToString(), $val);
        }
        catch { 
           
        }

        if ($spiral_steps -eq 0) {
            $cursor.pt += [System.Drawing.Size]::new($direction.Real, $direction.Imaginary);
            $direction *= [System.Numerics.Complex]::ImaginaryOne;
            $spiral_level += 2;
            $spiral_steps = $spiral_level * 4;
        }
        else {
            if (
                ($spiral_steps % $spiral_level) -eq 0
            ) {
                $direction *= [System.Numerics.Complex]::ImaginaryOne;
            }
            $cursor.pt += [System.Drawing.Size]::new($direction.Real, $direction.Imaginary);
        }

        $spiral_steps -= 1;
    } while ($answer2 -eq 0);
    # 413269 too high
    Write-Host "part2: $answer2";
}

part1;
part2;