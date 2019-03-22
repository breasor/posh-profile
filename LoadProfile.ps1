
If (-not (Test-Path $PROFILE)) {
    New-Item $PROFILE -ItemType File -Force
}

Clear-Content $PROFILE


foreach ($config in (Get-ChildItem -Path $PSScriptRoot\profile.d\*.ps1)) {
    Write-Host "Loading $config"
    $content = Get-Content $config.FullName
    Add-Content -Path $PROFILE -Value $content
}

