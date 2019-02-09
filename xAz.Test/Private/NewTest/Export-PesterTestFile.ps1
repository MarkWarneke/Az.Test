
function Export-PesterTestFile {
    [CmdletBinding()]
    param (
        $OutputPath,
        $Function,
        $FunctionName,
        $ModuleName,
        $UnitTest,
        $IntegrationTest = $false
    )

    process {
        If ([String]::IsNullOrEmpty($OutputPath)) {

            # Make prefix accessable
            $baseDirectory = Split-Path -Parent $Function.Module.Path
            Import-LocalizedData -BaseDirectory $baseDirectory -FileName "$ModuleName.psd1" -BindingVariable Data

            # Build function name without prefix
            $functionParts = $FunctionName.Split('-');
            $prefixLessMethodName = $functionParts[1].Replace($Data.DefaultCommandPrefix, "")
            $fileName = ("{0}{1}{2}{3}" -f $functionParts[0], "-", $prefixLessMethodName, ".Tests.ps1")

            $subfolder = 'Unit'
            if ($IntegrationTest) {
                $subfolder = 'Integration'
            }
            # Set path
            $OutputPath = "$baseDirectory\Test\$subfolder\$fileName"
        }

        $OutputPathParent = Split-Path $OutputPath -Parent
        if (-Not (Test-Path $OutputPathParent)) {
            $null = New-Item -ItemType Directory -Path $OutputPathParent
        }

        $sharedExist = Get-ChildItem $OutputPathParent -Filter 'shared.ps1'
        if (-Not $sharedExist) {
            Get-Shared | Out-File (Join-Path $OutputPathParent 'shared.ps1') -Force
        }

        $UnitTest = $UnitTest.Replace('''$SecureString''', '$SecureString')
        $UnitTest | Out-File $OutputPath -Force
    }
}