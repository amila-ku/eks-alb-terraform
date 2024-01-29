FROM golang:1.21 as build

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod ./
RUN go mod download

# Copy source files
COPY *.go ./
# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /myapp

FROM gcr.io/distroless/base-debian11
COPY --from=build --chmod=764 /myapp /
# 55679 - zpages
EXPOSE 8080/tcp

CMD ["/myapp"]
