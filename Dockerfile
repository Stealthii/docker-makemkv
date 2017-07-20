FROM ubuntu:xenial
MAINTAINER Dan Porter <dpreid@gmail.com>

ENV VERSION 1.10.6
ENV BUILD_PACKAGES "build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev wget less"
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends $BUILD_PACKAGES \
    && mkdir -p /tmp/build \
    && wget -O /tmp/build/makemkv-oss-$VERSION.tar.gz http://www.makemkv.com/download/makemkv-oss-$VERSION.tar.gz \
    && wget -O /tmp/build/makemkv-bin-$VERSION.tar.gz http://www.makemkv.com/download/makemkv-bin-$VERSION.tar.gz \
    && tar -xzf /tmp/build/makemkv-oss-$VERSION.tar.gz -C /tmp/build/ \
    && tar -xzf /tmp/build/makemkv-bin-$VERSION.tar.gz -C /tmp/build/ \
    && cd /tmp/build/makemkv-oss-$VERSION \
    && ./configure --disable-gui \
    && make install \
    && cd /tmp/build/makemkv-bin-$VERSION \
    && yes yes | make install \
    && cd / \
    && rm -rf /tmp/build \
    && apt-get purge -y $BUILD_PACKAGES \
    && apt-get install -y --no-install-recommends \
        libssl1.0.0 \
        libexpat1 \
        libavcodec-ffmpeg56 \
    && apt-get autoremove -y --purge \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/makemkvcon /usr/bin/makemkv

WORKDIR /data

CMD ["makemkvcon"]
