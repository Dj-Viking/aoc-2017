param(
    [int]
    $day
)

if (-not (Test-Path -Path ".\Day$day")) {
    $newday = ".\Day$day";
    mkdir "$newday";
    
    Push-Location "$newday";
    New-Item -ItemType File -Name "$newday.ps1" -Path ".";
    Pop-Location;

}