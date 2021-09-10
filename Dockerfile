FROM shrbox/winehq:main

VOLUME [ "/bds" ]
RUN useradd -m bds -d /home/bds -s /bin/bash
USER bds
WORKDIR /home/bds/
ENV bdsVer 1.17.11.01
ENV llVer 1.1.2.1
RUN apt install wget unzip -y && \
wget https://minecraft.azureedge.net/bin-win/bedrock-server-${bdsVer}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${llVer}/LiteLoader.zip && \
unzip bedrock-server-${bdsVer}.zip -d /bds && \
unzip LiteLoader.zip -d /bds && \
rm /home/bds/bedrock-server-${bdsVer}.zip && \
rm /home/bds/LiteLoader.zip
WORKDIR /home/bds/bds/
COPY vcruntime140_1.zip /home/bds/bds/
COPY dbghelp.dll /home/bds/bds/
RUN unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
rm vcruntime140_1.zip && \
wine SymDB2.exe && \
rm /home/bds/.wine -r

ENV WINEDEBUG -all
CMD [ "wine", "/bds/bedrock_server.exe" ]
