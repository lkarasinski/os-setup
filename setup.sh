#!/bin/bash

LATEST_RELEASE=$(curl -s https://api.github.com/repos/lkarasinski/os-setup/releases/latest)

DOWNLOAD_URL=$(echo $LATEST_RELEASE | grep -o 'https://github.com/lkarasinski/os-setup/releases/download/[^"]*')

curl -L -o setup $DOWNLOAD_URL

chmod +x setup

./setup

rm setup
