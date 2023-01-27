$ErrorActionPreference= 'silentlycontinue'
$text = @"
                              /       //  
           //       /        //      //   
          ///     ///      ///      ///  
         /////    ////     //      ///     
        /// //   ((((((   ///      //      
        ///  (( (((  ((( (((      ///     
       ///   ((((((   (((((      ///     
      ///     ((((     ((((      //      
      ///     ((((     ((((     ///       
     ///      (((((    (((((   ///         
     //      /(( (((  ((( ((/  //         
    ///      //   ((((((   // ///      
   ///      ///    /(/(     ////
   //      ///      ///     ///
  ///      //        /       //
 //       /

 If it ain't Nelson, It ain't Net.
"@
Write-Output $text
Write-Output "---------------------------------------------------"
$Drives = Get-PSDrive -PSProvider 'FileSystem'
$StardewDir = ''
Write-Output "Scanning for your Stardew Installation Directory"

foreach($Drive in $drives) {
    $StardewDir = Get-ChildItem -Path $Drive.Root "Stardew Valley" -Recurse -Directory | ForEach-Object{$_.FullName}
    if ($StardewDir -like '?:\*\common\*') {
        break
    }
}
Write-Output "Directory found, starting installation process"
Set-Location $StardewDir
Remove-Item .\Mods -recurse
mkdir Mods
$Url = "https://github.com/anelson1/Stardew-Mods/releases/download/latest/modpack.zip"
$ExtractPath = $StardewDir + "\Mods"
$DownloadZipFile = $StardewDir + $(Split-Path -Path $Url -Leaf)
Write-Output "Downloading modpack"
Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
Write-Output "Modpack downloaded, installing now. A new extraction window will open..."
$ExtractShell = New-Object -ComObject Shell.Application 
$ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items()
$ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles)
Start-Process $ExtractPath
Write-Output "Cleaning up"
Remove-Item modpack.zip
Write-Output "Thank you for using Nelson Net"
