

function New-ParamBlock {
    [CmdletBinding()]
    param (
        $Parameters
    )

    process {
        [string]$Block = [string]::Empty
        $n = $Parameters.Count
        For ($i = 0; $i -lt $n; $i++) {
            $Block += "`$$($Parameters[$i].Name),`r`n"
        }
        $Block += "`$Expected"

        return $Block
    }
}