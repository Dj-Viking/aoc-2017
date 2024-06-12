param(
    [int]
    $day
)

if (-not (Test-Path -Path ".\Day$day")) {
    $newday = ".\Day$day";
    mkdir "$newday";
    
    Push-Location "$newday";
    New-Item `
        -ItemType File `
        -Name "$newday.ps1" `
        -Path "." `
        -Value @"
        param(
            [string]
            `$inputtype = "sample"
        )

        [System.Collections.ArrayList]`$lines = @();

        Get-Content -Path `$(if (`$inputtype -notmatch "sample") { "`$(`$PSScriptRoot)\input.txt" } else { "`$(`$PSScriptRoot)\`$inputtype.txt" }) ``
        | ForEach-Object {
            `$lines.Add(`$_) | Out-Null
        };
"@; 

    New-Item `
        -ItemType File `
        -Name "sample.txt" `
        -Path "." `
        -Value "";
    
    New-Item `
        -ItemType File `
        -Name "input.txt" `
        -Path "." `
        -Value "";

    Pop-Location;

}
