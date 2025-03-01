# syntax=docker/dockerfile:1

FROM ubuntu:24.04

ARG SERVER_DIR=/home/steam/l4d2server
ARG APPID=222860
ARG ID=1001

# Dependencies
USER root
RUN echo "[BUILD] Installing dependencies" && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
        lib32gcc-s1 \
        lib32stdc++6 \
        lib32z1 \
        libbz2-1.0:i386 \
        libcurl3-gnutls:i386 \
        libstdc++6:i386 \
        libcurl4-gnutls-dev:i386 \
        curl \
        vim

# Create user
RUN groupadd -g $ID steam && useradd -m -r -u $ID -g steam -s /bin/bash steam
USER steam

# Download steam
RUN mkdir ~/steamcmd && \
    cd ~/steamcmd && \
    echo "[BUILD] Downloading steamcmd" && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Download game
RUN echo "[BUILD] Server will install at: $SERVER_DIR" && \
    echo "[BUILD] AppId: $APPID" && \
    cd "/home/steam/steamcmd" && \
    echo "[BUILD] Downloading game" && \
    steamcmdArgs="+force_install_dir $SERVER_DIR +login anonymous +@sSteamCmdForcePlatformType windows +app_update $APPID validate +quit" && \
    ./steamcmd.sh $steamcmdArgs && \
    steamcmdArgs="+force_install_dir $SERVER_DIR +login anonymous +@sSteamCmdForcePlatformType linux +app_update $APPID validate +quit" && \
    ./steamcmd.sh $steamcmdArgs && \
    echo "[BUILD] Performing cleanup" && \
    rm -rf /home/steam/Steam/logs && \
    rm -rf /home/steam/Steam/appcache && \
    echo "[BUILD] Finished" 

WORKDIR $SERVER_DIR

ENTRYPOINT ["/bin/bash", "-c"]
CMD [""]