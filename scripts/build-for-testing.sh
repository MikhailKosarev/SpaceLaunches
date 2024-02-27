#!/usr/bin/env bash

# Define constants
readonly APP_NAME="SpaceLaunches"
readonly IOS_SDK="17.2"
readonly DESTINATION_PLATFORM="iOS Simulator"
readonly DESTINATION_NAME="iPhone 15 Pro"
readonly TEST_TARGET="SpaceLaunchesTests"

# Execute xcodebuild
xcodebuild \
    build-for-testing \
    -workspace "${APP_NAME}.xcworkspace" \
    -scheme "${APP_NAME}" \
    -destination "platform=${DESTINATION_PLATFORM},name=${DESTINATION_NAME}" \
    -derivedDataPath "DerivedData"

