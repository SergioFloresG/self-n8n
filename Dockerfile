ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER 0

RUN if [ -x /usr/bin/apt-get ]; then \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        wkhtmltopdf \
        imagemagick \
        xfonts-base \
        fontconfig \
        libxrender1 \
        libxext6 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*; \
    elif [ -x /sbin/apk ]; then \
    apk add --no-cache \
        wkhtmltopdf \
        imagemagick \
        font-noto \
        fontconfig \
        libxrender \
        libxext; \
    else \
    echo "Error: No se encontró apt-get ni apk. PATH=$PATH"; \
    exit 1; \
    fi

USER node
