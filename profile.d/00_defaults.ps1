
# Proper history etc
Import-Module PSReadLine
Set-PSReadlineOption -BellStyle None

# https://technet.microsoft.com/en-us/magazine/hh241048.aspx
$MaximumHistoryCount = 10000;

# Oddly, Powershell doesn't have an inbuilt variable for the documents directory. So let's make one:
# From https://stackoverflow.com/questions/3492920/is-there-a-system-defined-environment-variable-for-documents-directory
$env:DOCUMENTS = [Environment]::GetFolderPath("mydocuments")

$global:ModuleList = @(
    "SecurityFever",
    "posh-git",
    "AzureAD",
    "Pester",
    "AWSPowerShell",
    "PSUtil",
    "carbon",
    "PSMSGraph",
    "pode",
    "UniversalDashboard.Community"
)


function Global:Set-PSDefaultParameters {

    # Default parameter values
    $Global:PSDefaultParameters = @{
        "Send-MailMessage:To"                = "brett.reasor@endicottcomm.com"
        #"Send-MailMessage:From"     = "User.123@domain.com"
        "Format-Table:AutoSize"              = {if ($host.Name -eq "ConsoleHost") {$true}}
        "Get-ChildItem:Force"                = "True"
        "Send-MailMessage:SMTPServer"        = "172.16.10.18"
        "Update-Help:Module"                 = "*"
        "Update-Help:ErrorAction"            = "SilentlyContinue"
        "Update-Help:Verbose"                = $True
        "Test-Connection:Count"              = "1"
        "Out-File:Encoding"                  = "utf8"
        "New-ExoPSSession:UserPrincipalname" = "breasor@ansafone.com"
    }
} #Set-PSDefaultParameterValues

Set-PSDefaultParameters

$WID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$Prp = New-Object System.Security.Principal.WindowsPrincipal($WID)
$Adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
$global:IsAdmin = $Prp.IsInRole($Adm)

Import-Module (Get-ChildItem -Path $($env:LOCALAPPDATA + "\Apps\2.0\") -Filter '*ExoPowershellModule.dll' -Recurse | Foreach {(Get-ChildItem -Path $_.Directory -Filter CreateExoPSSession.ps1)} | Sort-Object LastWriteTime | Select-Object -Last 1).FullName