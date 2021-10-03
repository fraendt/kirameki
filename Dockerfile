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

RUN apk add autoconf automake gcc g++ libtool make
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

RUN npm install
COPY . .

CMD ["node", "index.js"]