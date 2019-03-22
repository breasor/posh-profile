$old_ErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
Set-Alias -Name "cd"  -Value Push-Location -option AllScope -Force
Set-Alias -Name "cd-" -Value Pop-Location -Force
Set-Alias -Name 'gpm' -Value Get-Parameter -Force
New-Alias -Name 'df' -Value Get-Volume -Force
New-Alias -Name 'touch' -Value Set-FileTime -Force
Set-Alias -Name 'trash' -Value Remove-ItemSafely

#New-Alias -Name transcript -Value ([Diagnostics.Process]::Start("C:\Windows\System32\notepad.exe", $Variable:TRANSCRIPT))
#Set-Alias -Name transcript -Value [Diagnostics.Process]::Start("C:\Windows\System32\notepad.exe", $Variable:TRANSCRIPT)
New-Alias -Name ping -Value Test-Connection -Force

if ([Environment]::OSVersion.Version -ge (New-Object 'Version' 6, 2)) { Set-Alias -Name ipconfig -Value Get-NetIPConfiguration }

if (Test-Path -Path 'C:\Program Files\Git\bin\git.exe') { New-Alias -Name git -Value 'C:\Program Files\Git\bin\git.exe' -Scope Global -Force }

$ErrorActionPreference = $old_ErrorActionPreference
$old_ErrorActionPreference = $null

