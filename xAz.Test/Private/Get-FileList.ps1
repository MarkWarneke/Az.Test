function Get-FileList {
    [CmdletBinding()]
    param (
        [ValidateSet('shared', 'rules', 'integration')]
        [string]$Type
    )

    begin {
        $moduleFileList = $Local:MyInvocation.MyCommand.Module.FileList
    }

    process {
        switch ($Type) {
            'rules' { $moduleFileList[0]; break }
            'shared' { $moduleFileList[1]; break }
            'integration' { $moduleFileList[2]; break }
            Default {}
        }
    }

    end {
    }
}