param (
    $template
)

foreach ($json in $template) {
    Describe "Azure Resource Manager Templates" {
        it "should have content" {
            $json | Should -Not -BeNullOrEmpty
        }
    }
}