function New-IntegrationBlock {
    [CmdletBinding()]
    param (
        $FunctionName
    )

    process {
        [string]$Block = [string]::Empty
        $Block = Get-Content -Path (Get-FileList -Type Integration) -Raw
        
        return "$Block"
    }
}