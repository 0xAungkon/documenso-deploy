FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG NODE_MAJOR=22

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl git gnupg;  apt-get install -y --no-install-recommends build-essential python3 make g++ libvips-dev ; \
    mkdir -p /etc/apt/keyrings; \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg; \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends nodejs; \
    rm -rf /var/lib/apt/lists/*
RUN npm install -g npm@latest


WORKDIR /app
RUN git clone https://github.com/documenso/documenso --depth 1
WORKDIR /app/documenso
RUN npm install
COPY .env.documenso /app/documenso/.env
RUN npm i
RUN npm run build
WORKDIR /app/documenso/apps/remix
CMD ["npm", "run", "start"]