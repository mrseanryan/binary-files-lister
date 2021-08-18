param([string][Parameter(Mandatory=$True)] [ValidateNotNull()] $dirPath)

Write-Output("File name, Size in Kb, Version")

foreach ($file in (Get-ChildItem $dirPath | Where-Object {$_.extension -in ".dll", ".exe"} )) {
    $sizeInKb = [math]::Round($file.length/1KB)
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file.FullName).FileVersion
    Write-Output($file.name + ", " + $sizeInKb + ", " + $version)
}
