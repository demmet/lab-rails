FROM ruby:2.6.2

RUN apt-get update && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /lab-rails

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME

RUN gem install bundler
RUN bundle install
