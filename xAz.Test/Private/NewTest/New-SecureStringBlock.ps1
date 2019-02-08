
function New-SecureStringBlock {
    [CmdletBinding()]
    param (
        $ParameterSets
    )

    process {
        $SecureValues = $ParameterSets | ForEach-Object {$_.Parameters | Where-Object {$_.ParameterType.Name -eq 'SecureString'} }
        if ($SecureValues.Count -gt 0) {
            $SecureStringBlock = "`r`n`$SecureString = `"P@ssw0rd`" | ConvertTo-SecureString -AsPlainText -Force`r`n"
        }
        else {
            $SecureStringBlock = ''
        }
        return $SecureStringBlock
    }
}
