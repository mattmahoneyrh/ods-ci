#!/bin/bash

REGISTRY=quay.io/<RepositoryName>
IMAGE_NAME=ods-ci-image

cp `which oc` .
docker build -t ${IMAGE_NAME} .
docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}
#docker push ${REGISTRY}/${IMAGE_NAME}

