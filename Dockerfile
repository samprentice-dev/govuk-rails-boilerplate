FROM ruby:2.6.5-alpine

WORKDIR /app

RUN apk add --update --no-cache tzdata && \
  cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
  echo "Europe/London" > /etc/timezone

RUN apk add --update --no-cache build-base yarn postgresql-dev

COPY .ruby-version Gemfile Gemfile.lock /app/

RUN bundle install --jobs=4

COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

COPY . /app/

CMD rails server -b 0.0.0.0
