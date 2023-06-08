FROM golang:1.20.4 as build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY ./main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM scratch
WORKDIR /app
COPY --from=build /app/main .

CMD ["/app/main"]
EXPOSE 3000
