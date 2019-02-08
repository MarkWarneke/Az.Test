param(
    $Template
)

foreach ($json in $Template) {
    if ($json.resources.Count -gt 0) {
        Describe "The Azure Resource Managers Property Resources Structure" {
            foreach ($resource in $json.resources) {
                it "$($resource.type) should have the ordered properties `n comment > type > apiVersion > name > properties" {
                    "$resource" | Should -BeLike "*comments*type*apiVersion*name*properties*"
                }
            }
        }
    }
    else {
        Write-Warning "[$(Get-Date)] No resources found"
    }

}