#
#
# Multi-stage Dockerfile to build a very small image for the helloworld app

#
# Stage 1:
# Compile the code

FROM golang:latest as builder

WORKDIR /go/src/helloworld
COPY main.go .

RUN go get -d -v ./...
RUN go install -v ./...

#
# Stage 2:
# Create an image that has only the app binary

FROM scratch

COPY --from=builder /go/bin/helloworld .

CMD ["./helloworld"]

