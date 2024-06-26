#!/bin/bash

REGISTRY=quay.io/<RepositoryName>
IMAGE_NAME=ods-ci-image

docker run -i -t ${REGISTRY}/${IMAGE_NAME} /bin/bash

