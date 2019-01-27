
function Format-ValidationOutput {
    [CmdletBinding()]
    param (
        $ValidationOutput,
        [int] $Depth = 0
    )

    process {
        Set-StrictMode -Off
        return @($ValidationOutput | Where-Object { $_ -ne $null } | ForEach-Object { @('  ' * $Depth + ': ' + $_.Message) + @(Format-ValidationOutput @($_.Details) ($Depth + 1)) })
    }

}