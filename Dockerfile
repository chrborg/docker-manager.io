FROM mcr.microsoft.com/dotnet/runtime-deps:6.0

ARG TARGETARCH

RUN apt update; \
    apt install -y unzip wget; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

RUN if [ "$TARGETARCH" = "arm64" ] ; then ARCH="arm64" ; else ARCH="x64" ; fi; \
    mkdir /opt/manager-server; \
    wget -q -O - "https://github.com/Manager-io/Manager/releases/latest/download/ManagerServer-linux-$ARCH.tar.gz" | tar -zxC /opt/manager-server; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

