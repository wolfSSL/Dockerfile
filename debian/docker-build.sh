#!/bin/sh
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

source ../global-config.sh

# default building params
WOLFSSL_SOURCE="sid"
WOLFSSL_INSTALL="bin"
WOLFSSL_PACKAGES="libwolfssl12/sid"
WOLFSSL_MAKE_INSTALL="install-exec"

function usage()
{
    echo "wolfSSL Docker image builder"
    echo ""
    echo "./docker_build.sh"
    echo "\t-h --help     prints this help message"
    echo "\t--with-dev    installs dev files"
    echo "\t--from-src    installs wolfssl from source files"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --with-dev)
            WOLFSSL_INSTALL="dev"
            WOLFSSL_MAKE_INSTALL="install"
            WOLFSSL_PACKAGES=$WOLFSSL_PACKAGES" libwolfssl-dev/sid"
            ;;
        --from-src)
            WOLFSSL_SOURCE="src"
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

WOLFSSL_DOCKER_TAG=$WOLFSSL_SOURCE-$WOLFSSL_INSTALL

if [ "$WOLFSSL_SOURCE" == "sid" ]; then
    echo "Building docker image using packages from Sid";
    echo "Installing the following wolfssl packages: "$WOLFSSL_PACKAGES;
    echo ;
    docker build \
        -t wolfssl/debian:$WOLFSSL_DOCKER_TAG \
        -f from-aptitude.dockerfile \
        --build-arg WOLFSSL_PACKAGES="$WOLFSSL_PACKAGES" \
        .;
else
    echo "Building docker image using wolfSSL-$WOLFSSL_VERSION source files";
    echo "Using the following wolfssl make instruction: "$WOLFSSL_MAKE_INSTALL;
    echo ;
    docker build \
        -t wolfssl/debian:$WOLFSSL_DOCKER_TAG \
        -f from-source.dockerfile \
        --build-arg WOLFSSL_VERSION="$WOLFSSL_VERSION" \
        --build-arg WOLFSSL_MAKE_INSTALL="$WOLFSSL_MAKE_INSTALL" \
        .;
fi