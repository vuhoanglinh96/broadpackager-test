FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ntp yarn

RUN mkdir /broadpackager-test
WORKDIR /broadpackager-test

COPY Gemfile Gemfile.lock ./

RUN bundle install
VOLUME /user/local/bundle

ADD . /gpc-app
