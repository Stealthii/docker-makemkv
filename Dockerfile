FROM ubuntu:xenial
MAINTAINER Dan Porter <dpreid@gmail.com>

ENV VERSION 1.10.5

RUN set -x && \
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        libc6-dev \
        libssl-dev \
        libexpat1-dev \
        libavcodec-dev \
        libgl1-mesa-dev \
        libqt4-dev

ADD http://www.makemkv.com/download/makemkv-oss-$VERSION.tar.gz /tmp/makemkv-oss-$VERSION.tar.gz
RUN tar xzf /tmp/makemkv-oss-$VERSION.tar.gz && \
    rm /tmp/makemkv-oss-$VERSION.tar.gz && \
    cd /makemkv-oss-$VERSION && \
    ./configure && \
    make && \
    make install && \
    rm -rf /makemkv-oss-$VERSION

RUN set -x && apt-get install -y less

ADD http://www.makemkv.com/download/makemkv-bin-$VERSION.tar.gz /tmp/makemkv-bin-$VERSION.tar.gz
RUN tar xzf /tmp/makemkv-bin-$VERSION.tar.gz && \
    rm /tmp/makemkv-bin-$VERSION.tar.gz && \
    cd /makemkv-bin-$VERSION && \
    yes yes | make && \
    make install && \
    rm -rf /makemkv-bin-$VERSION

RUN mkdir /data
VOLUME ["/data"]


#CMD ["/start.sh"]
