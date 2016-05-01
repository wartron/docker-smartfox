FROM debian
MAINTAINER Nikolay Glushchenko <nick@nickalie.com>
ENV SMARTFOX_VERSION 2_9_0_64
ENV SMARTFOX_PATCH '2.11.1'
RUN apt-get update && \
    apt-get install -y wget unzip

WORKDIR /var
RUN wget http://www.smartfoxserver.com/downloads/sfs2x/SFS2X_unix_${SMARTFOX_VERSION}.tar.gz && \
    tar xf SFS2X_unix_${SMARTFOX_VERSION}.tar.gz && \
    rm SFS2X_unix_${SMARTFOX_VERSION}.tar.gz && \
    rm -rf SmartFoxServer_2X/jre && \
    cp SmartFoxServer_2X/SFS2X/lib/jetty/modules/npn/npn-1.7.0_45.mod SmartFoxServer_2X/SFS2X/lib/jetty/modules/npn/npn-1.8.0_60.mod
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.tar.gz && \
    tar xf jre-8u60-linux-x64.tar.gz && \
    rm jre-8u60-linux-x64.tar.gz && \
    mv jre1.8.0_60 SmartFoxServer_2X/jre
RUN wget http://smartfoxserver.com/downloads/sfs2x/patches/SFS2X-Patch-${SMARTFOX_PATCH}.zip && \
    unzip SFS2X-Patch-${SMARTFOX_PATCH}.zip -d SmartFoxServer_2X && \
    rm SFS2X-Patch-${SMARTFOX_PATCH}.zip && \
    cd SmartFoxServer_2X/SFS2X-Patch-${SMARTFOX_PATCH} && \
    ./install-linux.sh && \
    cd .. && rm -rf SFS2X-Patch-${SMARTFOX_PATCH}
WORKDIR /var/SmartFoxServer_2X/SFS2X
CMD ./sfs2x.sh
EXPOSE 8080 9933
