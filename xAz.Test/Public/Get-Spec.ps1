function Get-Spec {
    [CmdletBinding()]
    param (
        [ValidateSet('Static')]
        [string] $Spec
    )
    begin {
        $staticSpecFolder = Get-FileList -Type rules
    }

    process {
        switch ($spec) {
            'Static' {
                Write-Verbose -Message ("[$(Get-Date)] load {0}" -f $staticSpecFolder)
                $specs = Get-ChildItem $staticSpecFolder -Recurse -Include '*.spec.ps1'
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