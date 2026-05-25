ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER 0

RUN set -eux; \
    echo "Detectando sistema. PATH=$PATH"; \
    ls -la /etc/os-release || true; \
    cat /etc/os-release || true; \
    if command -v apt-get >/dev/null 2>&1; then \
        echo "Usando apt-get (Debian/Ubuntu)"; \
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
    elif command -v apk >/dev/null 2>&1; then \
        echo "Usando apk (Alpine)"; \
        apk add --no-cache \
            wkhtmltopdf \
            imagemagick \
            font-noto \
            fontconfig \
            libxrender \
            libxext; \
    else \
        echo "Error: gestor de paquetes no detectado"; \
        echo "Contenido de /usr/bin:"; ls /usr/bin || true; \
        echo "Contenido de /sbin:"; ls /sbin || true; \
        exit 1; \
    fi

USER node
