FROM golang:alpine AS builder


# Move to working directory /build
WORKDIR /build

COPY main.go .
COPY fakeDataGenerator/ ./fakeDataGenerator/


RUN go mod init main
RUN go mod tidy



# Build the application
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build

# Build a small image
FROM gcr.io/distroless/base-debian10

COPY --from=builder /build/main .

# Command to run

CMD ["/main"]