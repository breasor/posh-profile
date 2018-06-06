$PSLogPath = ("{0}\Documents\WindowsPowerShell\log\{1:yyyyMMdd}-{2}.log" -f $env:USERPROFILE,  (Get-Date), $PID)
Add-Content -Value "# $(Get-Date) $env:username $env:computername" -Path $PSLogPath
Add-Content -Value "# $(Get-Location)" -Path $PSLogPath

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
    $host.UI.RawUI.WindowTitle = Get-Location
    "$nextCommand PS \$currentDirectory>"
}  