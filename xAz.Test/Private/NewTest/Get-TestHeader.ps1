function Get-TestHeader {
    [CmdletBinding()]
    param (

    )

    begin {
    }

    process {
        return @"
        . `$PSScriptRoot/shared.ps1

        $SecureStringBlock
        Describe "$FunctionName parameter tests" -Tags Unit {
            $ContextBlock
        }
        $IntegrationBlock
        $PrivateBlock
"@
    }

    end {
    }
}