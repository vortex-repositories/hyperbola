#!/bin/bash
### This holds the script that builds regreet into Hyperbola.

echo "Preparing to build Display Manager..."
mkdir /tmp/regreet/
mkdir /tmp/regreet/repository
wget -q 'https://api.github.com/repos/rharish101/ReGreet/releases/latest' -O '/tmp/regreet/release-metadata'

regreet_metadata=$(cat /tmp/regreet/release-metadata)
regreet_version=$(echo "$regreet_metadata" | jq '.name' | tr -d '"')
wget "https://api.github.com/repos/rharish101/ReGreet/tarball/$regreet_version" -O '/tmp/regreet/repository.tar.gz'
tar -xvf /tmp/regreet/repository.tar.gz -C /tmp/regreet/repository --strip-components=1
cd /tmp/regreet/repository
echo "Building Display Manager"
cargo build -F gtk4_8 --release
echo "Installing Display Manager"
cp target/release/regreet /usr/bin
cd /tmp/build/
