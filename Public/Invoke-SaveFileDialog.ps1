function Invoke-SaveFileDialog {

    param(

        [Parameter(Mandatory=$false)]
        [Alias('InitialDirectory')]
        [ValidateScript({Test-Path -LiteralPath $_})]
        [string]
        $Path = "$pwd",

        [System.Environment+SpecialFolder]
        [Parameter(Mandatory=$false)]
        [string]
        $SpecialPath,

        [Parameter(Mandatory=$false)]
        [string]
        $DefaultFileName="New Document",

        [Parameter(Mandatory=$false)]
        [Switch]
        $NoCreatePrompt,

        [Parameter(Mandatory=$false)]
        [string]
        $FilterString = 'All files|*.*',

        [Parameter(Mandatory=$false)]
        [string]
        $Title = 'Save a new file',

        [Parameter(Mandatory=$false)]
        [string]
        $DefaultExt = ''

    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    
    $SaveFileDialog.Filter             = $FilterString
    $SaveFileDialog.FileName           = $DefaultFileName
    $SaveFileDialog.Title              = $Title
    $SaveFileDialog.DefaultExt         = $DefaultExt
    $SaveFileDialog.CreatePrompt       = $NoCreatePrompt
    $SaveFileDialog.OverwritePrompt    = $true
    $SaveFileDialog.AddExtension       = $true

    $P = $null
    if($SpecialPath){
        $P = [Environment]::GetFolderPath($SpecialPath)
    }else{
        $P = $Path
    }
    $P = $P.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
    $SaveFileDialog.InitialDirectory = $P

    $Result = $SaveFileDialog.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

    if($Result -eq 'OK'){
        $SaveFileDialog.FileName
    }
}