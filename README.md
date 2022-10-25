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