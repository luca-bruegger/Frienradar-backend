FROM ruby:3.0.0

USER root

ENV RAILS_ENV=staging
ENV BUNDLE_PATH=/opt/bundle

WORKDIR /myapp
COPY . /myapp

RUN apt-get update
RUN apt-get install direnv -y

RUN mkdir /opt/bundle && chmod 777 /opt/bundle
RUN mkdir /seed && chmod 777 /seed
RUN mkdir /home/app && chmod 777 /home/app
ENV HOME=/home/app

COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD [ "rails", "server", "-e", "'staging'", "-b", "0.0.0.0", "-p", "3001" ]