# Repository Downloader
## Development
### Setup
#### macOS
##### General
1. `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. `brew bundle`
##### Native
1. `asdf plugin add ruby`
2. `asdf plugin add nodejs`
3. `asdf plugin add yarn`
4. `asdf install`
5. `asdf reshim`
6. `gem update --system`
7. `asdf reshim`
###### Testing
1. `bin/rake`
###### Starting
1. `bin/dev`
##### Containerized
###### Testing
1. `./run_ci_tests.sh`
