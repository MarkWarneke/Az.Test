Function New-Test {
    <#
.SYNOPSIS
Creates a Pester unit test file.

.DESCRIPTION
Creates a Pester unit test file with standard structure and unit tests for parameter validation, including parameter invalid and valid.

.PARAMETER FunctionName
Name of the tested function. The function must be in memory.

.PARAMETER OutputPath
Path where the test file will be saved. If not specified, the path and the file name will be generated automatically.

.PARAMETER TestValues
Prompts for a test value for each mandatory parameter.
If not enabled, all values will be equal to 'TestValue' if of string type, or other values according to their type

.PARAMETER TestPrivateFunction
Adds a Describe block for testing private functions referenced by the tested public function

.EXAMPLE
New-Test -FunctionName 'Write-Hello'

Generates a Pester test for the Write-Hello function.
Test values are auto-generated.
File is saved in modules root folder .\Test\Write-Hello.Tests.ps1

.EXAMPLE
New-Test -FunctionName 'Write-Hello' -TestValues

Generates a Pester test for the Write-Hello function.
User is prompted for test values.
File is saved in modules root folder .\Test\Write-Hello.Tests.ps1

.EXAMPLE
New-Test -FunctionName 'Write-Hello' -OutputPath C:\Temp\Write-Hello.Tests.ps1

Generates a Pester test for the Write-Hello function.
Test values are auto-generated.
File is saved in C:\Temp\Write-Hello.Tests.ps1

.EXAMPLE
New-Test -FunctionName 'Write-Hello' -TestPrivateFunction

Generates a Pester test for the Write-Hello function.
Test values are auto-generated.
File is saved in .\Test\Write-Hello.Tests.ps1
A Describe block for testing private functions referenced in the tested public function is generated.

.NOTES
AUthor Lahiri Cristofori

#>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        PositionalBinding = $true,
        DefaultParameterSetName = "Default"
    )]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            Position = 0
        )]
        [String]$FunctionName,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true,
            Position = 1
        )]
        [string]$OutputPath,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $false,
            Position = 2
        )]
        [switch]$TestValues,

        [Parameter(
            Mandatory = $false,
            Position = 3
        )]
        [switch]$IntegrationTest = $false,

        [Parameter(
            Mandatory = $false,
            Position = 4
        )]
        [switch]$TestPrivateFunction
    )

    begin {}

    process {

        $Table = New-Object System.Object
        $ContextBlock = [string]::Empty

        $Function = Get-Command $FunctionName
        $AddValid = Get-FunctionType -Function $Function
        $ModuleName = Get-ModuleName -Function $Function

        $ParameterSets = $Function.ParameterSets
        $SecureStringBlock = New-SecureStringBlock -ParameterSets $ParameterSets

        if ($PSCmdlet.ShouldProcess("Test Cases", "Generate")) {
            Write-Verbose "[$FunctionName] $($ParameterSets.Count) parameter sets found."

            Foreach ($ParameterSet in $ParameterSets) {

                [array]$Parameters = $ParameterSet.Parameters | Where-Object {$_.IsMandatory -eq $true}
                Write-Verbose -Message ("[{0}] {1} mandatory parameters found for parameter set {2}." -f $FunctionName, $Parameters.Count, $ParameterSet.Name)

                if ($Parameters.Count -eq 0) { continue }

                if ($TestValues -eq $true) {
                    Write-Verbose -Message ("[{0}] Prompting for test values." -f $FunctionName)
                    $Table = Get-TestValue -Parameters $Parameters -Table $Table
                }

                ### BUILD BLOCK 1 ###
                $TestCasesBlockInvalid = New-TestCasesBlock -Parameters $Parameters -TestValues $TestValues -Table $Table -Context Invalid
                Write-Verbose -Message ("[{0}] Test cases block generated." -f $FunctionName)

                ### BUILD BLOCK 2 ###
                $DescriptionBlock = New-DescriptionBlock -Parameters $Parameters

                ### BUILD BLOCK 3 ###
                $ParamBlock = New-ParamBlock -Parameters $Parameters

                ### BUILD BLOCK 4 ###
                $InputObjectBlock = New-InputObjectBlock -Parameters $Parameters

                ### BUILD BLOCK 5 ###
                $TestCasesBlockValid = New-TestCasesBlock -Parameters $Parameters -TestValues $TestValues -Table $Table -Context Valid

                ### BUILD CONTEXT ###
                $ContextParameter = @{
                    Set                   = $Set
                    TestCasesBlockInvalid = $TestCasesBlockInvalid
                    DescriptionBlock      = $DescriptionBlock
                    ParamBlock            = $ParamBlock
                    InputObjectBlock      = $InputObjectBlock
                    TestCasesBlockValid   = $TestCasesBlockValid
                    FunctionName          = $FunctionName
                    AddValid              = $AddValid
                }
                $ContextBlock += New-ContextBlock @ContextParameter
            }

            if ($IntegrationTest) {
                $IntegrationBlock = New-IntegrationBlock -FunctionName $FunctionName
            }

            if ($TestPrivateFunction) {
                $PrivateBlock = New-PrivateBlock -FunctionName $FunctionName -ModuleName $ModuleName
            }

            ### BUILD PESTER TEST ###
            $UnitTest = New-UnitTest -ModuleName $ModuleName -FunctionName $FunctionName -SecureStringBlock $SecureStringBlock -ContextBlock $ContextBlock -IntegrationBlock $IntegrationBlock -PrivateBlock $PrivateBlock

            #### EXPORT TO FILE ####
            Export-PesterTestFile -OutputPath $OutputPath -Function $Function -FunctionName $FunctionName -ModuleName $ModuleName -UnitTest $UnitTest -IntegrationTest:$IntegrationTest
        }
        else {
            return "Not much"
        }
    }

    end {}
}

# New-Test -FunctionName "Get-Name" -TestValues -AddValid