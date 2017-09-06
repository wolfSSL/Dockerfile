#!/bin/sh
#
# Docker examples builder (docker-build-examples.sh)
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

source ../../global-config.sh

TAGS="sid-bin src-bin"

docker build \
    -t wolfssl/debian/example-builder \
    -f example-builder.dockerfile \
    --build-arg WOLFSSL_VERSION=$WOLFSSL_VERSION \
    .

docker run \
    --rm \
    --entrypoint cat \
    wolfssl/debian/example-builder \
    /wolfssl/examples.tar.gz \
    > examples.tar.gz

for TAG in $TAGS; do
    docker build \
        -t wolfssl/debian/example:$TAG \
        -f bin-example.dockerfile \
        --build-arg WOLFSSL_DEBIAN_TAG=$TAG \
        .
done
