param(
    [json] $TemplateJson
)

$link = "https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates"

Describe "Azure Resource Manager Template $TemplateJson Simple Structure" {
    $TestCases = @(
        @{
            Required = $true
            Expected = '$schema'
        },
        @{
            Required = $true
            Expected = "contentVersion"
        },
        @{
            Required = $false
            Expected = "parameters"
        },
        @{
            Required = $false
            Expected = "variables"
        },
        @{
            Required = $true
            Expected = "resources"
        },
        @{
            Required = $false
            Expected = "outputs"
        }
    )

    it "should have <Expected>" -TestCases $TestCases {
        param(
            $Required,
            $Expected
        )

        if ($Required) {
            $TemplateJson.$Expected | Should -Not -BeNullOrEmpty
        }
        else {
            if ($TemplateJson.$Expected) {
                $TemplateJson.$Expected | Should -Not -BeNullOrEmpty
            }
            else {
                Write-Warning -Message "$Expected not found, consider adding"
            }
        }

    }
}
