

FROM alpine:latest

ARG PB_VERSION=0.10.2


RUN apk add --no-cache \
    unzip \
    ca-certificates
    
RUN addgroup -g 1000 appuser
RUN adduser -u 1000 -g appuser appuser
USER appuser

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

EXPOSE 8080

# start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]