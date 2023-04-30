# ******** Build stage *********
FROM alpine:3.14 as build-stage

# Add dependencies
RUN apk add --no-cache gcc-arm-none-eabi newlib-arm-none-eabi ninja cmake bash git python3 py-pip

# Copy files and create folders
RUN mkdir -p /home/build/Debug /home/build/Release
RUN mkdir -p /dist/Debug/plain /dist/Debug/dev /dist/Debug/debug /dist/Release/
RUN pip3 install ecdsa==0.16.1

# Set working directory
WORKDIR /home/build/Debug
