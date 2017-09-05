# sid-bin-test.dockerfile
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

ARG WOLFSSL_DEBIAN_TAG=latest
FROM wolfssl/debian:$WOLFSSL_DEBIAN_TAG

WORKDIR /wolfssl

EXPOSE 11111

ADD examples.tar.gz /wolfssl

COPY docker-entrypoint.sh /wolfssl/docker-entrypoint.sh

ENTRYPOINT ["/wolfssl/docker-entrypoint.sh"]

CMD ["bash"]