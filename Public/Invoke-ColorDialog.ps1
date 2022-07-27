function Invoke-ColorDialog {
    param (
        [Parameter(Mandatory, ParameterSetName = "Hex", Position = 0)]
        [Switch]
        $Hex,

        [Parameter(Mandatory, ParameterSetName = "RGB", Position = 0)]
        [Switch]
        $RGB
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $colorDialog = New-Object System.Windows.Forms.ColorDialog
    $colorDialog.SolidColorOnly = $true

    if ( $colorDialog.ShowDialog( ) -eq 'OK' ) {
        #$colorDialog.Color.Name
        $cr = $colorDialog.Color.R
        $cg = $colorDialog.Color.G
        $cb = $colorDialog.Color.B

        if($Hex){
            $fin = Convert-Color -RGB $cr,$cg,$cb
        }else{
            $fin = "$cr,$cg,$cb"
        }

        $fin
    }
}