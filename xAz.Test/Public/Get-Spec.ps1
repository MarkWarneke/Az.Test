function Get-Spec {
    [CmdletBinding()]
    param (
        [ValidateSet('Static')]
        [string] $Spec
    )
    begin {
        $moduleFileList = $Local:MyInvocation.MyCommand.Module.FileList
        $staticSpecFolder = $moduleFileList[1]
    }

    process {
        switch ($spec) {
            'Static' {
                Write-Verbose -Message ("[$(Get-Date)] load {0}" -f $staticSpecFolder)
                $specs = Get-ChildItem $staticSpecFolder -Recurse
                foreach ($file in $specs) {
                    $name = ($file.Name).replace($file.Extension, '').replace('.spec', '')

                    [PSCustomObject]@{
                        Name = $name
                        Path = $file.FullName
                    }
                }

                break
            }
            Default {}
        }

    }


}