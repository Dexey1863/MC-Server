

$host.ui.RawUI.WindowTitle = "Server Interface"
function Main {
	Write-Host --------------------------- -ForegroundColor blue
	Write-Host !Welcome to Server Interface! 
	Write-Host Type Help for list of Commands $_ -ForegroundColor green
	$Task = Read-Host 'Enter Command'  
	Write-Host --------------------------- -ForegroundColor blue



#$Task = Read-host 'Enter the Task: START,STOP,RESTART,BACKUP,UPLOADLOCAL,UPLOADBACKUP,BACKUPFOLDER,PROPERTIES(not working),CLI,IPCONFIG'
if ($Task -eq "HELP"){
	Write-host Frontend Commands $_ -ForegroundColor green
	Write-host --------------------------- -ForegroundColor blue
	Write-Host Start
	Write-host Stop
	Write-host Restart
	Write-host CLI
	Write-Host ServerStatus
	Write-host 
	Write-host Backend Commands $_ -ForegroundColor Red
	Write-host ---------------------------- -ForegroundColor blue
	Write-host Backup
	Write-host Uploadbackup
	Write-host UploadLocal
	Write-host BackupDolder
	Write-host Ipconfig
	write-host
}

if ($Task -eq "START") {
	Write-Host 		Server starting NOW $_ -ForegroundColor green
	docker rm mc
    docker run -e EULA=TRUE -e MEMORY=2G -e DIFFICULTY=HARD -e OPS=Dexey1863 -e MOTD=Gibbning -v minecraftdata:/data -d -it -p 25565:25565 --name mc itzg/minecraft-server
	$CLI = Read-host 'Want to se the Command Line Interface Y/N'
	if ($CLI -eq "Y") {
		start-process Powershell.exe -Argumentlist "-command docker attach mc"
	}
}
if ($Task -eq "STOP") {
	Write-Host Server stopping NOW $_ -ForegroundColor Red
	docker container stop mc
	
}
if ($Task -eq "RESTART"){
	docker container stop mc
	
	docker rm mc
    docker run -e EULA=TRUE -e MEMORY=2G -e DIFFICULTY=HARD -e OPS=Dexey1863 -e MOTD=Gibbning -v minecraftdata:/data -d -it -p 25565:25565 --name mc itzg/minecraft-server
}
if ($Task -eq "BACKUP") {
	Write-Host Backuping NOW $_ -ForegroundColor Red
	docker container stop mc
	$timestamp = (Get-Date).ToString("[yyyy-MM-dd]-HH-mm-ss")
    docker run --rm --volumes-from mc -v backups:/backups ubuntu bash -c "tar cvf /backups/mc-backups-$timestamp.tar /data"
	
}
if ($Task -eq "UPLOADLOCAL") {
	Write-Host UploadingLocal NOW $_ -ForegroundColor blue
	docker container stop mc
	$TypeFile = Read-host 'SERVERFILE,WORLDFILE'
	if ($TypeFile -eq "SERVERFILE"){
		$FileName = Read-host 'File name. OBS file must be in the E:\Saves folder.'
		docker run --rm `
        -v E:\Saves:/source `
        -v minecraftdata:/target `
        ubuntu `
        sh -c "tar -C /target --strip-components=1 -xvf /source/${FileName}"
	}
	if ($TypeFile -eq "WORLDFILE"){
		$FileName = Read-host 'File name. OBS file must be in the E:\Saves folder.'
		docker run --rm `
		-v E:\Saves:/source `
		-v minecraftdata:/target `
		ubuntu `
		sh -c "rm -r /target/world && mkdir /target/world && tar -C /target/world -xvf /source/${FileName}"
	}
	
}
if ($Task -eq "SERVERSTATUS"){
	Write-Host Current Server Status $_ -ForegroundColor Blue
	docker ps
}
if ($Task -eq "UPLOADBACKUP") {
	Write-Host Uploadingbackup NOW $_ -ForegroundColor blue
	$SourceFile = Read-Host 'Enter the Backup file name'

    $timestamp = (Get-Date).ToString("[yyyy-MM-dd]-HH-mm-ss")
    docker run --rm --volumes-from mc -v backups:/backups ubuntu bash -c "tar cvf /backups/mc-backups-$timestamp.tar /data"


    docker stop mc
	
    docker run --rm `
    -v backups:/source-volume `
    -v minecraftdata:/target-volume `
    ubuntu `
    sh -c "rm -rf /target-volume/* && tar -C /target-volume --strip-components=1 -xvf /source-volume/${SourceFile}"
	
}
if ($Task -eq "BACKUPFOLDER"){
	docker run -it --rm -v backups:/vol busybox ls -l /vol
}

if ($Task -eq "CLI") {
	Write-Host Opening CLI in another window NOW $_ -ForegroundColor green
	start-process Powershell.exe -Argumentlist "-command docker attach mc"
}
if ($Task -eq "IPCONFIG"){
	ipconfig
}
if ($Task -eq "PROPERTIES") {
	docker run --rm `
	-v E:\saves:/source `
	-v minecraftdata:/target `
	ubuntu `
	sh -c "rm -r /target/server.properties && cp /source/server.properties.txt /target/server.properties"
}
if ($Task -eq "EXIT"){
	exit
}
Main
}

Main -$null


