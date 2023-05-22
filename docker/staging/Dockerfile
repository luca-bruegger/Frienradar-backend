FROM ruby:3.0.0

ENV RAILS_ENV=staging

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /myapp
COPY . /myapp

RUN bundle install

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3001

CMD [ "rails", "server", "-e", "'staging'", "-b", "0.0.0.0", "-p", "3001" ]