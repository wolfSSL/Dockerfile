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
FROM centos

ARG WOLFSSL_VERSION

RUN set -eux \
    # install deps
    && buildDeps=' \
        autoconf \
        automake \
        libtool \
        make \
        unzip \
    ' \
    && yum install -y $buildDeps \

    # download source files
    && curl -LS \
        https://github.com/wolfSSL/wolfssl/archive/v${WOLFSSL_VERSION}.zip \
        -o v${WOLFSSL_VERSION}.zip \
    && unzip v${WOLFSSL_VERSION}.zip \

    # build and install wolfssl
    && cd wolfssl-${WOLFSSL_VERSION} \
    && ./autogen.sh \
    && ./configure \
        --disable-dependency-tracking \
        --enable-sha224 \
        --enable-distro \
        --disable-silent-rules \
        --disable-examples \
    && make \
    && make install-exec \
    && cd .. \

    # cleanup
    && rm -r wolfssl-${WOLFSSL_VERSION} \
    && rm v${WOLFSSL_VERSION}.zip \
    && yum autoremove -y $buildDeps \
    && yum clean all
