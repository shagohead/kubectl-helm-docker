FROM curlimages/curl:latest AS curl

ARG KUBECTL_VERSION=v1.23.0
ARG HELM_VERSION=v3.10.3
ARG HELM_FILENAME=helm-${HELM_VERSION}-linux-arm64.tar.gz

WORKDIR /dst
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN curl -LO https://get.helm.sh/${HELM_FILENAME}
RUN tar -xzvf ${HELM_FILENAME}
RUN mv linux-arm64/helm ./

FROM alpine:3.20

COPY --from=curl /dst/kubectl /usr/local/bin/
COPY --from=curl /dst/helm /usr/local/bin/

LABEL org.opencontainers.image.authors="Vakhmin Anton <html.ru@gmail.com>"
