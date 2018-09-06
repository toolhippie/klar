FROM webhippie/alpine:latest

LABEL maintainer="Thomas Boerger <thomas@webhippie.de>" \
  org.label-schema.name="Klar" \
  org.label-schema.vendor="Thomas Boerger" \
  org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/klar"]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

RUN wget -q -O /usr/bin/klar https://github.com/optiopay/klar/releases/download/v2.3.0/klar-2.3.0-linux-amd64 && \
  chmod +x /usr/bin/klar
