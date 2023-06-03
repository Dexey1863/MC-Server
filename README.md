# MC-Server
Minecraft server interface for docker


Minecraft Interface that uses docker image to create a minecraft server.

Powershell script to interface with the server

.BAT file to start the powershell script.

What you need to install, Windows Powershell and Docker

You need to create 2 docker volume. one named "minecraftdata" and one named "backups"

You can do that by running these 2 commands in windows powershell
        1: docker volume create minecaraftdata
        2: docker volume create backups

You need to change the path inside the .BAT file to match the path to your Interface.ps1 file. 

In the "UploadLocal" and "properties" functions you need to select a path to a folder where you store the files you want to upload to the server. 

The properties file need to be named "server.properties.txt" and both the backup files need to be in .TAR format. 

If you chose UploadServerfile you need to have an entier server in that .TAR file. OBS only use that for downloaded backups for docker. If you chose UploadWorldFile you need to convert the folder where world data is stored to a .TAR file and you need to name it World.TAR. 

You need to create 2 scheduled tasks to backup the server every day. You do that by createding a new task in windows "Task Scheduler" and select the "powershell-backup.ps1" script to run at those selected times.
