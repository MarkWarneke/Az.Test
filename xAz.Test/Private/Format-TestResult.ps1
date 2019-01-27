
function Format-TestResult {
    [CmdletBinding()]
    param (
        $ErrorMessages
    )
    process {
        if ($ErrorMessages) {
            Write-Output '', 'Validation returned the following errors:', @($ErrorMessages), '', 'Template is invalid.'
        }
        else {
            Write-Output '', 'Template is valid.'
        }
    }
}