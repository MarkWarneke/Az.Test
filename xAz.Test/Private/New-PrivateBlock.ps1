
function New-PrivateBlock {
    [CmdletBinding()]
    param (
        $FunctionName,
        $ModuleName
    )

    process {
        [string]$Block = [string]::Empty

        $Block += @"

        Describe "$FunctionName tests - Private functions" -Tags Unit { # Change tag if necessary

            InModuleScope $ModuleName {
                Context ""{ # Add Context description
                    It ""{ # Add Test description
                        # Add test
                    }
                }
            }
        }
"@

        return $Block
    }

}