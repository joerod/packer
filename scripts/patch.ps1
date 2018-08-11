$waar = 1 -eq 1 
$Session = New-Object -com "Microsoft.Update.Session" 
$Search = $Session.CreateUpdateSearcher()  
$SearchResults = $Search.Search("IsInstalled=0 and IsHidden=0")  
$DownloadCollection = New-Object -com "Microsoft.Update.UpdateColl" 
$SearchResults.Updates | ForEach-Object {  
    if ($_.InstallationBehavior.CanRequestUserInput -ne $waar) {  
        $DownloadCollection.Add($_) | Out-Null  
        }  
    }  
 if ($($SearchResults.Updates.Count -gt 0)) { 
    $Downloader = $Session.CreateUpdateDownloader() 
    $Downloader.Updates = $DownloadCollection  
    $Downloader.Download() 
} 
 
 
$objServiceManager = New-Object -ComObject "Microsoft.Update.ServiceManager"
$objSession = New-Object -ComObject "Microsoft.Update.Session"
$objSearcher = $objSession.CreateUpdateSearcher()
Foreach ($objService in $objServiceManager.Services){
    if($ServiceID){ 
        if($objService.ServiceID -eq $ServiceID){
            $objSearcher.ServiceID = $ServiceID
            $objSearcher.ServerSelection = 3
            $serviceName = $objService.Name
        }
    }else{
        if($objService.IsDefaultAUService -eq $True){
            $serviceName = $objService.Name
        }
    }
}
$objResults = $objSearcher.Search("IsInstalled=0")
$FoundUpdatesToDownload = $objResults.Updates.count
if ($FoundUpdatesToDownload  -gt 0){
    foreach($Update in $objResults.Updates){
        if($Update.EulaAccepted -eq 0 ){
            $Update.AcceptEula()
        } 
        if($Update.isdownloaded -eq 0){
            $objCollectionTmp = New-Object -ComObject "Microsoft.Update.UpdateColl"
            $objCollectionTmp.Add($Update) | out-null
            $Downloader = $objSession.CreateUpdateDownloader()
            $Downloader.Updates = $objCollectionTmp
        } 
    } 
    $objCollectionTmp = New-Object -ComObject "Microsoft.Update.UpdateColl" 
    foreach($Update in $objResults.Updates){ 
            $objCollectionTmp.Add($Update) | out-null 
    } 
    $objInstaller = $objSession.CreateUpdateInstaller() 
    $objInstaller.Updates = $objCollectionTmp 
    $InstallResult = $objInstaller.Install() 
    $InstallResult 
} 