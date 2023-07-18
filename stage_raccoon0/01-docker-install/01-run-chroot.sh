#!/bin/bash -e

echo "executing docker post-package install"
#usermod -aG docker pi

echo "checking if docker is installed:"
apt list | grep docker
