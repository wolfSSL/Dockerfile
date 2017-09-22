# Supported tags and respective `Dockerfile` links

- [`alpine-examples`, `latest` (*examples/Dockerfile*) with BASE_IMAGE=alpine-lib](https://github.com/wolfssl/Dockerfile/blob/master/examples/Dockerfile)
- [`alpine-lib` (*alpine/lib/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/alpine/lib/Dockerfile)
- [`alpine-test` (*alpine/test/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/alpine/test/Dockerfile)
- [`centos-examples` (*examples/Dockerfile*) with BASE_IMAGE=centos-lib](https://github.com/wolfssl/Dockerfile/blob/master/examples/Dockerfile)
- [`centos-lib` (*centos/lib/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/centos/lib/Dockerfile)
- [`centos-test` (*centos/test/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/centos/test/Dockerfile)
- [`debian-examples` (*examples/Dockerfile*) with BASE_IMAGE=debian-lib](https://github.com/wolfssl/Dockerfile/blob/master/examples/Dockerfile)
- [`debian-lib` (*debian/lib/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/debian/lib/Dockerfile)
- [`debian-test` (*debian/test/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/debian/test/Dockerfile)
- [`ubuntu-examples` (*examples/Dockerfile*) with BASE_IMAGE=ubuntu-lib](https://github.com/wolfssl/Dockerfile/blob/master/examples/Dockerfile)
- [`ubuntu-lib` (*ubuntu/lib/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/ubuntu/lib/Dockerfile)
- [`ubuntu-test` (*ubuntu/test/Dockerfile*)](https://github.com/wolfssl/Dockerfile/blob/master/ubuntu/test/Dockerfile)

# Quick reference

 - **Where to get help**:
    [wolfSSL support channel](mailto:support@wolfssl.com)

 - **Where to file issues**:
    https://github.com/wolfssl/wolfssl/issues

 - **Maintained by**:
    [the wolfSSL Docker Maintainers](https://github.com/wolfssl/wolfssl)

# What is wolfSSL?

![logo](https://avatars1.githubusercontent.com/u/5891092?v=4&s=100)

wolfSSL is a lightweight C-language-based SSL/TLS library targeted for embedded, RTOS, or resource-constrained environments primarily because of its small size, speed, and portability. wolfSSL supports industry standards up to the current TLS 1.2 and DTLS 1.2 levels, is up to 20 times smaller than OpenSSL, offers a simple API, an OpenSSL compatibility layer, OCSP and CRL support, and offers several progressive ciphers. wolfSSL is under active development, and should be chosen over yaSSL when possible.

> [wolfSSL's website](https://www.wolfssl.com)

# How to use this image

## `*-lib` images

These images are loaded with and installation of wolfSSL binaries.

## `*-test` images

These images are loaded with wolfSSL's source code and binaries under /wolfssl-**WOLFSSL_VERSION**.

## `latest` and `*-examples` images

This images are wolfSSL's demo images, they are loaded with a simple client/server example to perform SSL/TLS connections.

## Running the examples:

```console
$ docker run \
     -it --name wolfserver \
     wolfssl/wolfssl \
     server
```
This command will run the wolfssl server on port `11111`.

```console
$ docker run \
    -it --link=wolfserver:server-addr \
    wolfssl/wolfssl \
    client -h server-addr
```
This command will run the wolfssl client and try to connect to the server at server-addr.

The expected output is something like:

**server side**
```
Container's IP address: 172.17.0.2
peer's cert info:
    issuer : /C=US/ST=Montana/L=Bozeman/O=wolfSSL_2048/OU=Programming-2048/CN=www.wolfssl.com/emailAddress=info@wolfssl.com
    subject: /C=US/ST=Montana/L=Bozeman/O=wolfSSL_2048/OU=Programming-2048/CN=www.wolfssl.com/emailAddress=info@wolfssl.com
    serial number:b9:bc:90:ed:ad:aa:0a:8c
SSL version is TLSv1.2
SSL cipher suite is TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
SSL curve name is SECP256R1
Server Random : C5C07219DEB6D02F8913B7163B984355B3B6F9DBDD09CB7752A5736AF704D165
Client message: hello wolfssl!
```
.

**client side**
```
Container's IP address: 172.17.0.3
Session Ticket CB: ticketSz = 134, ctx = initial session
peer's cert info:
    issuer : /C=US/ST=Montana/L=Bozeman/O=Sawtooth/OU=Consulting/CN=www.wolfssl.com/emailAddress=info@wolfssl.com
    subject: /C=US/ST=Montana/L=Bozeman/O=wolfSSL/OU=Support/CN=www.wolfssl.com/emailAddress=info@wolfssl.com
    serial number:01
SSL version is TLSv1.2
SSL cipher suite is TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
SSL curve name is SECP256R1
Client Random : F601361E88A01A09DAD3322EAA6A1D33323BAAA219857E2B53FD30DBA6E56EAA
I hear you fa shizzle!
```
.

It is possible to check more options by adding --help to both client and server commands.
