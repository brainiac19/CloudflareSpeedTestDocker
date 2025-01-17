FROM --platform=$BUILDPLATFORM golang:1.21 AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM
COPY . /app
WORKDIR /app
RUN CGO_ENABLED=0 \
    GOOS=$(echo $TARGETPLATFORM | cut -d / -f1) \
    GOARCH=$(echo $TARGETPLATFORM | cut -d / -f2) \
    go build -o CloudflareST

FROM --platform=$TARGETPLATFORM alpine:latest
COPY --from=build /app /config
RUN chmod +x /config/entrypoint.sh
RUN chmod +x /config/CloudflareST
WORKDIR /app
ENV PATH="/app:${PATH}"
ENTRYPOINT ["/config/entrypoint.sh"]