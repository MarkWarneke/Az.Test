        . $PSScriptRoot/shared.ps1

        
        Describe "Get-xAzSpec parameter tests" -Tags Unit {
            
        }
        Describe "$FunctionName integration tests" -Tags Build {

    BeforeAll {
        # Create test environment
        `$ResourceGroupName = 'TT-' + (Get-Date -Format FileDateTimeUniversal)
        Write-Host 'Creating test environment...'
        Get-AzureRmResourceGroup -Name `$ResourceGroupName | Remove-AzureRmResourceGroup -Force
        `$null = New-AzureRmResourceGroup -Name `$ResourceGroupName -Location 'WestEurope'
    }
    AfterAll {
        # Remove test environment
        Write-Host 'Removing test environment...'
        Get-AzureRmResourceGroup -Name `$ResourceGroupName | Remove-AzureRmResourceGroup -Force
    }

    Context "" { # Add Context description
        It "" { # Add Test description
            # Add test
        }
    }
}
        
