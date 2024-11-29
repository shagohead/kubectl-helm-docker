FROM alpine:3.20 AS dest

RUN apk add gettext

FROM curlimages/curl:latest AS curl

ARG KUBECTL_VERSION=v1.23.0
ARG HELM_VERSION=v3.10.3
ARG HELM_PLATFORM=linux-amd64
ARG HELM_FILENAME=helm-${HELM_VERSION}-${HELM_PLATFORM}.tar.gz

WORKDIR /dst
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN curl -LO https://get.helm.sh/${HELM_FILENAME}
RUN tar -xzvf ${HELM_FILENAME}
RUN mv ${HELM_PLATFORM}/helm ./

FROM dest

COPY --from=curl /dst/kubectl /usr/local/bin/
COPY --from=curl /dst/helm /usr/local/bin/

LABEL org.opencontainers.image.authors="Vakhmin Anton <html.ru@gmail.com>"
