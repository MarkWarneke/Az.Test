
function Test-Deployment {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullorEmpty()]
        [Alias('TemplatePath')]
        [object]
        $TemplateUri,

        [Parameter(Mandatory)]
        [ValidateNotNullorEmpty()]
        [HashTable]
        $templateParameterObject,

        [string]
        $ResourceGroupName,

        $DeploymentParameter,

        [string] $Location = 'westeurope'
    )
    begin {
        $_debugpreference = $debugpreference
        $debugpreference = "Continue"
        $RESOURCE_GROUP_NAME = 'TEST_'

        if (-Not $ResourceGroupName) {
            # Cleanup
            $AskToRemove = $true
            # Create unique ResourceGroupName based on current datetime
            $TestDateTime = Get-Date -Format FileDateTime
            $ResourceGroupName = '{0}{1}' -f $RESOURCE_GROUP_NAME, $TestDateTime
            $null = New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location
        }
    }

    process {
        $InputObject = @{
            ResourceGroupName       = $ResourceGroupName
            TemplateUri             = $TemplateUri
            TemplateParameterObject = $TemplateParameterObject
            DeploymentParameter     = $DeploymentParameter
        }

        try {
            $rawResponse = Test-AzureRmResourceGroupDeployment @InputObject @DeploymentParameter 5>&1 # 5>&1 Move debug stream to output
            $deploymentOutput = ($rawResponse.Item(32) -split 'Body:' | Select-Object -Skip 1 | ConvertFrom-Json).properties

            $deploymentOutput
        }
        catch {
            Write-Error "$($_.Exception) found"
            Write-Verbose "$($_.ScriptStackTrace)"
        }
    }

    end {
        # Don't remove on error to trace..
        if ($AskToRemove -or $ENV:BUILD_SERVER) {
            Get-AzureRmResourceGroup -Name $ResourceGroupName | Remove-AzureRmResourceGroup -Force
        }

        $debugpreference = $_debugpreference
    }
}