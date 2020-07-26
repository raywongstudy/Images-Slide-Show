# PowerShell Script for Photos Slide Show

關於此程式：
由於最近我去了一間公司實習，用戶要求希望實現在server中的一個共享的文件夾存取一部分的圖片，使所有連接該server共享的文件夾的電腦可以主動複製到本機的一個照片輪播資料夾中，並在本機進行相片輪播。所以我就設計了這兩個PowerShell程式去實現這一件事。

About this script:
Recently I join a company for an internship, the user requested that they want to access a part of the pictures inside the shared folder in the server so that all computers connected to the shared folder of the server can actively copy to the photo to the local machine. In the local machine folder, and perform photo need to run photo slide show. So I designed this two PowerShell script to achieve this task.

## 使用方法 ｜ How to use

相片輪播程式主要用window的cmd command去連結運行PowerShell程式而且可以設定文件夾和每張圖片之間轉換的時間，使用cmd的好處只是我方便加入註冊表開機自動運行程式。

The photo slide show program mainly uses the cmd command of the window to link and run the PowerShell program and can set the conversion time between the folder and each picture. The advantage of using cmd is that it is convenient for me to add the registry to start the program automatically.

主要command用法如下：

The main command usage is as follows:

<code> -folder  :Enter the slide show folder path </code>

<code> -wait_time  :Enter the time between show every picture (the number for seconds) </code>

e.g <code> Run-SliderShow -folder "C:\Users\raywongstudy\Desktop\slideshow" -wait_time "10" </code>

資料夾讀取程式主要用window的cmd command去連結運行PowerShell程式而且可以設定源文件夾的路徑，本機的路徑和log文件的路徑，使用cmd的好處只是我方便加入註冊表開機自動運行程式。

The folder reading program mainly uses the cmd command of the window to link to run the PowerShell program and can set the path of the source folder, the path of the local machine, and the path of the log file. The advantage of using cmd is that it is convenient for me to add the registry to automatically run the program.

主要command用法如下：

The main command usage is as follows:

<code>  -source_path  : Enter the source folder path (for upload file and will montor the folder behavior) </code> 

<code>  -location_path  : Enter the location file path (for auto get source path folder)</code> 

<code>  -log_file_path  : Enter the logfile save path (for save the montor folder log file)</code> 

e.g <code> Run-folderMonitor -source_path "C:\Users\raywongstudy\Desktop\Images-Slide-Show\source" -log_file_path "C:\Users\raywongstudy\Desktop\Images-Slide-Show\log" -location_path "C:\Users\raywongstudy\Desktop\Images-Slide-Show\local"</code> 
