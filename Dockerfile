ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}


RUN set -eux; \
    apk add --no-cache \
        wkhtmltopdf \
        imagemagick \
        font-noto \
        fontconfig \
        libxrender \
        libxext;

USER node
