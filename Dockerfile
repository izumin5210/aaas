FROM ruby:2.4.0-alpine

ENV APP /app
WORKDIR $APP
ENV PATH /root/.yarn/bin:$PATH
ENV YARNPKG_VERSION 0.22.0

RUN apk --update add --virtual build-deps \
    bash \
    curl \
    tar \
  && apk add \
    build-base \
    nodejs \
    postgresql-dev \
    python \
    tzdata \
  && apk add --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    entrykit \
  && curl -o- -L https://yarnpkg.com/install.sh \
    | bash -s -- --version $YARNPKG_VERSION \
  && apk del build-deps \
  && rm -rf /var/cache/apk/* \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN mkdir -p $APP/tmp/cache \
  && mkdir -p $APP/tmp/pids \
  && mkdir -p $APP/tmp/sockets

ENTRYPOINT [ \
  "prehook", "ruby -v", \
  "--", \
  "prehook", "bundle install --jobs 4 --quiet --path vendor/bundle", \
  "--" \
]
