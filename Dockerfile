FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    telnet \
    nodejs \
    libpq-dev \
    openssl \
    yarn \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Cache bundle install
WORKDIR /app
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
