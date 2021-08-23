FROM golang:1.15 as build
RUN go get github.com/codegangsta/negroni \
           github.com/gorilla/mux \
           github.com/xyproto/simpleredis
WORKDIR /app
ADD ./main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM scratch
WORKDIR /app
COPY --from=build /app/main .
COPY ./public/index.html public/index.html
COPY ./public/script.js public/script.js
COPY ./public/style.css public/style.css
CMD ["/app/main"]
EXPOSE 3000
