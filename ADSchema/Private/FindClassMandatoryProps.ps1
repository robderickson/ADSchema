function FindClassMandatoryProps {
    param(
        [Parameter()]
        $Attribute = '*',
  
        [Parameter()]
        $Class = 'user',
  
        [Parameter()]
        $ComputerName,
  
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )

    $CommandParams = @{}
    if ($ComputerName) {
        $CommandParams['ComputerName'] = $ComputerName
     }
     if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
        $CommandParams['Credential'] = $Credential
     }
    
    Invoke-Command @CommandParams -ScriptBlock {
        $schema = [directoryservices.activedirectory.activedirectoryschema]::getcurrentschema()
        $schema.FindClass($Class).MandatoryProperties | Where-Object {$_.Name -like $Attribute}
    }
}