#!/bin/bash -e

install -m 0755 -d /etc/apt/keyrings
rm -rf /etc/apt/keyrings/docker.*

echo "Downloading docker .pgp key"
curl -fsSL https://download.docker.com/linux/debian/gpg -o /tmp/docker.pgp # download pgp key
echo "Transforming .pgp key to .gpg"
gpg --batch --dearmor -o /etc/apt/keyrings/docker.gpg /tmp/docker.pgp # convert pgp to gpg
chmod a+r /etc/apt/keyrings/docker.gpg

apt_repo="deb [arch=\"armhf\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable"
echo "Adding ${apt_repo} to /etc/apt/sources.list.d/docker.list"
echo ${apt_repo} > /etc/apt/sources.list.d/docker.list

apt-get update -qq #> /dev/null
