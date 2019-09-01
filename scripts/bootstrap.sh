#!/bin/bash

set -e

echo "Bootsrap..."

# Get the directory of this script
# https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
scriptsDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
echo "Running: ${scriptsDir}"

echo "Install Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Install jq (json parser for bash)..."
brew install jq

echo "Install rbenv..."
brew install rbenv
eval "$(rbenv init -)"
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

echo "Parse ruby version using jq..."

resourcesDir="${scriptsDir}/../resources"
envJson="${resourcesDir}/env.json"
echo "Parsing: ${envJson}"
rubyVersion=$(cat ${envJson} | jq .dev_config.ruby_version)

echo "Bootstrap done"
echo "Please install ruby version: ${rubyVersion}"
echo "by using rbenv:"
echo "rbenv install <ruby_version>"

exit 0
