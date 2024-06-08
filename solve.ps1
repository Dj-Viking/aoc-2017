param(
    [Parameter(Mandatory, Position = 0)]
    [int]
    $day,

    [Parameter(Position = 1, HelpMessage = "s for sample ( default ) and i for input run")]
    [string]
    $solvefile = "sample"
)

$dir = ".\Day$day";

Push-Location $dir;

& ".\Day$day.ps1" -inputtype $solvefile

Pop-Location