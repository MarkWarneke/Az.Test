---
external help file: xAz.Test-help.xml
Module Name: xAz.Test
online version:
schema: 2.0.0
---

# Format-xAzOutput

## SYNOPSIS
Takes Outputs from Arm Template deployment and generates a pscustomobject.

## SYNTAX

```
Format-xAzOutput [[-Outputs] <Object>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Outputs
{{Fill Outputs Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Outputs is Dictionary\`2  needs enumerator
Output value has odd value key again -\> $output.Value.Value

\[DBG\]: PS C:\\\> $output

Key              Value
---              -----
virtualMachineId Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.DeploymentVariable

\[DBG\]: PS C:\\\> $output.Value

Type   Value
----   -----
String /subscriptions/\<Subscription\>/resourceGroups/\<ResourceGroup\>/providers/\<Provider\>/\<ResourceType\>/\<ResourceName\>

$output.value.value

## RELATED LINKS
