function New-TestCasesBlock {
    [CmdletBinding()]
    param (
        $Parameters,
        $TestValues,
        $Table,
        [Parameter(
            Mandatory = $true
        )]
        [ValidateSet("Invalid", "Valid")]
        [string]$Context
    )

    process {
        if ($Context -eq 'Invalid') {
            [string]$Block = [string]::Empty
            $n = $Parameters.Count
            For ($i = 0; $i -lt $n; $i++) {
                $Block += "@{`r`n"
                for ($j = 0; $j -lt $n; $j++) {
                    if ($i -eq $j) {
                        #$Block += "$($Parameters[$j].Name) = ''`r`n"
                        $Expected = $Parameters[$j].Name
                    }
                    else {
                        if ($TestValues -eq $true) {
                            $TestValue = '''' + $Table.$($Parameters[$j].Name) + ''''
                        }
                        else {

                            Switch -Wildcard ($Parameters[$j].ParameterType.Name) {
                                'SecureString' {$TestValue = '$SecureString'; break}
                                'Nullable*' {$TestValue = '1'; break}
                                'Array' {$TestValue = '@("item1","item2")'; break}
                                'Hashtable' {$TestValue = '@{item = ''value''}'; break}
                                'int*' {$TestValue = '1'; Write-Warning "Parameter $($Parameters[$j].Name) is defined as an $($Parameters[$j].ParameterType.Name). Integer parameter default value is 0 so the parameter validation will not throw (null value is converted into 0, a valid parameter). Please use [Nullable[int]] as a ParameterType for mandatory integer parameters." ; break}
                                default {$TestValue = '''TestValue'''; break}
                            }
                        }
                        $Block += "$($Parameters[$j].Name) = $TestValue`r`n"
                    }
                }
                $Block += "Expected = '$Expected'`r`n"
                if ($i -lt $n - 1) {
                    $Block += "},`r`n"
                }
                else {
                    $Block += "}"
                }
            }

            return $Block
        }
        elseif ($Context -eq 'Valid') {
            [string]$Block = [string]::Empty
            $n = $Parameters.Count
            $Block += "@{`n"
            For ($i = 0; $i -lt $n; $i++) {
                if ( [string]::IsNullOrEmpty( $Table.$($Parameters[$i].Name ) ) ) {
                    Switch -Wildcard ($Parameters[$i].ParameterType.Name) {
                        'SecureString' {$TestValue = '$SecureString'; break}
                        'Nullable*' {$TestValue = '1'; break}
                        'Array' {$TestValue = '@("item1","item2")'; break}
                        'Hashtable' {$TestValue = '@{item = ''value''}'; break}
                        'int*' {$TestValue = '1'; Write-Warning "Parameter $($Parameters[$j].Name) is defined as an $($Parameters[$j].ParameterType.Name). Integer parameter default value is 0 so the parameter validation will not throw (null value is converted into 0, a valid parameter). Please use [Nullable[int]] as a ParameterType for mandatory integer parameters." ; break}
                        default {$TestValue = '''TestValue'''; break}
                    }
                }
                else {
                    $TestValue = '''' + $Table.$($Parameters[$i].Name) + ''''
                }
                $Block += "$($Parameters[$i].Name) =  $TestValue`r`n"
            }
            $Block += "}"
            return $Block
        }
    }
}