FROM alpine:3.6
COPY . /app
WORKDIR /app

RUN addgroup -g 1000 turn \
    && adduser -u 1000 -G turn -s /bin/sh -D turn \
    && apk add --no-cache \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	coturn

# For an explanation of what the following command is derived from
# see https://stackoverflow.com/questions/35766382/coturn-how-to-use-turn-rest-api
CMD turnserver -a -v -n -r "test" \
	--cert=/app/keys/secrets/fullchain.pem \
	--pkey=/app/keys/secrets/privkey.pem \
	--use-auth-secret --static-auth-secret=bigbob --max-bps=3000000 \
	-f -m 3 --min-port=32355 --max-port=65535 -q 100 -Q 300 --cipher-list=ALL
