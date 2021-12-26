FROM shrbox/winehq:main

VOLUME [ "/home/container/bds" ]
ENV BDSDIR /home/container/bds/
ENV BDSVER 1.18.2.03
ENV LLVER 2.0.3
RUN adduser --disabled-password --home /home/container container && apt install wget unzip -y
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container/
RUN wget https://minecraft.azureedge.net/bin-win/bedrock-server-${BDSVER}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${LLVER}/LiteLoader-${LLVER}.zip && \
chmod +x bedrock-server-1.18.2.03.zip && \
unzip bedrock-server-${BDSVER}.zip -d ${BDSDIR} && \
unzip LiteLoader-${LLVER}.zip -d ${BDSDIR} && \
rm /home/container/bedrock-server-${BDSVER}.zip && \
rm /home/container/LiteLoader-${LLVER}.zip
WORKDIR ${BDSDIR}
COPY vcruntime140_1.zip ${BDSDIR}
RUN unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
rm vcruntime140_1.zip && \
wine SymDB2.exe && \
rm /home/container.wine -r

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
