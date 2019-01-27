
function Get-Error {
    [CmdletBinding()]
    param (
        $ResourceGroupName,
        $Exception
    )
    process {
        try {
            $correlationId = ((Get-AzureRMLog -ResourceGroupName $ResourceGroupName)[0]).CorrelationId
            $logentry = (Get-AzureRMLog -CorrelationId $correlationId -DetailedOutput)

            #$logentry
            $rawStatusMessage = $logentry.Properties
            $status = $rawStatusMessage.Content.statusMessage | ConvertFrom-Json
            $return = @{
                CorrelationId       = $correlationId
                Status              = $status
                ErrorDetails        = $status.error.details
                ErrorDetailsDetails = $status.error.details.details
                Exception           = $Exception
                ScriptStackTrace    = $Exception.ScriptStackTrace
            }
            $return
        }
        catch {
            Write-Verbose"$($Exception) found"
            Write-Verbose "$($Exception.ScriptStackTrace)"

            Write-Error "$($_.Exception) found"
            Write-Verbose "$($_.ScriptStackTrace)"
            throw $_
        }
    }
}