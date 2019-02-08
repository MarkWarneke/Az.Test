function Get-ModuleName {
    [CmdletBinding()]
    [Outputtype('String')]
    param (
        $Function
    )

    process {
        $ModuleName = $Function.Module.Name
        if ([string]::IsNullOrEmpty($ModuleName)) {
            $ModuleName = $Function.Name
        }
        $ModuleName
    }
}