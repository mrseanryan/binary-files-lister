param([string][Parameter(Mandatory=$True)] [ValidateNotNull()] $dirPath)

# TODO
#
# Directory-/File-name      File Size (KB)       Origin    OSS/Commercial/Internally Developed
# modeler/Mendix.CommandLine.Shared.dll           16           NL/Neutral/US           Internally Developed

Write-Output("File name, Size in Kb, Version")

foreach ($file in (Get-ChildItem $dirPath | Where-Object {$_.extension -in ".dll"} )) {
    $sizeInKb = [math]::Round($file.length/1KB)
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file.FullName).FileVersion
    Write-Output($file.name + ", " + $sizeInKb + ", " + $version)
}
