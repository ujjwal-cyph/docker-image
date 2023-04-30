#!/bin/bash

tag=${1}

rm x1v-docker.tar || true
curl -L https://media.githubusercontent.com/media/ujjwal-cyph/docker-image/main/x1v-docker.tar --output x1v-docker.tar
docker load -i x1v-docker.tar

if [ ! -d x1_wallet_firmware ]; then
    git clone https://github.com/Cypherock/x1_wallet_firmware.git --recurse-submodules
fi

cd x1_wallet_firmware

git checkout ${tag} -f --recurse-submodules;
cp ../privatekeypairs/*.h utilities/script/
docker run --mount type=bind,source=$(pwd),target=/x1v-sources/ x1-wallet-app-env ash -c 'export CLI_ROOT_DIR=/home && cd /x1v-sources && utilities/build.sh main release'
mkdir -p "../${tag}" && cp build/*/Cypherock-*.* "../${tag}/";
sha256sum "../${tag}/Cypherock-Main.bin" > "../${tag}/checksum.txt";
cat "../${tag}/checksum.txt";
