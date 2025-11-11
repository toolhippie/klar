FROM ghcr.io/dockhippie/golang:1.20@sha256:9fa4ba6145d0e40eda5a4ce47bab651b9b0a5e846e1a476ea8c3af978d5b2c7a AS build

# renovate: datasource=github-releases depName=optiopay/klar
ENV KLAR_VERSION=2.4.0

RUN go get -u github.com/kardianos/govendor && \
  git clone -b v${KLAR_VERSION} https://github.com/optiopay/klar.git /srv/app/src/github.com/optiopay/klar && \
  cd /srv/app/src/github.com/optiopay/klar && \
  govendor sync && \
  GO111MODULE=off go install

FROM ghcr.io/dockhippie/alpine:3.22@sha256:c5bd9014e136d50a0d82c511a4fcf52a2ef43c55d9d535de035870845d1a98be
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/klar /usr/bin/
