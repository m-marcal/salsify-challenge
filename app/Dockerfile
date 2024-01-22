FROM ruby:2.6.5-alpine AS build-env

ARG APP_DIR="/app"
ARG SYSTEM_PACKAGES="build-base postgresql-dev"

ENV PATH="$APP_DIR/vendor/bundle/bin:$PATH"
ENV GEM_PATH="$APP_DIR/vendor/bundle"
ENV GEM_HOME="$APP_DIR/vendor/bundle"

WORKDIR $APP_DIR

# Project files
COPY . .

# Update & Install system packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $SYSTEM_PACKAGES

# Install (and for some cases, compile)
# ruby dependecies
RUN gem install bundler:2.0.2 \
    && bundle install -V --jobs=10 --deployment --binstubs=./vendor/bundle/bin --clean \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf vendor/bundle/ruby/*/cache/*.gem \
    && find vendor/bundle/ruby/*/gems/ -name "*.c" -delete \
    && find vendor/bundle/ruby/*/gems/ -name "*.o" -delete

###############
# Deploy image
###############
FROM ruby:2.6.5-alpine

ARG APP_DIR="/app"
ARG SYSTEM_PACKAGES="postgresql-dev"

# Runtime env vars
ENV BUNDLE_APP_CONFIG="$APP_DIR/.bundle"
ENV PATH="$APP_DIR/vendor/bundle/bin:$PATH"
ENV GEM_PATH="$APP_DIR/vendor/bundle"
ENV GEM_HOME="$APP_DIR/vendor/bundle"

# App specific env vars
ENV DATABASE_URL=""
ENV RACK_ENV="development"
ENV GIFMACHINE_PASSWORD=""

WORKDIR $APP_DIR

# Update O.S and install application dependecies.
# Even though I've done this previously on $build-env image,
# on this stage we are starting again with a fresh ruby image.
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $SYSTEM_PACKAGES

COPY --from=build-env $APP_DIR $APP_DIR

EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb"]