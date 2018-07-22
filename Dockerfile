FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y ruby libruby ruby-dev \
    build-essential git-core libxml2-dev libxslt-dev imagemagick \
    libmapserver2 gdal-bin libgdal-dev ruby-mapscript nodejs \
    tzdata redis-server \
     && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH /bundle

RUN mkdir /app
WORKDIR /app
ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries \
    && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . .

# ADD lib/docker/database.yml ./config/database.yml

# ADD lib/docker/secrets.yml ./config/secrets.yml

# COPY lib/docker/default_user.bash ./default_user.bash

# RUN bash default_user.bash && rm -f default_user.bash

# Expose port 5000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.

CMD ["sh", "-c", "bundle exec rails server -b 0.0.0.0 -e $RAILS_ENV"]
