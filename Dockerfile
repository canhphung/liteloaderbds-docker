FROM shrbox/winehq:main

VOLUME [ "/bds" ]
ENV BDSDIR /home/bds/bds/
ENV BDSVER 1.17.11.01
ENV LLVER 1.1.2.1
RUN useradd -m bds -d /home/bds -s /bin/bash && apt install wget unzip -y
USER bds
WORKDIR /home/bds/
RUN wget https://minecraft.azureedge.net/bin-win/bedrock-server-${BDSVER}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${LLVER}/LiteLoader.zip && \
unzip bedrock-server-${BDSVER}.zip -d ${BDSDIR} && \
unzip LiteLoader.zip -d ${BDSDIR} && \
rm /home/bds/bedrock-server-${BDSVER}.zip && \
rm /home/bds/LiteLoader.zip
WORKDIR ${BDSDIR}
COPY vcruntime140_1.zip ${BDSDIR}
RUN unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
rm vcruntime140_1.zip && \
wine SymDB2.exe && \
rm /home/bds/.wine -r

ENV WINEDEBUG -all
CMD [ "wine", "/bds/bedrock_server_mod.exe" ]
