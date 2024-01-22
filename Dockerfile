# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM golang:1.21 AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 \
    GOOS=$(echo $TARGETPLATFORM | cut -d / -f1) \
    GOARCH=$(echo $TARGETPLATFORM | cut -d / -f2) \
    go build -o CloudflareST

FROM --platform=$TARGETPLATFORM alpine:latest
COPY --from=build /app /app
RUN chmod +x /app/CloudflareST
ENV PATH="/app:${PATH}"
ENTRYPOINT ["sleep", "infinity"]