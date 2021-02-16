FROM node:12.18.1-alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN apk update \
    && apk add --no-cache --virtual build-dependencies \
    python \
    make \
    g++ \
    build-base \
    wget \
    git \
    gcc \
    bash \
    openssh

# Install dependencies
COPY package.json ./
COPY firebase-import.js ./firebase-import.js
RUN npm install
RUN npm link
RUN apk del build-dependencies
ENTRYPOINT ["firebase-import"]