param([string][Parameter(Mandatory = $True)] [ValidateNotNull()] $dirPath)

Write-Output("File name, Size in Kb, Version")

function Write-File-Details {
    param (
        $file
    )

    $sizeInKb = [math]::Round($file.length / 1KB)
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file.FullName).FileVersion

    Write-Output($file.name + ", " + $sizeInKb + ", " + $version)
}

# xxx option -filter "MyDllPrefix"
foreach ($file in (Get-ChildItem $dirPath | Where-Object { $_.extension -in ".dll", ".exe" } )) {
    Write-File-Details($file)

    # xxx make option -dependencies
    try {
        $loadedNetAssembly = [System.Reflection.Assembly]::LoadFrom($file.FullName)
        foreach ($asm in $loadedNetAssembly.GetReferencedAssemblies()) {
            Write-Output(" -> $asm") # note: outputting detais of dependencies is not easy (location can be in GAC...)
        }
    }
    catch [BadImageFormatException] {
        # Is not a .NET assembly
    }
}