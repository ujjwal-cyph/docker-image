#!/bin/bash

docker build . --file Dockerfile --tag x1-wallet-app-env
docker save -o x1v-docker.tar x1-wallet-app-env
git add x1v-docker.tar
git commit -m "Update docker image"
git push origin main