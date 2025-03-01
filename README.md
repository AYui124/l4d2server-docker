# l4d2server-docker
Run left4dead2 dedicated server in docker
## how to use
- Download dockerfile and docker-compose.yml from this repo
- Build image 
```
docker build -t l4d2 .
```
- Create user
  For mounting some files to container 
```
groupadd -g 1001 steam && useradd -m -r -u 1001 -g steam -s /bin/bash steam
chown -R 1001:1001 /opt/l4d2
```
- Change password
  This is not necessary, but it is recommended to change for security
```
passwd steam
```
- Run
```
docker compose up -d
```

- Console
  Attach the console ( Press Ctrl+q to exit )
```
docker attach --detach-keys="ctrl-q" l4d2
```
  

## update server
- Delete container and image
```
docker compose down
docker rm l4d2
docker rmi l4d2
```
- Rebuild
```
docker build -t l4d2 .
```
