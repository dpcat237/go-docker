FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

#Pre
RUN apt-get update && apt-get install -y apt-utils \
    build-essential \
    software-properties-common \
    python-software-properties \
    net-tools \
    wget

#Aditional
RUN apt-get update && apt-get install -y git \
    supervisor \
    nano \
    htop \
    zsh \
    tig

#Server
RUN apt-get update && apt-get install -y yui-compressor \
    curl \
    mysql-client \
    ssh

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.7.1
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 43ad621c9b014cde8db17393dc108378d37bc853aa351a6c74bf6432c1bbd182

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/

#Upgrade
RUN apt-get update && apt-get upgrade -y

ADD Docker/execute/start.sh /start.sh

#cron to update composer
ADD Docker/execute/start-cron.sh /usr/bin/start-cron.sh
RUN chmod +x /usr/bin/start-cron.sh
CMD /usr/bin/start-cron.sh

ENTRYPOINT ["/start.sh"]
