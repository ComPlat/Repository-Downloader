FROM ruby:3.1.2-alpine3.16
RUN apk update
RUN apk upgrade
# icu-data-full is for non-English locales and legacy charset support
# build-base includes C compiler for native gem extions
# postgresql12-dev includes C header files that are needed to build pg gem
RUN apk add icu-data-full nodejs yarn build-base postgresql13-dev
WORKDIR /repository-downloader
COPY . /repository-downloader
RUN gem update --system  # update gem, bundle, bundler, etc. to newest version available
RUN bundle install
RUN yarn install
#CMD ["rails", "server", "-b", "0.0.0.0"]
