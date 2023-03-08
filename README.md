# Repository Downloader

## Production
### Setup
1. Install current version of [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/).
2. Change environment variables in `run_docker-compose.production.sh`.
   HINT: Loosing or exposing these values will be insecure and dangerous!
   `DOWNLOADER_ATTACHMENTS_PATH` needs to point to the root folder in which Active Storage attachments are available (read-only access preferred).
3. Execute run_docker-compose.production.sh.
   If it is your first run replace `db:migrate` with `db:setup`, but do not forget to change it back later, otherwise app will not boot, because it would destroy existing database.

#### Environment Variables
The following environment variables have to be set for the project to run:

BAG_IT_STREAM_THREADS - the number of threads BagIt runs with.

Docker Container:

DOWNLOADER_DB_HOST - database host address

DOWNLOADER_DB_PORT - database port

DOWNLOADER_DB_NAME - database name

DOWNLOADER_DB_USERNAME - database username

DOWNLOADER_DB_PASSWORD - database password

DOWNLOADER_SECRET_KEY_BASE - the secret key base for encrypted values, generate with RAILS_ENV=production bundle exec rake secret

DOWNLOADER_ATTACHMENTS_PATH - path to where the attachment files are stored

SSH_KEY - private SSH key that has GitHub read access to all needed private dependencies

## Development

### Setup

#### macOS

##### General

1. `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. `brew bundle`
3. `open -a Postgres`
4. Initialize database with version 12 in GUI

##### Native

1. `asdf plugin add ruby`
2. `asdf plugin add nodejs`
3. `asdf plugin add yarn`
4. `asdf install`
5. `asdf reshim`
6. `gem update --system`
7. `asdf reshim`
8. `bundle install`
9. `yarn install`
10. `asdf reshim`
11. `bundle exec rails db:setup`

###### Testing

1. `bin/rake`

###### Starting

1. `bin/dev`

##### Containerized

1. `open -a Docker`

###### Testing

1. `./run_ci_tests.sh`

#### Editors

##### RubyMine

1. Enable options for 'Before Commit':
   1. Reformat code
   2. Rearrange code
   3. Optimize Imports
   4. Analyze code
   5. Check TODO
   6. Cleanup
   7. Run 'spec: Repository-Downloader'


