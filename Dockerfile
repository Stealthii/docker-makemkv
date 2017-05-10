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
        wget \
        less

RUN mkdir -p /tmp/build \
    && wget -O /tmp/makemkv-oss-$VERSION.tar.gz http://www.makemkv.com/download/makemkv-oss-$VERSION.tar.gz \
    && tar -xzf /tmp/makemkv-oss-$VERSION.tar.gz -C /tmp/build/ \
    && cd /tmp/build/makemkv-oss-$VERSION \
    && ./configure --disable-gui \
    && make install \
    && wget -O /tmp/makemkv-bin-$VERSION.tar.gz http://www.makemkv.com/download/makemkv-bin-$VERSION.tar.gz \
    && tar -xzf /tmp/makemkv-bin-$VERSION.tar.gz -C /tmp/build/ \
    && cd /tmp/build/makemkv-bin-$VERSION \
    && yes yes | make install \
    && cd / \
    && ln -sf /usr/bin/makemkvcon /usr/bin/makemkv \
    && rm -rf /tmp/build

RUN set -x && \
    apt-get purge -y \
        build-essential \
        pkg-config \
        libc6-dev \
        libssl-dev \
        libexpat1-dev \
        libavcodec-dev \
        wget \
        less \
    && apt-get install -y \
        libssl1.0.0 \
        libexpat1 \
        libavcodec-ffmpeg56 \
    && apt-get autoremove -y --purge

WORKDIR /data

CMD ["makemkvcon"]
