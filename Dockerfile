FROM webhippie/golang:1.18 AS build

# renovate: datasource=github-releases depName=optiopay/klar
ENV KLAR_VERSION=2.4.0

RUN go get -u github.com/kardianos/govendor && \
  git clone -b v${KLAR_VERSION} https://github.com/optiopay/klar.git /srv/app/src/github.com/optiopay/klar && \
  cd /srv/app/src/github.com/optiopay/klar && \
  govendor sync && \
  GO111MODULE=off go install

FROM webhippie/alpine:3.16
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  rm -rf /var/cache/apk/*

COPY --from=build /srv/app/bin/klar /usr/bin/
