Get-PnpDevice -FriendlyName "*Graphics*" | Select-Object FriendlyName,InstanceID | format-list
# FriendlyName : Intel(R) Graphics Control Panel
# InstanceId   : SWD\DRIVERENUM\CUI&4&839C33&0

# FriendlyName : Intel(R) UHD Graphics 630
# InstanceId   : PCI\VEN_8086&DEV_3E9B&SUBSYS_226717AA&REV_00\3&11583659&1&10
function Elevate()
{
    # Check to see if we are currently running "as Administrator"
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {
        $ScriptPath = $script:MyInvocation.MyCommand.Path
        Start-Process powershell.exe -verb Runas -ArgumentList ("-executionpolicy bypass -noprofile -nologo -file `"$ScriptPath`"")
        # Exit this unelevated script with exit code for "Error: Not elevated"
        Exit 3;
    }
}
Elevate
Disable-pnpdevice -instanceid "PCI\VEN_8086&DEV_3E9B&SUBSYS_226717AA&REV_00\3&11583659&1&10" -confirm:$false
Enable-pnpdevice -instanceid "PCI\VEN_8086&DEV_3E9B&SUBSYS_226717AA&REV_00\3&11583659&1&10" -confirm:$false
 