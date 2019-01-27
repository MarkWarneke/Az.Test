
function Get-RemoteTemplate {
    [CmdletBinding()]
    param (
        $TemplateUri
    )

    process {
        try {
            $TemplateFile = (Invoke-WebRequest -Uri $TemplateUri).RawContent
            $TemplateFile
        }
        catch {
            Write-Verbose "Unable to download file"
            Write-Error "$($_.Exception) found"
            Write-Verbose "$($_.ScriptStackTrace)"
            throw $_
        }
    }
}


