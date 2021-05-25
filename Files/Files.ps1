Param ([string]$Source, [string]$Destination, [datetime]$FromDate, [switch]$Debug)
# param (
#     [parameter(Mandatory=$true)][ValidateRange(1, [int]::MaxValue)]
#     [Int]$startRevision,

#     [parameter(Mandatory=$true)][ValidateRange(1, [int]::MaxValue)]
#     [Int]$endRevision,

#     [parameter(Mandatory=$false)][ValidateRange(1, [int]::MaxValue)]
#     [Int]$stepSize = 10,

#     [parameter(Mandatory=$false)]
#     [String]$applicationToBuild
# )
# $path = 'c:\temp'
# $exclude = 'bin','C:\temp\bin'
# Get-ChildItem -Path $path -Exclude $exclude -Recurse



# Get-ChildItem $path |
#       Where-Object{$_.Creationtime -gt (Get-Date).addMinutes(-15) -AND $_.Length -gt 0Kb} |
#       Format-Table -Auto |
#       Out-String |
#       Out-file "$path\maybe.txt"


#       $file_list = Get-ChildItem  $path | Where-Object {([datetime]::now.Date -eq $_.lastwritetime.Date)};
Clear-Host
if ($Debug.IsPresent) {
    
}

if ($PSBoundParameters.ContainsKey('Source')) {
    
}
else{
    $Source = 'c:\temp'
}
if ($PSBoundParameters.ContainsKey('Destination')) {
    
}
else{    
    $Destination = 'c:\temp\to'
}
if ($PSBoundParameters.ContainsKey('FromDate')) {
    $minDate = [datetime]$FromDate
}
else{
    #$minDate = (Get-Date).Date
    
    $LastWriteTimes = Get-ChildItem $Destination | Measure-Object -Property LastWriteTime -Minimum -Maximum | Select-Object -Property Minimum,Maximum 

    $minDate = $LastWriteTimes.Maximum.AddTicks(1)

    Write-Host "Last change:$minDate"
}

[string[]]$exclude = Get-Content -Path 'C:\Temp\excludePsFileList.txt'  | Where-Object{ -not $_.StartsWith("#")  }
    #ForEach-Object { 
# @("exclude.txt")
[string[]]$excludeMatch = Get-Content -Path 'C:\Temp\excludePsFolderList.txt' | ForEach-Object { Write-Output $_.Replace("\","")} | Where-Object{ -not $_.StartsWith("#")  }
$excludeMatch = $excludeMatch + "to";
  #@("bin", "to") 



# [regex] $excludeMatchRegEx = ‘(?i)‘ + (($excludeMatch | ForEach-Object { [regex]::escape($_) }) –join “|”) + ‘’

[regex] $excludeMatchRegEx = '(?i)' + (($excludeMatch | ForEach-Object { [regex]::escape($_) }) -join "|") + ''

Write-Host "LastWriteTime >= [$minDate]"

Write-Host "From: $Source"
Write-Host "To:   $Destination"

Write-Host "exclude:      $([String]::Join(", ", $exclude))"
Write-Host "excludeMatch: $([String]::Join(", ", $excludeMatch))"


Read-Host ">>> Ctrl+c to Exit"
Get-ChildItem -Path $Source -Recurse -Exclude $exclude | 
#(Get-Date).addMinutes(-45)
Where-Object { $excludeMatch -eq $null -or $_.FullName.Replace($Source, "") -notmatch $excludeMatchRegEx -and $_.LastWriteTime -ge $minDate} |
# Sort-Object -Property Mode -Descending |
ForEach-Object {
    Write-Host "-- [$_]"

    if ($_.PSIsContainer -and !(Test-Path $( Join-Path $Destination $_.FullName.Substring($Source.length)))) {
            Write-Host "CREATING DIR:[$( Join-Path $Destination $_.FullName.Substring($Source.length))]"
            New-Item $( Join-Path $Destination $_.FullName.Substring($Source.length)) -Type Directory | Out-Null
    }
    elseif (!$_.PSIsContainer -and !(Test-Path $(Join-Path $Destination $_.DirectoryName.Substring($Source.length)))){
            Write-Host "CREATING DIR From File?:[$(Join-Path $Destination $_.DirectoryName.Substring($Source.length))]"
            New-Item $(Join-Path $Destination $_.DirectoryName.Substring($Source.length)) -Type Directory | Out-Null

    }
    if(!$_.PSIsContainer ){        
        Write-Output $_        
    }
} |
Copy-Item -Destination {    
    if ($_.PSIsContainer) {        
        Join-Path $Destination $_.Parent.FullName.Substring($Source.length) 
    }
    else {
        Join-Path $Destination $_.FullName.Substring($Source.length)
    } #-Force -WhatIf
} -Exclude $exclude -PassThru -Force -Recurse| 

ForEach-Object {
    Write-Host '------------------------------------------------------------------------------'
} {
    $_
    # Write-Host "Copy $_ to $(
    # if ($_.PSIsContainer) {        
        
    #     Join-Path $Destination $_.Parent.FullName.Substring($Source.length)
    # }
    # else {
    #     Join-Path $Destination $_.FullName.Substring($Source.length) 
    #     # Write-Host Join-Path $Destination $_.FullName.Substring($Source.length)
    # })"
} {
    Write-Host '------------------------------------------------------------------------------'
}

# Read-Host -Prompt 'Exiting'