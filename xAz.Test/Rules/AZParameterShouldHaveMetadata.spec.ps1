param(
    $template
)

foreach ($json in $template) {
    $parameterMembers = $json.parameters | Get-Member -MemberType NoteProperty
    if ($parameterMembers.Count -gt 0 ) {
        Describe "Azure Resource Manager Parameters" {
            foreach ($parameterName in $parametersMembers) {
                it "$($json.parameters.($parameterName.Name).type) should have metadata" {
                    $json.parameters.($parameterName.Name).metadata | Should -Not -BeNullOrEmpty
                }
            }
        }
    }
    else {
        Write-Warning "[$(Get-Date)] No parameters found"
    }

}
