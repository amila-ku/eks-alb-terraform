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

# Run the tests in the container
FROM build AS run-test-stage
RUN go test -v -cover ./...

# Final lean image
FROM gcr.io/distroless/base-debian11
COPY --from=build --chmod=764 /myapp /

EXPOSE 8080/tcp

CMD ["/myapp"]
