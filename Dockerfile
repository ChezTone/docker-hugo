FROM alpine as builder
RUN apk add curl tar
RUN mkdir /usr/working_directory
WORKDIR /usr/working_directory
RUN curl -sL https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.tar.gz | tar zxv

FROM scratch
COPY --from=builder /usr/working_directory/* /
ENTRYPOINT ["/hugo"]

