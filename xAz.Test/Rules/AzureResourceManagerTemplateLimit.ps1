param(
    [json] $TemplateJson
)

describe "Azure Resource Manager Template Limit" {

    $TestCases = @(
        @{
            Type  = "parameters"
            Count = 256
        },
        @{
            Type  = "variables"
            Count = 256
        },
        @{
            Type  = "outputs"
            Count = 64
        },
        @{
            Type  = "resources"
            Count = 800 # including Copy.. nvm
        }
    )

    it "should not exceed <Count> <Type>" -TestCases $TestCases {
        param(
            $Type,
            $Count
        )
        $TemplateJson.$Type.Count | Should -BeLessOrEqual $Count
    }
}
