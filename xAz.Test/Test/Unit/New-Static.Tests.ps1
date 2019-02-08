[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Test needs to display  executed folder")]
param(
    $templatesFolder
)

. $PSScriptRoot/shared.ps1

Describe "Should work" {

    $TestFolder = Split-Path $PSScriptRoot -Parent
    $StaticFolder = Join-Path $TestFolder 'Static'
    $templatesFolder = Get-ChildItem $StaticFolder
    foreach ($folder in $templatesFolder) {
        $ArmTemplatePath = Get-ChildItem -Path $folder.FullName -Filter 'azuredeploy.json'

        Write-Host ("Testing {0}" -f $ArmTemplatePath.FullName) -ForegroundColor DarkGreen
        Test-xAzStatic -TemplateUri $ArmTemplatePath.FullName -IncludeDefaultSpecs
    }

}