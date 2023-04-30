# ******** Build stage *********
FROM alpine:3.14 as build-stage

# Add dependencies
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache gcc-arm-none-eabi newlib-arm-none-eabi ninja cmake bash git python3 py-pip protoc g++ && ln -sf python3 /usr/bin/python

# Create folders
RUN mkdir -p /home/build/Debug /home/build/Release /dist/Debug/plain /dist/Debug/dev /dist/Debug/debug /dist/Release/

# Configure python packages
RUN pip3 install --no-cache-dir wheel
RUN pip3 install --no-cache-dir --upgrade pip setuptools
RUN pip3 install --no-cache-dir protobuf grpcio-tools==1.47.0 ecdsa==0.16.1

# Set working directory
WORKDIR /home/build/Debug
