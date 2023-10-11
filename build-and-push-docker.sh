#! /usr/bin/env bash

# First parameter is the docker registry
dockerRegistry=$1

# if no registry is passed, fail
if [ -z "$dockerRegistry" ]
then
    echo "No docker registry passed as parameter."
    exit 1
fi

cd eShopOnWeb
docker compose build
cd ..

docker tag eshopwebmvc:latest $dockerRegistry/eshopwebmvc:latest
docker tag eshoppublicapi:latest $dockerRegistry/eshoppublicapi:latest

docker login $dockerRegistry

docker push $dockerRegistry/eshopwebmvc:latest
docker push $dockerRegistry/eshoppublicapi:latest