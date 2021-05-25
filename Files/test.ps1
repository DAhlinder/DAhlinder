[datetime]$minDate = (Get-Date).Date

$LastWriteTimes = Get-ChildItem 'C:\VSProject\RixStat' | Measure-Object -Property LastWriteTime -Minimum -Maximum | Select-Object -Property Minimum,Maximum 

$minDate = $LastWriteTimes.Maximum

Write-Host "Last change:$minDate"


# PowerShell Basics: Working with the If Statement
# -eq	Equals to
# -ne	Not equal to
# -gt	Greater than
# -ge	Greater than or equal to
# -lt	Less than