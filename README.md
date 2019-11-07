
# AWS CLI Image with kubectl, eksctl and terraform

Adapted from https://hub.docker.com/r/mesosphere/aws-cli

This image, when run, will mount the current working director on the host to /project and maintain aws cli and kubectl configuration in the local host working directory. When first run, execute the /init.bsh file to configure your environment. This only needs to be done the first time you run the container from a given host directory as the .kube and .aws directories are mounted from the host.

## Build

    docker build -t awscli .

## Run

    docker run --rm -ti \
    -e AWS_ACCESS_KEY_ID=<YOUR ACCESS KEY ID> \
    -e AWS_SECRET_ACCESS_KEY="<YOUR SECRET ACCESS KEY" \
    -e AWS_DEFAULT_REGION=eu-west-2 \
    -e CLUSTER=<YOUR CLUSTER NAME> \
    -v "//$(pwd):/project" \
    -v "//$(pwd)/.aws:/root/.aws" \
    -v "//$(pwd)/.kube:/root/.kube" \
    awscli bash

On first run from any given host directory, use /init.bsh to initialise the .kube for this environment. Not needed on subsequent runs of the container from the same host directory (with the same docker run parameters).