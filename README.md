# binary-files-lister

:zap: PowerShell script that lists binary files at the given directory path.

## Dependencies

- OS = Windows
- PowerShell

## Usage

### To view help:

```
.\list.ps1
```

Output:

```
USAGE: list.ps1 <path to directory> [OPTIONS]
  OPTIONS:
  dependencies - Also show the .NET dependencies
  filter - Filter to filenames that contain the given text
```

### Basic usage:

```
.\list.ps1 c:\my-directory
```

### With options:

```
.\list.ps1 c:\my-directory filter=MyCompany dependencies
```

## Example output

```
File name, Size in Kb, Version
aadauthhelper.dll, 458, 10.0.19041.1151 (WinBuild.160101.0800)
aadcloudap.dll, 992, 10.0.19041.1151 (WinBuild.160101.0800)
aadjcsp.dll, 100, 10.0.19041.1081 (WinBuild.160101.0800)
aadtb.dll, 1398, 10.0.19041.1110 (WinBuild.160101.0800)
```
