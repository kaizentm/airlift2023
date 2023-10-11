#! /usr/bin/env bash

# First parameter is the docker registry
dockerRegistry=$1

# if no registry is passed, fail
if [ -z "$dockerRegistry" ]
then
    echo "No docker registry passed as parameter."
    exit 1
fi

pushd eShopOnWeb

docker compose build

popd

docker tag eshopwebmvc:latest $dockerRegistry/eshopwebmvc:latest
docker tag eshoppublicapi:latest $dockerRegistry/eshoppublicapi:latest

docker login $dockerRegistry

docker push $dockerRegistry/eshopwebmvc:latest
docker push $dockerRegistry/eshoppublicapi:latest