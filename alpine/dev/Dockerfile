# Copyright (C) 2006-2017 wolfSSL Inc.
#
# This file is part of wolfSSL.
#
# wolfSSL is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# wolfSSL is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335, USA

ARG WOLFSSL_VERSION=3.12.0-stable
FROM alpine

ARG WOLFSSL_VERSION

MAINTAINER wolfSSL Docker Maintainers "support@wolfssl.com"

LABEL vendor="wolfSSL Inc." \
      version=${WOLFSSL_VERSION}

RUN set -eux \
    # install deps
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        g++ \
        libtool \
        make \
        openssl \

    # download source files
    && wget https://github.com/wolfSSL/wolfssl/archive/v${WOLFSSL_VERSION}.zip \
    && unzip v${WOLFSSL_VERSION}.zip \

    # build and install wolfssl
    && cd wolfssl-${WOLFSSL_VERSION} \
    && ./autogen.sh \
    && ./configure \
        --enable-singlethreaded \
        --disable-dependency-tracking \
        --enable-sha224 \
        --enable-distro \
        --disable-silent-rules \
        --disable-examples \
    && make \
    && make install \
    && cd .. \

    # cleanup
    && rm -r wolfssl-${WOLFSSL_VERSION} \
    && rm v${WOLFSSL_VERSION}.zip \
    && apk del .build-deps
