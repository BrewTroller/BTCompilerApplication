FROM alpine:latest
MAINTAINER Eric Yanush <ericyanush@gmail.com>

# Copy in the app
ADD https://github.com/BrewTroller/BTCloudCompilerService/releases/download/v1.0.0-a2/BTCloudCompilerService-linux-amd64 /var/BTCCS/BTCloudCompilerService

ENV PATH /var/opt/avr-gcc/bin:$PATH

RUN apk --no-cache add ca-certificates wget cmake make curl git && \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
	apk add glibc-2.25-r0.apk && rm glibc-2.25-r0.apk  && \
    cd /var/opt && curl -L -O https://github.com/BrewTroller/toolchain-builder/releases/download/v5.4.0/avr-gcc-5.4.0-linux.tar.xz && tar xf avr-gcc* && \
    rm -rf avr-gcc*.xz && \
    chmod +x /var/BTCCS/BTCloudCompilerService

EXPOSE 8080
ENTRYPOINT /var/BTCCS/BTCloudCompilerService
