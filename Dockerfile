FROM hellobox/winehq

VOLUME [ "/bds" ]
WORKDIR /bds
ENV bdsVer bedrock-server-1.17.10.04.zip
RUN apt install wget unzip -y
RUN wget https://minecraft.azureedge.net/bin-win/${bdsVer}
RUN wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/1.1.0/LiteLoader.zip
RUN unzip ${bdsVer} -d bds
RUN unzip LiteLoader.zip -d bds
RUN wget https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe
RUN wine64 vc_redist.x64.exe /quiet
RUN wine64 SymDB2.exe
RUN rm PDB_Symdef.txt
RUN rm ${bdsVer}
RUN rm LiteLoader.zip

ENV WINEDEBUG -all
CMD [ "wine bedrock_server.exe" ]