FROM golang:1.11.5 as builder

WORKDIR /go/src/github.com/andreas-schroeder/kafka-health-check

RUN apt update -y \
    && apt install -y make git

RUN go get github.com/kardianos/govendor

COPY . .

RUN make deps && make

FROM docker-upgrade.artifactory.build.upgrade.com/container-base:20180926-10

COPY --from=builder /go/src/github.com/andreas-schroeder/kafka-health-check/kafka-health-check /

ENTRYPOINT ["/kafka-health-check"]
