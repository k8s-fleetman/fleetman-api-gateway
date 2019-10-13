#!/bin/bash
sed -i 's+REPOSITORY_TAG+'"${REPOSITORY_TAG}"'+' deploy.yaml
cat deploy.yaml | grep ${REPOSITORY_TAG}'
