function Test-Folder {
    [CmdletBinding()]
    param (
        # Path to ARM template
        [Parameter(Mandatory)]
        [string]
        $Path
    )
    
    begin {
    }
    
    process {
        $item = Get-ChildItem $Path

        $MandatoryFiles = @('azuredeploy.json', 'azuredeploy.parameters.json', 'metadata.json', 'README.md')
        $OptionalFolders = @('nestedtemplates', 'scripts')

        $item 
    }
    
    end {
    }
}