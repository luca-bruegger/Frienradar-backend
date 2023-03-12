# syntax=docker/dockerfile:1
FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y postgresql-client

# set up app directory
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]