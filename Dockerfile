FROM ruby:3.1.2-alpine3.16
RUN apk update
RUN apk upgrade
# tzdata contains time zone data needed for Ruby/ Rails Date support
# icu-data-full is for non-English locales and legacy charset support
# build-base includes C compiler for native gem extions
# postgresql12-dev includes C header files that are needed to build pg gem
# gcompat includes GNU C library compatibility layer needed for Nokogiri
RUN apk add tzdata icu-data-full nodejs yarn build-base postgresql12-dev gcompat
WORKDIR /repository-downloader
COPY . /repository-downloader
# CMD ["rails", "server", "-b", "0.0.0.0"]
