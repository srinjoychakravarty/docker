#!/bin/bash

docker ps -aq
docker stop $(docker ps -aq)
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)
docker build . -t prometheum-containerzzz
# docker run -it prometheum-containerzzz /bin/bash
# docker run --workdir /home/apps-0.46.1 --publish 127.0.0.1:3000:3000/tcp --entrypoint bash prometheum-containerzzz
# docker run --workdir /home --publish 127.0.0.1:3000:3000/tcp  prometheum-containerzzz