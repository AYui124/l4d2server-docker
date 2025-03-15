# l4d2server-docker
在Docker容器内运行l4d2服务器
## 安装
- 从此仓库下载dockerfile和docker-compose.yaml
- 构建镜像
```
docker build -t l4d2 .
```
- 创建用户  
镜像默认使用steam(1001:1001)这个用户运行，需在主机创建用于挂载目录的用户。并给与对应目录(/opt/l4d2)权限  
```
groupadd -g 1001 steam && useradd -m -r -u 1001 -g steam -s /bin/bash steam
chown -R 1001:1001 /opt/l4d2
```
- 修改主机steam用户密码  
非必须，但为了安全推荐修改
```
passwd steam
```
- 修改  
默认在yaml里配置了如下挂载文件，如需修改挂载目录位置请统一修改yaml文件
```
    volumes:
      - /opt/l4d2/addons:/home/steam/l4d2server/left4dead2/addons
      - /opt/l4d2/cfg/sourcemod:/home/steam/l4d2server/left4dead2/cfg/sourcemod
      - /opt/l4d2/cfg/l4d2server.cfg:/home/steam/l4d2server/left4dead2/cfg/l4d2server.cfg
      - /opt/l4d2/logs:/home/steam/l4d2server/left4dead2/logs
      - /opt/l4d2/motd.txt:/home/steam/l4d2server/left4dead2/motd.txt
      - /opt/l4d2/host.txt:/home/steam/l4d2server/left4dead2/host.txt
```
- 启动服务
```
docker compose up -d
```

- 进入控制台  
附加到docker主进程( 按 Ctrl+q 退出 )
```
docker attach --detach-keys="ctrl-q" l4d2
```
  

## 更新服务
方法1: 使用docker exec 启动镜像后通过steamcmd更新，保存容器到新的镜像  
  //Todo   
方法2: 从头开始创建
- 删除容器和镜像
```
docker compose down
docker rm l4d2
docker rmi l4d2
```
- 重建
```
docker build -t l4d2 .
docker compose up -d
```
## 卸载
- 停止并删除容器镜像
```
docker compose down
docker rm l4d2
docker rmi l4d2
```
- 删除dockerfile 挂载目录等文件
