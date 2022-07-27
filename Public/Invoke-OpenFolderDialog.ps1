


function Invoke-OpenFolderDialog {

    param(

        [Parameter(Mandatory=$false, Position = 0)]
        [ValidateScript({Test-Path -LiteralPath $_})]
        [string]
        $Path = [Environment]::GetFolderPath("Desktop").TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar,

        [System.Environment+SpecialFolder]
        [Parameter(Mandatory=$false)]
        [string]
        $SpecialPath,

        [Parameter(Mandatory=$false)]
        [string]
        $Title = "Select a folder",

        [Parameter(Mandatory=$false)]
        [switch]
        $NoNewFolder

    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $FolderBrowser              = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowser.RootFolder   = "MyComputer"

    $FinalPath = $null
    if($SpecialPath){
        $FinalPath = [Environment]::GetFolderPath($SpecialPath)
    }else{
        $FinalPath = $Path
    }

    $FinalPath = $FinalPath.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
    $FolderBrowser.SelectedPath = $FinalPath
    $FolderBrowser.Description  = $Title
    if($NoNewFolder) {$FolderBrowser.ShowNewFolderButton = $false}

    $Result = $FolderBrowser.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

    if ($Result -eq 'OK') {
        return $FolderBrowser.SelectedPath
    }
}