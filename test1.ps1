# getmac.exe | Format-List *
# getmac.exe | Get-Member
# getmac.exe | Select-String "Physical Address"
function Write-DA-Text {
    Write-Host "Host Test";
    Write-Output "Output text2";
}

Write-Host  $env:COMPUTERNAME

Write-DA-Text

# In a nutshell, Write-Host writes to the console itself. Think of it as a MsgBox in VBScript. Write-Output, on the other hand, writes to the pipeline, so the next command can accept it as its input. You are not required to use Write-Output in order to write objects, as Write-Output is implicitly called for you.

# PS> Get-Service
# would be the same as:

# PS> Get-Service | Write-Output
#Get-Variable
#Write-Host "Enter Path "
$myPath = Read-Host "Enter Path "
$evalPath = Test-Path $myPath

if ($evalPath -eq $true) {
    Write-Information "Path [$myPath] Exists." 
    # The $InformationPreference preference variable value determines whether the message you provide to Write-Information is displayed at the expected point in a script's operation. Because the default value of this variable is SilentlyContinue, by default, informational messages are not shown. If you don't want to change the value of $InformationPreference, you can override its value by adding the InformationAction common parameter to your command.
    Write-Host "Path [$myPath] Exists." -ForegroundColor Green
}
else {
    Write-Error "Path [$myPath] DO NOT Exists." 
    Write-Host "Path [$myPath] DO NOT Exists." -ForegroundColor Red
} #|| Write-Host "Allt ok"

$spw = Read-Host -Prompt 'Enter password' -AsSecureString
$spw | Format-List *

#Array
$myArray = @()
$myArray += "test";
$myArray += "test2";
$myArray += 'test3';

$myArray | Sort-Object -Descending

#Invoke-WebRequest
#Invoke-WmiMethod -Class 

Get-Host | Select-Object Version
$PSVersionTable 

wsl --list
#vim :q!
#Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
#bash
#See version
# lsb_release -a
#exit
#tmux
#htop
#sudo apt update
#python3