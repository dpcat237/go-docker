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

# Install Go
ENV GOLANG_VERSION 1.8
ENV GOLANG_DOWNLOAD_URL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C / -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOROOT /go
ENV GOPATH /usr/local/go
ENV PATH $GOPATH/bin:/go/bin:$PATH

RUN mkdir -p "$GOPATH/src"
RUN usermod -s /bin/bash www-data
RUN usermod -u 1000 www-data
RUN usermod -a -G users www-data
WORKDIR /usr/local/go/src
RUN chown -R www-data:www-data /usr/local/go/src
RUN echo www-data:wwwpwd | chpasswd

COPY go-wrapper /usr/local/bin/
COPY Docker/copy/root/.oh-my-zsh /root/.oh-my-zsh
COPY Docker/copy/root/.ssh       /root/.ssh
#COPY Docker/copy/root/.zshrc     /root/.zshrc

#Upgrade
#RUN apt-get update && apt-get upgrade -y

ADD Docker/execute/start.sh /start.sh

#cron to update composer
ADD Docker/execute/start-cron.sh /usr/bin/start-cron.sh
RUN chmod +x /usr/bin/start-cron.sh
CMD /usr/bin/start-cron.sh

ENTRYPOINT ["/start.sh"]
