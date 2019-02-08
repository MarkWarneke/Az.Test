param(
    $json
)

foreach ($json in $Template) {

    $link = "https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates"

    Describe "The Azure Resource Managers JSON Base Template" {
        $TestCases = @(
            @{
                Expected = "parameters"
            },
            @{
                Expected = "variables"
            },
            @{
                Expected = "resources"
            },
            @{
                Expected = "outputs"
            }
        )

        it "should have property <Expected>" -TestCases $TestCases {
            param(
                $Expected
            )

            $json | Get-Member -MemberType NoteProperty -Name $Expected  | Should -Not -BeNullOrEmpty -Because $link
        }
    }
}
