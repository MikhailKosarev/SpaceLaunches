#!/usr/bin/env bash

# Define constant
readonly XCODE_VERSION="15.2"

# Switch Xcode version
sudo xcode-select --switch "/Applications/Xcode_${XCODE_VERSION}.app"
