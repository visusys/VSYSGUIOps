function Invoke-OokiiInputDialog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
        [String]
        $MainInstruction,

        [Parameter(Mandatory)]
        [String]
        $MainContent,

        [Parameter(Mandatory=$false)]
        [String]
        $WindowTitle="Please provide input",

        [Parameter(Mandatory=$false)]
        [String]
        $InputText="Enter your text here",

        [Parameter(Mandatory=$false)]
        [Int32]
        $MaxLength=30,

        [Parameter(Mandatory=$false)]
        [Switch]
        $UsePasswordMasking,

        [Parameter(Mandatory=$false)]
        [Switch]
        $Multiline
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName PresentationCore,PresentationFramework

    [System.Windows.Forms.Application]::EnableVisualStyles()

    Add-Type -AssemblyName "$PSScriptRoot\..\Lib\Ookii.Dialogs.Winforms.dll"

    $IDialog                 = New-Object Ookii.Dialogs.WinForms.InputDialog
    $IDialog.MainInstruction = $MainInstruction
    $IDialog.Content         = $MainContent
    $IDialog.WindowTitle     = $WindowTitle
    $IDialog.Input           = $InputText
    $IDialog.MaxLength       = $MaxLength
    $IDialog.Multiline       = $Multiline

    if($UsePasswordMasking) {$IDialog.UsePasswordMasking = $true}

    $Result = $IDialog.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
    
    if($Result -eq 'OK'){
        [array] $ReturnArray = $IDialog.Input
        return (, $ReturnArray)
    }
}