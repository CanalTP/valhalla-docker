to build it:

    docker build -t navitia/valhalla .

you can then build the data:

     docker run -it -v/run/valhalla/valhalla/:/data/valhalla -p 8002:8002 --rm navitia/valhalla /usr/bin/build_valhalla_data /data/valhalla/ile-de-france-latest.osm.pbf

And finally start it:

    docker run -it -v/run/valhalla/valhalla/:/data/valhalla -p 8002:8002 --rm navitia/valhalla
