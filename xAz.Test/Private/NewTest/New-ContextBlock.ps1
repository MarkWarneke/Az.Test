function New-ContextBlock {
    [CmdletBinding()]
    param (
        $Set,
        $TestCasesBlockInvalid,
        $DescriptionBlock,
        $ParamBlock,
        $InputObjectBlock,
        $TestCasesBlockValid,
        $FunctionName,
        $AddValid
    )

    process {
        [string]$Block = [string]::Empty

        $Block += @"

        Context "Parameter Invalid - Parameter Set: $($Set.Name)" {
            `$TestCases = @(
                $TestCasesBlockInvalid
            )
            It "Given $DescriptionBlock - should throw an exception containing <Expected>" -TestCases `$TestCases {
                param(
                    $ParamBlock
                )
                {
                    `$InputObject = @{
                        $InputObjectBlock
                    }
                    $FunctionName @InputObject -WhatIf
                } | Should Throw `$Expected
            }
        }
"@

        if ($AddValid) {
            $Block += @"

            Context "Parameter valid - Parameter Set: $($Set.Name)" {
            ## Add Mock here. Any function that affects external resources or attempts connection to external services should be mocked

            `$TestCases = @(
                $TestCasesBlockValid
            )
            It "Given $DescriptionBlock - function should not throw" -TestCases `$TestCases {
                param(
                    $ParamBlock
                )

                {
                `$InputObject = @{
                        $InputObjectBlock
                }
                $FunctionName @InputObject -WhatIf
                } | Should Not Throw
            }

            ## Add Assert-MockCalled here.
        }
"@
        }

        return $Block
    }
}
