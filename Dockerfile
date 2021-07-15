FROM hellobox/winehq

VOLUME [ "/bds" ]
WORKDIR /root
ENV bdsVer bedrock-server-1.17.10.04.zip
RUN apt install wget unzip -y
RUN wget https://minecraft.azureedge.net/bin-win/${bdsVer}
RUN wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/1.1.0/LiteLoader.zip
RUN unzip ${bdsVer} -d /bds
RUN unzip LiteLoader.zip -d /bds
WORKDIR /bds
RUN wget "https://download.zip.dll-files.com/3b22b2ec303b0721827dd768c87df6ed/vcruntime140_1.zip?token=H2eXFzigitsFF6US5vY7bA&expires=1626368920" -O vcruntime140_1.dll
RUN wine SymDB2.exe
RUN rm PDB_Symdef.txt
RUN rm /root/${bdsVer}
RUN rm /root/LiteLoader.zip

ENV WINEDEBUG -all
CMD [ "wine bedrock_server.exe" ]