

docker exec mc mc-send-to-console say Restart in 5 seconds. Finish what you are doing.
start-sleep -seconds 1
docker exec mc mc-send-to-console say Restart in 4 seconds
start-sleep -seconds 1
docker exec mc mc-send-to-console say Restart in 3 seconds
start-sleep -seconds 1
docker exec mc mc-send-to-console say Restart in 2 seconds
start-sleep -seconds 1
docker exec mc mc-send-to-console say Restart in 1 seconds
start-sleep -seconds 1
docker exec mc mc-send-to-console say Restarting now
start-sleep -seconds 1


docker container stop mc
$timestamp = (Get-Date).ToString("[yyyy-MM-dd]-HH-mm-ss")
docker run --rm --volumes-from mc -v backups:/backups ubuntu bash -c "tar cvf /backups/mc-backups-$timestamp.tar /data"

docker rm mc
docker run -e EULA=TRUE -e MEMORY=2G -e DIFFICULTY=HARD -e MOTD=Gibbning -v minecraftdata:/data -d -it -p 25565:25565 --name mc itzg/minecraft-server
    docker container attach mc