param(
    [string]
    $inputtype = "sample"
)

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

part1;