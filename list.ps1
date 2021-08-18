param(
    [string] $dirPath,
    [string] $option1,
    [string] $option2
)

if (-not $dirPath) {
    Write-Output("USAGE: list.ps1 <path to directory> [OPTIONS]")
    Write-Output("  OPTIONS:")
    Write-Output("  dependencies - Also show the .NET dependencies")
    Write-Output("  filter - Filter to filenames that contain the given text")
    Exit
}

# TODO use proper options like with '-' prefix

function ProcessFilterByNameOption($value) {
    if ($value.StartsWith("filter=")) {
        return  $value.Split("=")[1]
    }
    return $null
}

function ProcessDependenciesOption($value) {
    Write-Verbose("'$value'") # TODO why is this needed?
    $test = $value -eq "dependencies"
    return $test
}

$doDependencies = ProcessDependenciesOption($option1)
if (-not $doDependencies) {
    $doDependencies = ProcessDependenciesOption($option2)
}

$filterByName = ProcessFilterByNameOption($option1)
if (-not $filterByName) {
    $filterByName = ProcessFilterByNameOption($option2)
}

if ($doDependencies) {
    Write-Verbose("Also outputting dependencies")
}
if ($filterByName) {
    Write-Verbose("Filtering to filenames like '$filterByName'")
}

Write-Output("File name, Size in Kb, Version")

function Write-File-Details {
    param (
        $file
    )

    $sizeInKb = [math]::Round($file.length / 1KB)
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file.FullName).FileVersion

    Write-Output($file.name + ", " + $sizeInKb + ", " + $version)
}

foreach ($file in (Get-ChildItem $dirPath | Where-Object { $_.extension -in (".dll", ".exe") -and (($null -eq $filterByName) -or ($_.Name.Contains($filterByName))) } )) {
    Write-File-Details($file)

    if ($doDependencies) {
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
}