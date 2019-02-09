function Get-Shared {
    [CmdletBinding()]
    param (

    )

    process {
        return Get-Content -Path (Get-FileList -Type shared) -Raw
    }
}