param(
    $Template
)

foreach ($json in $Template) {


    Describe "Azure Resource Manager Template Limit" {

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

            $BaseType = (($json.$Type).getType()).BaseType
            if ( $BaseType -eq 'System.Array') {
                $objects = $Json.$Type
            }
            else {
                $objects = ($json.$Type) | Get-Member -MemberType NoteProperty
            }

            $objects.Count | Should -BeLessOrEqual $Count
        }
    }
}
