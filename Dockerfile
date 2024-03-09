FROM hugomods/hugo:base as builder

RUN apk add dart-sass --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/
RUN apk add --no-cache dart-sass

# ARG HUGO_BASEURL=
# ENV HUGO_BASEURL=${HUGO_BASEURL}

WORKDIR /opt/site

COPY . .

RUN hugo

FROM rtsp/lighttpd

COPY --from=builder /opt/site/public /var/www/html/

COPY not-found.conf /etc/lighttpd/conf.d/not-found.conf