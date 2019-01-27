
function Test-Deployment {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullorEmpty()]
        [object]
        $TemplateUri,

        [Parameter(Mandatory)]
        [ValidateNotNullorEmpty()]
        [HashTable]
        $templateParameterObject,

        [Parameter(Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]
        $ResourceGroupName,

        $DeploymentParameter
    )
    begin {
        $_debugpreference = $debugpreference
        $debugpreference = "Continue"
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
        $debugpreference = $_debugpreference
    }
}