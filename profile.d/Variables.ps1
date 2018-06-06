function Global:Set-PSDefaultParameters {

# Default parameter values
    $Global:PSDefaultParameters = @{
        "Send-MailMessage:To"       = "brett.reasor@endicottcomm.com"
        #"Send-MailMessage:From"     = "User.123@domain.com"
        "Format-Table:AutoSize"       = {if ($host.Name -eq "ConsoleHost"){$true}}
        "Get-ChildItem:Force"         = "True"
        "Send-MailMessage:SMTPServer" = "smtp.remyusa.com"
        "Update-Help:Module"          = "*"
        "Update-Help:ErrorAction"     = "SilentlyContinue"
        "Update-Help:Verbose"         = $True
        "Test-Connection:Count"       = "1"
        }
} #Set-PSDefaultParameterValues

Set-PSDefaultParameters

$WID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$Prp = New-Object System.Security.Principal.WindowsPrincipal($WID)
$Adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
$IsAdmin = $Prp.IsInRole($Adm)