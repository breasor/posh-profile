$IsAdmin = (New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

if ($IsAdmin){ 	$Host.UI.RawUI.Backgroundcolor = "DarkRed"	}

Function Global:Prompt
{
    $LastCmd = Get-History -Count 1
    if($LastCmd)
    {
        $lastId = $LastCmd.Id
        
        Add-Content -Value "# $($LastCmd.StartExecutionTime)" -Path $PSLogPath
        Add-Content -Value "$($LastCmd.CommandLine)" -Path $PSLogPath

        Add-Content -Value "" -Path $PSLogPath
    }

    $nextCommand = $lastId + 1
    $currentDirectory = Split-Path (Get-Location) -Leaf
    if ($IsAdmin) { $host.UI.RawUI.WindowTitle = "IsAdmin - $(Get-Location)" }
    else { $host.UI.RawUI.WindowTitle = "$(Get-Location)" }
    "$nextCommand PS \$currentDirectory>"
}  