Get-WmiObject win32_computersystem | Select-Object *

Get-CimInstance win32_computersystem

Get-CimInstance Win32_OperatingSystem

get-childitem env:
Get-ChildItem HKLM:\SYSTEM

# foreach -parallel ($item in $collection) {
    
# }

$nummer = (1..10)

Measure-Command { $nummer | ForEach-Object  -Process {
        #$timer = New-Object System.Threading.Thread()
        #System.Threading.Sleep
        #$timer.S
        Start-Sleep -s (2 - ($_ % 2))
        Write-Output "Nr: $_" #{text:"Nr: $_", nummer:$_}


    } | ForEach-Object -Begin {
        [int]$i = 0
    } -Process {
        $i++;
        Write-Host "Order $($_)" -BackgroundColor $i
        Write-Progress -Activity "Search in Progress" -Status "$($i*10)% Complete:" -PercentComplete ($i*10);
    }
}
#Get-PSSession

foreach ( $i in 1..10 ) {
    Write-Progress -Id 0 "Step $i"
    foreach ( $j in 1..10 ) {
      Write-Progress -Id 1 -ParentId 0 "Step $i - Substep $j"
      foreach ( $k in 1..10 ) {
        Write-Progress -Id 2  -ParentId 1 "Step $i - Substep $j - iteration $k"; start-sleep -m 150
      }
    }
  }


get-command get* | Out-GridView -PassThru | ForEach-Object  -Begin {
    Write-Host "Här"

} -Process {
    Write-Host $_.DisplayName
}