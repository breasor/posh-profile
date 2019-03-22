$profileDir = $PSScriptRoot;

# From https://serverfault.com/questions/95431/in-a-powershell-script-how-can-i-check-if-im-running-with-administrator-privil#97599
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Set-Content function:\chrome "cmd /c `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe`" `$args "
Set-Content function:\google "cmd /c `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe`" https://www.google.com/search?q=`$args"
Set-Content function:\firefox "cmd /c `"C:\Program Files\Mozilla Firefox\firefox.exe`" `$args "


function update-powershell-profile {
    & $profile
}

# https://blogs.technet.microsoft.com/heyscriptingguy/2012/12/30/powertip-change-the-powershell-console-title
function set-title([string]$newtitle) {
    $host.ui.RawUI.WindowTitle = $newtitle + ' – ' + $host.ui.RawUI.WindowTitle
}

# From http://stackoverflow.com/questions/7330187/how-to-find-the-windows-version-from-the-powershell-command-line
function get-windows-build {
    [Environment]::OSVersion
}

function disable-windows-search {
    Set-Service wsearch -StartupType disabled
    stop-service wsearch
}

function Test-FileInSubPath([System.IO.DirectoryInfo]$Child, [System.IO.DirectoryInfo]$Parent) {
    write-host $Child.FullName | select-object '*'
    $Child.FullName.StartsWith($Parent.FullName)
}

function stree {
    $SourceTreeFolder = get-childitem ("${env:LOCALAPPDATA}" + "\SourceTree\app*") | Select-Object -first 1
    & $SourceTreeFolder/SourceTree.exe -f .
}

function get-serial-number {
    Get-CimInstance -ClassName Win32_Bios | select-object serialnumber
}

function get-process-for-port($port) {
    Get-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess
}


function open($file) {
    invoke-item $file
}

function explorer {
    explorer.exe .
}

function pkill($name) {
    get-process $name -ErrorAction SilentlyContinue | stop-process
}

function pgrep($name) {
    get-process $name
}

# Like Unix touch, creates new files and updates time on old ones
# PSCX has a touch, but it doesn't make empty files
if ($PSVersionTable.PSVersion.Major -gt 5) {
    Remove-Alias touch
}
function touch($file) {
    if ( Test-Path $file ) {
        Set-FileTime $file
    }
    else {
        New-Item $file -type file
    }
}

# From https://stackoverflow.com/questions/894430/creating-hard-and-soft-links-using-powershell
function ln($target, $link) {
    New-Item -ItemType SymbolicLink -Path $link -Value $target
}

function uptime {
	Get-CimInstance Win32_OperatingSystem | select-object csname, @{LABEL='LastBootUpTime';
	EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
}

function grep($regex, $dir) {
	if ( $dir ) {
		get-childitem $dir | select-string $regex
		return
	}
	$input | select-string $regex
}

function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}

function cut(){
	foreach ($part in $input) {
		$line = $part.ToString();
		$MaxLength = [System.Math]::Min(200, $line.Length)
		$line.subString(0, $MaxLength)
	}
}

# From https://github.com/Pscx/Pscx
function sudo(){
	Invoke-Elevated @args
}

function Start-AWS ($credentialsFile) {
    Import-Module AWSPowershell
    $AWSCredentials = Import-Csv -Path $credentialsFile
    Set-AWSCredentials -AccessKey $AWSCredentials.'Access Key Id' -SecretKey $AWSCredentials.'Secret Access Key' -StoreAs "brett.reasor"
    Initialize-AWSDefaults -ProfileName "brett.reasor" -Region us-east-1
}

function get-modules ($ModuleList) {
    if (Get-Command Install-Module -ErrorAction SilentlyContinue) {
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

        foreach ($module in $ModuleList) {
            if (-not (Get-Module -ListAvailable -Name $module)) {
                Install-Module $module -Scope CurrentUser -Confirm:$false -ErrorAction SilentlyContinue
            }
            else {
                Update-Module $module -Confirm:$false -ErrorAction SilentlyContinue
            }
        }

    }
}