FROM hellobox/winehq

VOLUME [ "/bds" ]
WORKDIR /root
ENV bdsVer 1.17.10.04
ENV llVer 1.1.0
RUN apt install wget unzip -y && \
wget https://minecraft.azureedge.net/bin-win/bedrock-server-${bdsVer}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${llVer}/LiteLoader.zip && \
unzip bedrock-server-${bdsVer}.zip -d /bds && \
unzip LiteLoader.zip -d /bds && \
rm /root/bedrock-server-${bdsVer}.zip && \
rm /root/LiteLoader.zip
WORKDIR /bds
RUN wget "https://cdn.jsdelivr.net/gh/Redbeanw44602/liteloader-docker/vcruntime140_1.zip" -O vcruntime140_1.zip && \
unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
rm vcruntime140_1.zip && \
wine SymDB2.exe && \
rm PDB_Symdef.txt && \
rm /root/.wine -r

ENV WINEDEBUG -all
CMD [ "wine", "/bds/bedrock_server.exe" ]