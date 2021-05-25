#Enable-PSRemoting
Enter-PSSession -ComputerName


Test-NetConnection -ComputerName 192.168.214.210 -TraceRoute
Test-NetConnection -ComputerName MIM 

get-WmiObject -class Win32_Share -computer $env:COMPUTERNAME
get-WmiObject -class Win32_Share -computer MIM 

$mimCredentials = Get-Credential

# When you have to provide credentials in non-interactive mode, you can create a PSCredential object in the following way.

$secpasswd = ConvertTo-SecureString "Passw0rd1" -AsPlainText -Force
$mimCredentials = New-Object System.Management.Automation.PSCredential ("admim\Administrator", $secpasswd)

# You can now pass $mycreds to any -PSCredential input parameter
Enter-PSSession -ComputerName MIM -Credential $mimCredentials # -UseSSL

Get-Item WSMan:\localhost\Client\TrustedHosts
Set-Item WSMan:\localhost\Client\TrustedHosts
$env:COMPUTERNAME