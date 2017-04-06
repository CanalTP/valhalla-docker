FROM navitia/prime-server

RUN apt-get update && apt-get install -y --no-install-recommends git \
      autoconf \
      automake \
      make \
      libtool \
      pkg-config \
      g++ \
      gcc \
      protobuf-compiler \
      libboost-all-dev \
      libcurl4-openssl-dev \
      libprotobuf-dev \
      libgeos-dev \
      libgeos++-dev \
      liblua5.2-dev \
      libspatialite-dev \
      libsqlite3-dev \
      spatialite-bin \
      wget \
      unzip \
      lua5.2 \
      python-all-dev \
      vim-common \
      jq \
      gucharmap \
      libprotobuf9 \
      libgeos-3.4.2 \
      liblua5.2 \
      libsqlite3-0 \
      libboost-date-time1.55.0 \
      libboost-filesystem1.55.0 \
      libboost-program-options1.55.0 \
      libboost-regex1.55.0 \
      libboost-system1.55.0 \
      libboost-thread1.55.0 \
      libboost-iostreams1.55.0 \
  && git clone --depth=1 --recursive https://github.com/valhalla/valhalla.git libvalhalla \
  && cd libvalhalla && ./autogen.sh && ./configure --enable-static && make -j4 install && make clean && cd - && rm -rf libvalhalla && ldconfig \
  && apt-get -y purge \
      git \
      autoconf \
      automake \
      make \
      libtool \
      pkg-config \
      g++ \
      gcc \
      protobuf-compiler \
      libboost-all-dev \
      libprotobuf-dev \
      libgeos-dev \
      libgeos++-dev \
      liblua5.2-dev \
      wget \
      unzip \
      python-all-dev \
      vim-common \
      jq \
      gucharmap \
 && apt-get autoremove -y && apt-get clean

VOLUME /data/valhalla
ADD valhalla.json /data/valhalla.json

EXPOSE 8002
ADD build_valhalla_data /usr/bin/build_valhalla_data
RUN chmod +x /usr/bin/build_valhalla_data
CMD /usr/local/bin/valhalla_route_service /data/valhalla.json
