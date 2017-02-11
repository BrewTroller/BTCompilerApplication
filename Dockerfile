FROM alpine:latest
MAINTAINER Eric Yanush <ericyanush@gmail.com>

# Copy in the app
ADD https://github.com/BrewTroller/BTCloudCompilerService/releases/download/v1.0.0-a2/BTCloudCompilerService-linux-amd64 /var/BTCCS/BTCloudCompilerService

ENV PATH /var/opt/avr-gcc/bin:$PATH

RUN apk --allow-untrusted --no-cache -X http://apkproxy.heroku.com/andyshinn/alpine-pkg-glibc add glibc glibc-bin cmake make curl git && \
    cd /var/opt && curl -L -O https://github.com/BrewTroller/toolchain-builder/releases/download/v5.4.0/avr-gcc-5.4.0-linux.tar.xz && tar xf avr-gcc* && \
    rm -rf avr-gcc*.xz && \
    chmod +x /var/BTCCS/BTCloudCompilerService

EXPOSE 8080
ENTRYPOINT /var/BTCCS/BTCloudCompilerService
