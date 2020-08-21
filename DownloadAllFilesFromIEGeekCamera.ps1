
function DownloadFolder($baseURL, $folder, $nestLevel, $localFolder)
{
    #Update Useron progress
    $downloadURL = -join("$baseURL","$folder");
    Write-Output $downloadURL;

    #Set up a web connection to camera
    $webClient = New-Object System.Net.WebClient;
    $cred = New-Object System.Net.NetworkCredential("$userID","$password");
    $webClient.Credentials = $cred;

    #Download the root content of the SD card
    $folderListing = $webClient.DownloadString("$downloadURL");

    #Set up a Regular Expression for Listing extracting each row
    $regexListing = New-Object System.Text.RegularExpressions.Regex("<tr>.+href=""(?'name'.+)"".*?(?'isDir'\[DIRECTORY\])?</td></tr>")

    $matches = $regexListing.Match($folderListing);
    while ($matches.Success)
    {
        $entryName = $matches.Groups["name"].Value;
       
        #Ignore the "parent" folder
        if (!$entryName.EndsWith(".."))
        {
            if (![string]::IsNullOrEmpty($matches.Groups["isDir"].Value))
            {
                #Its a sub folder
                DownloadFolder "$baseURL" "$entryName" ($nestLevel+1) "$localFolder"
            }
            else
            {
                #Its a file

                #Is it a 264 file?
                if ($entryName.EndsWith("264"))
                {
                    $localfile = -join($localFolder, [System.IO.Path]::GetFileName($entryName));
                    $fileDownloadURL = -join($baseURL,$matches.Groups["name"].Value);
                    $output = -join("".PadLeft($nestLevel*2,' '),"Downloading ", $fileDownloadURL, " to ", "$localfile");
                    Write-Output $output;

                    if ([System.IO.File]::Exists("$localFile"))
                    {
                        Write-Warning "Local file already exists, skipping";
                    }
                    else
                    {
        
                        #Download it
                        try
                        {
                            $webClient.DownloadFile("$fileDownloadURL", "$localfile")
                        }
                        catch 
                        {
                            
                        }
                    }
                }
            }
        }
        $matches = $matches.NextMatch();
    }
}

# URL of your Camera
$myCameraIP = $args[0];
#User ID / Password to access your camera
$userID = $args[1];
$password = $args[2];
# Where do you want the files to be stored
$myLocalStorage = $args[3]

DownloadFolder "http://$myCameraIP" "/sd/" 0 "$myLocalStorage"
