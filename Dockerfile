FROM alpine as builder

ENV HUGO_VERSION 0.85.0

RUN apk add curl tar
RUN mkdir /usr/working_directory
WORKDIR /usr/working_directory
RUN adduser -S scratchuser
RUN curl -sL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zxv
RUN  mkdir /tmp/hugo_cache

FROM scratch
COPY --from=builder /usr/working_directory/* /
COPY --from=builder /etc/passwd /etc/passwd
USER scratchuser
COPY --from=builder /tmp /tmp
ENTRYPOINT ["/hugo"]

