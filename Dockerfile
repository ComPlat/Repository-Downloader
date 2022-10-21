FROM ruby:3.1.2-alpine3.16
RUN apk update
RUN apk upgrade
#  icu-data-full is for non-English locales and legacy charset support
RUN apk add icu-data-full nodejs yarn
WORKDIR /repository-downloader
COPY . /repository-downloader
#RUN bundle install
#CMD ["rails", "server", "-b", "0.0.0.0"]
