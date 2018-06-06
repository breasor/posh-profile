Import-Module "$(${env:ProgramFiles(x86)})\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1"

$AWSCredentials = Import-Csv $AWSCredentialsFile
Set-AWSCredentials -AccessKey $AWSCredentials.'Access Key Id' -SecretKey $AWSCredentials.'Secret Access Key' -StoreAs "brett.reasor"
Initialize-AWSDefaults -ProfileName "brett.reasor" -Region us-east-1