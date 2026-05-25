ARG N8N_VERSION=latest
ARG ALPINE_VERSION=3.22.0

#
# https://github.com/Surnet/docker-wkhtmltopdf#other-images
FROM surnet/alpine-wkhtmltopdf:${ALPINE_VERSION}-0.12.6-full AS wkhtmltopdf

FROM n8nio/n8n:${N8N_VERSION}

# Copy apk and its deps from Alpine 3.23
COPY --from=wkhtmltopdf /sbin/apk /sbin/apk
COPY --from=wkhtmltopdf /usr/lib/libapk.so* /usr/lib/

USER root

# Install dependencies for wkhtmltopdf
RUN apk add --no-cache \
    libstdc++ \
    libx11 \
    libxrender \
    libxext \
    libssl3 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-dejavu \
    ttf-droid \
    ttf-freefont \
    ttf-liberation \
    # more fonts \
    && apk add --no-cache --virtual .build-deps \
    msttcorefonts-installer \
    font-noto \
    fontconfig \
    libxrender \
    libxext \
  # Install microsoft fonts \
  && update-ms-fonts \
  && fc-cache -f \
  # Clean up when done \
  && rm -rf /tmp/* \
  && apk del .build-deps

# Copy wkhtmltopdf files from docker-wkhtmltopdf image
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf
COPY --from=wkhtmltopdf /bin/wkhtmltoimage /bin/wkhtmltoimage
COPY --from=wkhtmltopdf /lib/libwkhtmltox* /lib/

RUN apk add --no-cache \
    imagemagick

USER node
