
function New-DescriptionBlock {
    [CmdletBinding()]
    param (
        $Parameters
    )

    process {
        [string]$Block = [string]::Empty
        $n = $Parameters.Count
        For ($i = 0; $i -lt $n; $i++) {
            if ($i -lt $n - 1) {
                $Block += "<$($Parameters[$i].Name)> as $($Parameters[$i].Name), "
            }
            else {
                $Block += "and <$($Parameters[$i].Name)> as $($Parameters[$i].Name)"
            }
        }

        return $Block
    }
}