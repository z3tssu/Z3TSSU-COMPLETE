$maxLength = 100
Get-ChildItem -Recurse -File | ForEach-Object {
    if ($_.FullName.Length -gt $maxLength) {
        $newName = $_.Name.Substring(0, [Math]::Min(50, $_.Name.Length)) + $_.Extension
        $newPath = Join-Path $_.DirectoryName $newName
        Rename-Item -Path $_.FullName -NewName $newName
        Write-Host "Renamed: $($_.FullName) to $newPath"
    }
}