# Get-ChildItem
# Sequence	Description
# `0	Null
# `a	Alert
# `b	Backspace
# `e	Escape
# `f	Form feed
# `n	New line
# `r	Carriage return
# `t	Horizontal tab
# `u{x}	Unicode escape sequence
# `v	Vertical tab


# Öppna fil i vscode  skriv code .\filnamn i terminalen

# Operator	Description	Example
# -and	Logical AND. TRUE when both	(1 -eq 1) -and (1 -eq 2)
# statements are TRUE.	False
# -or	Logical OR. TRUE when either	(1 -eq 1) -or (1 -eq 2)
# statement is TRUE.	True
# -xor	Logical EXCLUSIVE OR. TRUE when	(1 -eq 1) -xor (2 -eq 2)
# only one statement is TRUE	False
# -not	Logical not. Negates the statement	-not (1 -eq 1)
# that follows.	False
# !	Same as -not	!(1 -eq 1)


# Get-PSDrive
Clear-Host
Set-Location C:\VSProject\PowerShell
$logEntries = Get-EventLog -LogName Application -Newest 100 | Where-Object {$_.EntryType -ne "0" }
$logEntries| Format-Table TimeWritten, EntryType, Source, Message 
#$logEntries|Get-Member

$fileContent = $logEntries | ForEach-Object {
    
    #$message = $_.Message.IndexOf('\n') > 0 ? "line": $_.Message
if (($_.Message.IndexOf("`n") -gt 0) -or ($_.Message.IndexOf("`r") -gt 0)  -or ($_.Message.IndexOf("`t") -gt 0) )  {
    $message = "line"
}
else{
    $message = $_.message
}
    Write-Host $_.TimeWritten.ToString("yyyy-MM-dd HH:mm:ss") "`t" $_.EntryType "`t" $_.Source "`t" $message
    #Write-Output $_.TimeWritten "`t" $_.EntryType "`t" $_.Source "`t" $message
    Write-Output "$($_.TimeWritten.ToString("yyyy-MM-dd HH:mm:ss"))`t$($_.EntryType)`t$($_.Source)`t$($message)"
    #Export-Csv
} 

$filecontent > c:\temp\test.txt
#Use the Tee-Object cmdlet, which sends command output to a text file and then sends it to the pipeline.
$fileContent | Out-File c:\temp\out.txt
# Stream #	Description	Introduced in
# 1	Success Stream	PowerShell 2.0
# 2	Error Stream	PowerShell 2.0
# 3	Warning Stream	PowerShell 3.0
# 4	Verbose Stream	PowerShell 3.0
# 5	Debug Stream	PowerShell 3.0
# 6	Information Stream	PowerShell 5.0
# *	All Streams	PowerShell 3.0
#  Note

# There is also a Progress stream in PowerShell, but it is not used for redirection.

# The PowerShell redirection operators are as follows, where n represents the stream number. The Success stream ( 1 ) is the default if no stream is specified.

# TABLE 2
# Operator	Description	Syntax
# >	Send specified stream to a file.	n>
# >>	Append specified stream to a file.	n>>
# >&1	Redirects the specified stream to the Success stream.	n>&1

$logContent = Get-Content c:\temp\test.txt 
Write-Output "`nSelect string"
$logContent | Select-String -Pattern "Error"
Write-Output "`nRegexp"
$regexp = ".\tError\t."
$logContent | Select-String -Pattern $regexp -AllMatches 
Write-Output "`nWhere"
$logContent | Where-Object {$_ -like "*`tError`t*"}

