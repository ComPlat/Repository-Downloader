# Repository Downloader

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

## Production

### Setup
1. Install current version of docker and docker-compose.
2. Change environment variables in run_docker-compose.production.sh.
3. Execute run_docker-compose.production.sh.

#### Environment Variables
The following environment variables have to be set for the project to run:

BAG_IT_STREAM_THREADS - the number of threads BagIt runs with.

Docker Container:

DOWNLOADER_DB_HOST - database host address

DOWNLOADER_DB_NAME - database name

DOWNLOADER_DB_USERNAME - database username

DOWNLOADER_DB_PASSWORD - database password

DOWNLOADER_DB_PORT - database port