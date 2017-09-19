#!/bin/sh
#
# Docker examples builder
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

source VERSION

function usage()
{
    echo "wolfSSL Docker image builder"
    echo ""
    echo "./build.sh TARGET_OS"
    echo "\t-h --help     prints this help message"
    echo "\tTARGET_OS     one of: alpine, centos, debian or ubuntu"
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
        -*)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
        *)
            if [[ "$PARAM" =~ ^(alpine|centos|debian|ubuntu)$ ]]; then
                TARGET_OS=$PARAM
            else
                echo "ERROR: unknown target OS \"$PARAM\""
                usage
                exit 1
            fi
            ;;
    esac
    shift
done

if [[ "$TARGET_OS" == "" ]]; then
    usage
    exit 1
fi

echo "Building docker images using wolfssl:$TARGET_OS\n"

docker build \
    -t wolfssl/wolfssl:$TARGET_OS-lib \
    --build-arg WOLFSSL_VERSION=$WOLFSSL_VERSION \
    $TARGET_OS/lib

docker build \
    -t wolfssl/wolfssl:$TARGET_OS-test \
    --build-arg WOLFSSL_VERSION=$WOLFSSL_VERSION \
    $TARGET_OS/test

docker run \
    --rm \
    --entrypoint cat \
    wolfssl/wolfssl:$TARGET_OS-test \
    /wolfssl/examples.tar.gz \
    > examples/examples.tar.gz

docker build \
    -t wolfssl/wolfssl:$TARGET_OS-examples \
    --build-arg BASE_IMAGE=$TARGET_OS-lib \
    examples

rm examples/examples.tar.gz

