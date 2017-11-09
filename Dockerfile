FROM alpine:3.6
WORKDIR /app

RUN addgroup -g 1000 turn \
    && adduser -u 1000 -G turn -s /bin/sh -D turn \
    && apk add --no-cache \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	coturn

# For an explanation of what the following command is derived from
# see https://stackoverflow.com/questions/35766382/coturn-how-to-use-turn-rest-api
CMD turnserver -a -v -n -r "test" \
	--cert=/run/secrets/fullchain.pem \
	--pkey=/run/secrets/privkey.pem \
	--use-auth-secret --static-auth-secret=`cat /run/secrets/turn_secret` --max-bps=3000000 \
	-f -m 3 --min-port=32355 --max-port=65535 -q 100 -Q 300 --cipher-list=ALL
