# IPCameraDownloadAllFiles
A powershell script that will download ALL files from an IEGeek IP Camera - May work with other cameras too

The IEGeek IP Camera software only allows for files downloaded one by one so if you need to download footage captured over a long period, this could be very time consuming.

This powershell script will connect to your camera, access the SD card and pull the entire footage stored on the camera.

This is a "works on my setup" warranty and it may or may not work on yours and no liability will taken for loss or damage of footage / camera / pc environment.

You will need PowerShell installed and .Net Framework (the later the better) installed too

Exection:

Open Windows PowerShell
At the PS> prompt, type in 
    <location-of-script>\DownloadAllFilesFromIEGeekCamera.ps1 <ip-address-of-camera> <user-id-of-camera> <password-for-user> <local-folder>
  
  e.g. C:\Users\Me\Downloads\DownloadAllFilesFromIEGeekCamera.ps1 192.168.0.123 admin isyourpasswordstrongenough C:\MyCameraFootage\


