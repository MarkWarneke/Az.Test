function New-Deployment {
    [CmdletBinding(
        SupportsShouldProcess
    )]
    param (
        $ResourceGroupName,
        $TemplateUri,
        $TemplateParameterObject,
        $ParameterArgs
    )

    begin {
    }

    process {

        Test-xAzTemplateJson $TemplateUri -ErrorAction Stop

        $DeploymentArgs = @{
            ResourceGroupName       = $ResourceGroupName
            TemplateUri             = $TemplateUri
            TemplateParameterObject = $TemplateParameterObject
        }

        <#
            Debug deployment, test expanded template
        #>
        if ($Debug) {
            Write-Verbose "[$(Get-Date)]  Starting debug deployment..."
            $ErrorMessages = Test-xAzDeployment @DeploymentArgs @ParameterArgs
            Format-TestResult $ErrorMessages
        }
        <#
            Actual deployment, logs error details to to shell
        #>
        elseif ($PSCmdlet.ShouldProcess($ComponentName, $ResourceGroupName)) {
            Write-Verbose "[$(Get-Date)]  Starting actual deployment..."

            try {
                $Deployment = New-AzureRmResourceGroupDeployment @DeploymentArgs @ParameterArgs
                $return = Format-xAzOutput $Deployment.Outputs
                $return
            }
            catch {
                Get-xAzError -ResourceGroupName $ResourceGroupName -Exception $_
            }

        }
        <#
            Test deployment, whatif
        #>
        else {
            Write-Verbose "[$(Get-Date)]  Starting test deployment..."
            $return = Test-AzureRmResourceGroupDeployment @DeploymentArgs @ParameterArgs
            $ErrorMessages = Format-ValidationOutput $return
            Format-TestResult $ErrorMessages
        }
    }
}


