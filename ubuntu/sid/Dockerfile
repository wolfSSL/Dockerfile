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
ARG WOLFSSL_PACKAGES="libwolfssl12 libwolfssl-dev"
FROM ubuntu

ARG WOLFSSL_VERSION

MAINTAINER wolfSSL Docker Maintainers "support@wolfssl.com"

LABEL vendor="wolfSSL Inc." \
      version=${WOLFSSL_VERSION}

# activate WOLFSSL_INSTALLS arg after FROM
ARG WOLFSSL_PACKAGES

# install wolfssl from sid
RUN set -eux \
    # adds required keys to install from sid
    && gpg --keyserver pgpkeys.mit.edu --recv-key 8B48AD6246925553 \
    && gpg -a --export 8B48AD6246925553 | apt-key add - \
    && gpg --keyserver pgpkeys.mit.edu --recv-key 7638D0442B90D010 \
    && gpg -a --export 7638D0442B90D010 | apt-key add - \

    # install wolfssl
    && echo "deb http://ftp.it.debian.org/debian sid main contrib non-free" \
        > /etc/apt/sources.list.d/wolfssl.list \
    && apt-get update \
    && apt-get install -y ${WOLFSSL_PACKAGES} \

    # cleanup
    && rm -r /var/lib/apt/lists/* \
    && rm /etc/apt/sources.list.d/wolfssl.list \
    && apt-key del 8B48AD6246925553 \
    && apt-key del 7638D0442B90D010 \
    && rm -r /root/.gnupg
