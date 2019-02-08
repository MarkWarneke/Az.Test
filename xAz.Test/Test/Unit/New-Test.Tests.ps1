. $PSScriptRoot/shared.ps1

Describe "New-Test parameter tests" -Tags Unit {

    Context "Parameter Invalid - Parameter Set: __AllParameterSets" {
        $TestCases = @(
            @{
                Expected = 'FunctionName'
            }
        )
        It "Given and <FunctionName> as FunctionName - should throw an exception containing <Expected>" -TestCases $TestCases {
            param(
                $FunctionName,
                $Expected
            )
            {
                $InputObject = @{
                    FunctionName = $FunctionName
                }
                New-Test @InputObject -WhatIf
            } | Should Throw $Expected
        }
    }
    Context "Parameter valid - Parameter Set: __AllParameterSets" {
        ## Add Mock here. Any function that affects external resources or attempts connection to external services should be mocked

        $TestCases = @(
            @{
                FunctionName = 'testFunction'
            }
        )
        It "Given and <FunctionName> as FunctionName - function should not throw" -TestCases $TestCases {
            param(
                $FunctionName,
                $Expected
            )

            {
                $InputObject = @{
                    FunctionName = $FunctionName
                }
                New-Test @InputObject -WhatIf
            } | Should Not Throw
        }

        ## Add Assert-MockCalled here.
    }
}
