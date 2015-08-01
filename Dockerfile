FROM ubuntu:14.04
MAINTAINER Eric Yanush <ericyanush@gmail.com>

# Copy in the app
ADD https://github.com/BrewTroller/BTCloudCompilerService/releases/download/v1.0.0-a2/BTCloudCompilerService-linux-amd64 /var/BTCCS/BTCloudCompilerService

# Install all our packages
RUN apt-get --quiet -y update && \
	apt-get --quiet -y install \
	  avr-libc \
	  gcc-avr \
	  binutils-avr \
	  cmake \
		git \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists && \
	chmod +x /var/BTCCS/BTCloudCompilerService

EXPOSE 8080
ENTRYPOINT /var/BTCCS/BTCloudCompilerService