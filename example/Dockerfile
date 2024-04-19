FROM alpine:edge
ARG TARGETPLATFORM
LABEL MAINTAINER="i@nn.ci"
WORKDIR /bin/
COPY bin/${TARGETPLATFORM}/docker-actions ./
RUN chmod+x /bin/docker-actions && \
    /bin/docker-actions