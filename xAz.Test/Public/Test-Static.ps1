function Test-Static {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Test needs to display  executed folder")]
    [CmdletBinding()]
    param (
        # Link to the Template
        [Parameter(
            Mandatory,
            Position = 0
        )]
        [string] $TemplateUri,
        [switch] $IncludeDefaultSpecs
    )

    begin {
    }

    process {

        $null = Test-Path $TemplateUri -ErrorAction Stop

        try {
            $text = Get-Content $TemplateUri -Raw -ErrorAction Stop
        }
        catch {
            Write-Host "$($_.Exception) found"
            Write-Host "$($_.ScriptStackTrace)"
            break
        }

        try {
            $json = ConvertFrom-Json $text -ErrorAction Stop
        }
        catch {
            $JsonException = $_
        }

        Describe "Azure Resource Manager Template Files" {
            it "should be valid json" {
                $JsonException | Should -BeNullOrEmpty
                if ($JsonException) {
                    break
                }
            }
        }

        if ($IncludeDefaultSpecs) {
            $Spec += Get-xAzSpec -Spec Static
        }

        foreach ($specification in $Spec) {
            Write-Host ("`n Test Specification [{0}]" -f $specification.Name) -ForegroundColor DarkGreen
            . $specification.Path -Template $json
        }

    }
}