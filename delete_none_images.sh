#!/bin/sh

for id in `docker images | grep 'none' | gawk  '/[0-9a-f]{12}/{ print $3 }'`
do
    docker rmi -f $id
    echo "remove image ID:" $id
done
#docker container ls -a


