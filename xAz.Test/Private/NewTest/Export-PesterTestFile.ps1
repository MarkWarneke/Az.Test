
function Export-PesterTestFile {
    [CmdletBinding()]
    param (
        $OutputPath,
        $Function,
        $FunctionName,
        $ModuleName,
        $UnitTest
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

            # Set path
            $OutputPath = "$baseDirectory\Test\$fileName"
        }
        $UnitTest = $UnitTest.Replace('''$SecureString''', '$SecureString')
        $UnitTest | Out-File $OutputPath -Force
    }
}