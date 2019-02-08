function Get-TestValue {
    [CmdletBinding()]
    param (
        $Parameters,
        $Table
    )

    process {
        Foreach ($Parameter in $Parameters) {

            if (-Not ($Table.$($Parameter.Name))) {

                if ($Parameter.ParameterType.Name -eq 'SecureString') {
                    $Table | Add-Member -MemberType NoteProperty -Name $Parameter.Name -Value '$SecureString'
                }
                else {
                    $ans = [string]::Empty
                    $ans = Read-Host -Prompt "$($Parameter.Name)"
                    $Table | Add-Member -MemberType NoteProperty -Name $Parameter.Name -Value $ans
                }
            }
        }
        return $Table
    }
}