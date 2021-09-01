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

### Allowing execution of PowerShell scripts

If you see an error similar to this:

```
list.ps1 cannot be loaded because running scripts is disabled
on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170
```

Then you need to adjust the security settings on your machine, to be able to execute PowerShell scripts.

To simply allow the current user to execute ANY local PowerShell script, execute the following PowerShell code:

```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```
