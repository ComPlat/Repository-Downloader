FROM ruby:3.1.2-alpine3.16
WORKDIR /repository-downloader
COPY . /repository-downloader
#RUN bundle install
#CMD ["rails", "server", "-b", "0.0.0.0"]
