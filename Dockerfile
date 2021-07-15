FROM hellobox/winehq

VOLUME [ "/bds" ]
WORKDIR /root
ENV bdsVer 1.17.10.04
RUN apt install wget unzip -y && \
wget https://minecraft.azureedge.net/bin-win/bedrock-server-${bdsVer}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/1.1.0/LiteLoader.zip && \
unzip bedrock-server-${bdsVer}.zip -d /bds && \
unzip LiteLoader.zip -d /bds && \
rm /root/bedrock-server-${bdsVer}.zip && \
rm /root/LiteLoader.zip
WORKDIR /bds
RUN wget "https://download.zip.dll-files.com/3b22b2ec303b0721827dd768c87df6ed/vcruntime140_1.zip?token=H2eXFzigitsFF6US5vY7bA&expires=1626368920" -O vcruntime140_1.zip && \
unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
rm vcruntime140_1.zip && \
wine SymDB2.exe && \
rm PDB_Symdef.txt && \
rm .wine -rf

ENV WINEDEBUG -all
CMD [ "wine", "/bds/bedrock_server.exe" ]