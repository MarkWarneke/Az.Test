function New-IntegrationBlock {
    [CmdletBinding()]
    param (
        $FunctionName
    )

    process {
        [string]$Block = [string]::Empty

        $Block += @"

        Describe "$FunctionName integration tests" -Tags Build {

            BeforeAll{
                # Create test environment
                `$ResourceGroupName = 'MR-BDAP-TT-' + (Get-Date -Format FileDateTimeUniversal)
                Write-Host 'Creating test environment...'
                Get-AzureRmResourceGroup -Name `$ResourceGroupName | Remove-AzureRmResourceGroup -Force
                `$null = New-AzureRmResourceGroup -Name `$ResourceGroupName -Location 'WestEurope'
            }
            AfterAll{
                # Remove test environment
                Write-Host 'Removing test environment...'
                Get-AzureRmResourceGroup -Name `$ResourceGroupName | Remove-AzureRmResourceGroup -Force
            }

            Context ""{ # Add Context description
                It ""{ # Add Test description
                    # Add test
                }
            }
        }
"@

        return $Block
    }
}