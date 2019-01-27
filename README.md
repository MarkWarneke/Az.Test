# Az.Test

Testing Framework for Azure Resource Manager Templates (ARM-Templates). Infrastructure as code. PowerShell Core native

The module supports Azure Resource Manager Tempalte testing.

See [Examples](Examples):

```PowerShell
Import-Module .\xAz.Test\xAz.Test.psd1
Get-Command -Module xAz.Test

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Format-xAzOutput                                   0.0.1      xAz.Test
Function        Get-xAzDocs                                        0.0.1      xAz.Test
Function        Get-xAzError                                       0.0.1      xAz.Test
Function        Get-xAzFullSyntax                                  0.0.1      xAz.Test
Function        Get-xAzGuide                                       0.0.1      xAz.Test
Function        Get-xAzReference                                   0.0.1      xAz.Test
Function        Get-xAzRemoteTemplate                              0.0.1      xAz.Test
Function        Get-xAzSchema                                      0.0.1      xAz.Test
Function        Get-xAzSchemaUri                                   0.0.1      xAz.Test
Function        New-xAzDeployment                                  0.0.1      xAz.Test
Function        Test-xAzDeployment                                 0.0.1      xAz.Test
Function        Test-xAzFolder                                     0.0.1      xAz.Test
Function        Test-xAzStatic                                     0.0.1      xAz.Test
Function        Test-xAzTemplateJson                               0.0.1      xAz.Test
```

## Documentation

- [Documentation](xAz.Test/docs/en-US)
- [Examples](Examples)
- [Installation Notes](xAz.Test/docs/en-US/InstallNotes.md)
- [Release Notes](xAz.Test/docs/en-US/ReleaseNotes.md)
- TBD: [Wiki](https://github.com/mark-mit-k/Az.Test/wiki)

## Dependencies

xAz.Test Module

- [Pester](https://github.com/Pester/Pester)
- [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)

### Build

for clean Build additionally [PSake](https://github.com/psake/psake)

## Code of Conduct

This is a personal repository by [mark-mit-k](https://github.com/mark-mit-k). Microsoft is **NOT** maintaining this repository, we stick to the [code of conduct](https://microsoft.github.io/codeofconduct/)

## Contact

- twitter: [@mark_mit_k_](https://twitter.com/mark_mit_k_)
- github: [mark-mit-k](https://github.com/mark-mit-k)