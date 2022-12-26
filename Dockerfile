FROM ruby:3.0.0-alpine

RUN apk add --no-cache --update build-base \
  postgresql-dev \
  tzdata

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN gem install bundler  -v 2.2.3
RUN bundle install

EXPOSE 9292
ENTRYPOINT sh ./bin/entrypoint.sh
