FROM alpine as builder

ENV HUGO_VERSION 0.64.0

RUN apk add curl tar
RUN mkdir /usr/working_directory
WORKDIR /usr/working_directory
RUN curl -sL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zxv

FROM scratch
COPY --from=builder /usr/working_directory/* /
ENTRYPOINT ["/hugo"]

