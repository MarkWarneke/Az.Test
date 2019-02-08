function Get-FunctionType {
    [CmdletBinding()]
    param (
        $Function
    )

    process {
        if ($Function.CmdletBinding -eq $false) {
            Write-Warning "Function $FunctionName is not an advanced function, the 'Parameter Valid' tests can not be performed and will not be generated"
            return $false
        }
        else {
            return $true
        }
    }

}
