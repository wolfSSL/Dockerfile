# from-aptitude.dockerfile
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

# activate WOLFSSL_INSTALLS arg after FROM
ARG WOLFSSL_INSTALL

# install wolfssl from sid
RUN echo "deb http://ftp.it.debian.org/debian sid main contrib non-free" \
        > /etc/apt/sources.list.d/wolfssl.list \
    && apt-get update \
    && apt-get install ${WOLFSSL_INSTALL} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/apt/sources.list.d/wolfssl.list
