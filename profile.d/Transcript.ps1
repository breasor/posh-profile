## Transcript
Write-Verbose ("[{0}] Initialize Transcript" -f (Get-Date).ToString()) -Verbose
If ($host.Name -eq "ConsoleHost") {
    $transcripts = (Join-Path $Env:USERPROFILE "Documents\WindowsPowerShell\Transcripts")
    If (-Not (Test-Path $transcripts)) { New-Item -path $transcripts -Type Directory | Out-Null }
    $global:TRANSCRIPT = ("{0}\PSLOG_{1:dd-MM-yyyy}.txt" -f $transcripts,(Get-Date))
    Start-Transcript -Path $transcript -Append
    Get-ChildItem $transcripts | Where {
        $_.LastWriteTime -lt (Get-Date).AddDays(-14)
    } | Remove-Item -Force -ea 0
}
