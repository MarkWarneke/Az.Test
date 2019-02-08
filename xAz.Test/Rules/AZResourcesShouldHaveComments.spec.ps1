param(
    $Template
)

foreach ($json in $Template) {
    if ($json.resources.Count -gt 0) {
        Describe "Azure Resource Manager Resources Property" {
            foreach ($resource in $json.resources) {
                $type = $resource.type
                it "$type should have a property 'comments'" {
                    $resource.comments  | Should -Not -BeNullOrEmpty
                }
            }
        }
    }
    else {
        Write-Warning "[$(Get-Date)] No resources found"
    }

}