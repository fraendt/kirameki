FROM alpine:latest
# node:16-alpine3.11

# install dependencies 

## add npm/nodejs
RUN apk add --update nodejs npm

## Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN apk add libtool
RUN apk add autoconf
RUN apk add automake
RUN apk add gcc
RUN apk add g++
RUN apk add make
RUN apk add git

RUN apk add \
        build-base \
        cairo-dev \
        jpeg-dev \
        pango-dev \
        giflib-dev \
        pixman-dev \
        pangomm-dev \
        libjpeg-turbo-dev \
        freetype-dev \
    && apk add \
        pixman \
        cairo \
        pango \
        giflib

# set up 
WORKDIR /kirameki
COPY package*.json ./
COPY . .
RUN npm install
# --legacy-peer-deps

CMD ["node", "index.js"]