ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wkhtmltopdf \
        imagemagick \
        xfonts-base \
        fontconfig \
        libxrender1 \
        libxext6 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

