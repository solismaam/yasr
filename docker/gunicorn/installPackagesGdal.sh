#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt update
apt install --assume-yes --quiet gdal-bin
apt --assume-yes --quiet autoremove
apt clean
rm -rf /var/lib/apt/lists/*
