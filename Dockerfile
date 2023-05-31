FROM golang:alpine AS build

WORKDIR /brainiac

COPY / /brainiac

RUN go build .

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

WORKDIR /tmp

COPY --from=build /brainiac/brainiac /

ENTRYPOINT ["/brainiac"]