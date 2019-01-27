function Format-Output {
    <#
        .SYNOPSIS
            Takes Outputs from Arm Template deployment and generates a pscustomobject.

        .NOTES
            Outputs is Dictionary`2  needs enumerator
            Output value has odd value key again -> $output.Value.Value

            [DBG]: PS C:\> $output

            Key              Value
            ---              -----
            virtualMachineId Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.DeploymentVariable

            [DBG]: PS C:\> $output.Value

            Type   Value
            ----   -----
            String /subscriptions/<Subscription>/resourceGroups/<ResourceGroup>/providers/<Provider>/<ResourceType>/<ResourceName>

            $output.value.value
    #>
    [CmdletBinding()]
    param(
        $Outputs
    )

    if (-Not $Outputs) {
        Write-Error "[$(Get-Date)] Deployment output can not be parsed ´n $Deployment"
        return
    }
    else {
        try {
            $return = [PSCustomObject]@{}
            $enum = $Outputs.GetEnumerator()

            while ($enum.MoveNext()) {
                $current = $enum.Current
                $return | Add-Member -MemberType NoteProperty -Name $current.Key -Value $current.Value.Value
            }
            $return
        }
        catch {
            Write-Verbose "[$(Get-Date)] Unable to parse"
            return $Outputs
        }
    }
}