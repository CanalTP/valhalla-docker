FROM debian:8

RUN apt-get update && apt-get --no-install-recommends -y install libsodium13 libpgm-5.1-0 libsodium-dev libpgm-dev autoconf automake libtool make gcc g++  libcurl4-openssl-dev libcurl3 git pkg-config ca-certificates \
    && git clone --depth=1 --recursive https://github.com/zeromq/libzmq && cd libzmq && ./autogen.sh && ./configure && make -j4 install && make clean && cd .. && rm -rf libzmq \
    && git clone --depth=1 --recursive https://github.com/zeromq/czmq && cd czmq && ./autogen.sh && ./configure && make -j4 install && make clean && cd .. && rm -rf czmq \
    && git clone --depth=1 --recursive https://github.com/kevinkreiser/prime_server && cd prime_server && ./autogen.sh && ./configure && make -j4 install && make clean && cd .. && rm -rf prime_server \
    && apt-get -y purge libsodium-dev libpgm-dev autoconf automake libtool make gcc g++  libcurl4-openssl-dev git pkg-config && apt-get autoremove -y && apt-get clean
