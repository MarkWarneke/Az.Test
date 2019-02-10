param (
    $Template
)

$TextInfo = (Get-Culture).TextInfo

foreach ($json in $Template) {
    $parametersMembers = $json.parameters | Get-Member -MemberType NoteProperty
    if ($parametersMembers.Count -gt 0 ) {
        Describe "Azure Resource Manager Parameters" {
            foreach ($parameterName in $parametersMembers) {
                $titleCase = $TextInfo.ToTitleCase($parameterName.Name)
                $pascalCase = $titleCase[0].ToLower()
                $parameterName.Name | Should -BeExactly $pascalCase
            }

        }
    }
    else {
        Write-Warning "[$(Get-Date)] No parameters found"
    }

}