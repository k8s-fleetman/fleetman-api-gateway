#!/bin/bash
sed -i 's+REPOSITORY_TAG+'"${REPOSITORY_TAG}"'+' deployment.yaml
cat deployment.yaml | grep ${REPOSITORY_TAG}'
