FROM hellobox/winehq

VOLUME [ "/bds" ]
WORKDIR /bds
ENV bdsVer bedrock-server-1.17.10.04.zip
ENV WINEDEBUG -all
RUN apt install wget unzip -y
RUN wget https://minecraft.azureedge.net/bin-win/${bdsVer}
RUN wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/1.1.0/LiteLoader.zip
RUN unzip ${bdsVer} -d bds
RUN unzip LiteLoader.zip -d bds
RUN wine SymDB2.exe

CMD [ "wine bedrock_server.exe" ]