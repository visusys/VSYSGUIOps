function Invoke-OokiiPasswordDialog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
        [String]
        $MainInstruction,

        [Parameter(Mandatory=$false)]
        [String]
        $WindowTitle="Please enter a password",

        [Parameter(Mandatory=$false)]
        [Int32]
        $MaxLength=35
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName PresentationCore,PresentationFramework

    [System.Windows.Forms.Application]::EnableVisualStyles()

    Add-Type -AssemblyName "$PSScriptRoot\..\Lib\Ookii.Dialogs.Winforms.dll"

    $IDialog                    = New-Object Ookii.Dialogs.WinForms.InputDialog
    $IDialog.MainInstruction    = $MainInstruction
    $IDialog.WindowTitle        = $WindowTitle
    $IDialog.UsePasswordMasking = $true
    $IDialog.MaxLength          = $MaxLength

    $Result = $IDialog.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

    if($Result -eq 'OK'){
        [array] $ReturnArray = $IDialog.Input
        return (, $ReturnArray)
    }

}