function New-InputObjectBlock {
    [CmdletBinding()]
    param (
        $Parameters
    )

    process {
        [string]$Block = [string]::Empty
        $n = $Parameters.Count
        For ($i = 0; $i -lt $n; $i++) {
            if ($i -lt $n - 1) {
                $Block += "$($Parameters[$i].Name) = `$$($Parameters[$i].Name)`r`n"
            }
            else {
                $Block += "$($Parameters[$i].Name) = `$$($Parameters[$i].Name)"
            }
        }

        return $Block
    }
}
