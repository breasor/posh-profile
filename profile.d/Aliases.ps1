$old_ErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
Set-Alias -Name "cd"  -Value Push-Location -option AllScope
Set-Alias -Name "cd-" -Value Pop-Location
Set-Alias -Name gpm -Value Get-Parameter

#New-Alias -Name transcript -Value ([Diagnostics.Process]::Start("C:\Windows\System32\notepad.exe", $Variable:TRANSCRIPT))
#Set-Alias -Name transcript -Value [Diagnostics.Process]::Start("C:\Windows\System32\notepad.exe", $Variable:TRANSCRIPT)
New-Alias -Name ping -Value Test-Connection

if([Environment]::OSVersion.Version -ge (New-Object 'Version' 6,2)) { Set-Alias -Name ipconfig -Value Get-NetIPConfiguration }

if (Test-Path -Path 'C:\Program Files\Git\bin\git.exe'){ New-Alias -Name git -Value 'C:\Program Files\Git\bin\git.exe' -Scope Global }

$ErrorActionPreference = $old_ErrorActionPreference
$old_ErrorActionPreference = $null