FROM scratch
COPY demo-api-guestbook /
ENTRYPOINT ["/demo-api-guestbook"]