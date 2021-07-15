FROM hellobox/winehq

VOLUME [ "/bds" ]
WORKDIR /root
ENV bdsVer bedrock-server-1.17.10.04.zip
RUN apt install wget unzip -y
RUN wget https://minecraft.azureedge.net/bin-win/${bdsVer}
RUN wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/1.1.0/LiteLoader.zip
RUN unzip ${bdsVer} -d /bds
RUN unzip LiteLoader.zip -d /bds
RUN wget https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe
RUN wine vc_redist.x64.exe /quiet
WORKDIR /bds
RUN wine SymDB2.exe
RUN rm /root/PDB_Symdef.txt
RUN rm /root/${bdsVer}
RUN rm /root/LiteLoader.zip
RUN rm /root/vc_redist.x64.exe

ENV WINEDEBUG -all
CMD [ "wine bedrock_server.exe" ]