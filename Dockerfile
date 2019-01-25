FROM golang:1.11-alpine3.8 as builder

WORKDIR /go/src/github.com/andreas-schroeder/kafka-health-check

ENV CGO_ENABLED 0 

RUN apk update \
    && apk add make git

RUN go get github.com/kardianos/govendor

COPY . .

RUN make deps && make

FROM scratch

COPY --from=builder /go/src/github.com/andreas-schroeder/kafka-health-check/kafka-health-check /

ENTRYPOINT ["/kafka-health-check"]
