function Run-SliderShow([string] $folder = $PWD.Path, [string] $wait_time = $PWD.Path){
    $wait_time = [int]$wait_time
    [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
    $form = new-object Windows.Forms.Form

    $form.Text = "Image Viewer"
    $form.WindowState= "Maximized"
    $form.controlbox = $false
    $form.formborderstyle = "0"
    $form.BackColor = [System.Drawing.Color]::black

    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.dock = "fill"
    $pictureBox.sizemode = 4 
    $form.controls.add($pictureBox)
    $form.Add_Shown( { $form.Activate()} )
    $form.Show()
    
    Start-Sleep -Seconds 2
    do
    {
        $files = (get-childitem $folder | where { ! $_.PSIsContainer})
        if($files.Count -gt 0){
            foreach ($file in $files)
            {
                if(Test-Path -Path $file.fullname){
            
                    $pictureBox.Image = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]::new([System.IO.File]::ReadAllBytes($file.fullname)))

                    $form.bringtofront()
                    $pictureBox.Refresh()

                    Start-Sleep -Seconds $wait_time
                }
                

            }
        
        }


    }
    While ($running -ne 1) 
}


# -folder  :Enter the slide show folder path
# -wait_time  :Enter the time between show every picture (the number for seconds)

# Run-SliderShow -folder "C:\Users\raywongstudy\Desktop\slideshow" -wait_time "10"