param (
    $Template
)

foreach ($json in $Template) {
    $parametersMembers = $json.parameters | Get-Member -MemberType NoteProperty
    if ($parametersMembers.Count -gt 0 ) {
        Describe "Azure Resource Manager Parameters" {
            foreach ($parameterName in $parametersMembers) {
                $parameterName.Name | Should Be # pascalCase
            }

        }
    }
    else {
        Write-Warning "[$(Get-Date)] No parameters found"
    }

}