FROM node:6.12.0-alpine

RUN apk update &&\
    apk upgrade &&\
    apk add --update bash python make g++ libc6-compat

ENV PORT 9000
EXPOSE 9000

ADD package.json /tmp/package.json
RUN cd /tmp && npm install --production

WORKDIR /app
ADD . /app

RUN ln -s /tmp/node_modules /app/node_modules

RUN apk add openssl && \
    mkdir -p bin && \
    wget -qO bin/chamber https://github.com/segmentio/chamber/releases/download/v1.9.0/chamber-v1.9.0-linux-amd64 && \
    sha256sum -c chamber.sha256sum && \
    chmod 755 bin/chamber && \
    apk del --purge openssl

CMD bash ./docker-startup.sh
