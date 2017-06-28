FROM navitia/prime-server

VOLUME /data/valhalla
RUN apt-get update && apt-get install -y --no-install-recommends git \
      autoconf \
      automake \
      make \
      libtool \
      pkg-config \
      g++ \
      gcc \
      locales \
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
  && cd libvalhalla \
  && ./scripts/valhalla_build_config --mjolnir-tile-dir /data/valhalla/tiles --thor-source-to-target-algorithm timedistancematrix  --thor-logging-long-request 10000 \
    --service-limits-pedestrian-max-matrix-distance 20000 \
    --service-limits-bicycle-max-matrix-distance 40000 \
    --service-limits-auto-max-matrix-distance 100000 \
    --service-limits-multimodal-max-locations 50000 \
    --service-limits-bicycle-max-locations 50000 \
    --service-limits-isochrone-max-locations 50000 \
    --service-limits-auto-max-locations 50000 \
    --service-limits-transit-max-locations 50000 \
    --service-limits-hov-max-locations 50000 \
    --service-limits-pedestrian-max-locations 50000 \
    --service-limits-auto-shorter-max-locations 50000 \
    --service-limits-truck-max-locations 50000 \
    --service-limits-bus-max-locations 50000 \
    --service-limits-bicycle-max-matrix-locations 50000 \
    --service-limits-pedestrian-max-matrix-locations 50000 \
    --service-limits-auto-max-matrix-locations 50000 > /data/valhalla.json \
  && ./autogen.sh && ./configure --enable-static && make -j4 install && make clean && ldconfig \
  && cd - && rm -rf libvalhalla \
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


EXPOSE 8002
ADD build_valhalla_data /usr/bin/build_valhalla_data
RUN chmod +x /usr/bin/build_valhalla_data
CMD ["/usr/local/bin/valhalla_route_service","/data/valhalla.json"]
