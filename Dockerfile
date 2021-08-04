FROM shrbox/winehq:main

VOLUME [ "/bds" ]
WORKDIR /root
ENV bdsVer 1.17.10.04
ENV llVer 1.1.1
RUN apt install wget unzip -y && \
wget https://minecraft.azureedge.net/bin-win/bedrock-server-${bdsVer}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${llVer}/LiteLoader.zip && \
unzip bedrock-server-${bdsVer}.zip -d /bds && \
unzip LiteLoader.zip -d /bds && \
rm /root/bedrock-server-${bdsVer}.zip && \
rm /root/LiteLoader.zip
WORKDIR /bds
COPY vcruntime140_1.zip /bds/
RUN unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
rm vcruntime140_1.zip && \
wine SymDB2.exe && \
rm PDB_Symdef.txt && \
rm /root/.wine -r

ENV WINEDEBUG -all
CMD [ "wine", "/bds/bedrock_server.exe" ]