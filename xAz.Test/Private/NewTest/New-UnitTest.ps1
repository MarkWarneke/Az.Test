
function New-UnitTest {
    [CmdletBinding()]
    param (
        $ModuleName,
        $FunctionName,
        $SecureStringBlock,
        $ContextBlock,
        $IntegrationBlock,
        $PrivateBlock
    )

    process {
        $UnitTest = Get-TestHeader
        return $UnitTest
    }
}
