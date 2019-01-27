# InstallNotes

## Installing xAz.Test

You can install latest xAz.Test with cloning the git repository and copying it locally.

```PowerShell
git clone  https://github.com/mark-mit-k/Az.Test.git --branch master --single-branch [<folder>]

Copy-Item "Az.Test\xAz.Test" "$HOME\Documents\WindowsPowerShell\Modules" -Recurse # Add force to update
```

## Import and Usage

You can load Az.Test without installing, once installed

``` PowerShell
Import-Module xAz.Test
Get-Command -Module xAz.Test
```

## Build and Test

Run individual tests from folder `.\Az.Test\Test`

```PowerShell
Invoke-Pester .\Az.Test
```

## Uninstall

Depending on your installation you can run

```PowerShell
Remove-Item $HOME\Documents\WindowsPowerShell\Modules\xAz.Test\ -Recurse -Force
```