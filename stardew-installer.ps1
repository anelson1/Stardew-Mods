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
$Drives = Get-PSDrive -PSProvider 'FileSystem'
$StardewDir = ''
foreach($Drive in $drives) {
    $StardewDir = Get-ChildItem -Path $Drive.Root "Stardew Valley" -Recurse -Directory | ForEach-Object{$_.FullName}
    if ($StardewDir -like '?:\*\common\*') {
        break
    }
}
Set-Location $StardewDir
Remove-Item .\Mods -recurse
mkdir Mods
$Url = "https://github.com/anelson1/Stardew-Mods/releases/download/latest/modpack.zip"
$ExtractPath = $StardewDir + "\Mods"
$DownloadZipFile = $StardewDir + $(Split-Path -Path $Url -Leaf)
Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
$ExtractShell = New-Object -ComObject Shell.Application 
$ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items()
$ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 
Start-Process $ExtractPath
