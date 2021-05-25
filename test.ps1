[string[]]$excludeMatch = Get-Content -Path 'C:\Temp\excludePsFolderList.txt' #@("bin", "to")

[string[]]$exclude = Get-Content -Path 'C:\Temp\excludePsFileList.txt' 

$excludeMatch | ForEach-Object {
    Write-Host "-- [" $_.Replace("\","") "]"
}



#Where-Object {1 -ige}

#Get-ChildItem -Path C:\VSProject\RixStat -Recurse -Exclude @("Visa top 10 senaste.sql","Up*.log")

Get-ChildItem -Path C:\VSProject\RixStat -Exclude $exclude