#!/bin/bash

set -e

echo "Bootsrap..."

echo "Install Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

exit 0
