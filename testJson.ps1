$jsonStr = '{persons:[{name:"Daniel", sn:"Ahlinder"},
{name:"Nisse", sn:"Hult"}]}'

$jsonObj = $jsonStr | ConvertFrom-Json

$jsonObj.persons | ForEach-Object {$_|Format-List}

$jsonObj.persons.Length

Write-Host "length $($jsonObj.persons.Length)"