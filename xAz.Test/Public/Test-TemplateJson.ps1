function Test-TemplateJson {
    [CmdletBinding()]
    param (
        $TemplateUri
    )

    process {
        if (Test-Uri $TemplateUri) {
            Write-Verbose "[$(Get-Date)] Url found, attempting download"
            $TemplateFile = Get-RemoteTemplate $TemplateUri -ErrorAction Stop
        }
        elseif (-Not (Test-Path $TemplateUri)) {
            throw "No file $TemplateUri found"
        }
        else {
            $TemplateFile = $TemplateUri
        }

        $TemplateJSON = Get-Content $TemplateFile -Raw | ConvertFrom-Json -ErrorAction Stop
        Write-Verbose "[$(Get-Date)]  Template $TemplateJSON valid";
    }

}