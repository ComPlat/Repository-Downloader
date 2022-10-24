FROM ruby:3.1.2-alpine3.16
RUN apk update
RUN apk upgrade
RUN apk add icu-data-full nodejs yarn # icu-data-full is for non-English locales and legacy charset support
WORKDIR /repository-downloader
COPY . /repository-downloader
RUN gem update --system  # update gem, bundle, bundler, etc. to newest version available
RUN bundle install
#CMD ["rails", "server", "-b", "0.0.0.0"]
