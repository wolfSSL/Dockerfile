# Dockerfile
#
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

FROM debian

ARG WOLFSSL_VERSION

ARG WOLFSSL_MAKE_INSTALL

RUN cd /home \
    && apt-get update \
    && apt-get install -y wget unzip autoconf libtool make \
    && wget https://github.com/wolfSSL/wolfssl/archive/v${WOLFSSL_VERSION}.zip \
    && unzip v${WOLFSSL_VERSION}.zip \
    && cd wolfssl-${WOLFSSL_VERSION} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make check \
    && make ${WOLFSSL_MAKE_INSTALL} \
    && cd .. \
    && rm -rf wolfssl-${WOLFSSL_VERSION} \
    && rm v${WOLFSSL_VERSION}.zip \
    && apt-get autoremove -y wget unzip autoconf libtool make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
