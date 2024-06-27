#!/bin/bash

REGISTRY=quay.io/<RepositoryName>
IMAGE_NAME=ods-ci-image

cp `which oc` .
podman build -t ${IMAGE_NAME} .
podman tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}
#podman push ${REGISTRY}/${IMAGE_NAME}

