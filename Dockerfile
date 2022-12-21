FROM alpine:latest

ARG PB_VERSION=0.10.2

ENV USER=docker
ENV UID=1000
ENV GID=1000

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$USER" \
    --no-create-home \
    --uid "$UID" \
    "$USER"

# RUN apk add --no-cache \
#     unzip \
#     ca-certificates

# RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# RUN addgroup -g 1000 appgroup
# RUN adduser -u 1000 -g appgroup appuser
# USER appuser

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

EXPOSE 8080

# start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]