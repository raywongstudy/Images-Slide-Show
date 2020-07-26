function Run-folderMonitor([string] $location_path = $PWD.Path, [string] $source_path = $PWD.Path, [string] $log_file_path = $PWD.Path){
    $Date = Get-Date -Format 'yyyyMd'
    $filewatcher = New-Object System.IO.FileSystemWatcher
    $Global:localPath = $location_path
    $Global:logPath = $log_file_path+"\"+$Date+"_FileWatcher_log.txt"
    $Global:logline_save = " "
    $Global:source_path = $source_path
    if(Test-Path -Path $Global:logPath){
        Write-Host 'FileWatcher_log.txt exists!'
    }else{
        New-Item $Global:logPath
    }

    $filewatcher.Path = $source_path
    $filewatcher.Filter = "*.*"
    $filewatcher.IncludeSubdirectories = $true
    $filewatcher.EnableRaisingEvents = $true
    
    $Action = {
        $path = $Event.SourceEventArgs.FullPath
        $changeType = $Event.SourceEventArgs.ChangeType
        $oldPath = $Event.SourceEventArgs.OldFullPath
        $logline = "$(Get-Date) , $oldPath , $changeType , $path"

        $path_split = $path.split('\')[0..($path.split('\').Count -2)] -join '\'

        $source_path_lists = Get-ChildItem $Global:source_path

        if($source_path_lists.Count -ne 0){
            robocopy $path_split $Global:localPath /e /purge
        }

        if($Global:logline_sav -ne $logline){
            $Global:logline_save = $logline
            Add-content $Global:logPath -value $logline
            Write-Host $logline
        }
    }
    
    Register-ObjectEvent $filewatcher "Created" -Action $Action
    Register-ObjectEvent $filewatcher "Changed" -Action $Action
    Register-ObjectEvent $filewatcher "Deleted" -Action $Action
    Register-ObjectEvent $filewatcher "Renamed" -Action $Action

    while($true) {
        $source_folder = Get-ChildItem -Path $source_path
        $location_folder = Get-ChildItem -Path $location_path
        if($location_folder.Count -eq 0){
            Write-Host "your folder miss the image file"
            robocopy $source_path $Global:localPath /e /purge 
            Add-content $Global:logPath -value "$(Get-Date) , update the file $source_path\$($_.name) copy to $location_path"
        }
        if($source_folder.Count -gt 0 -and $location_folder.Count -gt 0){
                Compare-Object $source_folder $location_folder -Property Name, Length | ForEach-Object {
                robocopy $source_path $Global:localPath /e /purge 
                #Copy-Item "$source_path\$($_.name)" -Destination "$location_path" -Force
                Add-content $Global:logPath -value "$(Get-Date) , update the file $source_path\$($_.name) copy to $location_path"
                Write-Host "$(Get-Date) , update the file $source_path\$($_.name) copy to $location_path"
            }
        }
        sleep 8
    }
}

# -source_path  : Enter the source folder path (for upload file and will montor the folder behavior)
# -location_path  : Enter the location file path (for auto get source path folder)
# -log_file_path  : Enter the logfile save path (for save the montor folder log file)

#Run-folderMonitor -source_path "C:\Users\raywongstudy\Desktop\Images-Slide-Show\source" -log_file_path "C:\Users\raywongstudy\Desktop\Images-Slide-Show\log" -location_path "C:\Users\raywongstudy\Desktop\Images-Slide-Show\local"



