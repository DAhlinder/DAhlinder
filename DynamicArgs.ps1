Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf


# SPLATTING WITH HASH TABLES
# Use a hash table to splat parameter name and value pairs. You can use this format for all parameter types, including positional and switch parameters. Positional parameters must be assigned by name.
#To provide a value for the WhatIf switch parameter, use $True or $False.

$HashArguments = @{
  Path = "test.txt"
  Destination = "test2.txt"
  WhatIf = $true
}
Copy-Item @HashArguments

# SPLATTING WITH ARRAYS
# Use an array to splat values for positional parameters, which do not require parameter names. The values must be in position-number order in the array.
$ArrayArguments = "test.txt", "test2.txt"
Copy-Item @ArrayArguments -WhatIf

$PSBoundParameters 
$Args
function Get-MyProcess { Get-Process @Args }

function Get-MyCommand
{
    Param ([switch]$P, [switch]$C)
    $args
    if ($P) { Get-Process @Args }
    if ($C) { Get-Command @Args }
}

Get-MyCommand -P -C -Name PowerShell

Get-ChildItem -Force 'c:\windows\system32\d*.exe'
Get-ChildItem -Force 'c:\windows\sysnative\d*.exe' # on 32 bit